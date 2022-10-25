local LibFail = LibStub("LibFail-1.0", true)
if not LibFail then return end

local folder, Skada = ...
local Private = Skada.Private
Skada:RegisterModule("Fails", function(L, P, _, _, M)
	local mod = Skada:NewModule("Fails")
	local spellmod = mod:NewModule("Player's failed events")
	local playermod = spellmod:NewModule("Event's failed players")
	local ignored_spells = Skada.dummyTable -- Edit Skada\Core\Tables.lua
	local count_fails_by_spell = nil

	local pairs, tostring, format, UnitGUID = pairs, tostring, string.format, UnitGUID
	local uformat, IsInGroup = Private.uformat, Skada.IsInGroup
	local tank_events, mod_cols

	local function format_valuetext(d, columns, total, metadata, subview)
		d.valuetext = Skada:FormatValueCols(
			columns.Count and d.value,
			columns[subview and "sPercent" or "Percent"] and Skada:FormatPercent(d.value, total)
		)

		if metadata and d.value > metadata.maxvalue then
			metadata.maxvalue = d.value
		end
	end

	local function log_fail(set, actorid, actorname, spellid, failname)
		local actor = Skada:GetPlayer(set, actorid, actorname)
		if not actor or (actor.role == "TANK" and tank_events[failname]) then return end

		actor.fail = (actor.fail or 0) + 1
		set.fail = (set.fail or 0) + 1

		-- saving this to total set may become a memory hog deluxe.
		if (set == Skada.total and not P.totalidc) or not spellid then return end
		actor.failspells = actor.failspells or {}
		actor.failspells[spellid] = (actor.failspells[spellid] or 0) + 1
	end

	local function on_fail(failname, actorname, failtype, ...)
		local spellid = failname and actorname and LibFail:GetEventSpellId(failname)
		local actorid = spellid and not ignored_spells[spellid] and UnitGUID(actorname)
		if not actorid then return end

		Skada:DispatchSets(log_fail, actorid, actorname, tostring(spellid), failname)
	end

	function playermod:Enter(win, id, label)
		win.spellid, win.spellname = id, label
		win.title = format(L["%s's fails"], label)
	end

	function playermod:Update(win, set)
		win.title = uformat(L["%s's fails"], win.spellname)
		if not win.spellid then return end

		local total = set and count_fails_by_spell(set, win.spellid)
		if not total or total == 0 then
			return
		elseif win.metadata then
			win.metadata.maxvalue = 0
		end

		local nr = 0
		local actors = set.actors

		for i = 1, #actors do
			local actor = actors[i]
			if actor and actor.failspells and actor.failspells[win.spellid] then
				nr = nr + 1

				local d = win:actor(nr, actor, actor.enemy)
				d.value = actor.failspells[win.spellid]
				format_valuetext(d, mod_cols, total, win.metadata, true)
			end
		end
	end

	function spellmod:Enter(win, id, label)
		win.actorid, win.actorname = id, label
		win.title = format(L["%s's fails"], label)
	end

	function spellmod:Update(win, set)
		win.title = uformat(L["%s's fails"], win.actorname)

		local actor = set and set:GetPlayer(win.actorid, win.actorname)
		local total = actor and actor.fail
		local spells = (total and total > 0) and actor.failspells

		if not spells then
			return
		elseif win.metadata then
			win.metadata.maxvalue = 0
		end

		local nr = 0
		for spellid, count in pairs(spells) do
			nr = nr + 1

			local d = win:spell(nr, spellid)
			d.value = count
			format_valuetext(d, mod_cols, total, win.metadata, true)
		end
	end

	function mod:Update(win, set)
		win.title = win.class and format("%s (%s)", L["Fails"], L[win.class]) or L["Fails"]

		local total = set and set:GetTotal(win.class, nil, "fail")
		if not total or total == 0 then
			return
		elseif win.metadata then
			win.metadata.maxvalue = 0
		end

		local nr = 0
		local actors = set.actors

		for i = 1, #actors do
			local actor = actors[i]
			if win:show_actor(actor, set, true) and actor.fail then
				nr = nr + 1

				local d = win:actor(nr, actor, actor.name)
				d.value = actor.fail
				format_valuetext(d, mod_cols, total, win.metadata)
			end
		end
	end

	function mod:GetSetSummary(set, win)
		if not set then return end
		return set:GetTotal(win and win.class, nil, "fail") or 0
	end

	function mod:AddToTooltip(set, tooltip)
		if set.fail and set.fail > 0 then
			tooltip:AddDoubleLine(L["Fails"], set.fail, 1, 1, 1)
		end
	end

	function mod:OnEnable()
		spellmod.metadata = {click1 = playermod}
		self.metadata = {
			showspots = true,
			ordersort = true,
			click1 = spellmod,
			click4 = Skada.FilterClass,
			click4_label = L["Toggle Class Filter"],
			columns = {Count = true, Percent = false, sPercent = false},
			icon = [[Interface\Icons\ability_creature_cursed_01]]
		}

		mod_cols = self.metadata.columns

		-- no total click.
		spellmod.nototal = true

		Skada.RegisterMessage(self, "COMBAT_PLAYER_LEAVE", "CombatLeave")
		Skada:AddMode(self)

		-- table of ignored spells:
		if Skada.ignored_spells and Skada.ignored_spells.fails then
			ignored_spells = Skada.ignored_spells.fails
		end
	end

	function mod:OnDisable()
		Skada.UnregisterAllMessages(self)
		Skada:RemoveMode(self)
	end

	--------------------------------------------------------------------------

	do
		local options  -- holds the options table
		local function get_options()
			if not options then
				options = {
					type = "group",
					name = mod.localeName,
					desc = format(L["Options for %s."], mod.localeName),
					args = {
						header = {
							type = "description",
							name = mod.localeName,
							fontSize = "large",
							image = [[Interface\Icons\ability_creature_cursed_01]],
							imageWidth = 18,
							imageHeight = 18,
							imageCoords = {0.05, 0.95, 0.05, 0.95},
							width = "full",
							order = 0
						},
						sep = {
							type = "description",
							name = " ",
							width = "full",
							order = 1
						},
						failsannounce = {
							type = "toggle",
							name = L["Report Fails"],
							desc = L["Reports the group fails at the end of combat if there are any."],
							descStyle = "inline",
							order = 10,
							width = "double"
						},
						failschannel = {
							type = "select",
							name = L["Channel"],
							values = {AUTO = INSTANCE, GUILD = GUILD, OFFICER = CHAT_MSG_OFFICER, SELF = L["Self"]},
							order = 20,
							width = "double"
						}
					}
				}
			end
			return options
		end

		function mod:OnInitialize()
			local events = LibFail:GetSupportedEvents()
			for i = 1, #events do
				LibFail.RegisterCallback(folder, events[i], on_fail)
			end

			events = LibFail:GetFailsWhereTanksDoNotFail()
			tank_events = tank_events or {}
			for i = 1, #events do
				tank_events[events[i]] = true
			end

			M.ignoredfails = nil
			M.failschannel = M.failschannel or "AUTO"
			Skada.options.args.modules.args.failbot = get_options()
		end
	end

	function mod:CombatLeave(_, set)
		if set and set.fail and set.fail > 0 and M.failsannounce then
			local channel = M.failschannel or "AUTO"
			if channel == "SELF" or channel == "GUILD" or IsInGroup() then
				Skada:Report(channel, "preset", L["Fails"], nil, 10)
			end
		end
	end

	---------------------------------------------------------------------------

	count_fails_by_spell = function(self, spellid)
		local total = 0
		if not self.fail or not spellid then
			return total
		end

		local actors = self.actors
		for i = 1, #actors do
			local a = actors[i]
			if a and a.failspells and a.failspells[spellid] then
				total = total + a.failspells[spellid]
			end
		end
		return total
	end
end)

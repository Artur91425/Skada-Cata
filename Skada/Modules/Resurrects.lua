local Skada = Skada
Skada:RegisterModule("Resurrects", function(L, P, _, C, new, _, clear)
	local mod = Skada:NewModule("Resurrects")
	local playermod = mod:NewModule("Resurrect spell list")
	local targetmod = mod:NewModule("Resurrect target list")

	local pairs, tostring, format, pformat = pairs, tostring, string.format, Skada.pformat
	local GetSpellInfo = Skada.GetSpellInfo or GetSpellInfo
	local get_resurrected_targets, _

	local resurrectSpells = {
		[20484] = 0x08, -- Rebirth
		[20608] = 0x08, -- Reincarnation
		[3026] = 0x01 -- Use Soulstone
	}

	local function log_resurrect(set, data)
		local player = Skada:GetPlayer(set, data.playerid, data.playername, data.playerflags)
		if not player then return end

		player.ress = (player.ress or 0) + 1
		set.ress = (set.ress or 0) + 1

		-- saving this to total set may become a memory hog deluxe.
		if (set == Skada.total and not P.totalidc) or not data.spellid then return end

		-- spell
		local spell = player.resspells and player.resspells[data.spellid]
		if not spell then
			player.resspells = player.resspells or {}
			player.resspells[data.spellid] = {count = 0}
			spell = player.resspells[data.spellid]
		end
		spell.count = spell.count + 1

		-- spell targets
		if data.dstName then
			spell.targets = spell.targets or {}
			spell.targets[data.dstName] = (spell.targets[data.dstName] or 0) + 1
		end
	end

	local data = {}

	local function spell_resurrect(_, event, srcGUID, srcName, srcFlags, _, dstName, _, spellid)
		if spellid and (event == "SPELL_RESURRECT" or resurrectSpells[spellid]) then
			data.spellid = spellid

			if event == "SPELL_RESURRECT" then
				data.playerid = srcGUID
				data.playername = srcName
				data.playerflags = srcFlags
				data.dstName = dstName
			else
				data.playerid = srcGUID
				data.playername = srcName
				data.playerflags = srcFlags
				data.dstName = srcName
			end

			Skada:DispatchSets(log_resurrect, data)
		end
	end

	function playermod:Enter(win, id, label)
		win.actorid, win.actorname = id, label
		win.title = format(L["%s's resurrect spells"], label)
	end

	function playermod:Update(win, set)
		win.title = pformat(L["%s's resurrect spells"], win.actorname)
		if not set or not win.actorname then return end

		local actor, enemy = set:GetActor(win.actorname, win.actorid)
		local total = (actor and not enemy) and actor.ress or 0

		if total == 0 or not actor.resspells then
			return
		elseif win.metadata then
			win.metadata.maxvalue = 0
		end

		local nr = 0
		for spellid, spell in pairs(actor.resspells) do
			nr = nr + 1
			local d = win:spell(nr, spellid, nil, resurrectSpells[spellid])

			d.value = spell.count
			d.valuetext = Skada:FormatValueCols(
				mod.metadata.columns.Count and d.value,
				mod.metadata.columns.sPercent and Skada:FormatPercent(d.value, total)
			)

			if win.metadata and d.value > win.metadata.maxvalue then
				win.metadata.maxvalue = d.value
			end
		end
	end

	function targetmod:Enter(win, id, label)
		win.actorid, win.actorname = id, label
		win.title = format(L["%s's resurrect targets"], label)
	end

	function targetmod:Update(win, set)
		win.title = pformat(L["%s's resurrect targets"], win.actorname)
		if not set or not win.actorname then return end

		local actor, enemy = set:GetActor(win.actorname, win.actorid)
		local total = (actor and not enemy) and actor.ress or 0
		local targets = (total > 0) and get_resurrected_targets(actor)

		if not targets then
			return
		elseif win.metadata then
			win.metadata.maxvalue = 0
		end

		local nr = 0
		for targetname, target in pairs(targets) do
			nr = nr + 1
			local d = win:actor(nr, target, nil, targetname)

			d.value = target.count
			d.valuetext = Skada:FormatValueCols(
				mod.metadata.columns.Count and d.value,
				mod.metadata.columns.sPercent and Skada:FormatPercent(d.value, total)
			)

			if win.metadata and d.value > win.metadata.maxvalue then
				win.metadata.maxvalue = d.value
			end
		end
	end

	function mod:Update(win, set)
		win.title = L["Resurrects"]
		local total = set.ress or 0

		if total == 0 then
			return
		elseif win.metadata then
			win.metadata.maxvalue = 0
		end

		local nr = 0
		for i = 1, #set.players do
			local player = set.players[i]
			if player and player.ress then
				nr = nr + 1
				local d = win:actor(nr, player)

				d.value = player.ress
				d.valuetext = Skada:FormatValueCols(
					self.metadata.columns.Count and d.value,
					self.metadata.columns.Percent and Skada:FormatPercent(d.value, total)
				)

				if win.metadata and d.value > win.metadata.maxvalue then
					win.metadata.maxvalue = d.value
				end
			end
		end
	end

	function mod:OnEnable()
		self.metadata = {
			valuesort = true,
			click1 = playermod,
			click2 = targetmod,
			columns = {Count = true, Percent = false, sPercent = false},
			icon = [[Interface\Icons\spell_holy_resurrection]]
		}

		-- no total click.
		playermod.nototal = true
		targetmod.nototal = true

		Skada:RegisterForCL(spell_resurrect, "SPELL_RESURRECT", {src_is_interesting = true, dst_is_interesting = true})
		Skada:RegisterForCL(spell_resurrect, "SPELL_CAST_SUCCESS", {src_is_interesting = true, dst_is_not_interesting = true})

		Skada:AddMode(self)
	end

	function mod:OnDisable()
		Skada:RemoveMode(self)
	end

	function mod:AddToTooltip(set, tooltip)
		if set.ress and set.ress > 0 then
			tooltip:AddDoubleLine(L["Resurrects"], set.ress, 1, 1, 1)
		end
	end

	function mod:GetSetSummary(set)
		local ress = set.ress or 0
		return tostring(ress), ress
	end

	---------------------------------------------------------------------------

	get_resurrected_targets = function(self, tbl)
		if not self.resspells then return end

		tbl = clear(tbl or C)
		for _, spell in pairs(self.resspells) do
			if spell.targets then
				for name, count in pairs(spell.targets) do
					if not tbl[name] then
						tbl[name] = new()
						tbl[name].count = count
					else
						tbl[name].count = tbl[name].count + count
					end
					self.super:_fill_actor_table(tbl[name], name)
				end
			end
		end
		return tbl
	end
end)

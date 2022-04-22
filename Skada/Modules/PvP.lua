local Skada = Skada
Skada:AddLoadableModule("PVP", function(L)
	if Skada:IsDisabled("PVP") then return end

	local mod = Skada:NewModule(PVP, "AceEvent-3.0")

	local format, wipe, GetTime = string.format, wipe, GetTime
	local UnitGUID, UnitClass, UnitBuff, UnitIsPlayer = UnitGUID, UnitClass, UnitBuff, UnitIsPlayer
	local GetSpellInfo, UnitCastingInfo = GetSpellInfo, UnitCastingInfo
	local _

	local specsCache, specsRoles = nil, nil
	local spellsTable, aurasTable = nil, nil

	local function BuildSpellsList()
		if not specsRoles then
			specsRoles = {
				[105] = "HEALER", -- Druid: Restoration
				[256] = "HEALER", -- Priest: Discipline
				[257] = "HEALER", -- Priest: Holy
				[264] = "HEALER", -- Shaman: Restoration
				[65] = "HEALER", -- Paladin: Holy
				[66] = "TANK", -- Paladin: Protection
				[73] = "TANK" -- Warrior: Protection
			}
		end

		if not aurasTable then
			aurasTable = {
				WARRIOR = {
					[GetSpellInfo(56638)] = 71, -- Taste for Blood
					[GetSpellInfo(64976)] = 71, -- Juggernaut
					[GetSpellInfo(29801)] = 72, -- Rampage
					[GetSpellInfo(50227)] = 73 -- Sword and Board
				},
				PALADIN = {
					[GetSpellInfo(68020)] = 70, -- Seal of Command
					[GetSpellInfo(31801)] = 70 -- Seal of Vengeance
				},
				ROGUE = {
					[GetSpellInfo(58427)] = 259, -- Overkill
					[GetSpellInfo(36554)] = 261, -- Shadowstep
					[GetSpellInfo(31223)] = 261 -- Master of Subtlety
				},
				PRIEST = {
					[GetSpellInfo(52795)] = 256, -- Borrowed Time
					[GetSpellInfo(47788)] = 257, -- Guardian Spirit
					[GetSpellInfo(15473)] = 258, -- Shadowform
					[GetSpellInfo(15286)] = 258 -- Vampiric Embrace
				},
				DEATHKNIGHT = {
					[GetSpellInfo(49016)] = 250, -- Hysteria
					[GetSpellInfo(53138)] = 250, -- Abomination's Might
					[GetSpellInfo(55610)] = 251, -- Imp. Icy Talons
					[GetSpellInfo(49222)] = 252 -- Bone Shield
				},
				MAGE = {
					[GetSpellInfo(11426)] = 62, -- Ice Barrier
					[GetSpellInfo(11129)] = 63, -- Combustion
					[GetSpellInfo(31583)] = 64 -- Arcane Empowerment
				},
				WARLOCK = {
					[GetSpellInfo(30299)] = 267 -- Nether Protection
				},
				SHAMAN = {
					[GetSpellInfo(51470)] = 262, -- Elemental Oath
					[GetSpellInfo(30802)] = 263, -- Unleashed Rage
					[GetSpellInfo(974)] = 264 -- Earth Shield
				},
				HUNTER = {
					[GetSpellInfo(20895)] = 253, -- Spirit Bond
					[GetSpellInfo(19506)] = 254 -- Trueshot Aura
				},
				DRUID = {
					[GetSpellInfo(24907)] = 102, -- Moonkin Aura
					[GetSpellInfo(24932)] = 103, -- Leader of the Pack
					[GetSpellInfo(33891)] = 105, -- Tree of Life
					[GetSpellInfo(48438)] = 105 -- Wild Growth
				}
			}
		end

		if not spellsTable then
			spellsTable = {
				WARRIOR = {
					[GetSpellInfo(12294)] = 71, -- Mortal Strike
					[GetSpellInfo(46924)] = 71, -- Bladestorm
					[GetSpellInfo(1680)] = 72, -- Whirlwind
					[GetSpellInfo(23881)] = 72, -- Bloodthirst
					[GetSpellInfo(12809)] = 73, -- Concussion Blow
				},
				PALADIN = {
					[GetSpellInfo(20473)] = 65, -- Holy Shock
					[GetSpellInfo(53563)] = 65, -- Beacon of Light
					[GetSpellInfo(31935)] = 66, -- Avenger's Shield
					[GetSpellInfo(35395)] = 70, -- Crusader Strike
					[GetSpellInfo(53385)] = 70, -- Divine Storm
					[GetSpellInfo(20066)] = 70 -- Repentance
				},
				ROGUE = {
					[GetSpellInfo(1329)] = 259, -- Mutilate
					[GetSpellInfo(51690)] = 260, -- Killing Spree
					[GetSpellInfo(13877)] = 260, -- Blade Flurry
					[GetSpellInfo(13750)] = 260, -- Adrenaline Rush
					[GetSpellInfo(16511)] = 261, -- Hemorrhage
					[GetSpellInfo(51713)] = 261 -- Shadow Dance
				},
				PRIEST = {
					[GetSpellInfo(47540)] = 256, -- Penance
					[GetSpellInfo(10060)] = 256, -- Power Infusion
					[GetSpellInfo(33206)] = 256, -- Pain Suppression
					[GetSpellInfo(34861)] = 257, -- Circle of Healing
					[GetSpellInfo(15487)] = 258, -- Silence
					[GetSpellInfo(34914)] = 258 -- Vampiric Touch
				},
				DEATHKNIGHT = {
					[GetSpellInfo(45902)] = 250, -- Heart Strike
					[GetSpellInfo(49203)] = 251, -- Hungering Cold
					[GetSpellInfo(49143)] = 251, -- Frost Strike
					[GetSpellInfo(49184)] = 251, -- Howling Blast
					[GetSpellInfo(55090)] = 252 -- Scourge Strike
				},
				MAGE = {
					[GetSpellInfo(44425)] = 62, -- Arcane Barrage
					[GetSpellInfo(44457)] = 63, -- Living Bomb
					[GetSpellInfo(31661)] = 63, -- Dragon's Breath
					[GetSpellInfo(11113)] = 63, -- Blast Wave
					[GetSpellInfo(44572)] = 64 -- Deep Freeze
				},
				WARLOCK = {
					[GetSpellInfo(48181)] = 265, -- Haunt
					[GetSpellInfo(30108)] = 265, -- Unstable Affliction
					[GetSpellInfo(59672)] = 266, -- Metamorphosis
					[GetSpellInfo(50769)] = 267, -- Chaos Bolt
					[GetSpellInfo(30283)] = 267 -- Shadowfury
				},
				SHAMAN = {
					[GetSpellInfo(51490)] = 262, -- Thunderstorm
					[GetSpellInfo(16166)] = 262, -- Elemental Mastery
					[GetSpellInfo(51533)] = 263, -- Feral Spirit
					[GetSpellInfo(30823)] = 263, -- Shamanistic Rage
					[GetSpellInfo(17364)] = 263, -- Stormstrike
					[GetSpellInfo(61295)] = 264, -- Riptide
					[GetSpellInfo(51886)] = 264 -- Cleanse Spirit
				},
				HUNTER = {
					[GetSpellInfo(19577)] = 253, -- Intimidation
					[GetSpellInfo(34490)] = 254, -- Silencing Shot
					[GetSpellInfo(53209)] = 254, -- Chimera Shot
					[GetSpellInfo(53301)] = 255, -- Explosive Shot
					[GetSpellInfo(19386)] = 255 -- Wyvern Sting
				},
				DRUID = {
					[GetSpellInfo(48505)] = 102, -- Starfall
					[GetSpellInfo(50516)] = 102, -- Typhoon
					[GetSpellInfo(33876)] = 103, -- Mangle (Cat)
					[GetSpellInfo(33878)] = 104, -- Mangle (Bear)
					[GetSpellInfo(18562)] = 105 -- Swiftmend
				}
			}
		end
	end

	function mod:UNIT_AURA(event, unit)
		if Skada.instanceType ~= "pvp" and Skada.instanceType ~= "arena" then
			self:UnregisterEvent("UNIT_AURA")
		elseif unit and UnitIsPlayer(unit) and not specsCache[UnitGUID(unit)] then
			local _, class = UnitClass(unit)
			if class and Skada.validclass[class] then
				local i = 1
				local name = UnitBuff(unit, i)
				while name do
					if aurasTable[class] and aurasTable[class][name] then
						specsCache[UnitGUID(unit)] = aurasTable[class][name]
						break -- found
					end
					i = i + 1
					name = UnitBuff(unit, i)
				end
			end
		end
	end

	function mod:UNIT_SPELLCAST_START(event, unit)
		if Skada.instanceType ~= "pvp" and Skada.instanceType ~= "arena" then
			self:UnregisterEvent("UNIT_SPELLCAST_START")
		elseif unit and UnitIsPlayer(unit) and not specsCache[UnitGUID(unit)] then
			local _, class = UnitClass(unit)
			local spell = UnitCastingInfo(unit)
			if class and Skada.validclass[class] and spellsTable[class] and spellsTable[class][spell] then
				specsCache[UnitGUID(unit)] = spellsTable[class][spell]
			end
		end
	end

	function mod:CheckZone()
		specsCache = wipe(specsCache or {})

		if Skada.instanceType == "arena" or Skada.instanceType == "pvp" then
			BuildSpellsList()
			self:RegisterEvent("UNIT_AURA")
			self:RegisterEvent("UNIT_SPELLCAST_START")
			Skada.RegisterCallback(self, "Skada_GetEnemy", "GetEnemy")
		else
			self:UnregisterEvent("UNIT_AURA")
			self:UnregisterEvent("UNIT_SPELLCAST_START")
			Skada.UnregisterCallback(self, "Skada_GetEnemy", "GetEnemy")
		end
	end

	function mod:GetEnemy(_, enemy)
		if enemy and not enemy.fake and enemy.class and Skada.validclass[enemy.class] then
			if enemy.spec == nil then
				enemy.spec = specsCache[enemy.id]
			end

			if enemy.spec and (enemy.role == nil or enemy.role == "NONE") then
				enemy.role = specsRoles[enemy.spec] or "DAMAGER"
			end

			if enemy.time == nil then
				enemy.time = 0
			end

			if enemy.last == nil then
				enemy.last = GetTime()
			end
		end
	end

	function mod:OnEnable()
		Skada.forPVP = true
		specsCache = specsCache or {}
		Skada.RegisterCallback(self, "Skada_ZoneCheck", "CheckZone")
	end

	function mod:OnDisable()
		Skada.forPVP = nil
		Skada.UnregisterAllCallbacks(self)
	end

	---------------------------------------------------------------------------

	function mod:OnInitialize()
		if Skada.db.profile.modules.arena then
			Skada.db.profile.modules.arena = nil
		end
	end
end)
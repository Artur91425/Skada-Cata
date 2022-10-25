-- LibBars-1.0 by Kader, all glory to him.
-- Specialized ( = enhanced) for Skada
-- Note to self: don't forget to notify original author of changes
-- in the unlikely event they end up being usable outside of Skada.
local MAJOR, MINOR = "SpecializedLibBars-1.0", 90016
local lib, oldminor = LibStub:NewLibrary(MAJOR, MINOR)
if not lib then return end -- No Upgrade needed.

local CallbackHandler = LibStub("CallbackHandler-1.0")

-------------------------------------------------------------------------------
-- cache frequently used lua and game functions

local GetTime = GetTime
local sin, cos, rad = math.sin, math.cos, math.rad
local abs, min, max, floor = math.abs, math.min, math.max, math.floor
local tsort, tinsert, tremove, tconcat, wipe = table.sort, tinsert, tremove, table.concat, wipe
local next, pairs, error, type, xpcall = next, pairs, error, type, xpcall
local CreateFrame = CreateFrame
local GameTooltip = GameTooltip
local setmetatable = setmetatable
local GetScreenWidth = GetScreenWidth
local GetScreenHeight = GetScreenHeight

-------------------------------------------------------------------------------
-- localization

local L_RESIZE_HEADER = "Resize"
local L_RESIZE_CLICK = "\124cff00ff00Click\124r to freely resize window."
local L_RESIZE_SHIFT_CLICK = "\124cff00ff00Shift-Click\124r to change the width."
local L_RESIZE_ALT_CLICK = "\124cff00ff00Alt-Click\124r to change the height."
local L_LOCK_WINDOW = "Lock Window"
local L_UNLOCK_WINDOW = "Unlock Window"

if LOCALE_deDE then
	L_RESIZE_HEADER = "Größe ändern"
	L_RESIZE_CLICK = "\124cff00ff00Klicken\124r, um die Fenstergröße frei zu ändern."
	L_RESIZE_SHIFT_CLICK = "\124cff00ff00Umschalt-Klick\124r, um die Breite zu ändern."
	L_RESIZE_ALT_CLICK = "\124cff00ff00Alt-Klick\124r, um die Höhe zu ändern."
	L_LOCK_WINDOW = "Fenster sperren"
	L_UNLOCK_WINDOW = "Fenster entsperren"
elseif LOCALE_esES or LOCALE_esMX then
	L_RESIZE_HEADER = "Redimensionar"
	L_RESIZE_CLICK = "\124cff00ff00Haga clic\124r para cambiar el tamaño de la ventana."
	L_RESIZE_SHIFT_CLICK = "\124cff00ff00Shift-Click\124r para cambiar el ancho de la ventana."
	L_RESIZE_ALT_CLICK = "\124cff00ff00Alt-Click\124r para cambiar la altura de la ventana."
	L_LOCK_WINDOW = "Bloquear ventana"
	L_UNLOCK_WINDOW = "Desbloquear ventana"
elseif LOCALE_frFR then
	L_RESIZE_HEADER = "Redimensionner"
	L_RESIZE_CLICK = "\124cff00ff00Clic\124r pour redimensionner."
	L_RESIZE_SHIFT_CLICK = "\124cff00ff00Shift clic\124r pour changer la largeur."
	L_RESIZE_ALT_CLICK = "\124cff00ff00Alt clic\124r pour changer la hauteur."
	L_LOCK_WINDOW = "Verrouiller la fenêtre"
	L_UNLOCK_WINDOW = "Déverrouiller la fenêtre"
elseif LOCALE_koKR then
	L_RESIZE_HEADER = "크기 조정"
	L_RESIZE_CLICK = "\124cff00ff00클릭\124r하여 창 크기를 자유롭게 조정합니다."
	L_RESIZE_SHIFT_CLICK = "너비를 변경하려면 \124cff00ff00Shift-클릭\124r하십시오."
	L_RESIZE_ALT_CLICK = "높이를 변경하려면 \124cff00ff00Alt-클릭\124r하십시오"
	L_LOCK_WINDOW = "잠금 창"
	L_UNLOCK_WINDOW = "잠금 해제 창"
elseif LOCALE_ruRU then
	L_RESIZE_HEADER = "Изменение размера"
	L_RESIZE_CLICK = "\124cff00ff00Щелкните\124r, чтобы изменить размер окна."
	L_RESIZE_SHIFT_CLICK = "\124cff00ff00Shift-Click\124r, чтобы изменить ширину."
	L_RESIZE_ALT_CLICK = "\124cff00ff00ALT-Click\124r, чтобы изменить высоту."
	L_LOCK_WINDOW = "Заблокировать окно"
	L_UNLOCK_WINDOW = "Разблокировать окно"
elseif LOCALE_zhCN then
	L_RESIZE_HEADER = "调整大小"
	L_RESIZE_CLICK = "\124cff00ff00单击\124r以调整窗口大小。"
	L_RESIZE_SHIFT_CLICK = "\124cff00ff00Shift-Click\124r改变窗口的宽度。"
	L_RESIZE_ALT_CLICK = "\124cff00ff00Alt-Click\124r更改窗口高度。"
	L_LOCK_WINDOW = "锁定窗口"
	L_UNLOCK_WINDOW = "解锁窗口"
elseif LOCALE_zhTW then
	L_RESIZE_HEADER = "調整大小"
	L_RESIZE_CLICK = "\124cff00ff00單擊\124r以調整窗口大小。"
	L_RESIZE_SHIFT_CLICK = "\124cff00ff00Shift-Click\124r改變窗口的寬度。"
	L_RESIZE_ALT_CLICK = "\124cff00ff00Alt-Click\124r更改窗口高度。"
	L_LOCK_WINDOW = "鎖定窗口"
	L_UNLOCK_WINDOW = "解鎖窗口"
end

-------------------------------------------------------------------------------
-- frame and class creation

-- manageable textures and fontstrings z level
local createFrame
do
	local function setZLevel(self, level)
		local parent = self._parent
		if level <= 0 then
			self:SetParent(parent)
		else
			local zlevels = parent._zlevels
			if level > #zlevels then
				for i = #zlevels + 1, level do
					zlevels[i] = CreateFrame("Frame", nil, (zlevels[i - 1] or parent))
					zlevels[i]:SetAllPoints(true)
				end
			end
			self:SetParent(zlevels[level])
		end
	end

	local function createTexture(self, ...)
		local tx = self:_CreateTexture(...)
		tx._parent = self
		tx.SetZLevel = setZLevel
		return tx
	end

	local function createFontString(self, ...)
		local fs = self:_CreateFontString(...)
		fs._parent = self
		fs.SetZLevel = setZLevel
		return fs
	end

	function createFrame(...)
		local f = CreateFrame(...)
		f._zlevels = f._zlevels or {}

		f._CreateTexture = f.CreateTexture
		f.CreateTexture = createTexture

		f._CreateFontString = f.CreateFontString
		f.CreateFontString = createFontString

		return f
	end
end

local function createClass(ftype, parent)
	local class = (type(ftype) == "table") and ftype or CreateFrame(ftype)
	class.mt = {__index = class}

	if parent then
		class = setmetatable(class, {__index = parent})
		class.super = parent
	end

	class.Bind = function(self, o)
		return setmetatable(o, self.mt)
	end

	return class
end

-------------------------------------------------------------------------------
-- library variables.

local framePrototype = createClass("Frame")
lib.barPrototype = lib.barPrototype or createClass({}, framePrototype)
lib.barListPrototype = lib.barListPrototype or createClass({}, framePrototype)

local barPrototype = lib.barPrototype
local barListPrototype = lib.barListPrototype

local listOnEnter, listOnLeave
local anchorOnEnter, anchorOnLeave
local stretchOnMouseDown, stretchOnMouseUp
local SetTextureValue

lib.bars = lib.bars or {}
lib.barLists = lib.barLists or {}
lib.recycledBars = lib.recycledBars or {}
lib.listPosition = lib.listPosition or {}

local bars = lib.bars
local barLists = lib.barLists
local recycledBars = lib.recycledBars
local posix = lib.listPosition

local scrollspeed = 1
local dummyTable = {}

local ICON_LOCK = [[Interface\AddOns\Skada\Libs\SpecializedLibBars-1.0\lock.tga]]
local ICON_UNLOCK = [[Interface\AddOns\Skada\Libs\SpecializedLibBars-1.0\unlock.tga]]
local ICON_RESIZE = [[Interface\CHATFRAME\UI-ChatIM-SizeGrabber-Up]]
local ICON_STRETCH = [[Interface\MINIMAP\ROTATING-MINIMAPGUIDEARROW.blp]]

-------------------------------------------------------------------------------
-- local functions

-- compares flaots
local function equal_floats(a, b, epsilon)
	return abs(a - b) <= ((abs(a) < abs(b) and abs(b) or abs(a)) * 0.000001)
end

-- table pool
local new, del
do
	local table_pool = setmetatable({}, {__mode = "kv"})

	function new()
		local t = next(table_pool)
		if t then table_pool[t] = nil end
		return t or {}
	end

	function del(t)
		if type(t) == "table" then
			for k, v in pairs(t) do
				t[k] = nil
			end
			table_pool[t] = true
		end
		return nil
	end
end

-------------------------------------------------------------------------------
-- library functions.

-- lib:Embed - library embed
do
	lib.embeds = lib.embeds or {}

	local mixins = {"NewBar", "GetBar", "ReleaseBar", "GetBars", "NewBarGroup", "GetBarGroup", "GetBarGroups", "SetScrollSpeed"}
	function lib:Embed(target)
		for k, v in pairs(mixins) do
			target[v] = self[v]
		end
		lib.embeds[target] = true
		return target
	end
end

-- lib:NewBarGroup - bar list creation
do
	local function anchorOnMouseDown(self, button)
		local p = self:GetParent()
		if p.locked or button == "MiddleButton" then
			stretchOnMouseDown(p.stretcher, "LeftButton")
		elseif button == "LeftButton" and not p.locked and not p.isMoving then
			p.isMoving = true

			self.startX = p:GetLeft()
			self.startY = p:GetTop()
			p:StartMoving()

			if p.callbacks then
				p.callbacks:Fire("WindowMoveStart", p, self.startX, self.startY)
			end
		end
	end

	local function anchorOnMouseUp(self, button)
		local p = self:GetParent()
		if p.locked or button == "MiddleButton" then
			stretchOnMouseUp(p.stretcher, "LeftButton")
		elseif button == "LeftButton" and not p.locked and p.isMoving then
			p.isMoving = nil
			p:StopMovingOrSizing()

			local endX = p:GetLeft()
			local endY = p:GetTop()
			if p.callbacks and (self.startX ~= endX or self.startY ~= endY) then
				p.callbacks:Fire("WindowMoveStop", p, endX, endY)
			end
		end
	end

	local function listOnMouseDown(self, button)
		if button == "LeftButton" and not self.locked then
			anchorOnMouseDown(self.button, button)
		end
	end

	local function listOnMouseUp(self, button)
		if button == "LeftButton" and not self.locked then
			anchorOnMouseUp(self.button, button)
		end
	end

	local function listOnSizeChanged(self, width)
		self:SetLength(width)
		self:GuessMaxBars()
		self:SortBars()
		self.callbacks:Fire("WindowResizing", self)
	end

	local function listOnMouseWheel(self, direction)
		local maxbars = self:GetMaxBars()
		local numbars = self:GetNumBars()
		local offset = self:GetBarOffset()

		if direction == 1 and offset > 0 then
			self:SetBarOffset(IsShiftKeyDown() and 0 or max(0, offset - (IsControlKeyDown() and maxbars or scrollspeed)))
			self.callbacks:Fire("WindowScroll", self, direction)
		elseif direction == -1 and ((numbars - maxbars - offset) > 0) then
			if IsShiftKeyDown() then
				self:SetBarOffset(numbars - maxbars)
			else
				self:SetBarOffset(min(max(0, numbars - maxbars), offset + (IsControlKeyDown() and maxbars or scrollspeed)))
			end
			self.callbacks:Fire("WindowScroll", self, direction)
		end
	end

	local DEFAULT_TEXTURE = [[Interface\TARGETINGFRAME\UI-StatusBar]]
	local DEFAULT_BACKDROP = {
		bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],
		edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
		inset = 4,
		edgeSize = 8,
		tile = true,
		insets = {left = 2, right = 2, top = 2, bottom = 2}
	}

	function lib:NewBarGroup(name, orientation, height, length, thickness, frameName)
		if self == lib then
			error("You may only call :NewBarGroup as an embedded function")
		end

		if barLists[self] and barLists[self][name] then
			error("A bar list named " .. name .. " already exists.")
		end

		barLists[self] = barLists[self] or {}

		orientation = orientation or 1
		orientation = (orientation == "LEFT") and 1 or orientation
		orientation = (orientation == "RIGHT") and 3 or orientation

		frameName = frameName:gsub("%W","")
		local list = barListPrototype:Bind(createFrame("Frame", frameName, UIParent))
		list:SetFrameLevel(1)
		list:SetResizable(true)
		list:SetMovable(true)
		list:SetScript("OnMouseDown", listOnMouseDown)
		list:SetScript("OnMouseUp", listOnMouseUp)

		list.callbacks = list.callbacks or CallbackHandler:New(list)
		barLists[self][name] = list
		list.name = name

		local myfont = lib.defaultFont
		if not myfont then
			myfont = CreateFont("MyTitleFont")
			myfont:CopyFontObject(ChatFontSmall)
			lib.defaultFont = myfont
		end

		list.button = list.button or createFrame("Button", "$parentAnchor", list)
		list.button:SetFrameLevel(list:GetFrameLevel() + 3)
		list.button:SetText(name)
		list.button:SetNormalFontObject(myfont)
		list.button:SetBackdrop(DEFAULT_BACKDROP)
		list.button:SetBackdropColor(0, 0, 0, 1)

		list.button.text = list.button:GetFontString(nil, "ARTWORK")
		list.button.text:SetWordWrap(false)

		list.button.icon = list.button.icon or list.button:CreateTexture("$parentIcon", "ARTWORK")
		list.button.icon:SetTexCoord(0.094, 0.906, 0.094, 0.906)
		list.button.icon:SetPoint("LEFT", list.button, "LEFT", 5, 0)
		list.button.icon:SetWidth(14)
		list.button.icon:SetHeight(14)

		list.length = length or 200
		list.thickness = thickness or 15

		list.button:SetScript("OnMouseDown", anchorOnMouseDown)
		list.button:SetScript("OnMouseUp", anchorOnMouseUp)
		list.button:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up")

		list.buttons = {}

		list:SetPoint("TOPLEFT", UIParent, "CENTER")
		list:SetMinResize(80, 60)
		list:SetMaxResize(500, 500)

		list.showIcon = true
		list.showLabel = true
		list.showTimerLabel = true

		list.lastBar = list

		list.texture = DEFAULT_TEXTURE
		list.spacing = 0
		list.startpoint = 0
		list.offset = 0
		list.numBars = 0

		-- resize to the right
		if not list.resizeright then
			list.resizeright = CreateFrame("Button", "$parentRightResizer", list)
			list.resizeright:SetFrameLevel(list:GetFrameLevel() + 3)
			list.resizeright:SetWidth(12)
			list.resizeright:SetHeight(12)
			list.resizeright:SetAlpha(0)
			list.resizeright.icon = list.resizeright:CreateTexture("$parentIcon", "OVERLAY")
			list.resizeright.icon:SetAllPoints(list.resizeright)
			list.resizeright.icon:SetTexture(ICON_RESIZE)
			list.resizeright.icon:SetVertexColor(1, 1, 1, 0.65)
			list.resizeright:Hide()
		end

		-- resize to the left
		if not list.resizeleft then
			list.resizeleft = CreateFrame("Button", "$parentLeftResizer", list)
			list.resizeleft:SetFrameLevel(list:GetFrameLevel() + 3)
			list.resizeleft:SetWidth(12)
			list.resizeleft:SetHeight(12)
			list.resizeleft:SetAlpha(0)
			list.resizeleft.icon = list.resizeleft:CreateTexture("$parentIcon", "OVERLAY")
			list.resizeleft.icon:SetAllPoints(list.resizeleft)
			list.resizeleft.icon:SetTexture(ICON_RESIZE)
			list.resizeleft.icon:SetVertexColor(1, 1, 1, 0.65)
			list.resizeleft:Hide()
		end

		-- lock button
		if not list.lockbutton then
			list.lockbutton = CreateFrame("Button", "$parentLockButton", list)
			list.lockbutton:SetPoint("BOTTOM", list, "BOTTOM", 0, 2)
			list.lockbutton:SetFrameLevel(list:GetFrameLevel() + 3)
			list.lockbutton:SetWidth(12)
			list.lockbutton:SetHeight(12)
			list.lockbutton:SetAlpha(0)
			list.lockbutton.icon = list.lockbutton:CreateTexture("$parentIcon", "OVERLAY")
			list.lockbutton.icon:SetAllPoints(list.lockbutton)
			list.lockbutton.icon:SetTexture(ICON_LOCK)
			list.lockbutton.icon:SetVertexColor(0.6, 0.6, 0.6, 0.7)
			list.lockbutton:Hide()
		end

		-- stretch button
		if not list.stretcher then
			list.stretcher = CreateFrame("Button", "$parentStretcher", list)
			list.stretcher:SetFrameLevel(list:GetFrameLevel() + 3)
			list.stretcher:SetWidth(32)
			list.stretcher:SetHeight(12)
			list.stretcher:SetAlpha(0)
			list.stretcher.bg = list.stretcher:CreateTexture("$parentBG", "BACKGROUND")
			list.stretcher.bg:SetAllPoints(true)
			list.stretcher.bg:SetTexture([[Interface\Buttons\WHITE8X8]])
			list.stretcher.bg:SetVertexColor(0, 0, 0, 0.85)
			list.stretcher.icon = list.stretcher:CreateTexture("$parentIcon", "ARTWORK")
			list.stretcher.icon:SetWidth(12)
			list.stretcher.icon:SetHeight(12)
			list.stretcher.icon:SetPoint("CENTER")
			list.stretcher.icon:SetTexture(ICON_STRETCH)
			list.stretcher.icon:SetDesaturated(true)
			list.stretcher:Hide()
		end

		list:SetDisableResize(nil)
		list:SetDisableStretch(nil)
		list:SetReverseStretch(nil)
		list:SetAnchorMouseover(false)
		list:SetScript("OnSizeChanged", listOnSizeChanged)

		list:SetClickthrough(nil)
		list:EnableMouseWheel(true)
		list:SetScript("OnMouseWheel", listOnMouseWheel)

		list:SetOrientation(orientation)
		list:SetReverseGrowth(nil, true)
		list:SetWidth(length)
		list:SetHeight(height)

		return list
	end
end

-- retrieves a single bar list
function lib:GetBarGroup(name)
	return barLists[self] and barLists[self][name]
end

-- returns the list of all bar lists
function lib:GetBarGroups()
	return barLists[self]
end

-- individual bars functions

-- lib:NewBarFromPrototype - creates a new bar
function lib:NewBarFromPrototype(prototype, name, ...)
	if self == lib then
		error("You may only call :NewBar as an embedded function")
	end

	if type(prototype) ~= "table" or type(prototype.mt) ~= "table" then
		error("Invalid bar prototype")
	end

	bars[self] = bars[self] or {}
	local bar = bars[self][name]
	local isNew = false
	if not bar then
		self.numBars = self.numBars + 1
		bar = tremove(recycledBars)
		if not bar then
			bar = prototype:Bind(createFrame("Frame"))
		else
			bar:Show()
		end
		isNew = true
	end
	bar.name = name
	bar:Create(...)
	bar:SetFont(self.font, self.fontSize, self.fontFlags, self.numfont, self.numfontSize, self.numfontFlags)

	bars[self][name] = bar

	return bar, isNew
end

-- retrieves a single bar by name
function lib:GetBar(name)
	return bars[self] and bars[self][name]
end

-- retrieves all bars for the given list
function lib:GetBars(name)
	return bars[self] or dummyTable
end

barListPrototype.GetBar = lib.GetBar
barListPrototype.GetBars = lib.GetBars

-- releases a bar
function lib:ReleaseBar(name)
	if not bars[self] then return end

	local bar
	if type(name) == "string" then
		bar = bars[self][name]
	elseif type(name) == "table" then
		if name.name and bars[self][name.name] == name then
			bar = name
		end
	end

	if bar then
		bar:OnBarReleased()
		bars[self][bar.name] = nil
		recycledBars[#recycledBars + 1] = bar
		self.numBars = self.numBars - 1
		self.callbacks:Fire("BarReleased", bar, bar.name, self.numBars)
	end
end

-- changes lists scroll speed
function lib:SetScrollSpeed(speed)
	scrollspeed = min(10, max(1, speed or 0))
end

local function SavePosition(self)

	wipe(posix) -- always wipe
	posix.width = self:GetWidth()
	posix.height = self:GetHeight()

	local xOfs, yOfs = self:GetCenter()
	if not xOfs then return end

	local scale = self:GetEffectiveScale()
	local uiScale = UIParent:GetScale()

	xOfs = (xOfs * scale) - (GetScreenWidth() * uiScale) / 2
	yOfs = (yOfs * scale) - (GetScreenHeight() * uiScale) / 2
	posix.xOfs = xOfs / uiScale
	posix.yOfs = yOfs / uiScale
end

local function RestorePosition(self)
	if self == lib then return end

	if posix.xOfs and posix.yOfs then
		local scale = self:GetEffectiveScale()
		local uiScale = UIParent:GetScale()

		self:ClearAllPoints()
		self:SetPoint("CENTER", UIParent, "CENTER", posix.xOfs * uiScale / scale, posix.yOfs * uiScale / scale)
	end

	if posix.width then
		self:SetWidth(posix.width)
	end

	if posix.height then
		self:SetHeight(posix.height)
	end

	wipe(posix) -- always wipe
end

barListPrototype.SavePosition = SavePosition
barListPrototype.RestorePosition = RestorePosition

do
	local UIFrameFadeIn = UIFrameFadeIn
	local UIFrameFadeOut = UIFrameFadeOut
	function lib:Fade(timeToFade, startAlpha, endAlpha)
		if self == lib then return end
		local func = (startAlpha > endAlpha) and UIFrameFadeOut or UIFrameFadeIn
		return func(self, timeToFade, startAlpha, endAlpha)
	end
end
barListPrototype.Fade = lib.Fade
barPrototype.Fade = lib.Fade

-- returns bar(s) height
local function GetThickness(self)
	return self.thickness
end
barListPrototype.GetThickness = GetThickness
barPrototype.GetThickness = GetThickness

-- returns bar's length/group width
local function GetLength(self)
	return self.length
end
barListPrototype.GetLength = GetLength
barPrototype.GetLength = GetLength

-- changes size
local function SetSize(self, width, height)
	self:SetWidth(width)
	self:SetHeight(height)
end
barListPrototype.SetSize = SetSize
barPrototype.SetSize = SetSize

-- handles bar/group show/hide
local function SetShown(self, show)
	if show and not self:IsShown() then
		self:Show()
	elseif not show and self:IsShown() then
		self:Hide()
	end
end
barListPrototype.SetShown = SetShown
barPrototype.SetShown = SetShown

-- barListPrototype:AddOnUpdate
-- barPrototype:AddOnUpdate

do
	local function OnUpdate(self, elapsed)
		if not self.updateFuncs or next(self.updateFuncs) == nil then
			self:SetScript("OnUpdate", nil)
			return
		end
		for func in pairs(self.updateFuncs) do
			func(self, elapsed)
		end
	end

	local function AddOnUpdate(self, func)
		if self == lib then return end
		if type(func) == "function" then
			self.updateFuncs = self.updateFuncs or new()
			self.updateFuncs[func] = true
			self:SetScript("OnUpdate", self.OnUpdate)
		end
	end

	local function RemoveOnUpdate(self, func)
		if self == lib then return end
		if self.updateFuncs then
			self.updateFuncs[func] = nil
			if next(self.updateFuncs) == nil then
				self.updateFuncs = del(self.updateFuncs)
			end
		end
	end

	barListPrototype.OnUpdate = OnUpdate
	barListPrototype.AddOnUpdate = AddOnUpdate
	barListPrototype.RemoveOnUpdate = RemoveOnUpdate

	barPrototype.OnUpdate = OnUpdate
	barPrototype.AddOnUpdate = AddOnUpdate
	barPrototype.RemoveOnUpdate = RemoveOnUpdate
end

-------------------------------------------------------------------------------
-- bar lists/groups functions

-- locks the bar group
function barListPrototype:Lock(fireevent)
	self.locked = true
	self.lockbutton.icon:SetTexture(ICON_UNLOCK)

	if not self.noresize then
		self.resizeright:Hide()
		self.resizeleft:Hide()
	end

	if fireevent then
		self.callbacks:Fire("WindowLocked", self, self.locked)
	end
end

-- unlocks the bar group
function barListPrototype:Unlock(fireevent)
	self.locked = nil
	self.lockbutton.icon:SetTexture(ICON_LOCK)

	if not self.noresize then
		self.resizeright:Show()
		self.resizeleft:Show()
	end

	if fireevent then
		self.callbacks:Fire("WindowLocked", self, self.locked)
	end
end

-- toggle lock state
function barListPrototype:SetLocked(lock, fireevent)
	if lock then
		self:Lock(fireevent)
	else
		self:Unlock(fireevent)
	end
end

-- changes bars height
function barListPrototype:SetThickness(thickness)
	if thickness and self.thickness ~= thickness then
		self.thickness = thickness
		if bars[self] then
			for _, bar in pairs(bars[self]) do
				bar:SetThickness(self.thickness)
			end
		end
		self:UpdateOrientationLayout()
	end
end

-- changes spacing between bars
function barListPrototype:SetSpacing(spacing)
	if spacing and self.spacing ~= spacing then
		self.spacing = spacing
		self:SortBars()
	end
end

-- returns the spacing between bars
function barListPrototype:GetSpacing()
	return self.spacing
end

-- changes bars orientation
function barListPrototype:SetOrientation(o)
	if o and self.orientation ~= o then
		if o ~= 1 and o ~= 2 then
			error("orientation must be 1 or 2.")
		end

		self.orientation = o
		if bars[self] then
			for _, bar in pairs(bars[self]) do
				bar:SetOrientation(self.orientation)
			end
		end
		self:UpdateOrientationLayout()
	end
end

-- returns bars orientation
function barListPrototype:GetOrientation()
	return self.orientation
end

-- updates orientation layout
function barListPrototype:UpdateOrientationLayout()
	barListPrototype.super.SetWidth(self, self.length)
	self.button:SetWidth(self.length)
	self:SetReverseGrowth(self.growup, true)
end

-- barListPrototype:SetSmoothing - bars animation
do
	local function smoothUpdate(self, elapsed)
		if bars[self] then
			for _, bar in pairs(bars[self]) do
				if bar:IsShown() and bar.targetamount then
					local amt
					if bar.targetamount > bar.lastamount then
						amt = min(((bar.targetamount - bar.lastamount) / 10) + bar.lastamount, bar.targetamount)
					else
						amt = max(bar.lastamount - ((bar.lastamount - bar.targetamount) / 10), bar.targetamount)
					end

					bar.lastamount = amt
					if amt == bar.targetamount then
						bar.targetamount = nil
					end
					SetTextureValue(bar, amt, bar.targetdist)
				end
			end
		end
	end

	function barListPrototype:SetSmoothing(smoothing)
		self.smoothing = smoothing or nil
		if self.smoothing then
			self:AddOnUpdate(smoothUpdate)
		else
			self:RemoveOnUpdate(smoothUpdate)
		end
	end
end

-- changes group grow direction
function barListPrototype:SetReverseGrowth(reverse, update)
	if (self.growup == reverse) and update then return end -- only update if necessary

	self.growup = reverse or nil

	self.button:ClearAllPoints()
	self.resizeright:ClearAllPoints()
	self.resizeleft:ClearAllPoints()
	self.lockbutton:ClearAllPoints()

	if self.growup then
		self.button:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT")
		self.button:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")

		self.resizeright.icon:SetTexCoord(0, 1, 1, 0)
		self.resizeright:SetPoint("TOPRIGHT", self, "TOPRIGHT")

		self.resizeleft.icon:SetTexCoord(1, 0, 1, 0)
		self.resizeleft:SetPoint("TOPLEFT", self, "TOPLEFT")

		self.lockbutton:SetPoint("TOP", self, "TOP", 0, -2)
	else
		self.button:SetPoint("TOPLEFT", self, "TOPLEFT")
		self.button:SetPoint("TOPRIGHT", self, "TOPRIGHT")

		self.resizeright.icon:SetTexCoord(0, 1, 0, 1)
		self.resizeright:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")

		self.resizeleft.icon:SetTexCoord(1, 0, 0, 1)
		self.resizeleft:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT")

		self.lockbutton:SetPoint("BOTTOM", self, "BOTTOM", 0, 2)
	end

	self:SortBars()
end

-- returns true if the group is reversed
function barListPrototype:GetReverseGrowth()
	return self.growup
end

-- makes bars (un)clickable
function barListPrototype:SetClickthrough(clickthrough)
	if self.clickthrough ~= clickthrough then
		self.clickthrough = clickthrough or nil
		if bars[self] then
			for _, bar in pairs(bars[self]) do
				bar:EnableMouse(not self.clickthrough)
			end
		end
	end
end

-- barListPrototype:AddButton - adds buttons to anchor
do
	local function buttonOnEnter(self)
		GameTooltip_SetDefaultAnchor(GameTooltip, self)
		GameTooltip:SetText(self.title)
		GameTooltip:AddLine(self.description, 1, 1, 1, true)
		GameTooltip:Show()
		anchorOnEnter(self:GetParent())
	end

	local function buttonOnLeave(self)
		GameTooltip:Hide()
		anchorOnLeave(self:GetParent())
	end

	function barListPrototype:AddButton(index, title, description, normaltex, highlighttex, clickfunc)
		if index and not title then
			title = index
		elseif title and not index then
			index = title
		end

		-- Create button frame.
		local btn = CreateFrame("Button", "$parent" .. title:gsub("%s+", "_"), self.button)
		btn:SetFrameLevel(self.button:GetFrameLevel() + 1)
		btn:SetWidth(14)
		btn:SetHeight(14)

		btn:SetNormalTexture(normaltex)
		btn:SetHighlightTexture(highlighttex or normaltex, "ADD")
		btn.normalTex = btn:GetNormalTexture()
		btn.highlightTex = btn:GetHighlightTexture()

		btn:RegisterForClicks("AnyUp")
		btn:SetScript("OnClick", clickfunc)

		btn.list = self
		btn.index = index
		btn.title = title
		btn.description = description

		btn:SetScript("OnEnter", buttonOnEnter)
		btn:SetScript("OnLeave", buttonOnLeave)

		btn:Hide()
		self.buttons[#self.buttons + 1] = btn
		self:AdjustButtons()

		return btn
	end
end

-- handles anchor buttons show/hide
function barListPrototype:ShowButton(title, visible)
	for i = 1, #self.buttons do
		local b = self.buttons[i]
		if b and b.title == title then
			b.visible = visible or nil
			break
		end
	end
	self:AdjustButtons()
end

-- shows anchor
function barListPrototype:ShowAnchor()
	self.button:Show()
	self:GuessMaxBars()
	self:SortBars()
end

-- hides anchor
function barListPrototype:HideAnchor()
	self.button:Hide()
	self:GuessMaxBars()
	self:SortBars()
end

-- shows anchor icon
function barListPrototype:ShowAnchorIcon(icon)
	if not self.showAnchorIcon then
		self.showAnchorIcon = true
		self.button.icon:Show()
		self:AdjustTitle()
	end
	if icon then
		self.button.icon:SetTexture(icon)
	end
end

-- hides anchor icon
function barListPrototype:HideAnchorIcon()
	if self.showAnchorIcon then
		self.showAnchorIcon = nil
		self.button.icon:SetTexture(nil)
		self.button.icon:Hide()
		self:AdjustTitle()
	end
end

-- adds an offset to bars starting point.
function barListPrototype:SetDisplacement(startpoint)
	if startpoint and self.startpoint ~= startpoint then
		self.startpoint = startpoint
		self:GuessMaxBars()
		self:SortBars()
	end
end

-- barListPrototype:SetAnchorMouseover - handles anchor mouseover
do
	function anchorOnEnter(self)
		local p = self:GetParent()
		listOnEnter(p)

		if p.mouseover then
			p:AdjustTitle(true)

			for i = 1, #p.buttons do
				local b = p.buttons[i]
				if b and b.visible then
					b:Show()
				end
			end
		end
	end

	function anchorOnLeave(self)
		local p = self:GetParent()
		listOnLeave(p)

		if p.mouseover then
			p:AdjustTitle()

			for i = 1, #p.buttons do
				local b = p.buttons[i]
				if b and b.visible then
					b:Hide()
				end
			end
		end
	end

	function barListPrototype:SetAnchorMouseover(mouseover)
		self.mouseover = mouseover or nil
		self.button:SetScript("OnEnter", anchorOnEnter)
		self.button:SetScript("OnLeave", anchorOnLeave)
		self:AdjustButtons()
	end
end

-- adjusts anchor text
function barListPrototype:AdjustTitle(nomouseover)
	self.button.text:SetJustifyH(self.orientation == 2 and "RIGHT" or "LEFT")
	self.button.text:SetJustifyV("MIDDLE")

	self.button.icon:ClearAllPoints()
	self.button.text:ClearAllPoints()

	if self.lastbtn and self.orientation == 2 then
		if self.mouseover and not nomouseover then
			self.button.text:SetPoint("LEFT", self.button, "LEFT", 5, 1)
		else
			self.button.text:SetPoint("LEFT", self.lastbtn, "RIGHT")
		end
		self.button.icon:SetPoint("RIGHT", self.button, "RIGHT", -5, -1)
		self.button.text:SetPoint("RIGHT", self.button, "RIGHT", self.showAnchorIcon and -23 or -5, 0)
	elseif self.lastbtn then
		self.button.icon:SetPoint("LEFT", self.button, "LEFT", 5, -1)
		self.button.text:SetPoint("LEFT", self.button, "LEFT", self.showAnchorIcon and 23 or 5, 0)
		if self.mouseover and not nomouseover then
			self.button.text:SetPoint("RIGHT", self.button, "RIGHT", -5, 1)
		else
			self.button.text:SetPoint("RIGHT", self.lastbtn, "LEFT")
		end
	else
		self.button.icon:SetPoint("LEFT", self.button, "LEFT", 5, -1)
		self.button.text:SetPoint("LEFT", self.button, "LEFT", self.showAnchorIcon and 23 or 5, 0)
		self.button.text:SetPoint("RIGHT", self.button, "RIGHT", -5, 0)
	end
end

-- adjusts anchor buttons
function barListPrototype:AdjustButtons()
	self.lastbtn = nil
	local height = self.button:GetHeight()
	local spacing = self.btnspacing or 1
	local nr = 0

	for i = 1, #self.buttons do
		local btn = self.buttons[i]
		if btn then
			btn:ClearAllPoints()

			if btn.visible then
				if nr == 0 and self.orientation == 2 then
					btn:SetPoint("TOPLEFT", self.button, "TOPLEFT", 5, -(max(height - btn:GetHeight(), 0) / 2))
				elseif nr == 0 then
					btn:SetPoint("TOPRIGHT", self.button, "TOPRIGHT", -5, -(max(height - btn:GetHeight(), 0) / 2))
				elseif self.orientation == 2 then
					btn:SetPoint("TOPLEFT", self.lastbtn, "TOPRIGHT", spacing, 0)
				else
					btn:SetPoint("TOPRIGHT", self.lastbtn, "TOPLEFT", -spacing, 0)
				end
				self.lastbtn = btn
				nr = nr + 1

				if self.mouseover then
					btn:Hide()
				else
					btn:Show()
				end
			else
				btn:Hide()
			end
		end
	end

	self:AdjustTitle()
end

-- changes spacing between anchor buttons
function barListPrototype:SetButtonsSpacing(spacing)
	if self.btnspacing ~= spacing then
		self.btnspacing = spacing or 1
		self:AdjustButtons()
	end
end

-- changes anchor buttons opacity
function barListPrototype:SetButtonsOpacity(opacity)
	if opacity and self.buttonsOpacity ~= opacity then
		self.buttonsOpacity = opacity
		for i = 1, #self.buttons do
			local btn = self.buttons[i]
			if btn then
				btn:SetAlpha(opacity)
			end
		end
	end
end

-- creates a new bar from prototype
function barListPrototype:NewBarFromPrototype(prototype, ...)
	local bar, isNew = lib.NewBarFromPrototype(self, prototype, ...)
	bar:SetTexture(self.texture)

	if self.showIcon then
		bar:ShowIcon()
	else
		bar:HideIcon(bar)
	end
	if self.showLabel then
		bar:ShowLabel()
	else
		bar:HideLabel(bar)
	end
	if self.showTimerLabel then
		bar:ShowTimerLabel()
	else
		bar:HideTimerLabel(bar)
	end
	self:SortBars()
	bar.ownerGroup = self
	bar:SetParent(self)

	bar:EnableMouse(not self.clickthrough)
	return bar, isNew
end

-- creates a new bar
function barListPrototype:NewBar(name, text, value, maxVal, icon)
	local bar, isNew = self:NewBarFromPrototype(barPrototype, name, text, value, maxVal, icon, self.orientation, self.length, self.thickness)

	if self.bgcolor then
		bar.bg:SetVertexColor(self.bgcolor[1], self.bgcolor[2], self.bgcolor[3], self.bgcolor[4])
	else
		bar.bg:SetVertexColor(0.3, 0.3, 0.3, 0.6)
	end

	return bar, isNew
end

-- removes the given bar
function barListPrototype:RemoveBar(bar)
	lib.ReleaseBar(self, bar)
end

function barListPrototype:SetDisableHighlight(disable)
	self.barhighlight = (disable ~= true) and true or nil
end

-- changes bars background color
function barListPrototype:SetBarBackgroundColor(r, g, b, a)
	if not self.bgcolor or self.bgcolor[1] ~= r or self.bgcolor[2] ~= g or self.bgcolor[3] ~= b or self.bgcolor[4] ~= a then
		self.bgcolor = self.bgcolor or new()
		self.bgcolor[1] = r
		self.bgcolor[2] = g
		self.bgcolor[3] = b
		self.bgcolor[4] = a or 1

		if bars[self] then
			for _, bar in pairs(bars[self]) do
				bar.bg:SetVertexColor(self.bgcolor[1], self.bgcolor[2], self.bgcolor[3], self.bgcolor[4])
			end
		end
	end
end

-- barListPrototype:SetDisableResize - disable group resize
do
	function listOnEnter(self)
		if self.lockbutton then
			self.lockbutton:SetAlpha(1)
		end
		if self.stretcher then
			self.stretcher:SetAlpha(1)
		end
		if self.resizeright then
			self.resizeright:SetAlpha(1)
			self.resizeleft:SetAlpha(1)
		end
	end

	function listOnLeave(self)
		GameTooltip:Hide()
		if self.lockbutton then
			self.lockbutton:SetAlpha(0)
		end
		if self.stretcher then
			self.stretcher:SetAlpha(0)
		end
		if self.resizeright then
			self.resizeright:SetAlpha(0)
			self.resizeleft:SetAlpha(0)
		end
	end

	local strfind = strfind or string.find
	local function sizerOnMouseDown(self, button)
		local p = self:GetParent()
		if button == "LeftButton" and not p.isResizing then
			p.isResizing = true

			self.direction = self.direction or strfind(self:GetName(), "Left") and "LEFT" or "RIGHT"
			if IsShiftKeyDown() then
				p:StartSizing(self.direction)
			elseif IsAltKeyDown() then
				p:StartSizing(p.growup and "TOP" or "BOTTOM")
			else
				p:StartSizing((p.growup and "TOP" or "BOTTOM") .. self.direction)
			end
		end
	end

	local function sizerOnMouseUp(self, button)
		local p = self:GetParent()
		if button == "LeftButton" and p.isResizing then
			p.isResizing = nil
			local top, left = p:GetTop(), p:GetLeft()
			p:StopMovingOrSizing()
			p:SetLength(p:GetLength())
			p:GuessMaxBars()
			p:SortBars()
			if p.callbacks then
				p.callbacks:Fire("WindowResized", p)
			end
		end
	end

	local function sizerOnEnter(self)
		GameTooltip:SetOwner(self, "ANCHOR_NONE")
		GameTooltip:SetPoint("BOTTOM", self, "TOP")
		GameTooltip:ClearLines()
		GameTooltip:AddLine(L_RESIZE_HEADER)
		GameTooltip:AddLine(L_RESIZE_CLICK, 1, 1, 1)
		GameTooltip:AddLine(L_RESIZE_SHIFT_CLICK, 1, 1, 1)
		GameTooltip:AddLine(L_RESIZE_ALT_CLICK, 1, 1, 1)
		GameTooltip:Show()
		listOnEnter(self:GetParent())
		self.icon:SetVertexColor(1, 1, 1, 1)
	end

	local function sizerOnLeave(self)
		listOnLeave(self:GetParent())
		self.icon:SetVertexColor(1, 1, 1, 0.65)
	end

	local function lockOnEnter(self)
		local p = self:GetParent()
		GameTooltip:SetOwner(self, "ANCHOR_NONE")
		GameTooltip:SetPoint("BOTTOM", self, "TOP")
		GameTooltip:ClearLines()
		GameTooltip:AddLine(p.name)
		GameTooltip:AddLine(p.locked and L_UNLOCK_WINDOW or L_LOCK_WINDOW, 1, 1, 1)
		GameTooltip:Show()
		listOnEnter(self:GetParent())
		self.icon:SetVertexColor(1, 1, 1, 0.7)
	end

	local function lockOnLeave(self)
		listOnLeave(self:GetParent())
		self.icon:SetVertexColor(0.6, 0.6, 0.6, 0.7)
	end

	local function lockOnClick(self)
		local p = self:GetParent()
		if p.locked then
			p:Unlock(true)
		else
			p:Lock(true)
		end
		lockOnEnter(self)
	end

	function barListPrototype:SetDisableResize(disable)
		self.noresize = disable or nil

		if self.noresize then
			-- window
			self:SetScript("OnEnter", nil)
			self:SetScript("OnLeave", nil)

			-- lock button
			self.lockbutton:SetScript("OnClick", nil)
			self.lockbutton:SetScript("OnEnter", nil)
			self.lockbutton:SetScript("OnLeave", nil)
			self.lockbutton:Hide()

			-- left resizer
			self.resizeleft:SetScript("OnMouseDown", nil)
			self.resizeleft:SetScript("OnMouseUp", nil)
			self.resizeleft:SetScript("OnEnter", nil)
			self.resizeleft:SetScript("OnLeave", nil)
			self.resizeleft:Hide()

			-- right resizer
			self.resizeright:SetScript("OnMouseDown", nil)
			self.resizeright:SetScript("OnMouseUp", nil)
			self.resizeright:SetScript("OnEnter", nil)
			self.resizeright:SetScript("OnLeave", nil)
			self.resizeright:Hide()
		else
			-- window
			self:SetScript("OnEnter", listOnEnter)
			self:SetScript("OnLeave", listOnLeave)

			-- lock button
			self.lockbutton:SetScript("OnClick", lockOnClick)
			self.lockbutton:SetScript("OnEnter", lockOnEnter)
			self.lockbutton:SetScript("OnLeave", lockOnLeave)
			self.lockbutton:Show()

			-- left resizer
			self.resizeleft:SetScript("OnMouseDown", sizerOnMouseDown)
			self.resizeleft:SetScript("OnMouseUp", sizerOnMouseUp)
			self.resizeleft:SetScript("OnEnter", sizerOnEnter)
			self.resizeleft:SetScript("OnLeave", sizerOnLeave)
			self.resizeleft:Show()

			-- right resizer
			self.resizeright:SetScript("OnMouseDown", sizerOnMouseDown)
			self.resizeright:SetScript("OnMouseUp", sizerOnMouseUp)
			self.resizeright:SetScript("OnEnter", sizerOnEnter)
			self.resizeright:SetScript("OnLeave", sizerOnLeave)
			self.resizeright:Show()
		end
	end
end

-- barListPrototype:SetDisableStretch - disable group stretch
do
	local function listOnStretch(self, elapsed)
		if self.stretch_off then
			self.stretch_on = nil
			self.stretch_off = nil
			self.callbacks:Fire("WindowStretchStop", self)
		elseif self.stretch_on then
			if not self.isStretching then
				self.isStretching = true
				self:SavePosition()
				self:StartSizing(self.stretchdown and "BOTTOM" or "TOP")
				self.callbacks:Fire("WindowStretchStart", self)
			else
				self:SortBars()
				self.callbacks:Fire("WindowStretching", self)
			end
		else
			self.isStretching = nil
			self:StopMovingOrSizing()
			self:RestorePosition()
			self:RemoveOnUpdate(listOnStretch)
		end
	end

	function stretchOnMouseDown(self, button)
		local p = self:GetParent()
		if button == "LeftButton" and p then
			p.stretch_on = true
			p:AddOnUpdate(listOnStretch)
		end
	end

	function stretchOnMouseUp(self, button)
		local p = self:GetParent()
		if p and p.stretch_on then
			p.stretch_off = true
		end
	end

	local function stretchOnEnter(self)
		self.icon:SetDesaturated(false)
		listOnEnter(self:GetParent())
	end

	local function stretchOnLeave(self)
		self.icon:SetDesaturated(true)
		listOnLeave(self:GetParent())
	end

	function barListPrototype:SetDisableStretch(disable)
		self.nostrech = disable or nil
		if self.nostrech then
			self.stretcher:SetScript("OnMouseDown", nil)
			self.stretcher:SetScript("OnMouseUp", nil)
			self.stretcher:SetScript("OnEnter", nil)
			self.stretcher:SetScript("OnLeave", nil)
			self.stretcher:Hide()
		else
			self.stretcher:SetScript("OnMouseDown", stretchOnMouseDown)
			self.stretcher:SetScript("OnMouseUp", stretchOnMouseUp)
			self.stretcher:SetScript("OnEnter", stretchOnEnter)
			self.stretcher:SetScript("OnLeave", stretchOnLeave)
			self.stretcher:Show()
		end
	end
end

-- reverse group's stretch direction
function barListPrototype:SetReverseStretch(stretchdown)
	self.stretchdown = stretchdown or nil
	if self.stretcher:IsShown() then
		self.stretcher:ClearAllPoints()
		if self.stretchdown then
			self.stretcher:SetPoint("TOP", self, "BOTTOM")
			self.stretcher.icon:SetTexCoord(0.219, 0.781, 0.781, 0)
		else
			self.stretcher:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT")
			self.stretcher.icon:SetTexCoord(0.219, 0.781, 0, 0.781)
		end
	end
end

-- changes bars offset
function barListPrototype:SetBarOffset(offset)
	if self.offset ~= offset then
		self.offset = offset
		self:SortBars()
	end
end

-- returns bars offset
function barListPrototype:GetBarOffset()
	return self.offset
end

-- changes group width
function barListPrototype:SetLength(length)
	if not equal_floats(self.length, length) then
		self.length = length
		if bars[self] then
			for _, bar in pairs(bars[self]) do
				bar:SetLength(length)
				bar:OnSizeChanged()
			end
		end
		self:UpdateOrientationLayout()
	end
end

-- changes group height
function barListPrototype:SetHeight(height)
	self.super.SetHeight(self, height)
	self:GuessMaxBars()
end

-- sets bars sort function
function barListPrototype:SetSortFunction(func)
	if self.sortFunc ~= func then
		if func and type(func) ~= "function" then
			error(":SetSortFunction requires a valid function.")
		end

		self.sortFunc = func
	end
end

-- returns bars sort function
function barListPrototype:GetSortFunction(func)
	return self.sortFunc
end

-- changes bars width
function barListPrototype:SetBarWidth(width)
	self:SetLength(width)
end

-- changes bars height
function barListPrototype:SetBarHeight(height)
	self:SetThickness(height)
end

-- sets max bars
function barListPrototype:SetMaxBars(num)
	if self.maxBars ~= num then
		self.maxBars = floor(num)
		self:SortBars()
	end
end

-- returns max bars
function barListPrototype:GetMaxBars()
	return self.maxBars
end

-- guesses max bars to display depending on the group's height
function barListPrototype:GuessMaxBars()
	local maxbars = self:GetHeight() / (self.thickness + self.spacing)

	if self.button:IsVisible() then
		local height = self:GetHeight() + self.spacing
		local height2 = self.button:GetHeight() + self.startpoint
		maxbars = ((maxbars - 1) * ((height - height2) / height)) + 1
	end

	self.maxBars = floor(maxbars)
end

-- returns the number of bars
function barListPrototype:GetNumBars()
	return self.numBars or 0
end

-- changes bars texture
function barListPrototype:SetTexture(tex)
	if self.texture ~= tex then
		self.texture = tex
		if bars[self] then
			for _, bar in pairs(bars[self]) do
				bar.fg:SetTexture(self.texture)
				bar.bg:SetTexture(self.texture)
			end
		end
	end
end

-- changes labels and timerLabels fonts
function barListPrototype:SetFont(font, size, outline, numFont, numSize, numOutline)
	local changed = false

	-- label
	if font and self.font ~= font then
		self.font = font
		changed = true
	end
	if size and self.fontSize ~= size then
		self.fontSize = size
		changed = true
	end
	if outline and self.fontFlags ~= outline then
		self.fontFlags = outline
		changed = true
	end

	-- timer
	if numFont and self.numfont ~= numFont then
		self.numfont = numFont
		changed = true
	end
	if numSize and self.numfontSize ~= numSize then
		self.numfontSize = numSize
		changed = true
	end
	if numOutline and self.numfontFlags ~= numOutline then
		self.numfontFlags = numOutline
		changed = true
	end

	if changed and bars[self] then
		for _, bar in pairs(bars[self]) do
			bar:SetFont(font, size, outline, numFont, numSize, numOutline)
		end
	end
end

-- show bar icons
function barListPrototype:ShowBarIcons()
	self.showIcon = true
	if bars[self] then
		for _, bar in pairs(bars[self]) do
			bar:ShowIcon()
		end
	end
end

-- hide bar icons
function barListPrototype:HideBarIcons()
	self.showIcon = nil
	if bars[self] then
		for _, bar in pairs(bars[self]) do
			bar:HideIcon()
		end
	end
end

-- returns true if bar icons are shown
function barListPrototype:IsIconShown()
	return self.showIcon
end

-- shows bar labels
function barListPrototype:ShowLabel()
	self.showLabel = true
	if bars[self] then
		for _, bar in pairs(bars[self]) do
			bar:ShowLabel()
		end
	end
end

-- hides bar labesl
function barListPrototype:HideLabel()
	self.showLabel = nil
	if bars[self] then
		for _, bar in pairs(bars[self]) do
			bar:HideLabel()
		end
	end
end

-- shows bars timer labels
function barListPrototype:ShowTimerLabel()
	self.showTimerLabel = true
	if bars[self] then
		for _, bar in pairs(bars[self]) do
			bar:ShowTimerLabel()
		end
	end
end

-- hides bars timer labels
function barListPrototype:HideTimerLabel()
	self.showTimerLabel = nil
	if bars[self] then
		for _, bar in pairs(bars[self]) do
			bar:HideTimerLabel()
		end
	end
end

-- changes bars text color
function barListPrototype:SetTextColor(r, g, b, a)
	if not self.textcolor or self.textcolor[1] ~= r or self.textcolor[2] ~= g or self.textcolor[3] ~= b or self.textcolor[4] ~= a then
		self.textcolor = self.textcolor or new()
		self.textcolor[1] = r or 1
		self.textcolor[2] = g or 1
		self.textcolor[3] = b or 1
		self.textcolor[4] = a or 1

		if bars[self] then
			for _, bar in pairs(bars[self]) do
				bar.label:SetTextColor(self.textcolor[1], self.textcolor[2], self.textcolor[3], self.textcolor[4])
				bar.timerLabel:SetTextColor(self.textcolor[1], self.textcolor[2], self.textcolor[3], self.textcolor[4])
			end
		end
	end
end

-- changes bar default color
function barListPrototype:SetColor(r, g, b, a)
	if not self.colors or self.colors[1] ~= r or self.colors[2] ~= g or self.colors[3] ~= b or self.colors[4] ~= a then
		self.colors = self.colors or new()
		local alpha = (a and self.colors[4] ~= a)

		self.colors[1] = r
		self.colors[2] = g
		self.colors[3] = b
		self.colors[4] = a

		if bars[self] then
			for _, bar in pairs(bars[self]) do
				if bar.lockColor and alpha then
					bar:SetColor(nil, nil, nil, a, bar.lockColor)
				elseif bar.lockColor then
					bar:UpdateColor()
				else
					bar:SetColor(r, g, b, a, bar.lockColor)
				end
			end
		end
	end
end

-- enables or disabled spark icon
function barListPrototype:SetUseSpark(usespark)
	if self.usespark ~= usespark then
		self.usespark = usespark or nil

		if bars[self] then
			for _, bar in pairs(bars[self]) do
				if self.usespark and not bar.spark:IsShown() then
					bar.spark:Show()
				elseif not self.usespark and bar.spark:IsShown() then
					bar.spark:Hide()
				end
			end
		end
	end
end

-- barListPrototype:SortBars - sorts bars
do
	local values = {}

	local function sortFunc(a, b)
		local apct, bpct = a.value / a.maxValue, b.value / b.maxValue
		if apct == bpct then
			if a.maxValue == b.maxValue then
				return a.name > b.name
			else
				return a.maxValue > b.maxValue
			end
		else
			return apct > bpct
		end
	end

	function barListPrototype:SortBars()
		local lastBar = self
		local ct = 0
		local has_fixed = nil

		if not bars[self] then
			return
		else
			for _, bar in pairs(bars[self]) do
				ct = ct + 1
				values[ct] = bar
				bar:Hide()
				has_fixed = has_fixed or bar.fixed
			end
		end

		for i = ct + 1, #values do
			values[i] = nil
		end
		if #values == 0 then
			return
		end

		tsort(values, self.sortFunc or sortFunc)

		local orientation = self.orientation
		local growup = self.growup
		local spacing = self.spacing
		local startpoint = self.button:IsVisible() and (self.button:GetHeight() + self.startpoint) or 0

		local from, to
		local offset = self.offset
		local y1, y2 = startpoint, startpoint
		local maxbars = min(#values, self.maxBars)

		local start, stop, step, fixnum
		if growup then
			from = "BOTTOM"
			to = "TOP"
			start = min(#values, maxbars + offset)
			stop = min(#values, 1 + offset)
			step = -1
			fixnum = start
		else
			from = "TOP"
			to = "BOTTOM"
			start = min(1 + offset, #values)
			stop = min(maxbars + offset, #values)
			step = 1
			fixnum = stop
		end

		-- Fixed bar replaces the last bar
		if has_fixed and fixnum < #values then
			for i = fixnum + 1, #values, 1 do
				if values[i].fixed then
					tinsert(values, fixnum, values[i])
					break
				end
			end
		end

		local showIcon = self.showIcon
		local thickness = self.thickness
		local shown = 0

		for i = start, stop, step do
			local origTo = to
			local v = values[i]
			if lastBar == self then
				to = from
				if growup then
					y1, y2 = startpoint, startpoint
				else
					y1, y2 = -startpoint, -startpoint
				end
			else
				if growup then
					y1, y2 = spacing, spacing
				else
					y1, y2 = -spacing, -spacing
				end
			end

			local x1, x2 = 0, 0 -- TODO: find a better way
			if showIcon and lastBar == self then
				if orientation == 1 then
					x1 = thickness
				else
					x2 = -thickness
				end
			end

			if shown <= maxbars and v then
				v:ClearAllPoints()
				v:SetPoint(from .. "LEFT", lastBar, to .. "LEFT", x1, y1)
				v:SetPoint(from .. "RIGHT", lastBar, to .. "RIGHT", x2, y2)
				v:Show()

				shown = shown + 1
				lastBar = v
			end

			to = origTo
		end

		self.lastBar = lastBar
	end
end

-------------------------------------------------------------------------------
-- bar functions

-- barPrototype:Create - creates a new bar
do
	local function barOnMouseDown(self, button)
		local p = self:GetParent()
		if p and p.callbacks then
			p.callbacks:Fire("BarClick", self, button)
		end
	end

	local function barOnEnter(self, motion)
		local p = self:GetParent()
		listOnEnter(p)
		if p.barhighlight then
			self.hg:SetVertexColor(1, 1, 1, 0.1)
		end
		if p.callbacks then
			p.callbacks:Fire("BarEnter", self, motion)
		end
	end

	local function barOnLeave(self, motion)
		local p = self:GetParent()
		listOnLeave(p)
		if p.barhighlight then
			self.hg:SetVertexColor(0, 0, 0, 0)
		end
		if p.callbacks then
			p.callbacks:Fire("BarLeave", self, motion)
		end
	end

	local DEFAULT_ICON = [[Interface\Icons\INV_Misc_QuestionMark]]
	function barPrototype:Create(text, value, maxVal, icon, orientation, length, thickness)
		self:SetScript("OnMouseDown", barOnMouseDown)
		self:SetScript("OnEnter", barOnEnter)
		self:SetScript("OnLeave", barOnLeave)
		self:SetScript("OnSizeChanged", self.OnSizeChanged)

		self.bg = self.bg or self:CreateTexture(nil, "BACKGROUND")
		self.bg:SetAllPoints()
		self.bg:SetVertexColor(0.3, 0.3, 0.3, 0.6)

		self.fg = self.fg or self:CreateTexture(nil, "BORDER")

		self.hg = self.hg or self:CreateTexture(nil, "ARTWORK")
		self.hg:SetAllPoints()
		self.hg:SetTexture([[Interface\Buttons\WHITE8X8]])
		self.hg:SetVertexColor(0, 0, 0, 0)

		self.spark = self.spark or self:CreateTexture(nil, "OVERLAY")
		self.spark:SetTexture([[Interface\CastingBar\UI-CastingBar-Spark]])
		self.spark:SetWidth(10)
		self.spark:SetHeight(10)
		self.spark:SetBlendMode("ADD")
		self.spark:Hide()

		self.iconFrame = self.iconFrame or CreateFrame("Frame", nil, self)
		self.iconFrame:SetPoint("LEFT", self, "LEFT")
		self.iconFrame:SetFrameLevel(self:GetFrameLevel() + 1)

		self.icon = self.icon or self.iconFrame:CreateTexture(nil, "OVERLAY")
		self.icon:SetAllPoints(self.iconFrame)
		self:SetIcon(icon or DEFAULT_ICON)
		if icon then
			self:ShowIcon()
		end
		self.icon:SetTexCoord(0.094, 0.906, 0.094, 0.906)

		self.label = self.label or self:CreateFontString(nil, "OVERLAY", "ChatFontNormal")
		self.label:SetWordWrap(false)
		self.label:SetText(text)
		self.label:ClearAllPoints()
		self.label:SetPoint("LEFT", self, "LEFT", 3, 0)
		self:ShowLabel()

		self.timerLabel = self.timerLabel or self:CreateFontString(nil, "OVERLAY", "ChatFontNormal")
		self.timerLabel:ClearAllPoints()
		self.timerLabel:SetPoint("RIGHT", self, "RIGHT", -3, 0)
		self:SetTimerLabel("")
		self:HideTimerLabel()

		local f, s, m = self.label:GetFont()
		self.label:SetFont(f, s or 10, m)

		f, s, m = self.timerLabel:GetFont()
		self.timerLabel:SetFont(f, s or 10, m)

		self:SetScale(1)
		self:SetAlpha(1)

		self.length = length or 200
		self.thickness = thickness or 15
		self:SetOrientation(orientation or 1)

		self.value = value or 1
		self.maxValue = maxVal or self.value
		self:SetMaxValue(self.maxValue)
		self:SetValue(self.value)
	end
end

-- releases a bar that's no longer in use
function barPrototype:OnBarReleased()
	self.ownerGroup = nil
	self.colors = del(self.colors)
	self.updateFuncs = del(self.updateFuncs)

	self.fg:SetVertexColor(1, 1, 1, 0)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnLeave", nil)
	self:SetScript("OnUpdate", nil)
	self:SetParent(UIParent)
	self:ClearAllPoints()
	self:Hide()

	local f, s, m = ChatFontNormal:GetFont()
	self.label:SetFont(f, s or 10, m)
	self.timerLabel:SetFont(f, s or 10, m)
end

-- handles size change
function barPrototype:OnSizeChanged()
	self:SetValue(self.value)
end

-- changes label and timer fonts
function barPrototype:SetFont(font, size, outline, numFont, numSize, numOutline)
	local f, s, o = self.label:GetFont()
	self.label:SetFont(font or f, size or s, outline or o)

	f, s, o = self.timerLabel:GetFont()
	self.timerLabel:SetFont(numFont or f, numSize or s, numOutline or o)
end

-- changes bar icon texture
function barPrototype:SetIcon(icon, ...)
	if icon then
		self.icon:SetTexture(icon)
		if self.showIcon then
			self.icon:Show()
		end
		if ... then
			self.icon:SetTexCoord(...)
		end
	else
		self.icon:Hide()
	end
end

-- shows bar's icon
function barPrototype:ShowIcon()
	self.showIcon = true
	if self.icon then
		self.icon:Show()
	end
end

-- hides bar's icon
function barPrototype:HideIcon()
	self.showIcon = nil
	if self.icon then
		self.icon:Hide()
	end
end

-- returns true if bar's icon is set to be shown
function barPrototype:IsIconShown()
	return self.showIcon
end

-- changes bar's label text
function barPrototype:SetLabel(text)
	self.label:SetText(text)
end

-- returns bar's label text
function barPrototype:GetLabel()
	return self.label:GetText()
end

barPrototype.SetText = barPrototype.SetLabel -- for API compatibility
barPrototype.GetText = barPrototype.GetLabel -- for API compatibility

-- shows bar's label
function barPrototype:ShowLabel()
	if not self.label:IsShown() then
		self.label:Show()
	end
end

-- hides bar's label
function barPrototype:HideLabel()
	if self.label:IsShown() then
		self.label:Hide()
	end
end

-- changes timer's text
function barPrototype:SetTimerLabel(text)
	self.timerLabel:SetText(text)
end

-- returns timer's text
function barPrototype:GetTimerLabel()
	return self.timerLabel:GetText()
end

-- shows bar's timer label
function barPrototype:ShowTimerLabel()
	if not self.timerLabel:IsShown() then
		self.timerLabel:Show()
	end
end

-- hides bar's timer label
function barPrototype:HideTimerLabel()
	if self.timerLabel:IsShown() then
		self.timerLabel:Hide()
	end
end

-- changes bar's foreground and background textures
function barPrototype:SetTexture(texture)
	self.fg:SetTexture(texture)
	self.bg:SetTexture(texture)
end

-- changes bar's color
function barPrototype:SetColor(r, g, b, a, locked)
	if not self.colors or self.colors[1] ~= r or self.colors[2] ~= g or self.colors[3] ~= b or self.colors[4] ~= a then
		self.colors = self.colors or new()

		self.colors[1] = r or self.colors[1]
		self.colors[2] = g or self.colors[2]
		self.colors[3] = b or self.colors[3]
		self.colors[4] = a or self.colors[4]
		self.lockColor = locked or nil

		self:UpdateColor()
	end
end

-- unsets bar color
function barPrototype:UnsetColor()
	self.colors = del(self.colors)
end

-- updates bar's foreground color
function barPrototype:UpdateColor()
	if self.colors then
		self.fg:SetVertexColor(self.colors[1], self.colors[2], self.colors[3], self.colors[4] or 1)
	end
end

-- barPrototype:SetLength -- changes bar's width
-- barPrototype:SetThickness -- changes bar's heght
do
	barPrototype.SetWidth = barPrototype.super.SetWidth
	barPrototype.SetHeight = barPrototype.super.SetHeight

	local function updateSize(self)
		local iconSize = self.showIcon and self.thickness or 0
		local width = max(0.0001, self.length - iconSize)
		local height = self.thickness

		self:SetWidth(width)
		self:SetHeight(height)
		self.iconFrame:SetWidth(height)
		self.iconFrame:SetHeight(height)
	end

	function barPrototype:SetLength(length)
		self.length = length
		updateSize(self)
	end

	function barPrototype:SetThickness(thickness)
		self.thickness = thickness
		updateSize(self)
	end
end

-- changes bar's orientation
function barPrototype:SetOrientation(o)
	self:UpdateOrientationLayout(o)
	self:SetThickness(self.thickness)
end

-- returns bar's orientation
function barPrototype:GetOrientation()
	return self.orientation
end

-- updates bar's orientation
function barPrototype:UpdateOrientationLayout(orientation)
	local t = nil
	if orientation == 1 then
		t = self.iconFrame
		t:ClearAllPoints()
		t:SetPoint("RIGHT", self, "LEFT")

		t = self.spark
		t:ClearAllPoints()
		t:SetPoint("TOP", self.fg, "TOPRIGHT", 0, 7)
		t:SetPoint("BOTTOM", self.fg, "BOTTOMRIGHT", 0, -7)
		t:SetTexCoord(0, 1, 0, 1)

		t = self.fg
		t.SetValue = t.SetWidth
		t:ClearAllPoints()
		t:SetPoint("TOPLEFT", self, "TOPLEFT")
		t:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT")

		t = self.timerLabel
		t:ClearAllPoints()
		t:SetPoint("RIGHT", self, "RIGHT", -5, 0)
		t:SetJustifyH("RIGHT")
		t:SetJustifyV("MIDDLE")

		t = self.label
		t:ClearAllPoints()
		t:SetPoint("LEFT", self, "LEFT", 5, 0)
		t:SetPoint("RIGHT", self.timerLabel, "LEFT")
		t:SetJustifyH("LEFT")
		t:SetJustifyV("MIDDLE")

		self.bg:SetTexCoord(0, 1, 0, 1)
	elseif orientation == 2 then
		t = self.iconFrame
		t:ClearAllPoints()
		t:SetPoint("LEFT", self, "RIGHT")

		t = self.spark
		t:ClearAllPoints()
		t:SetPoint("TOP", self.fg, "TOPLEFT", 0, 7)
		t:SetPoint("BOTTOM", self.fg, "BOTTOMLEFT", 0, -7)
		t:SetTexCoord(0, 1, 0, 1)

		t = self.fg
		t.SetValue = t.SetWidth
		t:ClearAllPoints()
		t:SetPoint("TOPRIGHT", self, "TOPRIGHT")
		t:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")

		t = self.timerLabel
		t:ClearAllPoints()
		t:SetPoint("LEFT", self, "LEFT", 5, 0)
		t:SetJustifyH("LEFT")
		t:SetJustifyV("MIDDLE")

		t = self.label
		t:ClearAllPoints()
		t:SetPoint("RIGHT", self, "RIGHT", -5, 0)
		t:SetPoint("LEFT", self.timerLabel, "RIGHT")
		t:SetJustifyH("RIGHT")
		t:SetJustifyV("MIDDLE")

		self.bg:SetTexCoord(0, 1, 0, 1)
	end
	self:SetValue(self.value or 0)
end

-- barPrototype:SetValue - changes bar's value
do
	local function SetTextureTarget(self, amt, dist)
		self.targetamount = amt
		self.targetdist = dist
	end

	function SetTextureValue(self, amt, dist)
		dist = max(0.0001, dist - (self.showIcon and self.thickness or 0))
		self.fg:SetValue(amt * dist)

		if self.orientation == 1 then
			self.fg:SetTexCoord(0, amt, 0, 1)
		elseif self.orientation == 2 then
			self.fg:SetTexCoord(1 - amt, 1, 0, 1)
		end
	end

	function barPrototype:SetValue(val)
		if not val then
			error("value cannot be nil!")
		end

		self.value = val
		if not self.maxValue or val > self.maxValue then
			self.maxValue = val
		end

		local ownerGroup = self.ownerGroup
		if ownerGroup then
			local amt = max(0.000001, min(1, val / max(self.maxValue, 0.000001)))
			local dist = (ownerGroup and ownerGroup:GetLength()) or self.length

			-- smoothing
			if ownerGroup.smoothing and self.lastamount then
				SetTextureTarget(self, amt, dist)
			else
				self.lastamount = amt
				SetTextureValue(self, amt, dist)
			end

			-- spark
			if ownerGroup.usespark and self.spark then
				if amt == 1 or amt <= 0.000001 then
					self.spark:Hide()
				else
					self.spark:Show()
				end
			end

			self:UpdateColor()
		end
	end
end

-- sets bar's max value
function barPrototype:SetMaxValue(val)
	self.maxValue = val
	self:SetValue(self.value)
end

--- Finally: upgrade our old embeds
for target, v in pairs(lib.embeds) do
	lib:Embed(target)
end

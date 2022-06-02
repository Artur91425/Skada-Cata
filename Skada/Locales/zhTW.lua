local L = LibStub("AceLocale-3.0"):NewLocale("Skada", "zhTW")
if not L then return end

L["A damage meter."] = "一個傷害統計。"
L["Memory usage is high. You may want to reset Skada, and enable one of the automatic reset options."] = "記憶體使用過高，你或許想要重置Skada，並且啟用一個自動重設的選項。"
L["Skada is out of date. You can download the newest version from |cffffbb00%s|r"] = "Skada 已過期. 你可以在 |cffffbb00%s|r 下載到最新的版本."
L["Skada: Modes"] = "Skada:模組"
L["Skada: Fights"] = "Skada:戰鬥"
L["Data Collection"] = "數據收集"
L["ENABLED"] = "啟用"
L["DISABLED"] = "停用"
L["Enable All"] = "全部啟用"
L["Disable All"] = "禁用所有"
L["Stopping for wipe."] = "因擦拭而停止。"
L["Usage:"] = "利用："
-- profiles
L["Profiles"] = "設定檔"
L["Profile Import/Export"] = "匯入/匯出設定檔"
L["Import Profile"] = "匯入設定檔"
L["Export Profile"] = "匯出設定檔"
L["Paste here a profile in text format."] = "將設定檔以文字格式貼在這."
L["Press CTRL-V to paste a Skada configuration text."] = "按下 CTRL-V 貼上 Skada 的設定文字"
L["This is your current profile in text format."] = "這是你目前的設定文字."
L["Press CTRL-C to copy the configuration to your clipboard."] = "按下 CTRL-C 複製 Skada 的設定到你的剪貼簿"
-- common lines
L["Options"] = "選項"
L["Options for %s."] = "%s狀態的選項。"
L["General"] = "一般"
L["General options for %s."] = "%s 的常規選項。"
L["Text"] = "文本"
L["Text options for %s."] = "%s 的文本選項。"
L["Format"] = "格式"
L["Format options for %s."] = "%s 的格式選項。"
L["Appearance"] = "外貌"
L["Appearance options for %s."] = "%s 的外觀選項。"
L["Advanced"] = "進階"
L["Advanced options for %s."] = "%s 的高級選項。"
L["Position"] = "位置"
L["Position settings for %s."] = "%s 的位置選項。"
L["Width"] = "寬度"
L["The width of %s."] = "%s 的寬度。"
L["Height"] = "高度"
L["The height of %s."] = "%s 的高度。"
L["Verbose Mode"] = "詳細模式"
L["Enable verbose mode for %s."] = "為 %s 啟用詳細模式。"
L["More Details"] = "更多細節"
L["Active Time"] = "活躍時間"
L["Segment Time"] = "分段時間"
L["Click for |cff00ff00%s|r"] = "點擊後為 |cff00ff00%s|r"
L["Shift-Click for |cff00ff00%s|r"] = "Shift+點擊後為 |cff00ff00%s|r"
L["Control-Click for |cff00ff00%s|r"] = "Ctrl+點擊後為 |cff00ff00%s|r"
L["Alt-Click for |cff00ff00%s|r"] = "Alt+點擊後為 |cff00ff00%s|r"
L["Toggle Class Filter"] = "按类筛选"
L["Average"] = "平均"
L["Casts"] = "施法"
L["Count"] = "計數"
L["Refresh"] = "刷新"
L["Percent"] = "百分比"
L["sPercent"] = "百分比 (子模塊)"
L["General Options"] = "一般選項"
L["HoT"] = " (治療/跳)"
L["DoT"] = " (傷害/跳)"
L["Hits"] = "命中"
L["Normal Hits"] = "一般命中"
L["Critical"] = "致命"
L["Critical Hits"] = "致命一擊"
L["Crushing"] = "碾壓"
L["Glancing"] = "偏斜"
L["ABSORB"] = "吸收"
L["BLOCK"] = "格檔"
L["DEFLECT"] = "避開"
L["DODGE"] = "閃躲"
L["EVADE"] = "閃避"
L["IMMUNE"] = "免疫"
L["MISS"] = "未擊中"
L["PARRY"] = "招架"
L["REFLECT"] = "反射"
L["RESIST"] = "抵制"
L["Only for bosses."] = "只針對老闆。"
L["Enable this only against bosses."] = "只對老闆啟用此。"
-- windows section:
L["Window"] = "視窗"
L["Windows"] = "視窗"
L["Create Window"] = "建立視窗"
L["Window Name"] = "窗口名稱"
L["Enter the name for the new window."] = "為新視窗輸入名稱。"
L["Delete Window"] = "刪除視窗"
L["Choose the window to be deleted."] = "選擇的視窗已刪除。"
-- L["Are you sure you want to delete this window?"] = ""
L["Rename Window"] = "重新命名視窗"
L["Enter the name for the window."] = "輸入視窗名稱。"
L["Test Mode"] = "測試模式"
L["Creates fake data to help you configure your windows."] = "創建虛假數據以幫助您配置窗口。"
-- L["Child Window"] = ""
-- L["A child window will replicate the parent window actions."] = ""
-- L["Child Window Mode"] = ""
L["Lock Window"] = "鎖定視窗"
L["Locks the bar window in place."] = "鎖定計量條視窗位置。"
L["Hide Window"] = "隱藏視窗"
-- L["Hides the window."] = ""
-- L["Sticky Window"] = ""
-- L["Allows the window to stick to other Skada windows."] = ""
L["Snap to best fit"] = "適合比例"
L["Snaps the window size to best fit when resizing."] = "視窗比例自動調整到適合比例。"
L["Disable Resize Buttons"] = "停用調整大小按鈕"
L["Resize and lock/unlock buttons won't show up when you hover over the window."] = "將鼠標懸停在窗口上時不會出現調整大小和鎖定/解鎖。"
L["Disable stretch button"] = "禁用拉伸按鈕"
L["Stretch button won't show up when you hover over the window."] = "當您將鼠標懸停在窗口上時，不會顯示拉伸按鈕。"
L["Reverse window stretch"] = "向下拉伸窗口"
L["opt_botstretch_desc"] = "将拉伸按钮放置在窗口底部，并使后者向下拉伸。"
L["Display System"] = "顯示方式"
L["Choose the system to be used for displaying data in this window."] = "在視窗中選擇顯示資料的使用方式。"
-- L["Copy Settings"] = ""
-- L["Choose the window from which you want to copy the settings."] = ""
-- bars
L["Bars"] = "計量條"
L["Left Text"] = "左文字"
L["Right Text"] = "右文字"
L["Font"] = "字體"
L["The font used by %s."] = "%s 使用的字體。"
L["Font Size"] = "字體大小"
L["The font size of %s."] = "%s 的字體大小。"
L["Font Outline"] = "字体轮廓"
L["Sets the font outline."] = "設置字體輪廓。"
L["Outline"] = "輪廓"
L["Thick outline"] = "粗體"
L["Monochrome"] = "單色"
L["Outlined monochrome"] = "單色字體"
L["Bar Texture"] = "計量條的材質"
L["The texture used by all bars."] = "所有計量條使用這個材質。"
L["Spacing"] = "間距"
L["Distance between %s."] = "%s 之間的距離。"
L["Displacement"] = "位移"
L["The distance between the edge of the window and the first bar."] = "窗口邊緣與第一個欄之間的距離。"
L["Bar Orientation"] = "計量條的方向"
L["The direction the bars are drawn in."] = "計量條的增長方向。"
L["Left to right"] = "由左到右"
L["Right to left"] = "由右到左"
L["Reverse bar growth"] = "計量條反向增長"
L["Bars will grow up instead of down."] = "計量條將向上增長。"
-- L["Disable bar highlight"] = ""
-- L["Hovering a bar won't make it brighter."] = ""
L["Bar Color"] = "計量條的顏色"
L["Choose the default color of the bars."] = "變更計量條預設的顏色。"
L["Background Color"] = "背景的顏色"
L["Choose the background color of the bars."] = "選擇計量條的背景顏色。"
L["Spell school colors"] = "法術派別顏色"
L["Use spell school colors where applicable."] = "適合的法術使用派別顏色。"
L["When possible, bars will be colored according to player class."] = "依照玩家職業來調整計量條的顏色。"
L["When possible, bar text will be colored according to player class."] = "依照玩家職業來調整計量條文字的顏色。"
L["Class Icons"] = "職業圖示"
L["Use class icons where applicable."] = "使用職業圖示(如果適用)."
-- L["Spec Icons"] = ""
-- L["Use specialization icons where applicable."] = ""
L["Role Icons"] = "角色類型圖標"
L["Use role icons where applicable."] = "使用適用的角色類型圖標。"
L["Show Spark Effect"] = "顯示觸發效果"
L["Click Through"] = "點擊穿透"
L["Disables mouse clicks on bars."] = "在計量條上停用滑鼠點擊。"
L["Smooth Bars"] = "平滑計量條"
L["Animate bar changes smoothly rather than immediately."] = "計量條動態平滑變化而非立即的。"
-- title bar
L["Title Bar"] = "標題條"
L["Enables the title bar."] = "啟用標題條。"
L["Include set"] = "包含設定"
L["Include set name in title bar"] = "在標題欄包含設定名稱"
L["Encounter Timer"] = "首領戰鬥計時器"
L["When enabled, a stopwatch is shown on the left side of the text."] = "如果開啟，在文字的左側將出現一個計時器"
L["Mode Icon"] = "模式圖標"
L["Shows mode's icon in the title bar."] = "在標題欄中顯示模式的圖標。"
L["The texture used as the background of the title."] = "使用於標題的背景材質。"
L["The background color of the title."] = "標題的背景顏色。"
L["Border texture"] = "邊框的材質"
L["The texture used for the borders."] = "使用於邊框的材質。"
L["Border Color"] = "外框顏色"
L["The color used for the border."] = "使用在外框的顏色。"
L["Buttons"] = "按鈕"
L["Auto Hide Buttons"] = "自動隱藏按鈕"
L["Show window buttons only if the cursor is over the title bar."] = "仅当光标在标题栏上方时才显示窗口按钮。"
L["Buttons Style"] = "按鈕樣式"
-- general window
L["Background"] = "背景"
L["Background Texture"] = "背景的材質"
L["The texture used as the background."] = "使用於背景的材質。"
L["Tile"] = "標題"
L["Tile the background texture."] = "標題的背景材質。"
L["Tile Size"] = "標題大小"
L["The size of the texture pattern."] = "材質圖案的大小"
L["The color of the background."] = "背景的顏色。"
L["Border"] = "外框"
L["Border Thickness"] = "邊框的厚度"
L["The thickness of the borders."] = "邊框的厚度。"
L["Border Insets"] = "邊界距離"
L["The distance between the window and its border."] = "窗口和它的边界之间的距离。"
L["Scale"] = "比例"
L["Sets the scale of the window."] = "設定視窗比例。"
L["Strata"] = "層級"
L["This determines what other frames will be in front of the frame."] = "這決定了那些其他的框架會在此框架之前。"
L["Clamped To Screen"] = "限制在螢幕內"
L["Toggle whether to permit movement out of screen."] = "打開/關閉是否允許把框架移到超出螢幕的位置。"
L["X Offset"] = "水平位置"
L["Y Offset"] = "垂直位置"
-- switching
L["Mode Switching"] = "轉換模組"
L["Combat Mode"] = "戰鬥模組"
L["opt_combatmode_desc"] = "當進入戰鬥時，自動切換|cffffbb00目前的|r以及選擇的模組。"
L["Wipe Mode"] = "清除模組"
L["opt_wipemode_desc"] = "清除後，自動切換至|cffffbb00目前的|r模組。"
L["Return after combat"] = "戰鬥後返回"
L["Return to the previous set and mode after combat ends."] = "戰鬥結束後返回原先的設定和模組。"
L["Auto switch to current"] = "自動轉換到目前"
L["opt_autocurrent_desc"] = "不管何時進入戰鬥，這個視窗會自動切換到|cffffbb00目前的|r片段"
L["Auto Hide"] = "自動隱藏"
L["While in combat"] = "戰鬥中"
L["While out of combat"] = "脫離戰鬥"
L["While not in a group"] = "當不在隊伍時"
L["While inside an instance"] = "當在副本時"
L["While not inside an instance"] = "當不在副本時"
L["In Battlegrounds"] = "戰場"
L["Inline Bar Display"] = "內置條顯示"
L["Inline display is a horizontal window style."] = "內置顯示是一個水平視窗樣式。"
L["Font Color"] = "文字顏色"
-- L["Font Color.\nClick \"Class Colors\" to begin."] = ""
-- L["opt_barwidth_desc"] = ""
L["Fixed bar width"] = "固定條列寬度"
L["opt_fixedbarwidth_desc"] = "勾選後，條列寬度將會固定。否則條列寬度取決於文字寬度。"
L["Class Colors"] = "班級顏色"
L["Use class colors for %s."] = "對 %s 使用類顏色。"
-- L["opt_isusingclasscolors_desc"] = ""
-- L["Put values on new line."] = ""
-- L["opt_isonnewline_desc"] = ""
-- L["Use ElvUI skin if avaliable."] = ""
-- L["opt_isusingelvuiskin_desc"] = ""
-- L["Use solid background."] = ""
-- L["Un-check this for an opaque background."] = ""
L["Data Text"] = "數據文字"
L["mod_broker_desc"] = "數據文字行為類似LDB數據輸出。它可以整合在任何像是泰坦面板與巧克力棒的LDB顯示中。它也有一個可選的內部框架。"
L["Use frame"] = "使用窗口"
L["opt_useframe_desc"] = "顯示一個獨立的框架。 如果您使用的是 LDB 顯示提供程序，例如 Titan Panel 或 ChocolateBar，則不需要。"
L["Text Color"] = "文字顏色"
L["Choose the default color."] = "選擇預設顏色。"
L["Hint: Left-Click to set active mode."] = "提示：左鍵點擊來設定啟動模式。"
L["Right-Click to set active set."] = "右鍵點擊設定啟動設置。"
L["Shift+Left-Click to open menu."] = "Shift+左鍵點擊開啟選單。"
-- data resets
L["Data Resets"] = "資料重置"
L["Reset on entering instance"] = "進入副本時重置"
L["Controls if data is reset when you enter an instance."] = "當你進入副本時資料是否要重置。"
L["Reset on joining a group"] = "加入團體時重置"
L["Controls if data is reset when you join a group."] = "當你加入團體時資料是否要重置。"
L["Reset on leaving a group"] = "離開團體時重置"
L["Controls if data is reset when you leave a group."] = "當你離開團體時控制資料是否要重置。"
L["Ask"] = "詢問"
L["Do you want to reset Skada?\nHold SHIFT to reset all data."] = "你要重置Skada嗎？\n按住 SHIFT 重置所有。"
L["All data has been reset."] = "所有資料已重置。"
L["There is no data to reset."] = "沒有要重置的數據。"
L["Skip reset dialog"] = "跳過重置確認"
L["opt_skippopup_desc"] = "如果您希望 Skada 在沒有確認對話框的情況下重置，請啟用此選項。"
L["Are you sure you want to reinstall Skada?"] = "您確定要重新安裝 Skada 嗎？"
-- general options
L["Show minimap button"] = "顯示小地圖按鈕"
L["Toggles showing the minimap button."] = "切換顯示小地圖按鈕。"
L["Transliterate"] = "音譯"
L["Converts Cyrillic letters into Latin letters."] = "將西里爾字母轉換為拉丁字母。"
L["Merge pets"] = "合併寵物"
L["Merges pets with their owners. Changing this only affects new data."] = "合併寵物與主人的資料，此只影響改變後的資料。"
L["Show totals"] = "顯示總計"
L["Shows a extra row with a summary in certain modes."] = "在某些模式顯示額外一行的總計。"
L["Only keep boss fighs"] = "只保留首領戰"
L["Boss fights will be kept with this on, and non-boss fights are discarded."] = "保留與首領之間的戰鬥紀錄，與非首領的戰鬥紀錄將會被消除。"
-- L["Always keep boss fights"] = ""
-- L["Boss fights will be kept with this on and will not be affected by Skada reset."] = ""
L["Hide when solo"] = "單練時隱藏"
L["Hides Skada's window when not in a party or raid."] = "當不在隊伍或團隊時隱藏Skada的視窗。"
L["Hide in PvP"] = "在PvP中隱藏"
L["Hides Skada's window when in Battlegrounds/Arenas."] = "當處於戰場/競技場時隱藏Skada的視窗。"
L["Hide in combat"] = "戰鬥中隱藏"
L["Hides Skada's window when in combat."] = "當處於戰鬥狀態時隱藏Skada的視窗。"
-- L["Show in combat"] = ""
-- L["Shows Skada's window when in combat."] = ""
L["Disable while hidden"] = "停用時隱藏"
L["Skada will not collect any data when automatically hidden."] = "當自動隱藏時，Skada將不會紀錄任何資料。"
L["Sort modes by usage"] = "根據使用率對模組排序"
L["The mode list will be sorted to reflect usage instead of alphabetically."] = "模組列表將依照使用率排序而非字母順序"
L["Show rank numbers"] = "顯示排名"
L["Shows numbers for relative ranks for modes where it is applicable."] = "在模組適當位置顯示相對排名。"
L["Aggressive combat detection"] = "雜兵戰鬥檢測"
L["opt_tentativecombatstart_desc"] = [[Skada在團隊副本中經常性的使用一種非常傳統(簡易)的戰鬥檢測機制。勾選此選項Skada將嘗試模仿其他的傷害統計插件，使其有效運用在雜兵戰, 但與首領戰則是無效的。]]
L["Autostop"] = "自動停止"
L["opt_autostop_desc"] = "當有一半以上的團員已死時自動停止當前區段。"
L["Always show self"] = "總是顯示自己"
L["opt_showself_desc"] = "保持玩家顯示在最後即使沒有足夠的空間。"
L["Number format"] = "數字位數"
L["Controls the way large numbers are displayed."] = "控制數字的顯示位數。"
L["Condensed"] = "簡易的"
L["Detailed"] = "詳細的"
L["Combined"] = "組合的"
L["Comma"] = "逗號"
L["Numeral system"] = "數字系統"
L["Select which numeral system to use."] = "選擇要使用的數字縮寫系統。"
L["Auto"] = "自動"
L["Western"] = "西方"
L["East Asia"] = "亞洲"
L["Brackets"] = "框架符號"
L["Choose which type of brackets to use."] = "選擇要使用的括號類型。"
L["Separator"] = "分隔符號"
L["Choose which character is used to separator values between brackets."] = "選擇使用哪個字符來分隔括號之間的值。"
L["Number of decimals"] = "小數位數"
L["Controls the way percentages are displayed."] = "控制百分比的顯示方式。"
L["Data Feed"] = "資料來源"
L["opt_feed_desc"] = "選擇需要顯示在DataBroker上的資料來源。需要一個LDB的顯示插件，例如Titan Panel。"
L["Time Measure"] = "時間測量方式"
L["Activity Time"] = "活躍時間"
L["Effective Time"] = "介面效果微調"
L["opt_timemesure_desc"] = [=[|cFFFFFF00活躍時間|r: 每一位團隊成員停止活動時，便會暫停各自的計時，並在恢復後再次開始計時。這是用來測量 DPS 和 HPS 最常用的方法。

|cFFFFFF00有效時間|r: 用於排名，此方法會使用整場戰鬥時間來測量所有團隊成員的 DPS 和 HPS。]=]
L["Number set duplicates"] = "重複數字設置"
L["Append a count to set names with duplicate mob names."] = "追加一個統計以設置重複的怪物名稱。"
L["Set Format"] = "設定格式"
L["Controls the way set names are displayed."] = "控制設定名稱顯示的方式。"
-- L["Links in reports"] = ""
-- L["When possible, use links in the report messages."] = ""
L["Segments to keep"] = "保留分段資料"
L["The number of fight segments to keep. Persistent segments are not included in this."] = "保留多少戰鬥資料分段的數量，不包含連續的片段。"
L["Persistent segments"] = "持久段"
L["The number of persistent fight segments to keep."] = "要保留的持久段數。"
L["Memory Check"] = "內存檢查"
L["Checks memory usage and warns you if it is greater than or equal to 30mb."] = "檢查內存使用情況並在它大於或等於 30mb 時向您發出警告。"
L["Disable Comms"] = "禁用通訊"
L["Minimum segment length"] = "最小分段長度"
L["The minimum length required in seconds for a segment to be saved."] = "保存段所需的最小长度（秒）。"
L["Update frequency"] = "更新頻率"
L["How often windows are updated. Shorter for faster updates. Increases CPU usage."] = "視窗更新有多頻繁。較短時間更新快速，但增加CPU的負擔。"
-- columns
L["Columns"] = "計量條上"
-- tooltips
L["Tooltips"] = "提示訊息"
L["Show Tooltips"] = "顯示提示訊息"
L["Shows tooltips with extra information in some modes."] = "在一些模組中顯示提示訊息以及額外的訊息。"
L["Informative Tooltips"] = "提示訊息的資訊"
L["Shows subview summaries in the tooltips."] = "在提示訊息中顯示即時資訊。"
L["Subview Rows"] = "資訊行數"
L["The number of rows from each subview to show when using informative tooltips."] = "當使用提示訊息的資訊時需要多少行數來顯示資訊。"
L["Tooltip Position"] = "提示訊息的位置"
L["Position of the tooltips."] = "提示訊息的位置。"
L["Top Right"] = "右上"
L["Top Left"] = "左上"
L["Bottom Right"] = "右下"
L["Bottom Left"] = "左下"
L["Smart"] = "智能"
-- L["Follow Cursor"] = ""
L["Top"] = "上"
L["Bottom"] = "下"
L["Right"] = "右"
L["Left"] = "左"
-- disabled modules
L["Modules"] = "组件"
L["Disabled Modules"] = "停用模組"
L["Modules Options"] = "模塊選項"
L["Tick the modules you want to disable."] = "勾選您想要停用的模組。"
L["This change requires a UI reload. Are you sure?"] = "這些改變需要重載UI，你確認嗎？"
-- themes options
L["Theme"] = "主題"
L["Themes"] = "主題"
L["Apply Theme"] = "套用主題"
-- L["Theme applied!"] = ""
L["Name of your new theme."] = "你新主題的名稱。"
L["Save Theme"] = "儲存主題"
L["Delete Theme"] = "刪除主題"
L["Are you sure you want to delete this theme?"] = "確定要刪除此樣式嗎？"
-- scroll options
L["Scroll"] = "滾動"
L["Wheel Speed"] = "鼠標滾輪速度"
L["opt_wheelspeed_desc"] = "更改鼠標滾輪在視窗上滾動的速度。"
L["Scroll Icon"] = "滾動圖標"
L["Scroll mouse button"] = "滾動鼠標按鈕"
-- minimap button
L["Skada Summary"] = "Skada一覽"
-- L["|cff00ff00Left-Click|r to toggle windows."] = ""
L["|cff00ff00Ctrl+Left-Click|r to show/hide windows."] = "|cff00ff00Ctrl+左鍵點|r顯示/隱藏窗口。"
L["|cff00ff00Shift+Left-Click|r to reset."] = "|cff00ff00Shift+左鍵點|r擊進行重置。"
L["|cff00ff00Right-Click|r to open menu."] = "右鍵點擊開啟選單。"
-- skada menu
L["Skada Menu"] = "Skada 選單"
L["Delete Segment"] = "刪除分段資料"
L["Select Segment"] = "选择细分"
L["Keep Segment"] = "保留分段資料"
L["Toggle Windows"] = "切換窗口"
L["Show/Hide Windows"] = "顯示/隱藏窗口"
L["Start New Segment"] = "開始新的分段"
L["Start New Phase"] = "開始新階段"
L["Select All"] = "全選"
L["Deselect All"] = "取消全選"
-- window buttons
L["Configure"] = "設定"
L["Open Config"] = "打開配置"
L["btn_config_desc"] = "讓你配置此啟用的Skada視窗。"
L["btn_reset_desc"] = "除標記為保留外重置全部戰鬥數據。"
L["Segment"] = "分段"
L["btn_segment_desc"] = "跳至特定區段。\n|cff00ff00Shift 點擊|r: |cffffbb00下一個|r片段\n|cff00ff00Shift 右鍵單擊|r: |cffffbb00以前的|r片段\n|cff00ff00中鍵|r: |cffffbb00目前的|r片段"
L["Mode"] = "模組"
L["Jump to a specific mode."] = "跳至特定模組。"
L["Report"] = "報告"
L["btn_report_desc"] = "打開一個對話框，讓你以各種方式報告數據給他人。\n|cff00ff00Shift-點擊後為|r: 快速報告。"
L["Stop"] = "停止"
L["btn_stop_desc"] = "停止或恢復當前區段。用於滅團後停止收集數據。也可在設置中設為自動停止。"
L["Segment Stopped."] = "段已停止。"
L["Segment Paused."] = "段已暫停。"
L["Segment Resumed."] = "段已恢復。"
L["Quick Access"] = "快速訪問"
-- default segments
L["Total"] = "總體的"
L["Current"] = "目前的"
-- report module and window
L["Skada: %s for %s:"] = "Skada:%s來自%s:"
L["Self"] = "自己"
L["Whisper Target"] = "悄悄話目標"
L["Line"] = "排"
L["Lines"] = "行數"
L["There is nothing to report."] = "沒有資料可以報告。"
L["No mode or segment selected for report."] = "沒有選擇可報告的模組或分段資料。"
-- Bar Display Module --
L["Bar Display"] = "顯示計量條"
L["mod_bar_desc"] = "條列顯示是大多數傷害統計使用的一般條列視窗。它可以是廣泛的樣式。"
-- Threat Module --
L["Threat"] = "威脅值"
L["Threat Warning"] = "威脅值的警告"
L["Flash Screen"] = "螢幕閃爍"
L["This will cause the screen to flash as a threat warning."] = "威脅值警告時讓螢幕閃爍。"
L["Shake Screen"] = "螢幕震動"
L["This will cause the screen to shake as a threat warning."] = "威脅值警告時讓螢幕震動。"
L["Warning Message"] = "警报消息"
L["Print a message to screen when you accumulate too much threat."] = "當你仇恨過高時在螢幕上顯示警報消息。"
L["Play sound"] = "播放音效"
L["This will play a sound as a threat warning."] = "威脅值警告時會撥放音效。"
L["Message Output"] = "顯示模式"
L["Choose where warning messages should be displayed."] = "選擇應在何處顯示警告消息。"
L["Chat Frame"] = "聊天視窗"
L["Blizzard Error Frame"] = "Blizzard 錯誤訊息框架"
L["Threat sound"] = "威脅值的音效"
L["opt_threat_soundfile_desc"] = "當你的威脅值達到一定的百分比時播放音效。"
L["Warning Frequency"] = "警告頻率"
L["Threat Threshold"] = "威脅值的條件"
L["opt_threat_threshold_desc"] = "當你的威脅值與坦克相同時顯示警告。"
L["Show raw threat"] = "顯示原始威脅值"
L["opt_threat_rawvalue_desc"] = "顯示與坦克之間的原始威脅值百分比。"
L["Use focus target"] = "使用專注目標"
L["opt_threat_focustarget_desc"] = "讓 Skada 額外檢查您的「focus」和「focus目標」位於「目標」和「目標的目標」之前的順序顯示威脅."
L["Disable while tanking"] = "當為坦克時關閉警報"
L["opt_threat_notankwarnings_desc"] = "如果在防禦姿態,熊形態,正義之怒與冰霜系時,不顯示警報."
L["Ignore Pets"] = "忽略寵物"
L["opt_threat_ignorepets_desc"] = [=[讓 Skada 忽略敵對玩家寵物以確定顯示哪些單位的威脅。

玩家寵物|cffffff78攻擊|r或者|cffffff78防禦|r狀態保持威脅與正常的怪物相同，正被攻擊目標具有最高的威脅。如果寵物指定攻擊一個具體目標，寵物仍然保持在威脅列表，但保持在指定的目標定義100%威脅之上。玩家寵物可以被嘲諷以攻擊你。

然而，玩家寵物在|cffffff78被動|r模式並沒有威脅列表，嘲諷依然不起作用。它們只攻擊玩家所指定的目標且沒有仇恨列表。

當玩家寵物處於|cffffff78跟隨|r狀態時，寵物的威脅列表被消除並立刻停止攻擊，雖然它可能會立即重新指定目標位於攻擊/防禦模式。]=]
L["> Pull Aggro <"] = ">獲得仇恨<"
L["Show Pull Aggro Bar"] = "顯示獲得仇恨棒條"
L["opt_threat_showaggrobar_desc"] = "顯示獲得仇恨所需威脅數值的棒條。"
L["Hide empty window"] = "隱藏空窗口"
L["opt_threat_hideempty_desc"] = "沒有可顯示的內容時完全隱藏窗口。"
L["Test Warnings"] = "測試警報"
L["TPS"] = "每秒威脅值"
L["Threat: Personal Threat"] = "威脅值:個人的威脅值"
-- Absorbs & Healing Module --
L["Healing"] = "治療"
L["Healing Done"] = "造成治療"
L["Healing Taken"] = "承受治療"
L["Healed target list"] = "被治療的玩家"
L["Healing spell list"] = "治療法術列表"
-- L["%s's healing"] = ""
-- L["%s's healed targets"] = ""
-- L["actor heal spells"] = function(n1, n2) return ((not n2 or n1 == n2) and "%s's healing spells" or "%s's healing on %s"):format(n1, n2) end
L["HPS"] = "每秒治療"
L["sHPS"] = "每秒治療 (子模塊)"
-- L["Healing: Personal HPS"] = ""
-- L["RHPS"] = ""
-- L["Healing: Raid HPS"] = ""
L["Total Healing"] = "總體治療"
L["Overheal"] = "過量治療"
L["Overhealing"] = "過量治療"
-- L["Overhealed target list"] = ""
-- L["Overheal spell list"] = ""
-- L["%s's overheal targets"] = ""
-- L["actor overheal spells"] = function(n1, n2) return ((not n2 or n1 == n2) and "%s's overheal spells" or "%s's overhealing on %s"):format(n1, n2) end
L["Absorbs"] = "吸收量"
-- L["Absorbed target list"] = ""
-- L["Absorb spell list"] = ""
-- L["%s's absorbed targets"] = ""
-- L["actor absorb spells"] = function(n1, n2) return ((not n2 or n1 == n2) and "%s's absorb spells" or "%s's absorbs on %s"):format(n1, n2) end
L["APS"] = "每秒吸收"
L["sAPS"] = "每秒吸收 (子模塊)"
L["Absorbs and Healing"] = "吸收和治療"
-- L["Absorbs and healing spells"] = ""
-- L["Absorbed and healed targets"] = ""
-- L["%s's absorbed and healed targets"] = ""
-- L["actor absorb and heal spells"] = function(n1, n2) return ((not n2 or n1 == n2) and "%s's absorb and healing spells" or "%s's absorbs and healing on %s"):format(n1, n2) end
-- L["Healing source list"] = ""
-- L["%s's received healing"] = ""
-- L["Healing Done By Spell"] = ""
-- L["Healing spell sources"] = ""
-- Auras Module --
-- L["Uptime"] = ""
-- L["Buffs and Debuffs"] = ""
L["Buffs"] = "增益"
L["Buff spell list"] = "增益法術列表"
-- L["%s's buffs"] = ""
L["Debuffs"] = "減益"
L["Debuff spell list"] = "減益法術的列表"
-- L["Debuff target list"] = ""
-- L["actor debuffs"] = function(n1, n2) return ((not n2 or n1 == n2) and "%s's debuffs" or "%s's debuffs on %s"):format(n1, n2) end
-- L["%s's <%s> targets"] = ""
-- L["Sunder Counter"] = ""
-- L["Sunder target list"] = ""
-- CC Tracker Module --
L["Crowd Control"] = "控場"
L["CC Done"] = "施放控場"
L["CC Taken"] = "受到控場"
L["CC Breaks"] = "移除控場"
L["Crowd Control Spells"] = "人群控制法術"
L["Crowd Control Targets"] = "人群控制目標"
L["Crowd Control Sources"] = "人群控制來源"
L["%s's control spells"] = "%s的控制法術"
L["%s's control targets"] = "%s的控制对象"
L["%s's control sources"] = "%s的控制来源"
L["Ignore Main Tanks"] = "忽略主坦克"
L["%s on %s removed by %s"] = "%s在%s被%s移除了"
L["%s on %s removed by %s's %s"] = "%s在%s被%s的%s移除了"
-- Damage Module --
-- damage done module
L["Damage"] = "傷害"
-- L["Damage target list"] = ""
L["Damage spell list"] = "傷害法術列表"
L["Damage spell details"] = "傷害法術細節"
-- L["Damage spell targets"] = ""
L["Damage Done"] = "總傷害"
-- L["actor damage"] = function(n1, n2) return ((not n2 or n1 == n2) and "%s's damage" or "%s's damage on %s"):format(n1, n2) end
-- L["%s's <%s> damage"] = ""
-- L["Useful Damage"] = ""
-- L["Useful damage on %s"] = ""
-- L["Damage Done By Spell"] = ""
-- L["%s's sources"] = ""
L["DPS"] = "每秒傷害"
L["sDPS"] = "每秒傷害 (子模塊)"
L["Damage: Personal DPS"] = "傷害:個人的DPS"
L["RDPS"] = "團隊DPS"
L["Damage: Raid DPS"] = "傷害:團隊的DPS"
L["Absorbed Damage"] = "吸收傷害"
L["Enable this if you want the damage absorbed to be included in the damage done."] = "如果你想包括吸收傷害到造成的傷害啟用此。"
-- damage taken module
L["Damage Taken"] = "承受傷害"
-- L["Damage taken by %s"] = ""
-- L["Damage source list"] = ""
-- L["Damage spell sources"] = ""
L["Damage Taken By Spell"] = "承受法術傷害"
-- L["%s's targets"] = ""
L["DTPS"] = "每秒承受的傷害"
L["sDTPS"] = "每秒承受的傷害 (子模塊)"
-- enemy damage done module
L["Enemies"] = "敵方"
L["Enemy Damage Done"] = "敵方的傷害"
L["Damage done per player"] = "每位玩家的總傷害"
-- L["Damage from %s"] = ""
-- enemy damage taken module
L["Enemy Damage Taken"] = "敵方的承受傷害"
-- L["%s's damage sources"] = ""
L["%s below %s%%"] = "%s - %s%%"
L["%s - %s%% to %s%%"] = "%s - %s%% 到 %s%%"
L["Phase %s"] = "第 %s 階段"
L["%s - Phase %s"] = "%s - 第 %s 階段"
L["%s - Phase 1"] = "%s - 第 1 階段"
L["%s - Phase 2"] = "%s - 第 2 階段"
L["%s - Phase 3"] = "%s - 第 3 階段"
L["|cffffbb00%s|r - |cff00ff00Phase %s|r started."] = "|cffffbb00%s|r - |cff00ff00第 %s|r 開始。"
L["|cffffbb00%s|r - |cff00ff00Phase %s|r stopped."] = "|cffffbb00%s|r - |cff00ff00第 %s|r 停止。"
L["|cffffbb00%s|r - |cff00ff00Phase %s|r resumed."] = "|cffffbb00%s|r - |cff00ff00第 %s|r 恢復。"
-- enemy healing done module
L["Enemy Healing Done"] = "敵方造成治療"
-- avoidance and mitigation module
-- L["Avoidance & Mitigation"] = ""
-- L["Damage Breakdown"] = ""
-- L["%s's damage breakdown"] = ""
-- friendly fire module
L["Friendly Fire"] = "隊友誤傷"
-- useful damage targets
L["Important targets"] = "重要目標"
L["Oozes"] = "滲出"
-- L["Princes overkilling"] = ""
-- L["Adds"] = ""
-- L["Halion and Inferno"] = ""
-- L["Valkyrs overkilling"] = ""
-- Deaths Module --
-- L["%s's death"] = ""
-- L["%s's deaths"] = ""
L["Death log"] = "死亡紀錄表"
-- L["%s's death log"] = ""
-- L["Player's deaths"] = ""
L["%s dies"] = "%s已死亡"
L["Spell details"] = "法術細節"
-- L["Spell"] = ""
-- L["Amount"] = ""
-- L["Source"] = ""
L["Change"] = "變更"
L["Events Amount"] = "事件數量"
L["Set the amount of events the death log should record."] = "設置死亡日誌應記錄的事件數量。"
L["Minimum Healing"] = "最小癒合"
L["Ignore heal events that are below this threshold."] = "忽略低於此閾值的修復事件。"
L["Announce Deaths"] = "宣布死亡"
L["Announces information about the last hit the player took before they died."] = "宣布玩家死前最後一次命中。"
-- activity module
L["Activity"] = "活躍度"
-- dispels module lines --
-- L["Dispel spell list"] = ""
-- L["Dispelled spell list"] = ""
-- L["Dispelled target list"] = ""
-- L["%s's dispel spells"] = ""
-- L["%s's dispelled spells"] = ""
-- L["%s's dispelled targets"] = ""
-- failbot module lines --
L["Fails"] = "失誤"
L["%s's fails"] = "％s的失敗"
L["Player's failed events"] = "玩家的失敗事件"
L["Event's failed players"] = "活動失敗的玩家"
L["Report Fails"] = "報告失敗"
L["Reports the group fails at the end of combat if there are any."] = "戰鬥結束時報告失敗列表。"
L["Ignored Events"] = "忽略的事件"
-- interrupts module lines --
-- L["Interrupt spells"] = ""
-- L["Interrupted spells"] = ""
-- L["Interrupted targets"] = ""
-- L["%s's interrupt spells"] = ""
-- L["%s's interrupted spells"] = ""
-- L["%s's interrupted targets"] = ""
L["%s interrupted!"] = "%s 打斷!"
-- Power gained module --
L["Resources"] = "能量"
L["Power gained: Mana"] = "獲得法力"
L["Power gained: Rage"] = "獲得怒氣"
L["Power gained: Energy"] = "獲得能量"
L["Power gained: Runic Power"] = "獲得符能"
L["Mana gained spells"] = "獲得法力的法術列表"
L["Rage gained spells"] = "獲得怒氣的法術列表"
L["Energy gained spells"] = "獲得能量的法術列表"
L["Runic Power gained spells"] = "獲得符能的法術列表"
-- L["%s's gained %s"] = ""
-- Parry module lines --
-- L["Parry-Haste"] = ""
-- L["Parry target list"] = ""
-- L["%s's parry targets"] = ""
-- L["%s parried %s (%s)"] = ""
-- Potions module lines --
-- L["Potions"] = ""
-- L["Potions list"] = ""
-- L["Players list"] = ""
-- L["%s's used potions"] = ""
-- L["Pre-potion"] = "Pre-potion"
-- L["pre-potion: %s"] = "pre-potion: %s"
-- L["Prints pre-potion after the end of the combat."] = ""
-- healthstone --
L["Healthstones"] = "治療石"
-- resurrect module lines --
-- L["Resurrects"] = ""
-- L["Resurrect spell list"] = ""
-- L["Resurrect target list"] = ""
-- L["%s's resurrect spells"] = ""
-- L["%s's resurrect targets"] = ""
-- nickname module lines --
L["Nickname"] = "暱稱"
L["Nicknames are sent to group members and Skada can use them instead of your character name."] = "在傳遞Skada數據之時，你的人物名將會被暱稱所代替。"
L["Set a nickname for you."] = "給你自己設定一個暱稱。"
-- L["Nickname isn't a valid string."] = ""
-- L["Your nickname is too long, max of 12 characters is allowed."] = ""
-- L["Only letters and two spaces are allowed."] = ""
-- L["Your nickname contains a forbidden word."] = ""
-- L["You can't use the same letter three times consecutively, two spaces consecutively or more then two spaces."] = ""
L["Ignore Nicknames"] = "忽略所有昵称"
L["When enabled, nicknames set by Skada users are ignored."] = "如果启用，则Skada用户设置的所有昵称将被忽略。"
-- L["Name display"] = ""
-- L["Choose how names are shown on your bars."] = ""
L["Clear Cache"] = "Clear Cache"
L["Are you sure you want clear cached nicknames?"] = "您确定要清除缓存的昵称吗？"
-- overkill module lines --
L["Overkill"] = "過度損壞"
L["Overkill spell list"] = "過度傷害法術"
L["Overkill target list"] = "過度損壞的目標"
L["%s's overkill spells"] = "%s過度傷害法術"
L["%s's overkill targets"] = "%s過度損壞的目標"
-- tweaks module lines --
L["Improvement"] = "改進"
L["Tweaks"] = "調整"
-- L["First hit"] = ""
-- L["|cffffff00First Hit|r: %s from %s"] = ""
-- L["|cffffbb00First Hit|r: *?*"] = ""
-- L["|cffffbb00Boss First Target|r: %s"] = ""
-- L["opt_tweaks_firsthit_desc"] = ""
-- L["Filter DPS meters Spam"] = ""
-- L["opt_tweaks_spamage_desc"] = ""
L["Reported by: %s"] = "已回報由%s"
-- L["Smart Stop"] = ""
-- L["opt_tweaks_smarthalt_desc"] = ""
-- L["Duration"] = ""
-- L["opt_tweaks_smartwait_desc"] = ""
L["Modes Icons"] = "模式圖標"
L["Show modes icons on bars and menus."] = "在欄和菜單上顯示模式圖標。"
L["opt_tweaks_combatlogfix_desc"] = "從斷裂而沒有完全破壞它可以防止戰鬥記錄。"
L["Conservative Mode"] = "保守的"
L["Aggressive Mode"] = "挑釁的"
L["opt_tweaks_combatlogfixalt_desc"] = "不断清除战斗日志，而不是仅在它损坏时清除。"
L["%d filtered / %d events found. Cleared combat log, as it broke."] = "發現 %d 個過濾/%d 個事件。 清除戰鬥日誌，因為它壞了。"
L["Enable this if you want to ignore |cffffbb00%s|r."] = "如果您想忽略|cffffbb00%s|r，請啟用此功能。"
L["Custom Colors"] = "定制色彩"
L["Arena Teams"] = "競技場隊伍"
L["Are you sure you want to reset all colors?"] = "确定要重置所有颜色？"
L["Announce %s"] = "宣布：%s"
L["Announces how long it took to apply %d stacks of %s and announces when it drops."] = "宣布應用 %d 堆 %s 所用的時間，並宣布它何時到期。"
L["%s dropped from %s!"] = "%s 已於 %s 過期！"
L["%s stacks of %s applied on %s in %s sec!"] = "%4$s 秒內將 %1$s 疊 %2$s 塗抹在 %3$s 上！"
L["My Spells"] = "我的法術"
-- total data options
L["Total Segment"] = "總段" -- needs review
L["All Segments"] = "所有段" -- needs review
L["Raid Bosses"] = "突襲首領" -- needs review
L["Raid Trash"] = "突襲垃圾" -- needs review
L["Dungeon Bosses"] = "地牢首領" -- needs review
L["Dungeon Trash"] = "地牢垃圾" -- needs review
L["opt_tweaks_total_all_desc"] = "将所有段添加到总段的数据中。" -- needs review
L["opt_tweaks_total_fmt_desc"] = "将带有 %s 的段添加到总段的数据中。" -- needs review
L["Detailed total segment"] = "詳細的總段"
-- L["opt_tweaks_total_full_desc"] = "When enabled, Skada will record everything to the total segment, instead of total numbers (record spell details, their targets as their sources)."
-- arena
L["mod_pvp_desc"] = "為競技場和戰場添加專業化檢測，並在同一窗口顯示競技場對手。"
L["Gold Team"] = "金隊"
L["Green Team"] = "綠隊"
L["Color for %s."] = "%s 的顏色。"
-- notifications
L["Notifications"] = "通知"
L["opt_toast_desc"] = "在適用時使用視覺通知而不是聊天窗口消息。"
L["Test Notifications"] = "測試通知"
-- comparison module
L["Comparison"] = "比較"
L["Damage Comparison"] = "傷害比較"
L["%s vs %s: %s"] = "%s 與 %s: %s"
L["%s vs %s: Spells"] = "%s 與 %s: 法術"
L["%s vs %s: Targets"] = "%s 與 %s: 目標"
L["%s vs %s: Damage on %s"] = "%s 與 %s: %sZTR上的傷害"
-- about
L["About"] = "關於"
L["Author"] = "作者"
L["Credits"] = "貢獻者"
L["Date"] = "日期"
L["Discord"] = "Discord"
L["License"] = "授權"
L["Version"] = "版本"
L["Website"] = "網站"
-- some bosses entries
L["World Boss"] = "世界首領"
L["Acidmaw"] = "酸喉"
L["Auriaya"] = "奧芮雅"
L["Blood Prince Council"] = "血親王議會"
L["Champions of the Alliance"] = "聯盟的冠軍" -- needs review
L["Champions of the Horde"] = "部落的冠軍" -- needs review
L["Cult Adherent"] = "神教擁護者"
L["Cult Fanatic"] = "神教狂熱者"
L["Darnavan"] = "達納凡"
L["Deformed Fanatic"] = "畸形的狂熱者"
L["Dreadscale"] = "懼鱗"
L["Empowered Adherent"] = "強化的擁護者"
L["Faction Champions"] = "陣營勇士"
L["Gas Cloud"] = "毒氣雲"
L["General Vezax"] = "威札斯將軍"
L["Gluth"] = "古魯斯"
L["Halion"] = "海萊恩"
L["Hogger"] = "霍格"
L["Ice Sphere"] = "寒冰球體"
L["Icecrown Gunship Battle"] = "寒冰皇冠空中艦艇戰"
L["Icehowl"] = "冰嚎"
L["Kel'Thuzad"] = "科爾蘇加德"
L["Kologarn"] = "柯洛剛恩"
L["Lady Deathwhisper"] = "亡語女士"
L["Living Inferno"] = "燃燒的煉獄火"
L["Mimiron"] = "彌米倫"
L["Onyxia"] = "奧妮克希亞"
L["Prince Keleseth"] = "凱雷希斯親王"
L["Prince Taldaram"] = "泰爾達朗親王"
L["Prince Valanar"] = "瓦拉納爾親王"
L["Raging Spirit"] = "狂怒的鬼魂"
L["Reanimated Adherent"] = "再活化的擁護者"
L["Reanimated Fanatic"] = "再活化的狂熱者"
L["Sapphiron"] = "薩菲隆"
L["Shambling Horror"] = "蹣跚的恐獸"
L["Sindragosa"] = "辛德拉苟莎"
L["Thaddius"] = "泰迪斯"
L["The Four Horsemen"] = "四騎士"
L["The Iron Council"] = "鐵之集會"
L["The Lich King"] = "巫妖王"
L["The Northrend Beasts"] = "北裂境巨獸"
L["Thorim"] = "索林姆"
L["Twin Val'kyr"] = "華爾琪雙子"
L["Val'kyr Shadowguard"] = "華爾琪影衛"
L["Valithria Dreamwalker"] = "瓦莉絲瑞雅·夢行者"
L["Volatile Ooze"] = "暴躁軟泥怪"
L["Wicked Spirit"] = "邪惡靈魂"
L["Yogg-Saron"] = "尤格薩倫"
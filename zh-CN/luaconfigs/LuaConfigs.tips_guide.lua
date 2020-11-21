-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local tips_guide = {
    {
        condition = 101,
        delay = 0.5,
        target_name = "RotateWithMian/MainUI/Middle/Btn_Exproation",
        target_parent = 1,
        target_type = 1
    }, {
        condition = 112,
        id = 2,
        target_name = "SectorRoot/UICanvas/InfoNode/1",
        target_parent = "002_Sector_001",
        target_type = 2
    }, {
        custom_code = "GuideUtil.TipsGuideSectorLevelItem(1101,true,0)",
        custom_code_clear = "GuideUtil.ClearTipsGuideSectorLevelItem(1101,true)",
        id = 3,
        type = 1
    }, {
        id = 4,
        target_name = "DetailNode/BtnGroup/Btn_ViewAvg",
        target_parent = 75,
        target_type = 1
    }, {
        custom_code = "GuideUtil.TipsGuideSectorLevelItem(1102,false,0)",
        custom_code_clear = "GuideUtil.ClearTipsGuideSectorLevelItem(1101,false)",
        id = 5,
        type = 1
    }, {
        id = 6,
        target_name = "DetailNode/BtnGroup/Btn_Battle",
        target_parent = 75,
        target_type = 1
    }, {
        custom_code = "GuideUtil.TipsGuideSectorLevelItem(1102,true,0)",
        custom_code_clear = "GuideUtil.ClearTipsGuideSectorLevelItem(1102,true)",
        id = 7,
        type = 1
    }, {
        custom_code = "GuideUtil.TipsGuideSectorLevelItem(1103,false,0)",
        custom_code_clear = "GuideUtil.ClearTipsGuideSectorLevelItem(1103,false)",
        id = 8,
        type = 1
    }
}
local __default_values = {
    condition = 109,
    condition_arg = __rt_1,
    custom_code = "",
    custom_code_clear = "",
    delay = 0,
    id = 1,
    show_dir = 0,
    target_name = "",
    target_parent = "",
    target_type = 0,
    type = 0,
    wait_target = true
}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(tips_guide) do setmetatable(v, base) end
local __rawdata = {__basemetatable = base}
setmetatable(tips_guide, {__index = __rawdata})
return tips_guide


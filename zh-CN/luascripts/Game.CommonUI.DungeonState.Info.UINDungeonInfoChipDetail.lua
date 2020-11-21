-- params : ...
-- function num : 0 , upvalues : _ENV
local UINDungeonInfoChipDetail = class("UINDungeonInfoChipDetail", UIBaseNode)
local base = UIBaseNode
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local UINDungeonInfoChipDetailTag = require(
                                        "Game.CommonUI.DungeonState.Info.UINDungeonInfoChipDetailTag")
local UINDungeonInfoChipDetailAttr = require(
                                         "Game.CommonUI.DungeonState.Info.UINDungeonInfoChipDetailAttr")
UINDungeonInfoChipDetail.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINDungeonInfoChipDetailTag, UINDungeonInfoChipDetailAttr
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self.tagPool = (UIItemPool.New)(UINDungeonInfoChipDetailTag,
                                    (self.ui).obj_tagItem);
    ((self.ui).obj_tagItem):SetActive(false)
    self.attrPool = (UIItemPool.New)(UINDungeonInfoChipDetailAttr,
                                     (self.ui).obj_attrItem);
    ((self.ui).obj_attrItem):SetActive(false)
    self.nowChipIndex = 1
    self.chipDataList = {}
end

UINDungeonInfoChipDetail.InitChipInfo = function(self, chipDataList, index)
    -- function num : 0_1
    self.chipDataList = chipDataList
    self:RefreshData(index)
end

UINDungeonInfoChipDetail.RefreshData = function(self, index)
    -- function num : 0_2 , upvalues : _ENV, UINChipItem
    self.nowChipIndex = index
    local chipData = (self.chipDataList)[index]
    local chipCfg = chipData.chipCfg
    local qualityColor = ItemQualityColor[chipData.quality] -- DECOMPILER ERROR at PC16: Confused about usage of register: R5 in 'UnsetPending'
    ;
    ((self.ui).tex_Decorate).color = (Color.New)(qualityColor.r, qualityColor.g,
                                                 qualityColor.b, 0.5) -- DECOMPILER ERROR at PC19: Confused about usage of register: R5 in 'UnsetPending'
    ;
    ((self.ui).img_QualityColor).color = qualityColor;
    ((self.ui).img_QualityIconInfo):SetIndex(chipData.quality) -- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'
    ;
    ((self.ui).img_QualityIcon).color = qualityColor -- DECOMPILER ERROR at PC30: Confused about usage of register: R5 in 'UnsetPending'
    ;
    ((self.ui).img_QualityLine).color = qualityColor;
    ((self.ui).img_Mark):SetIndex(chipData:GetMarkIconIndex())
    local chipItem = (UINChipItem.New)()
    chipItem:Init((self.ui).obj_chipItem)
    chipItem:InitChipItem(chipData) -- DECOMPILER ERROR at PC50: Confused about usage of register: R6 in 'UnsetPending'
    ;
    ((self.ui).tex_ChipName).text = chipData:GetName() -- DECOMPILER ERROR at PC55: Confused about usage of register: R6 in 'UnsetPending'
    ;
    ((self.ui).tex_ChipIntro).text = chipData:GetChipInfo();
    ((self.ui).tex_ChipLevel):SetIndex(0, tostring(chipData:GetCount()))
    if #chipCfg.skill_list > 0 then
        local skillId = (chipCfg.skill_list)[1]
        local skillCfg =
            (((CS.GameData).instance).listBattleSkillDatas):GetDataById(skillId)
        if skillCfg == nil then
            error("Can\'t find skillCfg, id = " .. tostring(skillId))
        else
            local num = chipData:GetCount() -- DECOMPILER ERROR at PC95: Confused about usage of register: R9 in 'UnsetPending'
            ;
            ((self.ui).tex_Description).text = skillCfg:GetLevelDescribe(num)
        end
    else
        do
            if #chipCfg.attribute_id > 0 then
                local attrId = (chipCfg.attribute_id)[1]
                local initValue = (chipCfg.attribute_initial)[1]
                local fluenceIntro =
                    ConfigData:GetChipinfluenceIntro(chipCfg.id)
                local num = chipData:GetCount()
                local increaseVal = (chipCfg.level_increase)[1]
                local attrInfo = (BattleUtil.GetChipAttrInfo)(attrId, initValue,
                                                              increaseVal, num) -- DECOMPILER ERROR at PC125: Confused about usage of register: R12 in 'UnsetPending'
                ;
                ((self.ui).tex_Description).text = fluenceIntro .. attrInfo
            else
                do
                    -- DECOMPILER ERROR at PC129: Confused about usage of register: R6 in 'UnsetPending'


                    ((self.ui).tex_Description).text = "";
                    (self.tagPool):HideAll()
                    for _, tagId in ipairs(chipCfg.fun_tag) do
                        local tagConfig = (ConfigData.chip_tag)[tagId]
                        if tagConfig == nil then
                            error("Can\'t get chip tag config with ID:" .. tagId)
                        else
                            local tagItem = (self.tagPool):GetOne(true)
                            tagItem:InitTagItem(tagConfig, qualityColor)
                        end
                    end
                    (self.attrPool):HideAll()
                    for index, attrId in ipairs(chipCfg.attribute_id) do
                        local inital = (chipCfg.attribute_initial)[index]
                        local increase = (chipCfg.level_increase)[index] or 0
                        local totalNum = chipData:GetCount() - 1
                        local val = inital + totalNum * increase
                        local attrItem = (self.attrPool):GetOne(true)
                        attrItem:InitAttrItem(attrId, val)
                    end
                end
            end
        end
    end
end

UINDungeonInfoChipDetail.SwitchChip = function(self, bool)
    -- function num : 0_3
    local nextIndex = self.nowChipIndex
    local listCount = #self.chipDataList
    if bool then
        if listCount < nextIndex + 1 then
            nextIndex = 1
        else
            nextIndex = nextIndex + 1
        end
    else
        if nextIndex - 1 <= 0 then
            nextIndex = listCount
        else
            nextIndex = nextIndex - 1
        end
    end
    self:RefreshData(nextIndex)
    return nextIndex
end

UINDungeonInfoChipDetail.OnDelete = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnDelete)(self)
end

return UINDungeonInfoChipDetail


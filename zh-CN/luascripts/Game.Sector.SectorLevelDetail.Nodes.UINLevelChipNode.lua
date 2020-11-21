-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLevelChipNode = class("UINLevelChipNode", UIBaseNode)
local base = UIBaseNode
local UINLevelChipQualityItem = require(
                                    "Game.Sector.SectorLevelDetail.Nodes.UINLevelChipQualityItem")
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINChipDetailPanel")
local ChipData = require("Game.PlayerData.Item.ChipData")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local eDetailType = SectorLevelDetailEnum.eDetailType
UINLevelChipNode.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINChipDetailPanel, UINLevelChipQualityItem
    self.chipDataQualityDic = nil;
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self.chipDetailPanel = (UINChipDetailPanel.New)();
    (self.chipDetailPanel):Init((self.ui).uINChipItemDetail);
    (self.chipDetailPanel):SetChipEffectHeroNodeActive(false)
    self.qualityItemPool = (UIItemPool.New)(UINLevelChipQualityItem,
                                            (self.ui).chipQualityItem);
    ((self.ui).chipQualityItem):SetActive(false)
    self._OnChipClick = BindCallback(self, self.OnChipClick)
end

UINLevelChipNode.InitInfoNode = function(self, LevelDtail)
    -- function num : 0_1 , upvalues : eDetailType, _ENV
    if LevelDtail.detailType == eDetailType.Stage or LevelDtail.detailType ==
        eDetailType.Infinity then
        self:InitChipDataQualityDic(LevelDtail)
    else
        return
    end
    self:Sort()
    self:RefreshQualityItems();
    ((self.ui).img_ChipSelect):SetActive(false);
    (self.chipDetailPanel):Hide()
    if LevelDtail.detailType == eDetailType.Infinity then
        local num = 0
        local bestCompleteLevelData =
            (LevelDtail.levelData).bestCompleteLevelData
        if bestCompleteLevelData ~= nil then
            num = ((bestCompleteLevelData.cfg).resource_itemNums)[1]
        end
        ((self.ui).tex_OriginRes):SetIndex(0, tostring(num));
        ((self.ui).obj_originRes):SetActive(true)
    else
        do

            ((self.ui).obj_originRes):SetActive(false)
        end
    end
end

UINLevelChipNode.InitChipDataQualityDic =
    function(self, LevelDtail)
        -- function num : 0_2 , upvalues : eDetailType, _ENV, ChipData
        local chip_dic = {}
        if LevelDtail.detailType == eDetailType.Stage then
            local stageCfg = LevelDtail.stageCfg
            for k, v in pairs(stageCfg.function_extra) do
                chip_dic[v] = true
            end
            local chip_pool_dic = {}
            for _, epId in pairs(stageCfg.exploration_list) do
                local epCfg = (ConfigData.exploration)[epId]
                if epCfg ~= nil then
                    for _, poolId in pairs(epCfg.chip_pool) do
                        chip_pool_dic[poolId] = true
                        local funcPoolCfg =
                            (ConfigData.ep_function_pool)[poolId]
                        if funcPoolCfg ~= nil then
                            for _, chipId in pairs(funcPoolCfg.function_pool) do
                                chip_dic[chipId] = true
                            end
                        end
                    end
                end
            end
        else
            do
                if LevelDtail.detailType == eDetailType.Infinity then
                    local infinityCfg = (LevelDtail.levelData).cfg
                    for k, v in pairs(infinityCfg.chip) do
                        chip_dic[v] = true
                    end
                end
                do
                    self.chipDataQualityDic = {}
                    local chipData = nil
                    for itemId, _ in pairs(chip_dic) do
                        chipData = (ChipData.New)(R10_PC67)
                        -- DECOMPILER ERROR at PC75: Overwrote pending register: R10 in 'AssignReg'

                        -- DECOMPILER ERROR at PC77: Confused about usage of register: R9 in 'UnsetPending'

                        if (self.chipDataQualityDic)[R10_PC67] == nil then
                            (self.chipDataQualityDic)[R10_PC67] = {} -- DECOMPILER ERROR at PC80: Overwrote pending register: R10 in 'AssignReg'
                            -- DECOMPILER ERROR at PC82: Overwrote pending register: R10 in 'AssignReg'
                            ;
                            (table.insert)(R10_PC67, chipData)
                        else
                            -- DECOMPILER ERROR at PC88: Overwrote pending register: R10 in 'AssignReg'

                            -- DECOMPILER ERROR at PC90: Overwrote pending register: R10 in 'AssignReg'


                            (table.insert)(R10_PC67, chipData)
                        end
                    end
                end
            end
        end
    end

UINLevelChipNode.Sort = function(self)
    -- function num : 0_3 , upvalues : _ENV
    for key, list in pairs(self.chipDataQualityDic) do
        (table.sort)(list, function(chip1, chip2)
            -- function num : 0_3_0
            do return chip1.dataId < chip2.dataId end
            -- DECOMPILER ERROR: 1 unprocessed JMP targets
        end)
    end
end

UINLevelChipNode.RefreshQualityItems = function(self)
    -- function num : 0_4 , upvalues : _ENV
    (self.qualityItemPool):HideAll()
    local keys = (table.keys)(self.chipDataQualityDic);
    (table.sort)(keys, function(a, b)
        -- function num : 0_4_0
        do return b < a end
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end)
    for _, qId in ipairs(keys) do
        local chipDataList = (self.chipDataQualityDic)[qId]
        local qualityItem = (self.qualityItemPool):GetOne()
        qualityItem:InitChipQualityItem(qId, chipDataList, self._OnChipClick)
    end
end

UINLevelChipNode.OnChipClick = function(self, chipData, chipItem)
    -- function num : 0_5
    if self.selectedChipData == chipData then
        ((self.ui).img_ChipSelect):SetActive(false);
        (self.chipDetailPanel):Hide()
        self.selectedChipData = nil
    else
        self.selectedChipData = chipData;
        ((self.ui).img_ChipSelect):SetActive(true) -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'
        ;
        (((self.ui).img_ChipSelect).transform).position =
            (chipItem.transform).position;
        (((self.ui).img_ChipSelect).transform):SetParent(chipItem.transform);
        (self.chipDetailPanel):Show();
        (self.chipDetailPanel):InitChipDetailPanel(nil, chipData, nil,
                                                   self.resloader, nil, true,
                                                   true, false)
    end
end

UINLevelChipNode.OnDelete = function(self)
    -- function num : 0_6 , upvalues : base
    (base.OnDelete)(self)
end

return UINLevelChipNode


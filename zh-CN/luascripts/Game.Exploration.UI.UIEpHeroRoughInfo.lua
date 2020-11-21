-- params : ...
-- function num : 0 , upvalues : _ENV
local base = UIBaseNode
local UIEpHeroRoughInfo = class("UIEpHeroRoughInfo", base)
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local ShowChipMaxCount = 3
UIEpHeroRoughInfo.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINChipItem
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    ((self.ui).propGlobalItem):SetActive(false)
    self.chipItemPool = (UIItemPool.New)(UINChipItem, (self.ui).propGlobalItem)
end

UIEpHeroRoughInfo.InitRoughInfo = function(self, dynHero, resloader)
    -- function num : 0_1 , upvalues : _ENV
    self.dynHero = dynHero
    resloader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(
                                   dynHero:GetResName()), function(texture)
        -- function num : 0_1_0 , upvalues : self, dynHero
        if self.dynHero ~= dynHero then return end -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'
        
        ((self.ui).img_Pic).texture = texture
    end)
    self:RefreshHeroInfo()
end

UIEpHeroRoughInfo.RefreshHeroInfo = function(self)
    -- function num : 0_2 , upvalues : ExplorationEnum
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

    ((self.ui).img_HpFill).fillAmount = (self.dynHero).hpPer /
                                            ExplorationEnum.eHeroHpPercent
end

UIEpHeroRoughInfo.RefreshHeroChip = function(self)
    -- function num : 0_3 , upvalues : _ENV, ShowChipMaxCount
    local ownedChips = (self.dynHero):GetOwnedChips()
    local sortTab = {}
    for k, v in pairs(ownedChips) do (table.insert)(sortTab, k) end
    (table.sort)(sortTab, function(a, b)
        -- function num : 0_3_0
        do return a:GetQuality() < b:GetQuality() end
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end)
    if ShowChipMaxCount >= #sortTab or not ShowChipMaxCount then
        local maxCount = #sortTab
    end
    (self.chipItemPool):HideAll()
    for i = 1, maxCount do
        local chipData = sortTab[i]
        local chipItem = (self.chipItemPool):GetOne()
        chipItem:InitChipItem(chipData, true, nil)
        chipItem:BindDefaultClickEvent()
    end
end

UIEpHeroRoughInfo.OnDelete = function(self)
    -- function num : 0_4 , upvalues : base
    (self.chipItemPool):DeleteAll();
    (base.OnDelete)(self)
end

return UIEpHeroRoughInfo


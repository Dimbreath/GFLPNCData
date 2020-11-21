-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAchivLevelRewardItem = class("UIAchivLevelRewardItem", UIBaseNode)
local base = UIBaseNode
local UICommonItem = require("Game.CommonUI.Item.UICommonItem")
local cs_MessageCommon = CS.MessageCommon
UIAchivLevelRewardItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UICommonItem
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_GetReward, self,
                               self.OnClickGetReward);
    ((self.ui).rewardItem):SetActive(false)
    self.levelRewardItemPool = (UIItemPool.New)(UICommonItem,
                                                (self.ui).rewardItem)
end

UIAchivLevelRewardItem.RefreshLevelRewardItem =
    function(self, level, picked, getRewardEvent)
        -- function num : 0_1 , upvalues : _ENV
        self.level = level
        self.getRewardEvent = getRewardEvent;
        ((self.ui).tex_Level):SetIndex(0, tostring(level))
        if (PlayerDataCenter.playerLevel).level < level then
            (((self.ui).btn_GetReward).gameObject):SetActive(false);
            ((self.ui).notFinish):SetActive(true);
            ((self.ui).tex_Complete):SetIndex(0)
        else
            if picked then
                (((self.ui).btn_GetReward).gameObject):SetActive(false);
                ((self.ui).notFinish):SetActive(true);
                ((self.ui).tex_Complete):SetIndex(1)
            else

                (((self.ui).btn_GetReward).gameObject):SetActive(true);
                ((self.ui).notFinish):SetActive(false)
            end
        end
        (self.levelRewardItemPool):HideAll()
        local cfg = (ConfigData.achievement_level)[level]
        if cfg == nil then
            error("can\'t find achievement_level by level, level = " ..
                      tostring(level))
            return
        end
        self.rewardIds = cfg.rewardIds
        for k, id in ipairs(cfg.rewardIds) do
            local num = (cfg.rewardNums)[k]
            local itemCfg = (ConfigData.item)[id]
            local rewardItem = (self.levelRewardItemPool):GetOne()
            rewardItem:InitItem(itemCfg, num)
            rewardItem:ParentWindowType(UIWindowTypeID.Achievement)
        end
    end

UIAchivLevelRewardItem.OnClickGetReward =
    function(self)
        -- function num : 0_2 , upvalues : _ENV, cs_MessageCommon
        local containAth = false
        for k, rewardId in ipairs(self.rewardIds) do
            local itemCfg = (ConfigData.item)[rewardId]
            if itemCfg ~= nil and itemCfg.type == eItemType.Arithmetic then
                containAth = true
                break
            end
        end
        do
            if containAth and (ConfigData.game_config).athMaxNum <=
                #(PlayerDataCenter.allAthData):GetAllAthList() then
                (cs_MessageCommon.ShowMessageTips)(
                    ConfigData:GetTipContent(TipContent.Ath_MaxCount))
                return
            end
            if self.getRewardEvent ~= nil then
                (self.getRewardEvent)(self.level)
            end
        end
    end

UIAchivLevelRewardItem.OnDelete = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnDelete)(self)
end

return UIAchivLevelRewardItem


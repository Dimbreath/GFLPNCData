-- params : ...
-- function num : 0 , upvalues : _ENV
local UICommonReward = class("UICommonReward", UIBaseWindow)
local base = UIBaseWindow
local UICommonItem = require("Game.CommonUI.Item.UINBaseItemWithCount")
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
UICommonReward.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, cs_ResLoader
    ((self.ui).itemUnit):SetActive(false);
    (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.__OnClickClose)
    self.RewardItemDic = {}
    self.resloader = (cs_ResLoader.Create)()
end

UICommonReward.InitRewardsItem = function(self, rewardIds, rewardNums)
    -- function num : 0_1 , upvalues : _ENV, UICommonItem, cs_MessageCommon
    if rewardIds == nil or rewardNums == nil or #rewardIds ~= #rewardNums then
        error("argument error")
        return
    end
    local heroIdList = {}
    for i = 1, #rewardIds do
        local rewardId = rewardIds[i]
        local rewardNum = rewardNums[i]
        local go = ((self.ui).itemUnit):Instantiate()
        local rewardItem = (UICommonItem.New)()
        local itemCfg = (ConfigData.item)[rewardId]
        rewardItem:Init(go)
        rewardItem:InitItemWithCount(itemCfg, rewardNum)
        rewardItem:Show() -- DECOMPILER ERROR at PC38: Confused about usage of register: R13 in 'UnsetPending'
        ;
        (self.RewardItemDic)[rewardId] = rewardItem
        if itemCfg.action_type == eItemActionType.HeroCard then
            if itemCfg.arg == nil or (itemCfg.arg)[1] == nil then
                error("hero card item cfg error id=" .. rewardId)
            else

                (table.insert)(heroIdList, (itemCfg.arg)[1])
            end
        end
        if itemCfg.type == eItemType.Arithmetic and
            (ConfigData.game_config).athMaxNum <=
            #(PlayerDataCenter.allAthData):GetAllAthList() then
            (cs_MessageCommon.ShowMessageTips)(
                ConfigData:GetTipContent(TipContent.Ath_MaxCount))
        end
    end
    AudioManager:PlayAudioById(1029)
    if #heroIdList > 0 then
        UIManager:ShowWindowAsync(UIWindowTypeID.GetHero, function(window)
            -- function num : 0_1_0 , upvalues : _ENV, heroIdList
            if window == nil then return end
            local heroDataList = {}
            for index, heroId in ipairs(heroIdList) do
                local heroData = (PlayerDataCenter.heroDic)[heroId];
                (table.insert)(heroDataList, heroData)
            end
            window:InitGetHeroList(heroDataList)
        end)
    end
end

UICommonReward.__OnClickClose = function(self)
    -- function num : 0_2
    self:Delete()
end

return UICommonReward


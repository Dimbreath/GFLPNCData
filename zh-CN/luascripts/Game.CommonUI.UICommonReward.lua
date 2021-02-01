-- params : ...
-- function num : 0 , upvalues : _ENV
local UICommonReward = class("UICommonReward", UIBaseWindow)
local base = UIBaseWindow
local UICommonItem = require("Game.CommonUI.Item.UINBaseItemWithCount")
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
UICommonReward.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, cs_ResLoader
  ((self.ui).itemUnit):SetActive(false)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.__OnClickClose)
  self.RewardItemDic = {}
  self.resloader = (cs_ResLoader.Create)()
end

UICommonReward.InitRewardsItem = function(self, rewardIds, rewardNums, heroIdSnapshoot)
  -- function num : 0_1 , upvalues : _ENV, UICommonItem, cs_MessageCommon
  if heroIdSnapshoot == nil then
    heroIdSnapshoot = table.emptytable
  end
  if rewardIds == nil or rewardNums == nil or #rewardIds ~= #rewardNums then
    error("argument error")
    return 
  end
  ;
  (((self.ui).tex_Tips).gameObject):SetActive(false)
  local heroIdList = {}
  local newHeroIndexDic = {}
  for i = 1, #rewardIds do
    local rewardId = rewardIds[i]
    local rewardNum = rewardNums[i]
    local go = ((self.ui).itemUnit):Instantiate()
    local rewardItem = (UICommonItem.New)()
    local itemCfg = (ConfigData.item)[rewardId]
    rewardItem:Init(go)
    rewardItem:InitItemWithCount(itemCfg, rewardNum)
    rewardItem:SetNotNeedAnyJump(true)
    rewardItem:Show()
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (self.RewardItemDic)[rewardId] = rewardItem
    if itemCfg.action_type == eItemActionType.HeroCard then
      if itemCfg.arg == nil or (itemCfg.arg)[1] == nil then
        error("hero card item cfg error id=" .. rewardId)
      else
        ;
        (table.insert)(heroIdList, (itemCfg.arg)[1])
        if not heroIdSnapshoot[(itemCfg.arg)[1]] then
          newHeroIndexDic[#heroIdList] = true
        end
      end
    end
    if itemCfg.type == eItemType.Arithmetic and (ConfigData.game_config).athMaxNum <= #(PlayerDataCenter.allAthData):GetAllAthList() then
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
    end
  end
  if #heroIdList > 0 then
    self:Hide()
    UIManager:ShowWindowAsync(UIWindowTypeID.GetHero, function(window)
    -- function num : 0_1_0 , upvalues : heroIdList, newHeroIndexDic, self
    if window == nil then
      return 
    end
    window:InitGetHeroList(heroIdList, false, true, newHeroIndexDic)
    self:Show()
    self:_ExecuteStartFunc()
  end
)
  else
    AudioManager:PlayAudioById(1029)
    self:_ExecuteStartFunc()
  end
end

UICommonReward.InitRewardTitle = function(self, msg)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).txt_RewardTitle).text = msg
end

UICommonReward.InitRewardTips = function(self, rewardTips)
  -- function num : 0_3 , upvalues : _ENV
  if (string.IsNullOrEmpty)(rewardTips) then
    return 
  end
  ;
  (((self.ui).tex_Tips).gameObject):SetActive(true)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Tips).text = rewardTips
end

UICommonReward.BindCommonRewardStart = function(self, startFunc)
  -- function num : 0_4
  self.__startFunc = startFunc
end

UICommonReward._ExecuteStartFunc = function(self)
  -- function num : 0_5
  if self.__startFunc ~= nil then
    (self.__startFunc)()
  end
end

UICommonReward.BindCommonRewardExit = function(self, exitAction)
  -- function num : 0_6
  self.__exitAction = exitAction
end

UICommonReward.__OnClickClose = function(self)
  -- function num : 0_7
  self:Delete()
  if self.__exitAction ~= nil then
    (self.__exitAction)()
  end
end

UICommonReward.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnDelete)(self)
end

return UICommonReward


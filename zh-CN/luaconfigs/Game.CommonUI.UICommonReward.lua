-- params : ...
-- function num : 0 , upvalues : _ENV
local UICommonReward = class("UICommonReward", UIBaseWindow)
local base = UIBaseWindow
local UICommonItem = require("Game.CommonUI.Item.UICommonRewardItem")
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local cs_DoTween = ((CS.DG).Tweening).DOTween
local cs_Ease = ((CS.DG).Tweening).Ease
UICommonReward.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, cs_ResLoader
  ((self.ui).itemUnit):SetActive(false)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.__OnClickClose)
  self.RewardItemDic = {}
  self.resloader = (cs_ResLoader.Create)()
  ;
  (((self.ui).dotween_rewardContent).gameObject):SetActive(false)
  self.__isShowing = false
  self.commonRewardQueue = {}
end

UICommonReward.AddNext2ShowReward = function(self, rewardIds, rewardNums, heroIdSnapshoot, isSkip, title, exitAction, startFunc)
  -- function num : 0_1 , upvalues : _ENV
  if self.__isShowing then
    local data = {rewardIds = rewardIds, rewardNums = rewardNums, heroIdSnapshoot = heroIdSnapshoot, isSkip = isSkip, title = title, exitAction = exitAction, startFunc = startFunc}
    ;
    (table.insert)(self.commonRewardQueue, data)
  else
    do
      self:InitRewardsItem(rewardIds, rewardNums, heroIdSnapshoot, isSkip)
      self:BindCommonRewardExit(exitAction)
      self:BindCommonRewardStart(startFunc)
    end
  end
end

UICommonReward.InitRewardsItem = function(self, rewardIds, rewardNums, heroIdSnapshoot, isSkip)
  -- function num : 0_2 , upvalues : _ENV, cs_MessageCommon, UICommonItem
  self.__isShowing = true
  self.__startingTweenPlayed = false
  for k,v in pairs(self.RewardItemDic) do
    v:Delete()
  end
  self.RewardItemDic = {}
  if heroIdSnapshoot == nil then
    heroIdSnapshoot = table.emptytable
  end
  if rewardIds == nil or rewardNums == nil or #rewardIds ~= #rewardNums then
    error("argument error")
    return 
  end
  self.rewardItemList = {}
  ;
  (((self.ui).tex_Tips).gameObject):SetActive(false)
  local heroIdList = {}
  local newHeroIndexDic = {}
  for i = 1, #rewardIds do
    local rewardId = rewardIds[i]
    local rewardNum = rewardNums[i]
    local itemCfg = (ConfigData.item)[rewardId]
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
    local go = ((self.ui).itemUnit):Instantiate()
    local rewardItem = (UICommonItem.New)()
    rewardItem:Init(go)
    rewardItem:InitCommonRewardItem(itemCfg, rewardNum, heroIdSnapshoot)
    rewardItem:Hide()
    -- DECOMPILER ERROR at PC117: Confused about usage of register: R16 in 'UnsetPending'

    ;
    (self.RewardItemDic)[rewardId] = rewardItem
    ;
    (table.insert)(self.rewardItemList, rewardItem)
  end
  if #heroIdList > 0 then
    self:Hide()
    UIManager:ShowWindowAsync(UIWindowTypeID.GetHero, function(window)
    -- function num : 0_2_0 , upvalues : heroIdList, newHeroIndexDic, self, _ENV, isSkip
    if window == nil then
      return 
    end
    window:InitGetHeroList(heroIdList, false, true, newHeroIndexDic, function()
      -- function num : 0_2_0_0 , upvalues : self, _ENV
      self:Show()
      self:_ExecuteStartFunc()
      AudioManager:PlayAudioById(1115)
      UIManager:DeleteWindow(UIWindowTypeID.GetHero)
    end
, isSkip)
  end
)
  else
    AudioManager:PlayAudioById(1029)
    self:_ExecuteStartFunc()
  end
end

UICommonReward.InitRewardTitle = function(self, msg)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).txt_RewardTitle).text = msg
end

UICommonReward.InitRewardTips = function(self, rewardTips)
  -- function num : 0_4 , upvalues : _ENV
  if (string.IsNullOrEmpty)(rewardTips) then
    return 
  end
  ;
  (((self.ui).tex_Tips).gameObject):SetActive(true)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Tips).text = rewardTips
end

UICommonReward.ShowGetRewardFx = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (((self.ui).dotween_rewardContent).gameObject):SetActive(false)
  ;
  (((self.ui).dotween_rewardContent).onComplete):AddListener(function()
    -- function num : 0_5_0 , upvalues : _ENV, self
    for rewardId,rewardItem in pairs(self.RewardItemDic) do
      rewardItem:Show()
      ;
      (rewardItem.baseItem):LoadGetRewardFx(self.resloader, nil, nil)
    end
    self:_RewardItemTween()
  end
)
  ;
  (((self.ui).dotween_rewardContent).gameObject):SetActive(true)
end

UICommonReward.BindCommonRewardStart = function(self, startFunc)
  -- function num : 0_6
  self.__startFunc = startFunc
end

UICommonReward._ExecuteStartFunc = function(self)
  -- function num : 0_7
  if self.__startingTweenPlayed then
    return 
  end
  self.__startingTweenPlayed = true
  if self.__startFunc ~= nil then
    (self.__startFunc)()
  end
  self:ShowGetRewardFx()
end

UICommonReward.BindCommonRewardExit = function(self, exitAction)
  -- function num : 0_8
  self.__exitAction = exitAction
end

UICommonReward.__OnClickClose = function(self)
  -- function num : 0_9 , upvalues : _ENV
  self.__startingTweenPlayed = false
  if self.__exitAction ~= nil then
    (self.__exitAction)()
  end
  if #self.commonRewardQueue > 0 then
    local data = (table.remove)(self.commonRewardQueue, 1)
    self:InitRewardsItem(data.rewardIds, data.rewardNums, data.heroIdSnapshoot, data.isSkip)
    self:BindCommonRewardExit(data.exitAction)
    self:BindCommonRewardStart(data.startFunc)
  else
    do
      self:Delete()
      self.__isShowing = false
    end
  end
end

UICommonReward._RewardItemTween = function(self)
  -- function num : 0_10 , upvalues : cs_DoTween, _ENV, cs_Ease
  if self.tweenSeq ~= nil then
    (self.tweenSeq):Kill(true)
    self.tweenSeq = nil
  end
  local tweenSeq = (cs_DoTween.Sequence)()
  for index,rewardItem in ipairs(self.rewardItemList) do
    tweenSeq:Append((((rewardItem.transform):DOScale(Vector3.zero, 0.2)):From()):SetEase(cs_Ease.OutBack))
  end
  self.tweenSeq = tweenSeq
end

UICommonReward.OnDelete = function(self)
  -- function num : 0_11 , upvalues : _ENV, base
  if self.tweenSeq ~= nil then
    (self.tweenSeq):Kill()
    self.tweenSeq = nil
  end
  for k,v in pairs(self.RewardItemDic) do
    v:Delete()
  end
  self.RewardItemDic = nil
  self.rewardItemList = nil
  ;
  ((self.ui).dotween_rewardContent):DOKill()
  ;
  (base.OnDelete)(self)
end

return UICommonReward


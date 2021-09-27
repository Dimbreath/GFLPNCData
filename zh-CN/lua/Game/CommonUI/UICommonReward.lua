local UICommonReward = class("UICommonReward", UIBaseWindow)
local base = UIBaseWindow
local UICommonItem = require("Game.CommonUI.Item.UICommonRewardItem")
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local cs_DoTween = ((CS.DG).Tweening).DOTween
local cs_Ease = ((CS.DG).Tweening).Ease
UICommonReward.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, cs_ResLoader, UICommonItem
  ((self.ui).itemUnit):SetActive(false)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.__OnClickClose)
  self.RewardItemDic = {}
  self.resloader = (cs_ResLoader.Create)()
  ;
  (((self.ui).dotween_rewardContent).gameObject):SetActive(false)
  self.__isShowing = false
  self.commonRewardQueue = {}
  self.__rewardTips = nil
  ;
  (((self.ui).tex_Tips).gameObject):SetActive(false)
  self._itemWidthUtil = ((((self.ui).itemUnit).transform).rect).width
  self._listRectHeightUtil = (((self.ui).tran_list).rect).height
  self._listTotalLength = (((self.ui).tran_scroll).rect).width
  self.itemPool = (UIItemPool.New)(UICommonItem, (self.ui).itemUnit)
end

UICommonReward.AddNext2ShowReward = function(self, rewardIds, rewardNums, heroIdSnapshoot, isSkip, title, exitAction, startFunc, isSplit, rewardTips)
  -- function num : 0_1 , upvalues : _ENV
  if self.__isShowing then
    local data = {rewardIds = rewardIds, rewardNums = rewardNums, heroIdSnapshoot = heroIdSnapshoot, isSkip = isSkip, title = title, exitAction = exitAction, startFunc = startFunc, isSplit = isSplit, rewardTips = rewardTips}
    if isSplit then
      (table.insert)(self.commonRewardQueue, 1, data)
    else
      ;
      (table.insert)(self.commonRewardQueue, data)
    end
  else
    do
      self:BindCommonRewardExit(exitAction)
      self:BindCommonRewardStart(startFunc)
      self:InitRewardsItem(rewardIds, rewardNums, heroIdSnapshoot, isSkip)
    end
  end
end

UICommonReward.InitRewardsItem = function(self, in_rewardIds, in_rewardNums, heroIdSnapshoot, isSkip, isNotHandledGreat)
  -- function num : 0_2 , upvalues : _ENV, cs_MessageCommon
  self.__isShowing = true
  local rewardIds = {}
  local rewardNums = {}
  for index,value in ipairs(in_rewardIds) do
    rewardIds[index] = value
    rewardNums[index] = in_rewardNums[index]
  end
  if not isNotHandledGreat then
    local isHaveGreatRewards = false
    local greatItems, greatNums = nil, nil
    for index = #rewardIds, 1, -1 do
      local itemId = rewardIds[index]
      if ((ConfigData.game_config).itemWithGreatFxDic)[itemId] then
        if not isHaveGreatRewards then
          isHaveGreatRewards = true
          greatItems = {}
          greatNums = {}
        end
        ;
        (table.insert)(greatItems, 1, itemId)
        ;
        (table.insert)(greatNums, 1, rewardNums[index])
        ;
        (table.remove)(rewardIds, index)
        ;
        (table.remove)(rewardNums, index)
      end
    end
    if isHaveGreatRewards then
      if #rewardIds == 0 then
        rewardIds = greatItems
        rewardNums = greatNums
      else
        self:AddNext2ShowReward(rewardIds, rewardNums, heroIdSnapshoot, isSkip, ((self.ui).txt_RewardTitle).text, self.__exitAction, self.__startFunc, true, self.__rewardTips)
        rewardIds = greatItems
        rewardNums = greatNums
      end
    end
  end
  do
    self.__startingTweenPlayed = false
    ;
    (self.itemPool):HideAll()
    if heroIdSnapshoot == nil then
      heroIdSnapshoot = table.emptytable
    end
    if rewardIds == nil or rewardNums == nil or #rewardIds ~= #rewardNums then
      error("argument error")
      return 
    end
    local heroIdList = {}
    local newHeroIndexDic = {}
    self.RewardItemDic = {}
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
      local rewardItem = (self.itemPool):GetOne()
      rewardItem:InitCommonRewardItem(itemCfg, rewardNum, heroIdSnapshoot)
      rewardItem:Hide()
      -- DECOMPILER ERROR at PC177: Confused about usage of register: R18 in 'UnsetPending'

      ;
      (self.RewardItemDic)[i] = rewardItem
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
  self.__rewardTips = rewardTips
end

UICommonReward.ShowGetRewardFx = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (((self.ui).dotween_rewardContent).gameObject):SetActive(false)
  if not self.__isAdded then
    self.__isAdded = true
    ;
    (((self.ui).dotween_rewardContent).onComplete):AddListener(function()
    -- function num : 0_5_0 , upvalues : _ENV, self
    for _,rewardItem in pairs(self.RewardItemDic) do
      rewardItem:Show()
      if ((ConfigData.game_config).itemWithGreatFxDic)[(rewardItem.itemCfg).id] then
        (rewardItem.baseItem):LoadGetGreatRewardFx(self.resloader, 5)
      else
        ;
        (rewardItem.baseItem):LoadGetRewardFx(self.resloader, 5)
      end
    end
    self:_RewardItemTween()
  end
)
  end
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
  if self.tweenSeq ~= nil then
    (self.tweenSeq):Kill()
    self.tweenSeq = nil
  end
  ;
  (((self.ui).dotween_rewardContent).gameObject):SetActive(false)
  if #self.commonRewardQueue > 0 then
    local data = (table.remove)(self.commonRewardQueue, 1)
    self:InitRewardsItem(data.rewardIds, data.rewardNums, data.heroIdSnapshoot, data.isSkip, true)
    self:BindCommonRewardExit(data.exitAction)
    self:BindCommonRewardStart(data.startFunc)
    self.__rewardTips = nil
    ;
    (((self.ui).tex_Tips).gameObject):SetActive(false)
    if data.title ~= nil then
      self:InitRewardTitle(data.title)
    end
    if data.rewardTips ~= nil then
      self:InitRewardTips(data.rewardTips)
    end
    if data.isSplit and self.__exitAction ~= nil then
      (self.__exitAction)()
    end
  else
    do
      self:Delete()
      self.__isShowing = false
      if self.__exitAction ~= nil then
        (self.__exitAction)()
      end
    end
  end
end

UICommonReward._RewardItemTween = function(self)
  -- function num : 0_10 , upvalues : cs_DoTween, _ENV, cs_Ease
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).scroll).enabled = false
  if self.tweenSeq ~= nil then
    (self.tweenSeq):Kill(true)
    self.tweenSeq = nil
  end
  local isOverlength, showCount, anchoredOffset, offset, pageCount = self:CalculateScorllRect()
  local tweenSeq = (cs_DoTween.Sequence)()
  local count = 1
  for index,rewardItem in ipairs((self.itemPool).listItem) do
    tweenSeq:Append((((rewardItem.transform):DOScale(Vector3.zero, 0.2)):From()):SetEase(cs_Ease.OutBack))
    if isOverlength and showCount <= count then
      count = 1
      pageCount = pageCount - 1
      if pageCount ~= 1 or not self._listTotalLength - offset then
        do
          do
            local sub = self._listTotalLength
            do
              tweenSeq:AppendCallback(function()
    -- function num : 0_10_0 , upvalues : self, sub, _ENV
    local move = (((self.ui).tran_list).localPosition).x - sub
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).tran_list).localPosition = (Vector3.New)(move, 0, 0)
  end
)
            end
            count = count + 1
            -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  tweenSeq:OnComplete(function()
    -- function num : 0_10_1 , upvalues : self, _ENV, anchoredOffset
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

    ((self.ui).tran_list).anchoredPosition = (Vector2.New)(-anchoredOffset, 0)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((self.ui).scroll).enabled = true
  end
)
  self.tweenSeq = tweenSeq
end

UICommonReward.CalculateScorllRect = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local showCount = 0
  local isOverlength = false
  local itemCount = #(self.itemPool).listItem
  local targetLength = itemCount * self._itemWidthUtil + itemCount * 20 + 40
  local anchoredOffset = 0
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tran_list).sizeDelta = (Vector2.New)(targetLength, self._listRectHeightUtil)
  isOverlength = self._listTotalLength < targetLength
  if isOverlength then
    anchoredOffset = (targetLength - self._listTotalLength) / 2
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tran_list).anchoredPosition = (Vector2.New)(anchoredOffset, 0)
    showCount = (math.ceil)((self._listTotalLength - 40) / (self._itemWidthUtil + 20))
  else
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R6 in 'UnsetPending'

    ((self.ui).tran_list).anchoredPosition = Vector3.zero
  end
  local pageCount = (math.ceil)(targetLength / self._listTotalLength)
  local offset = pageCount * self._listTotalLength - targetLength
  do return isOverlength, showCount, anchoredOffset, offset, pageCount end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UICommonReward.OnDelete = function(self)
  -- function num : 0_12 , upvalues : _ENV, base
  if self.tweenSeq ~= nil then
    (self.tweenSeq):Kill()
    self.tweenSeq = nil
  end
  ;
  (self.itemPool):DeleteAll()
  self.RewardItemDic = nil
  ;
  ((self.ui).dotween_rewardContent):DOKill()
  MsgCenter:Broadcast(eMsgEventId.RewardExit)
  ;
  (base.OnDelete)(self)
end

return UICommonReward


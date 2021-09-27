local UINLtrPtNode = class("UINLtrPtNode", UIBaseNode)
local base = UIBaseNode
local UINLtrPtRrewardItem = require("Game.Lottery.UI.PtNode.UINLtrPtRrewardItem")
local CheckerTypeId, CheckerGlobalConfig = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local cs_DoTween = ((CS.DG).Tweening).DOTween
local cs_Ease = ((CS.DG).Tweening).Ease
UINLtrPtNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINLtrPtRrewardItem, UINHeroHeadItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self._OnClickClose)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self._OnClickConfirm)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Cancel, self, self._OnClickCancel)
  ;
  ((self.ui).exchangeItem):SetActive(false)
  self.ptRewardItemPool = (UIItemPool.New)(UINLtrPtRrewardItem, (self.ui).exchangeItem)
  self._ExchangePtRewardFunc = BindCallback(self, self._ExchangePtReward)
  self.heroItem = UINHeroHeadItem:New()
  ;
  (self.heroItem):Init((self.ui).obj_heroHeadItem)
  ;
  (((self.ui).img_Star).gameObject):SetActive(false)
  self.starList = {}
  self:_InitSwithTween()
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Tips).text = ConfigData:GetTipContent(306)
  -- DECOMPILER ERROR at PC75: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_End).text = ConfigData:GetTipContent(307)
  -- DECOMPILER ERROR at PC82: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Title).text = ConfigData:GetTipContent(305)
end

UINLtrPtNode.InitLtrPtNode = function(self, ltrPoolData, resLoader, ltrCtrl)
  -- function num : 0_1 , upvalues : _ENV
  self.ltrCtrl = ltrCtrl
  self.ltrPoolData = ltrPoolData
  self.resLoader = resLoader
  ;
  (self.showSeq):Rewind()
  AudioManager:PlayAudioById(1066)
  ;
  (UIUtil.SetTopStatus)(self, self.Hide, {}, nil, nil, true)
  local ltrCfg = ltrPoolData:GetLtrPoolDataCfg()
  local startTime, endTime = (self.ltrPoolData):GetStartAndEndTime()
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R7 in 'UnsetPending'

  if endTime ~= -1 then
    ((self.ui).tex_Time).text = tostring((os.date)("%m/%d %H:%M", endTime))
  end
  self:ReFreshLtrPtUI()
end

UINLtrPtNode.ReFreshLtrPtUI = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local ltrCfg = (self.ltrPoolData):GetLtrPoolDataCfg()
  local ptNum = (self.ltrPoolData):GetLtrPtNum()
  ;
  (self.ptRewardItemPool):HideAll()
  for k,itemId in ipairs(ltrCfg.pt_rewardItemIdList) do
    local costNum = (ltrCfg.pt_rewardCostNumList)[k]
    local rewardItem = ((self.ptRewardItemPool):GetOne())
    local firstAwardId, firstAwardNum = nil, nil
    if not (self.ltrPoolData).pickBig and ltrCfg.pt_mark == itemId then
      for id,num in pairs(ltrCfg.pt_first_reward) do
        firstAwardId = id
        firstAwardNum = num
        do break end
      end
    end
    do
      do
        rewardItem:InitLtrPtRrewardItem(itemId, costNum, self.resLoader, self._ExchangePtRewardFunc, ptNum, firstAwardId, firstAwardNum)
        -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Count).text = tostring(ptNum)
end

UINLtrPtNode._ExchangePtReward = function(self, itemId, costNum, heroCfg, firstAwardId, firstAwardNum)
  -- function num : 0_3 , upvalues : _ENV, UINBaseItemWithCount
  self._exchangItemId = itemId
  if firstAwardId ~= nil then
    self._extraAward = {[firstAwardId] = firstAwardNum}
  else
    self._extraAward = nil
  end
  ;
  (self.showSeq):Rewind()
  ;
  (self.showSeq):Restart()
  local heroName = (LanguageUtil.GetLocaleText)(heroCfg.name)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = heroName
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_Info).text = (string.format)(ConfigData:GetTipContent(308), costNum, heroName)
  local ptNum = (self.ltrPoolData):GetLtrPtNum()
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).tex_PtFrom).text = tostring(ptNum)
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).tex_PtTo).text = tostring(ptNum - costNum)
  ;
  (self.heroItem):InitHeroHeadItemWithId(heroCfg.id)
  local rankCfg = (ConfigData.hero_rank)[heroCfg.rank]
  if rankCfg == nil then
    error("Can\'t find rankCfg, id = " .. tostring(heroCfg.rank))
  end
  self:__RefreshStar(rankCfg.star)
  if firstAwardId == nil then
    ((self.ui).confirmItemObj):SetActive(false)
    ;
    (((self.ui).tex_EXInfo).gameObject):SetActive(false)
    return 
  end
  ;
  ((self.ui).confirmItemObj):SetActive(true)
  if self.confirmIte == nil then
    self.confirmIte = (UINBaseItemWithCount.New)()
    ;
    (self.confirmIte):Init((self.ui).confirmItem)
  end
  local firstAwardCfg = (ConfigData.item)[firstAwardId]
  ;
  (self.confirmIte):InitItemWithCount(firstAwardCfg, firstAwardNum)
  local awardName = (LanguageUtil.GetLocaleText)(firstAwardCfg.name)
  -- DECOMPILER ERROR at PC112: Confused about usage of register: R11 in 'UnsetPending'

  ;
  ((self.ui).tex_confirm_ItemName).text = awardName
  ;
  (((self.ui).tex_EXInfo).gameObject):SetActive(true)
  -- DECOMPILER ERROR at PC129: Confused about usage of register: R11 in 'UnsetPending'

  ;
  ((self.ui).tex_EXInfo).text = (string.format)(ConfigData:GetTipContent(309), awardName)
end

UINLtrPtNode.__RefreshStar = function(self, heroStar)
  -- function num : 0_4
  local half = heroStar % 2
  local rankImgIndex = (heroStar - half) / 2 - 1
  if rankImgIndex >= 0 then
    (((self.ui).img_Star).gameObject):SetActive(true)
    ;
    ((self.ui).img_Star):SetIndex(rankImgIndex)
    local vec = ((((self.ui).img_Star).image).rectTransform).sizeDelta
    vec.x = (((((self.ui).img_Star).image).sprite).rect).width
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((((self.ui).img_Star).image).rectTransform).sizeDelta = vec
  else
    do
      ;
      (((self.ui).img_Star).gameObject):SetActive(false)
      ;
      (((self.ui).img_Half).gameObject):SetActive(half == 1)
      -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end
  end
end

UINLtrPtNode._OnClickConfirm = function(self)
  -- function num : 0_5
  (self.ltrCtrl):ReqExchangeLtrPtReward(self._exchangItemId, self._extraAward)
  ;
  (self.showSeq):PlayBackwards()
  self:_OnClickClose()
end

UINLtrPtNode._OnClickCancel = function(self)
  -- function num : 0_6
  (self.showSeq):PlayBackwards()
end

UINLtrPtNode.BindCloseFun = function(self, closeFun)
  -- function num : 0_7
  self.__closeFun = closeFun
end

UINLtrPtNode._OnClickClose = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (UIUtil.OnClickBack)()
  if self.__closeFun ~= nil then
    (self.__closeFun)()
  end
end

UINLtrPtNode._InitSwithTween = function(self)
  -- function num : 0_9 , upvalues : cs_DoTween, cs_Ease
  self:_KillTween()
  local sequence = (cs_DoTween.Sequence)()
  ;
  (((self.ui).tran_List).gameObject):SetActive(true)
  ;
  (((self.ui).tran_Confirm).gameObject):SetActive(true)
  sequence:Insert(0, (((self.ui).tran_List):DOAnchorPosX((((self.ui).tran_List).anchoredPosition).x - 1156, 0.45)):SetRelative(true))
  sequence:Insert(0, ((self.ui).fade_List):DOFade(0, 0.35))
  sequence:Insert(0, (((self.ui).tran_Confirm):DOAnchorPosX((((self.ui).tran_Confirm).anchoredPosition).x + 1156, 0.45)):From(true))
  sequence:Insert(0, (((self.ui).fade_Confirm):DOFade(0, 0.35)):From())
  sequence:SetEase(cs_Ease.InQuad)
  sequence:SetAutoKill(false)
  sequence:Pause()
  self.showSeq = sequence
end

UINLtrPtNode._KillTween = function(self)
  -- function num : 0_10
  if self.showSeq ~= nil then
    (self.showSeq):Kill(true)
    self.showSeq = nil
  end
end

UINLtrPtNode.OnDelete = function(self)
  -- function num : 0_11 , upvalues : base
  self:_KillTween()
  ;
  (self.ptRewardItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINLtrPtNode


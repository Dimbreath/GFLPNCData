-- params : ...
-- function num : 0 , upvalues : _ENV
local UILottery = class("UILottery", UIBaseWindow)
local base = UIBaseWindow
local LotteryEnum = require("Game.Lottery.LotteryEnum")
local UINLtrPoolItem = require("Game.Lottery.UI.UINLtrPoolItem")
local UINLtrHeroItem = require("Game.Lottery.UI.UINLtrHeroItem")
local UINLtrPoolDetail = require("Game.Lottery.UI.PoolDetail.UINLtrPoolDetail")
local CheckerTypeId, CheckerGlobalConfig = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local UINLtrPtNode = require("Game.Lottery.UI.PtNode.UINLtrPtNode")
local cs_ResLoader = CS.ResLoader
local cs_MovieManager_ins = (CS.MovieManager).Instance
local cs_EventTriggerListener = CS.EventTriggerListener
local cs_LayoutRebuilder = ((CS.UnityEngine).UI).LayoutRebuilder
UILottery.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, cs_EventTriggerListener, cs_ResLoader, UINLtrPoolItem, UINLtrHeroItem, UINLtrPoolDetail, UINLtrPtNode
  self.__onSelectLtrPoolItem = BindCallback(self, self.SelectLtrPoolItem)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Once, self, self.__OnClickDrawOne)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Ten, self, self.__OnClickDrawTen)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SpecialOne, self, self.__OnClickDrawSpecialOne)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_PtExchange, self, self.__OnClickPtExchange)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_PoolDetail, self, self.__OnClickPoolDetail)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_bg, self, self.__OnClickBg)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_LeftArrow, self, self.__OnClickLeftArrow)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_RightArrow, self, self.__OnClickRightArrow)
  local eventTrigger = (cs_EventTriggerListener.Get)(((self.ui).infoScroll).gameObject)
  eventTrigger:onEndDrag("+", BindCallback(self, self.__OnEndDrag))
  ;
  (UIUtil.SetTopStatus)(self, self.__OnClickClose, {}, nil, nil)
  self.resLoader = (cs_ResLoader.Create)()
  ;
  ((self.ui).infoItem):SetActive(false)
  self.ltrPoolItemPool = (UIItemPool.New)(UINLtrPoolItem, (self.ui).infoItem)
  self.poolItemWidth = ((((self.ui).infoItem).transform).sizeDelta).x + ((self.ui).scrollLayoutGroup).spacing
  self.heroL = (UINLtrHeroItem.New)()
  ;
  (self.heroL):Init((self.ui).subHeroItem)
  self.heroR = (UINLtrHeroItem.New)()
  ;
  (self.heroR):Init((self.ui).mainHeroItem)
  self.poolDetailNode = (UINLtrPoolDetail.New)()
  ;
  (self.poolDetailNode):Init((self.ui).showGachaRateNode)
  ;
  (self.poolDetailNode):Hide()
  self.ltrPtNode = (UINLtrPtNode.New)()
  ;
  (self.ltrPtNode):Init((self.ui).exchangeNode)
  ;
  (self.ltrPtNode):Hide()
end

UILottery.InitUILottery = function(self, ltrCtrl, poolDataList, poolIndex)
  -- function num : 0_1 , upvalues : _ENV, cs_LayoutRebuilder
  self.ltrCtrl = ltrCtrl
  self:_SetPoolDataList(poolDataList)
  self.poolItemDic = {}
  ;
  (self.ltrPoolItemPool):HideAll()
  for k,poolData in ipairs(self.poolDataList) do
    local poolItem = (self.ltrPoolItemPool):GetOne()
    poolItem:InitLtrPoolItem(k, poolData, self.resLoader, self.__onSelectLtrPoolItem)
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.poolItemDic)[poolData.poolId] = poolItem
  end
  ;
  ((self.ui).img_Select):SetAsLastSibling()
  ;
  (cs_LayoutRebuilder.ForceRebuildLayoutImmediate)(((self.ui).scrollLayoutGroup).transform)
  self:SelectLtrUIPool(poolIndex)
end

UILottery._SetPoolDataList = function(self, poolDataList)
  -- function num : 0_2
  self.poolDataList = poolDataList
end

UILottery.RefreshLtrPoolUI = function(self, poolDataList, poolIndex)
  -- function num : 0_3 , upvalues : _ENV, cs_LayoutRebuilder
  self:_SetPoolDataList(poolDataList)
  local curIdDic = {}
  for k,poolData in ipairs(poolDataList) do
    curIdDic[poolData.poolId] = true
    local poolItem = (self.poolItemDic)[poolData.poolId]
    if poolItem == nil then
      poolItem = (self.ltrPoolItemPool):GetOne()
      poolItem:InitLtrPoolItem(k, poolData, self.resLoader, self.__onSelectLtrPoolItem)
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R10 in 'UnsetPending'

      ;
      (self.poolItemDic)[poolData.poolId] = poolItem
    end
    ;
    (poolItem.transform):SetAsLastSibling()
    poolItem:SetLtrPoolItemIndex(k)
  end
  local toBeRemoveIdDic = {}
  for poolId,poolItem in pairs(self.poolItemDic) do
    if curIdDic[poolId] == nil then
      toBeRemoveIdDic[poolId] = true
      ;
      (self.ltrPoolItemPool):HideOne(poolItem)
    end
  end
  for poolId,v in pairs(toBeRemoveIdDic) do
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R10 in 'UnsetPending'

    (self.poolItemDic)[poolId] = nil
  end
  ;
  ((self.ui).img_Select):SetAsLastSibling()
  ;
  (cs_LayoutRebuilder.ForceRebuildLayoutImmediate)(((self.ui).scrollLayoutGroup).transform)
  self:SelectLtrUIPool(poolIndex)
  ;
  (self.ltrPtNode):Hide()
end

UILottery.SelectLotteryPoolById = function(self, poolId)
  -- function num : 0_4 , upvalues : _ENV
  for _,poolItem in pairs(self.poolItemDic) do
    if poolItem.poolId == poolId then
      self:SelectLtrPoolItem(poolItem, true)
      return 
    end
  end
end

UILottery.SelectLtrUIPool = function(self, poolIndex)
  -- function num : 0_5
  local poolData = (self.poolDataList)[poolIndex]
  local poolItem = (self.poolItemDic)[poolData.poolId]
  self:SelectLtrPoolItem(poolItem)
end

UILottery.SelectLtrPoolItem = function(self, poolItem, noAudio)
  -- function num : 0_6 , upvalues : _ENV
  if not noAudio then
    noAudio = false
  end
  if not noAudio then
    AudioManager:PlayAudioById(1041)
  end
  self:_ClearSelectMoveTween()
  self._selectMoveTween = ((self.ui).img_Select):DOLocalMoveX(((poolItem.transform).anchoredPosition).x, 0.2)
  if self.poolItem ~= poolItem then
    ((self.ui).ani_Pic):DORestart()
    self.poolItem = poolItem
  end
  local changedPool = false
  if self.curPoolCfg ~= poolItem.poolCfg then
    changedPool = true
  end
  self.curPoolData = poolItem.ltrPoolData
  self.curPoolCfg = poolItem.poolCfg
  local poolId = (self.curPoolCfg).lottery_id
  ;
  (self.ltrCtrl):SelectLtrPool(poolId)
  self.poolIndex = poolItem.index
  self:RefreshCurLtrUI(changedPool)
  self:_LocateItemTween()
end

UILottery.RefreshCurLtrUI = function(self, changedPool)
  -- function num : 0_7 , upvalues : LotteryEnum, _ENV, cs_ResLoader, cs_MovieManager_ins
  local curPoolData = self.curPoolData
  local curPoolCfg = self.curPoolCfg
  ;
  (((self.ui).btn_LeftArrow).gameObject):SetActive(self.poolIndex ~= 1)
  ;
  (((self.ui).btn_RightArrow).gameObject):SetActive(self.poolIndex ~= #self.poolDataList)
  self:__RefreshTopRes()
  local hasOnece = curPoolData:IsLtrExecTypeOpen((LotteryEnum.eLtrExecType).Once)
  local hasTen = curPoolData:IsLtrExecTypeOpen((LotteryEnum.eLtrExecType).Ten)
  local hasSpecialOnce = curPoolData:IsLtrExecTypeOpen((LotteryEnum.eLtrExecType).SpecialOnce)
  ;
  (((self.ui).btn_Once).gameObject):SetActive(hasOnece)
  ;
  (((self.ui).btn_Ten).gameObject):SetActive(hasTen)
  ;
  (((self.ui).btn_SpecialOne).gameObject):SetActive(hasSpecialOnce)
  -- DECOMPILER ERROR at PC64: Confused about usage of register: R7 in 'UnsetPending'

  if hasOnece then
    ((self.ui).tex_PayOnce).text = tostring((self.curPoolCfg).costNum1)
    -- DECOMPILER ERROR at PC76: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).img_PayIcon_Once).sprite = CRH:GetSprite(((ConfigData.item)[(self.curPoolCfg).costId1]).small_icon)
  end
  -- DECOMPILER ERROR at PC85: Confused about usage of register: R7 in 'UnsetPending'

  if hasTen then
    ((self.ui).tex_PayTen).text = tostring((self.curPoolCfg).costNum2)
    -- DECOMPILER ERROR at PC97: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).img_PayIcon_Ten).sprite = CRH:GetSprite(((ConfigData.item)[(self.curPoolCfg).costId2]).small_icon)
  end
  do
    if hasSpecialOnce then
      local itemCfg = (ConfigData.item)[(self.curPoolCfg).costId3]
      -- DECOMPILER ERROR at PC111: Confused about usage of register: R8 in 'UnsetPending'

      ;
      ((self.ui).tex_PaySepecialOne).text = tostring((self.curPoolCfg).costNum3)
      -- DECOMPILER ERROR at PC118: Confused about usage of register: R8 in 'UnsetPending'

      ;
      ((self.ui).img_PayIcon_SpecialOnce).sprite = CRH:GetSprite(itemCfg.small_icon)
      ;
      ((self.ui).tex_SpecialOnceItemName):SetIndex(0, (LanguageUtil.GetLocaleText)(itemCfg.name))
    end
    self:RefreshCurLtrChangedUI()
    -- DECOMPILER ERROR at PC137: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).tex_Desc).text = (LanguageUtil.GetLocaleText)((self.curPoolCfg).intro_des)
    if changedPool and self.tempResLoader ~= nil then
      (self.tempResLoader):Put2Pool()
      self.tempResLoader = nil
    end
    if self.tempResLoader == nil then
      self.tempResLoader = (cs_ResLoader.Create)()
    end
    -- DECOMPILER ERROR at PC155: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).img_Pic).enabled = false
    if (self.curPoolCfg).bg_type == 1 then
      if self.moviePlayer ~= nil then
        (self.moviePlayer):StopVideo()
        cs_MovieManager_ins:ReturnMoviePlayer(self.moviePlayer)
        self.moviePlayer = nil
      end
      local path = PathConsts:GetLotteryPicPath("MainPicture/" .. (self.curPoolCfg).bg_path)
      ;
      (self.tempResLoader):LoadABAssetAsync(path, function(texture)
    -- function num : 0_7_0 , upvalues : self
    if texture == nil then
      return 
    end
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Pic).texture = texture
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Pic).enabled = true
  end
)
    elseif (self.curPoolCfg).bg_type == 2 then
      if self.moviePlayer == nil then
        self.moviePlayer = cs_MovieManager_ins:GetMoviePlayer()
      end
      ;
      (self.moviePlayer):SetVideoRender((self.ui).img_Video)
      local path = "Lottery/" .. (self.curPoolCfg).bg_path
      ;
      (self.moviePlayer):PlayVideo(path, nil, 1, true)
    else
      error("lottery_para.bg_type error : " .. tostring((self.curPoolCfg).bg_type))
    end
    -- DECOMPILER ERROR at PC222: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).img_SubImage).enabled = false
    do
      if not (string.IsNullOrEmpty)((self.curPoolCfg).bg1_path) then
        local path = PathConsts:GetLotteryPicPath("SubPicture/" .. (self.curPoolCfg).bg1_path)
        ;
        (self.tempResLoader):LoadABAssetAsync(path, function(texture)
    -- function num : 0_7_1 , upvalues : self
    if texture == nil then
      return 
    end
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_SubImage).texture = texture
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_SubImage).enabled = true
  end
)
      end
      -- DECOMPILER ERROR at PC244: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self.ui).img_Tile).enabled = false
      do
        if not (string.IsNullOrEmpty)((self.curPoolCfg).intro_path) then
          local introPath = PathConsts:GetLotteryPicPath("Tile/" .. (self.curPoolCfg).intro_path)
          ;
          (self.tempResLoader):LoadABAssetAsync(introPath, function(texture)
    -- function num : 0_7_2 , upvalues : self
    if texture == nil then
      return 
    end
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Tile).texture = texture
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Tile).enabled = true
  end
)
        end
        if (self.curPoolCfg).up_reward1 == 0 then
          (self.heroL):Hide()
        else
          (self.heroL):Show()
          ;
          (self.heroL):InitLtrHeroItem((self.curPoolCfg).up_reward1, self.tempResLoader, (self.curPoolCfg).up_hero1_para)
        end
        if (self.curPoolCfg).up_reward2 == 0 then
          (self.heroR):Hide()
        else
          (self.heroR):Show()
          ;
          (self.heroR):InitLtrHeroItem((self.curPoolCfg).up_reward2, self.tempResLoader, (self.curPoolCfg).up_hero2_para)
        end
        local lotteryData = ((PlayerDataCenter.allLtrData).ltrDataDic)[(self.curPoolCfg).lottery_id]
        local startTime, endTime = lotteryData:GetStartAndEndTime()
        if endTime == -1 then
          (((self.ui).tex_EndTime).gameObject):SetActive(false)
        else
          (((self.ui).tex_EndTime).gameObject):SetActive(true)
          ;
          ((self.ui).tex_EndTime):SetIndex(0, (os.date)("%m/%d %H:%M", endTime))
        end
        -- DECOMPILER ERROR: 20 unprocessed JMP targets
      end
    end
  end
end

UILottery.RefreshCurLtrChangedUI = function(self)
  -- function num : 0_8 , upvalues : _ENV
  self:__RefreshSpecialOnceBtnState()
  self:__RefreshPtBtn()
  self:__RefreshTenBtn()
  if (self.curPoolCfg).count_limit ~= 0 then
    ((self.ui).obj_RemianNum):SetActive(true)
    local limitNum = (self.curPoolData):GetLtrPoolLimitNum()
    local remainNum = (self.curPoolData):GetLtrPoolRemainNum()
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_RemianNum).text = tostring(remainNum) .. "/" .. tostring(limitNum)
  else
    do
      ;
      ((self.ui).obj_RemianNum):SetActive(false)
    end
  end
end

UILottery.__RefreshTopRes = function(self)
  -- function num : 0_9 , upvalues : _ENV, LotteryEnum
  local topResDic = {}
  for k,execType in pairs(LotteryEnum.eLtrExecType) do
    if (self.curPoolData):IsLtrExecTypeOpen(execType) then
      local costIdStr = "costId" .. tostring(execType)
      topResDic[(self.curPoolCfg)[costIdStr]] = true
    end
  end
  if (self.curPoolCfg).pool_type == (LotteryEnum.eLotteryPoolType).Paid then
    topResDic[ConstGlobalItem.PaidItem] = true
    topResDic[ConstGlobalItem.PaidSubItem] = true
  end
  local topResIdList = {}
  for itemId,_ in pairs(topResDic) do
    (table.insert)(topResIdList, itemId)
  end
  ;
  (table.sort)(topResIdList)
  ;
  (UIUtil.RefreshTopResId)(topResIdList)
end

UILottery.__RefreshPtBtn = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local hasPt = (self.curPoolData):HasLtrPt()
  ;
  (((self.ui).btn_PtExchange).gameObject):SetActive(hasPt)
  ;
  ((self.ui).obj_MaskOnlyPt):SetActive(false)
  ;
  ((self.ui).obj_onlyPtTips):SetActive(false)
  if not hasPt then
    return 
  end
  local ptNum = (self.curPoolData):GetLtrPtNum()
  local maxPtNum = 0
  for k,num in ipairs((self.curPoolCfg).pt_rewardCostNumList) do
    maxPtNum = (math.max)(maxPtNum, num)
  end
  ;
  ((self.ui).tex_PtNum):SetIndex(0, tostring(ptNum), tostring(maxPtNum))
  if maxPtNum <= ptNum then
    ((self.ui).obj_MaskOnlyPt):SetActive(true)
    ;
    ((self.ui).obj_onlyPtTips):SetActive(true)
    ;
    ((self.ui).tex_PtTips):SetIndex(0, tostring(maxPtNum))
  end
end

UILottery.__RefreshTenBtn = function(self)
  -- function num : 0_11 , upvalues : LotteryEnum
  if not (self.curPoolData):IsLtrExecTypeOpen((LotteryEnum.eLtrExecType).Ten) then
    return 
  end
  local limitNum = (self.curPoolCfg).count_limit
  local disableTen = limitNum ~= 0 and (self.curPoolData):GetLtrPoolRemainNum() < 10
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).btn_Ten).enabled = not disableTen
  ;
  ((self.ui).obj_TenNumLimit):SetActive(disableTen)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UILottery.__RefreshSpecialOnceBtnState = function(self)
  -- function num : 0_12 , upvalues : LotteryEnum, _ENV
  if not (self.curPoolData):IsLtrExecTypeOpen((LotteryEnum.eLtrExecType).SpecialOnce) then
    self:__ClearSpecialOnceBtnTimer()
    return 
  end
  if (self.curPoolData):IsLtrExecSpecialOneceTimeOk() then
    ((self.ui).obj_MaskSpecialOne):SetActive(false)
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).btn_SpecialOne).enabled = true
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).tex_SpecialOneceTime).text = (LanguageUtil.GetLocaleText)((self.curPoolCfg).sp_time_show)
  else
    ;
    ((self.ui).obj_MaskSpecialOne):SetActive(true)
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).btn_SpecialOne).enabled = false
    self:__ClearSpecialOnceBtnTimer()
    self._specialOnceBtnTimer = (TimerManager:GetTimer(1, self.__UpdSpecialOnceBtnTime, self, false, false, true)):Start()
    self:__UpdSpecialOnceBtnTime()
  end
end

UILottery.__UpdSpecialOnceBtnTime = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local remainingTs = (self.curPoolData):GetLtrExecSpecialOneceRemainingTs()
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  if remainingTs >= 0 then
    ((self.ui).tex_SpecialOneceTime).text = TimestampToTime(remainingTs)
    return 
  end
  self:__ClearSpecialOnceBtnTimer()
  self:__RefreshSpecialOnceBtnState()
end

UILottery.__ClearSpecialOnceBtnTimer = function(self)
  -- function num : 0_14
  if self._specialOnceBtnTimer ~= nil then
    (self._specialOnceBtnTimer):Stop()
    self._specialOnceBtnTimer = nil
  end
end

UILottery.__OnEndDrag = function(self)
  -- function num : 0_15 , upvalues : _ENV
  ((self.ui).infoScroll):StopMovement()
  local hPos = ((self.ui).infoScroll).horizontalNormalizedPosition
  if hPos <= 0 or hPos >= 1 then
    return 
  end
  local paddingLeft = (((self.ui).scrollLayoutGroup).padding).left
  local curPosX = ((((self.ui).infoScroll).content).localPosition).x + paddingLeft
  local count = (math.floor)((math.abs)(curPosX) / self.poolItemWidth)
  local tarPos = -count * self.poolItemWidth
  if count * self.poolItemWidth + self.poolItemWidth / 2 < (math.abs)(curPosX) then
    tarPos = -(count + 1) * self.poolItemWidth
  end
  if count > 0 then
    tarPos = tarPos + ((self.ui).scrollLayoutGroup).spacing
  end
  self:__ClearScrollTween()
  self.__scrollTween = (((self.ui).infoScroll).content):DOLocalMoveX(tarPos, 0.2)
end

UILottery.__ClearScrollTween = function(self)
  -- function num : 0_16
  if self.__scrollTween ~= nil then
    (self.__scrollTween):Kill()
    self.__scrollTween = nil
  end
end

UILottery.__OnClickDrawOne = function(self)
  -- function num : 0_17
  (self.ltrCtrl):LtrDrawOne()
end

UILottery.__OnClickDrawTen = function(self)
  -- function num : 0_18
  (self.ltrCtrl):LtrDrawTen()
end

UILottery.__OnClickDrawSpecialOne = function(self)
  -- function num : 0_19
  (self.ltrCtrl):LtrDrawSpecialOne()
end

UILottery.__OnClickPtExchange = function(self)
  -- function num : 0_20
  if (self.ltrCtrl):CheckLtrPoolExpired() then
    return 
  end
  ;
  (self.ltrPtNode):InitLtrPtNode(self.curPoolData, self.tempResLoader, self.ltrCtrl)
  ;
  (self.ltrPtNode):Show()
end

UILottery.__OnClickPoolDetail = function(self)
  -- function num : 0_21 , upvalues : LotteryEnum
  if (self.ltrCtrl):CheckLtrPoolExpired() then
    return 
  end
  ;
  (self.ltrCtrl):ChangeLotteryState((LotteryEnum.eLotteryState).PoolDetail)
  ;
  (self.poolDetailNode):InitLtrPoolDetail(self.curPoolCfg, function()
    -- function num : 0_21_0 , upvalues : self, LotteryEnum
    (self.ltrCtrl):ChangeLotteryState((LotteryEnum.eLotteryState).Normal)
  end
)
end

UILottery.__OnClickBg = function(self)
  -- function num : 0_22
  (self.ltrCtrl):CheckLtrPoolExpired()
end

UILottery.__OnClickLeftArrow = function(self)
  -- function num : 0_23
  self:__ChangePoolIndex(false)
end

UILottery.__OnClickRightArrow = function(self)
  -- function num : 0_24
  self:__ChangePoolIndex(true)
end

UILottery.__ChangePoolIndex = function(self, isAdd)
  -- function num : 0_25 , upvalues : _ENV
  local index = self.poolIndex
  if isAdd then
    index = index + 1
  else
    index = index - 1
  end
  index = (math.clamp)(index, 1, #self.poolDataList)
  if index == self.poolIndex then
    return 
  end
  self:SelectLtrUIPool(index)
  self:_LocateItemTween()
end

UILottery._LocateItemTween = function(self)
  -- function num : 0_26
  local tarPos = nil
  local leftPos = -((((self.ui).scrollLayoutGroup).padding).left + (self.poolIndex - 1) * self.poolItemWidth)
  local rightPos = leftPos - self.poolItemWidth
  local curPosX = ((((self.ui).infoScroll).content).localPosition).x
  if curPosX - leftPos < 0 then
    tarPos = leftPos + (((self.ui).scrollLayoutGroup).padding).left
  else
    if ((((self.ui).infoScroll).transform).rect).width < curPosX - rightPos then
      tarPos = rightPos + ((((self.ui).infoScroll).transform).rect).width
    else
      return 
    end
  end
  self:__ClearScrollTween()
  self.__scrollTween = (((self.ui).infoScroll).content):DOLocalMoveX(tarPos, 0.2)
end

UILottery.__OnClickClose = function(self)
  -- function num : 0_27 , upvalues : _ENV
  self:OnCloseWin()
  do
    if self.fromType == eBaseWinFromWhere.home then
      local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
      if homeWin ~= nil then
        AudioManager:RemoveAllVoice()
      end
    end
    ControllerManager:DeleteController(ControllerTypeId.Lottery)
    self:Delete()
  end
end

UILottery.ScrollLotteryPoolEnd = function(self)
  -- function num : 0_28
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).infoScroll).horizontalNormalizedPosition = 1
end

UILottery.OnHide = function(self)
  -- function num : 0_29 , upvalues : base
  (base.OnHide)(self)
end

UILottery._ClearSelectMoveTween = function(self)
  -- function num : 0_30
  if self._selectMoveTween ~= nil then
    (self._selectMoveTween):Kill()
    self._selectMoveTween = nil
  end
end

UILottery.OnDelete = function(self)
  -- function num : 0_31 , upvalues : cs_MovieManager_ins, base
  ((self.ui).ani_Pic):DOKill()
  ;
  (self.ltrPoolItemPool):DeleteAll()
  self:_ClearSelectMoveTween()
  if self.tempResLoader ~= nil then
    (self.tempResLoader):Put2Pool()
    self.tempResLoader = nil
  end
  if self.moviePlayer ~= nil then
    cs_MovieManager_ins:ReturnMoviePlayer(self.moviePlayer)
    self.moviePlayer = nil
  end
  self:__ClearScrollTween()
  self:__ClearSpecialOnceBtnTimer()
  ;
  (self.resLoader):Put2Pool()
  self.resLoader = nil
  ;
  (self.poolDetailNode):Delete()
  ;
  (self.ltrPtNode):Delete()
  ;
  (base.OnDelete)(self)
end

return UILottery


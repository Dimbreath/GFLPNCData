local UILottery = class("UILottery", UIBaseWindow)
local base = UIBaseWindow
local LotteryEnum = require("Game.Lottery.LotteryEnum")
local UINLtrPoolItem = require("Game.Lottery.UI.UINLtrPoolItem")
local UINLtrHeroItem = require("Game.Lottery.UI.UINLtrHeroItem")
local UILotteryPoolDetail = require("Game.Lottery.UI.PoolDetail.UILotteryPoolDetail")
local CheckerTypeId, CheckerGlobalConfig = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local UINLtrPtNode = require("Game.Lottery.UI.PtNode.UINLtrPtNode")
local HeroInfoData = require("Game.Lottery.Data.HeroInfoData")
local LotteryRtUtil = require("Game.Lottery.UI.LotteryRtUtil")
local cs_ResLoader = CS.ResLoader
local cs_MovieManager_ins = (CS.MovieManager).Instance
local cs_EventTriggerListener = CS.EventTriggerListener
local cs_LayoutRebuilder = ((CS.UnityEngine).UI).LayoutRebuilder
UILottery.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, cs_EventTriggerListener, cs_ResLoader, UINLtrPoolItem, UINLtrHeroItem
  self.__onSelectLtrPoolItem = BindCallback(self, self.SelectLtrPoolItem)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Once, self, self.__OnClickDrawOne)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Ten, self, self.__OnClickDrawTen)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Select, self, self.__OnClickFreeSelect)
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
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_HeroInfo, self, self.__OnClickHeroInfo)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ShowCharacter, self, self.__OnClickShowCharacter)
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
  self.__OnPageChangeDragBegin = BindCallback(self, self.OnPageChangeDragBegin)
  self.__OnPageChangeDragEnd = BindCallback(self, self.OnPageChangeDragEnd)
  local pageChangeEventTrigger = (cs_EventTriggerListener.Get)((self.ui).dragPageChange)
  pageChangeEventTrigger:onBeginDrag("+", self.__OnPageChangeDragBegin)
  pageChangeEventTrigger:onEndDrag("+", self.__OnPageChangeDragEnd)
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
end

UILottery.__refreshModel = function(self)
  -- function num : 0_4 , upvalues : _ENV, cs_ResLoader
  if self.resLoader ~= nil then
    (self.resLoader):Put2Pool()
    self.resLoader = nil
  end
  local modelPath = PathConsts:GetCharacterModelPrefabPath(((self.UpHeroData).heroData):GetResModelName())
  if self.modelPath == modelPath then
    return 
  end
  if not IsNull(self.heroGo) then
    (self.heroGo):SetActive(false)
  end
  self.resLoader = (cs_ResLoader.Create)()
  ;
  (self.resLoader):LoadABAssetAsync(modelPath, function(prefab)
    -- function num : 0_4_0 , upvalues : _ENV, self, modelPath
    DestroyUnityObject(self.heroGo)
    self.modelPath = modelPath
    self.heroGo = prefab:Instantiate(((self.ui).modelHoder).transform)
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.heroGo).transform).localEulerAngles = (Vector3.New)(0, 180, 0)
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.heroGo).transform).localPosition = (Vector3.New)(0, -0.5, 0)
  end
)
end

UILottery.SelectLotteryPoolById = function(self, poolId)
  -- function num : 0_5 , upvalues : _ENV
  for _,poolItem in pairs(self.poolItemDic) do
    if poolItem.poolId == poolId then
      self:SelectLtrPoolItem(poolItem, true)
      return 
    end
  end
end

UILottery.SelectLtrUIPool = function(self, poolIndex)
  -- function num : 0_6
  local poolData = (self.poolDataList)[poolIndex]
  local poolItem = (self.poolItemDic)[poolData.poolId]
  self:SelectLtrPoolItem(poolItem)
end

UILottery.SelectLtrPoolItem = function(self, poolItem, noAudio)
  -- function num : 0_7 , upvalues : _ENV
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
  self:__RefreshGuaranteeState()
  self:RefreshCurLtrUI(changedPool)
  self:_LocateItemTween()
end

UILottery.RefreshCurLtrUI = function(self, changedPool)
  -- function num : 0_8 , upvalues : LotteryEnum, _ENV, cs_ResLoader, cs_MovieManager_ins
  local curPoolData = self.curPoolData
  local curPoolCfg = self.curPoolCfg
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).btn_LeftArrow).interactable = self.poolIndex ~= 1
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).btn_RightArrow).interactable = self.poolIndex ~= #self.poolDataList
  self:__RefreshTopRes()
  local hasOnece = curPoolData:IsLtrExecTypeOpen((LotteryEnum.eLtrExecType).Once)
  local hasTen = curPoolData:IsLtrExecTypeOpen((LotteryEnum.eLtrExecType).Ten)
  local hasSpecialOnce = curPoolData:IsLtrExecTypeOpen((LotteryEnum.eLtrExecType).SpecialOnce)
  local hasFreeChoice = curPoolData:IsLtrExecTypeOpen((LotteryEnum.eLtrExecType).FreeChoice)
  local IsGuaranteeOpen = curPoolData:IsGuaranteeOpen()
  local IsHeroInfoBtnOpenParam = curPoolData:IsHeroInfoBtnOpen()
  if hasFreeChoice then
    (((self.ui).model_camera).gameObject):SetActive(false)
    ;
    (((self.ui).rect_uiModel).gameObject):SetActive(false)
    local window = UIManager:GetWindow(UIWindowTypeID.LotterySelectHero)
    if window ~= nil then
      if not (self.curPoolData):IsLtrExecTypeOpen((LotteryEnum.eLtrExecType).FreeChoice) then
        window:Hide()
        return 
      end
      window:Show()
      window:InitLotterySelectHero(self.curPoolData)
      -- DECOMPILER ERROR at PC81: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (window.transform).localScale = Vector3.one
      ;
      ((self.ui).dragPageChange):SetActive(false)
    else
      UIManager:ShowWindowAsync(UIWindowTypeID.LotterySelectHero, function(window)
    -- function num : 0_8_0 , upvalues : self, LotteryEnum, _ENV
    if window == nil then
      return 
    end
    ;
    (window.transform):SetParent((self.ui).selectHeroHolder)
    window:InitPageChangeDrag(self.__OnPageChangeDragBegin, self.__OnPageChangeDragEnd)
    if not (self.curPoolData):IsLtrExecTypeOpen((LotteryEnum.eLtrExecType).FreeChoice) then
      window:Hide()
      return 
    end
    window:InitLotterySelectHero(self.curPoolData)
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (window.transform).localScale = Vector3.one
    ;
    ((self.ui).dragPageChange):SetActive(false)
  end
)
    end
  else
    local selectHeroWindow = UIManager:GetWindow(UIWindowTypeID.LotterySelectHero)
    if selectHeroWindow ~= nil and selectHeroWindow.active then
      selectHeroWindow:Hide()
      selectHeroWindow:ClearLotterySelect()
    end
    ;
    ((self.ui).dragPageChange):SetActive(true)
  end
  ;
  (((self.ui).sprcialSlogan).gameObject):SetActive(IsGuaranteeOpen)
  ;
  ((self.ui).adapter):SetActive(not hasFreeChoice)
  ;
  (((self.ui).btn_PoolDetail).gameObject):SetActive(not hasFreeChoice)
  self:__RefreshFreeChoiceTips()
  local isUpLottery = IsHeroInfoBtnOpenParam[1]
  ;
  (((self.ui).btn_HeroInfo).gameObject):SetActive(isUpLottery)
  ;
  (((self.ui).btn_ShowCharacter).gameObject):SetActive(isUpLottery)
  self.UpHeroId = IsHeroInfoBtnOpenParam[2]
  if isUpLottery and self.UpHeroId then
    local lottery_preview = (ConfigData.lottery_preview)[self.UpHeroId]
    if lottery_preview ~= nil then
      local fullPath = PathConsts:GetImagePath(lottery_preview.previewPic)
      local image = (self.resLoader):LoadABAsset(fullPath)
      -- DECOMPILER ERROR at PC171: Confused about usage of register: R14 in 'UnsetPending'

      if image ~= nil then
        ((self.ui).img_PreviewCharacter).texture = image
      end
    end
  end
  local pos = curPoolData:GetHeroUpPara()
  -- DECOMPILER ERROR at PC187: Confused about usage of register: R12 in 'UnsetPending'

  if #pos == 4 then
    ((((self.ui).btn_HeroInfo).gameObject).transform).localPosition = (Vector3.New)(pos[1], pos[2], 0)
    -- DECOMPILER ERROR at PC198: Confused about usage of register: R12 in 'UnsetPending'

    ;
    ((((self.ui).btn_ShowCharacter).gameObject).transform).localPosition = (Vector3.New)(pos[3], pos[4], 0)
  end
  ;
  (((self.ui).btn_Once).gameObject):SetActive(hasOnece)
  ;
  (((self.ui).btn_Ten).gameObject):SetActive(hasTen)
  ;
  (((self.ui).btn_Select).gameObject):SetActive(hasFreeChoice)
  ;
  (((self.ui).btn_SpecialOne).gameObject):SetActive(hasSpecialOnce)
  -- DECOMPILER ERROR at PC231: Confused about usage of register: R12 in 'UnsetPending'

  if hasOnece then
    ((self.ui).tex_PayOnce).text = tostring((self.curPoolCfg).costNum1)
    -- DECOMPILER ERROR at PC243: Confused about usage of register: R12 in 'UnsetPending'

    ;
    ((self.ui).img_PayIcon_Once).sprite = CRH:GetSprite(((ConfigData.item)[(self.curPoolCfg).costId1]).small_icon)
  end
  -- DECOMPILER ERROR at PC252: Confused about usage of register: R12 in 'UnsetPending'

  if hasTen then
    ((self.ui).tex_PayTen).text = tostring((self.curPoolCfg).costNum2)
    -- DECOMPILER ERROR at PC264: Confused about usage of register: R12 in 'UnsetPending'

    ;
    ((self.ui).img_PayIcon_Ten).sprite = CRH:GetSprite(((ConfigData.item)[(self.curPoolCfg).costId2]).small_icon)
  end
  do
    if hasSpecialOnce then
      local itemCfg = (ConfigData.item)[(self.curPoolCfg).costId3]
      -- DECOMPILER ERROR at PC278: Confused about usage of register: R13 in 'UnsetPending'

      ;
      ((self.ui).tex_PaySepecialOne).text = tostring((self.curPoolCfg).costNum3)
      -- DECOMPILER ERROR at PC285: Confused about usage of register: R13 in 'UnsetPending'

      ;
      ((self.ui).img_PayIcon_SpecialOnce).sprite = CRH:GetSprite(itemCfg.small_icon)
      ;
      ((self.ui).tex_SpecialOnceItemName):SetIndex(0, (LanguageUtil.GetLocaleText)(itemCfg.name))
    end
    -- DECOMPILER ERROR at PC303: Confused about usage of register: R12 in 'UnsetPending'

    if hasFreeChoice then
      ((self.ui).tex_Pay_Select).text = tostring((self.curPoolCfg).costNum4)
      -- DECOMPILER ERROR at PC315: Confused about usage of register: R12 in 'UnsetPending'

      ;
      ((self.ui).img_PayIcon_Select).sprite = CRH:GetSprite(((ConfigData.item)[(self.curPoolCfg).costId4]).small_icon)
    end
    self:RefreshCurLtrChangedUI()
    -- DECOMPILER ERROR at PC324: Confused about usage of register: R12 in 'UnsetPending'

    if (self.curPoolCfg).intro_des == nil then
      ((self.ui).tex_Desc).text = nil
    else
      -- DECOMPILER ERROR at PC333: Confused about usage of register: R12 in 'UnsetPending'

      ((self.ui).tex_Desc).text = (LanguageUtil.GetLocaleText)((self.curPoolCfg).intro_des)
    end
    if changedPool and self.tempResLoader ~= nil then
      (self.tempResLoader):Put2Pool()
      self.tempResLoader = nil
    end
    if self.tempResLoader == nil then
      self.tempResLoader = (cs_ResLoader.Create)()
    end
    -- DECOMPILER ERROR at PC351: Confused about usage of register: R12 in 'UnsetPending'

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
    -- function num : 0_8_1 , upvalues : self
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
    -- DECOMPILER ERROR at PC418: Confused about usage of register: R12 in 'UnsetPending'

    ;
    ((self.ui).img_SubImage).enabled = false
    do
      if not (string.IsNullOrEmpty)((self.curPoolCfg).bg1_path) then
        local path = PathConsts:GetLotteryPicPath("SubPicture/" .. (self.curPoolCfg).bg1_path)
        ;
        (self.tempResLoader):LoadABAssetAsync(path, function(texture)
    -- function num : 0_8_2 , upvalues : self
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
      -- DECOMPILER ERROR at PC440: Confused about usage of register: R12 in 'UnsetPending'

      ;
      ((self.ui).img_Tile).enabled = false
      do
        if not (string.IsNullOrEmpty)((self.curPoolCfg).intro_path) then
          local introPath = PathConsts:GetLotteryPicPath("Tile/" .. (self.curPoolCfg).intro_path)
          ;
          (self.tempResLoader):LoadABAssetAsync(introPath, function(texture)
    -- function num : 0_8_3 , upvalues : self
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
        -- DECOMPILER ERROR: 30 unprocessed JMP targets
      end
    end
  end
end

UILottery.RefreshCurLtrChangedUI = function(self)
  -- function num : 0_9 , upvalues : LotteryEnum, _ENV
  self:__RefreshSpecialOnceBtnState()
  self:__RefreshPtBtn()
  self:__RefreshTenBtn()
  if (self.curPoolCfg).count_limit ~= 0 and not (self.curPoolData):IsLtrExecTypeOpen((LotteryEnum.eLtrExecType).FreeChoice) then
    ((self.ui).obj_RemianNum):SetActive(true)
    local limitNum = (self.curPoolData):GetLtrPoolLimitNum()
    local remainNum = (self.curPoolData):GetLtrPoolRemainNum()
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R3 in 'UnsetPending'

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
  -- function num : 0_10 , upvalues : _ENV, LotteryEnum
  local topResDic = {}
  for k,execType in pairs(LotteryEnum.eLtrExecType) do
    if (self.curPoolData):IsLtrExecTypeOpen(execType) then
      local costIdStr = "costId" .. tostring(execType)
      topResDic[(self.curPoolCfg)[costIdStr]] = true
    end
  end
  if (self.curPoolCfg).pool_client_type == (LotteryEnum.eLotteryPoolType).Paid then
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
  -- function num : 0_11 , upvalues : _ENV
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
  -- function num : 0_12 , upvalues : LotteryEnum
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

UILottery.__RefreshGuaranteeState = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local IsGuaranteeOpen = (self.curPoolData):IsGuaranteeOpen()
  if not IsGuaranteeOpen then
    return 
  end
  local usedGuarantee = ((PlayerDataCenter.allLtrData).ltrSpecial)[((self.curPoolData).ltrCfg).guaranteeType]
  local allGuarantee = ((self.curPoolData).ltrCfg).guaranteeNums
  if usedGuarantee == nil then
    usedGuarantee = 0
  end
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_SprcialSlogan).text = (string.format)("%s/%s", usedGuarantee, allGuarantee)
end

UILottery.__RefreshFreeChoiceTips = function(self)
  -- function num : 0_14 , upvalues : LotteryEnum, _ENV
  local isFreeChoice = (self.curPoolData):IsLtrExecTypeOpen((LotteryEnum.eLtrExecType).FreeChoice)
  ;
  ((self.ui).obj_FreeChoiceTips):SetActive(false)
  if not isFreeChoice then
    return 
  end
  local lastEndTime, lastPoolData = nil, nil
  for k,poolData in ipairs(self.poolDataList) do
    local startTime, endTime = poolData:GetStartAndEndTime()
    if poolData:IsLtrFreeChoicePrompt() then
      if endTime == -1 then
        lastPoolData = poolData
        break
      end
      if lastEndTime == nil or lastEndTime < endTime then
        lastEndTime = endTime
        lastPoolData = poolData
      end
    end
  end
  do
    if lastPoolData == nil then
      return 
    end
    ;
    ((self.ui).obj_FreeChoiceTips):SetActive(true)
    local poolName = (LanguageUtil.GetLocaleText)((lastPoolData.ltrCfg).name)
    ;
    ((self.ui).tex_FreeChoiceTips):SetIndex(0, poolName)
  end
end

UILottery.__RefreshSpecialOnceBtnState = function(self)
  -- function num : 0_15 , upvalues : LotteryEnum, _ENV
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
    self._specialOnceBtnTimerId = TimerManager:StartTimer(1, self.__UpdSpecialOnceBtnTime, self, false, false, true)
    self:__UpdSpecialOnceBtnTime()
  end
end

UILottery.__UpdSpecialOnceBtnTime = function(self)
  -- function num : 0_16 , upvalues : _ENV
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
  -- function num : 0_17 , upvalues : _ENV
  if self._specialOnceBtnTimerId ~= nil then
    TimerManager:StopTimer(self._specialOnceBtnTimerId)
    self._specialOnceBtnTimerId = nil
  end
end

UILottery.__OnEndDrag = function(self)
  -- function num : 0_18 , upvalues : _ENV
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
    self:__ClearScrollTween()
    self.__scrollTween = (((self.ui).infoScroll).content):DOLocalMoveX(tarPos, 0.2)
  end
end

UILottery.__ClearScrollTween = function(self)
  -- function num : 0_19
  if self.__scrollTween ~= nil then
    (self.__scrollTween):Kill()
    self.__scrollTween = nil
  end
end

UILottery.__OnClickDrawOne = function(self)
  -- function num : 0_20
  (self.ltrCtrl):LtrDrawOne()
end

UILottery.__OnClickDrawTen = function(self)
  -- function num : 0_21
  (self.ltrCtrl):LtrDrawTen()
end

UILottery.__OnClickDrawSpecialOne = function(self)
  -- function num : 0_22
  (self.ltrCtrl):LtrDrawSpecialOne()
end

UILottery.__OnClickFreeSelect = function(self)
  -- function num : 0_23
  (self.ltrCtrl):LtrFreeSelectJudge((self.curPoolData).ltrCfg)
end

UILottery.__OnClickPtExchange = function(self)
  -- function num : 0_24 , upvalues : _ENV
  if (self.ltrCtrl):CheckLtrPoolExpired() then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.LotteryExchange, function(window)
    -- function num : 0_24_0 , upvalues : self
    if window ~= nil then
      window:ShowLtrPtNode(self.curPoolData, self.tempResLoader, self.ltrCtrl)
    end
  end
)
end

UILottery.__OnClickPoolDetail = function(self)
  -- function num : 0_25 , upvalues : LotteryEnum, _ENV
  if (self.ltrCtrl):CheckLtrPoolExpired() then
    return 
  end
  ;
  (self.ltrCtrl):ChangeLotteryState((LotteryEnum.eLotteryState).PoolDetail)
  UIManager:ShowWindowAsync(UIWindowTypeID.LotteryPoolDetail, function(win)
    -- function num : 0_25_0 , upvalues : self, LotteryEnum
    if win == nil then
      return 
    end
    win:InitLtrPoolDetail(self.curPoolCfg, function()
      -- function num : 0_25_0_0 , upvalues : self, LotteryEnum
      (self.ltrCtrl):ChangeLotteryState((LotteryEnum.eLotteryState).Normal)
    end
)
  end
)
end

UILottery.__OnClickBg = function(self)
  -- function num : 0_26
  (self.ltrCtrl):CheckLtrPoolExpired()
end

UILottery.__OnClickLeftArrow = function(self)
  -- function num : 0_27
  self:__ChangePoolIndex(false)
end

UILottery.__OnClickRightArrow = function(self)
  -- function num : 0_28
  self:__ChangePoolIndex(true)
end

UILottery.__OnClickHeroInfo = function(self)
  -- function num : 0_29 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroInfoState, function(win)
    -- function num : 0_29_0 , upvalues : self
    if win == nil then
      return 
    end
    win:InitHeroInfoState(self.UpHeroId)
  end
)
end

UILottery.__OnClickShowCharacter = function(self)
  -- function num : 0_30 , upvalues : _ENV
  local currentPoolId = 0
  local lottrryCtrl = ControllerManager:GetController(ControllerTypeId.Lottery, true)
  if lottrryCtrl ~= nil then
    currentPoolId = lottrryCtrl.curPoolId
  end
  self:CloseLottery(true)
  ;
  (ControllerManager:GetController(ControllerTypeId.ShowCharacter, true)):EnterShowCharacterScene(self.UpHeroId, currentPoolId)
end

UILottery.__ChangePoolIndex = function(self, isAdd)
  -- function num : 0_31 , upvalues : _ENV
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
  -- function num : 0_32
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
  -- function num : 0_33 , upvalues : _ENV
  do
    if self.fromType == eBaseWinFromWhere.home then
      local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
      self:CloseLottery(homeWin ~= nil)
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

UILottery.CloseLottery = function(self, needRemoveAllVoice)
  -- function num : 0_34 , upvalues : _ENV
  self:OnCloseWin()
  if needRemoveAllVoice then
    AudioManager:RemoveAllVoice()
  end
  ControllerManager:DeleteController(ControllerTypeId.Lottery)
  self:Delete()
end

UILottery.ScrollLotteryPoolEnd = function(self)
  -- function num : 0_35
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).infoScroll).horizontalNormalizedPosition = 1
end

UILottery.OnPageChangeDragBegin = function(self, go, eventData)
  -- function num : 0_36 , upvalues : _ENV
  if GuideManager.inGuide then
    return 
  end
  self.pageChangeTouchPointX = (eventData.position).x
end

UILottery.OnPageChangeDragEnd = function(self, go, eventData)
  -- function num : 0_37
  if self.pageChangeTouchPointX == nil then
    return 
  end
  local curPointX = (eventData.position).x
  local startPointX = self.pageChangeTouchPointX
  self.pageChangeTouchPointX = nil
  local diff = curPointX - startPointX
  if (self.ui).dragPageChangeDiff < diff then
    self:__ChangePoolIndex(false)
  else
    if diff < -(self.ui).dragPageChangeDiff then
      self:__ChangePoolIndex(true)
    end
  end
end

UILottery.OnHide = function(self)
  -- function num : 0_38 , upvalues : base
  (base.OnHide)(self)
end

UILottery._ClearSelectMoveTween = function(self)
  -- function num : 0_39
  if self._selectMoveTween ~= nil then
    (self._selectMoveTween):Kill()
    self._selectMoveTween = nil
  end
end

UILottery.OnDelete = function(self)
  -- function num : 0_40 , upvalues : _ENV, cs_MovieManager_ins, LotteryRtUtil, base
  ((self.ui).ani_Pic):DOKill()
  ;
  (self.ltrPoolItemPool):DeleteAll()
  UIManager:DeleteWindow(UIWindowTypeID.LotterySelectHero)
  UIManager:DeleteWindow(UIWindowTypeID.LotteryExchange)
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
  if self.resLoader ~= nil then
    (self.resLoader):Put2Pool()
    self.resLoader = nil
  end
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R1 in 'UnsetPending'

  if self.texture ~= nil then
    ((self.ui).model_camera).targetTexture = nil
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).model_Image).texture = nil
    ;
    (LotteryRtUtil.ReleaseTemporaryAndDestory)(self.texture)
    self.texture = nil
    ;
    (((self.ui).model_camera).gameObject):SetActive(false)
    ;
    (((self.ui).rect_uiModel).gameObject):SetActive(false)
  end
  ;
  (base.OnDelete)(self)
end

return UILottery


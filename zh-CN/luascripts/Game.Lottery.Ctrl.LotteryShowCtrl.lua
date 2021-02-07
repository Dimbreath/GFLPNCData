-- params : ...
-- function num : 0 , upvalues : _ENV
local base = require("Game.Lottery.Ctrl.LotteryCtrlBase")
local LotteryShowCtrl = class("LotteryShowCtrl", base)
local UINLtrShowPoint = require("Game.Lottery.UI.Show.UINLtrShowPoint")
local UINLtrShowRing = require("Game.Lottery.UI.Show.UINLtrShowRing")
local UINLtrSWaveRing = require("Game.Lottery.UI.Show.UINLtrSWaveRing")
local UINLtrSPointBingo = require("Game.Lottery.UI.Show.UINLtrSPointBingo")
local LtrShowCfg = require("Game.Lottery.UI.Show.LtrShowCfg")
local LotteryEnum = require("Game.Lottery.LotteryEnum")
local util = require("XLua.Common.xlua_util")
local cs_ResLoader = CS.ResLoader
local cs_DOTween = ((CS.DG).Tweening).DOTween
local cs_Ease = ((CS.DG).Tweening).Ease
local cs_Material = (CS.UnityEngine).Material
local cs_WaitForSeconds = (CS.UnityEngine).WaitForSeconds
LotteryShowCtrl.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.__OnCamReturnEnd = BindCallback(self, self.__CamReturnEnd)
  self.__MainCoroutineFunc = BindCallback(self, self.__MainCoroutine)
  self.tweenList = {}
end

LotteryShowCtrl.PlayAllDOTween = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self.allTweensAnimation = (((self.bind).ui_buttom).transform):GetComponentsInChildren(typeof(((CS.DG).Tweening).DOTweenAnimation))
  for i = 0, (self.allTweensAnimation).Length - 1 do
    local tween = (self.allTweensAnimation)[i]
    tween:DORestart(false)
  end
end

LotteryShowCtrl.LtrShowStart = function(self, showRareList, poolType)
  -- function num : 0_2 , upvalues : _ENV
  AudioManager:RemoveAllVoice()
  self._auBack_Start = AudioManager:PlayAudioById(1042, function()
    -- function num : 0_2_0 , upvalues : self
    self._auBack_Start = nil
  end
)
  self.showRareList = showRareList
  self.poolType = poolType
  if not self:__LoadRes() then
    self:__OnShowStart()
  end
end

LotteryShowCtrl._OnClickStart = function(self)
  -- function num : 0_3 , upvalues : _ENV, LotteryEnum
  if self.waitStart then
    if self._auBack_Start ~= nil then
      AudioManager:StopAudioByBack(self._auBack_Start)
      self._auBack_Start = nil
    end
    ;
    ((self.bind).startRingDown):SetActive(true)
    AudioManager:PlayAudioById(1044)
    self:__ContinuePlayShow()
    self.waitStart = false
    ;
    (self.ltrCtrl):ChangeLotteryState((LotteryEnum.eLotteryState).LotteryAnimation)
  end
end

LotteryShowCtrl.__MainCoroutine = function(self)
  -- function num : 0_4 , upvalues : _ENV, cs_WaitForSeconds
  self:_ChangeRingMaskSize(1)
  while not self._circle1ScanComplete do
    (coroutine.yield)(nil)
  end
  ;
  (coroutine.yield)(cs_WaitForSeconds(0.5))
  self:_ShowBingo(self.circle1IndexList, self.circle1PointIndexDic, eHeroCardRareType.R)
  ;
  (coroutine.yield)(cs_WaitForSeconds(1))
  if self.scanPointNum == 0 then
    self:_OnShowEnd()
    return 
  end
  self:__ContinuePlayShow()
  ;
  (self.waveRingPool):HideAll()
  ;
  (self.showRingPool):HideAll()
  self:_ChangeRingMaskSize(2)
  self:_KillWaveTweens()
  self:_BalckBgTween(1500, 2370, 0.155, 0.278)
  self:_ShowQuality1BingoExit()
  while self.scanWaveEndNum < self.scanPointNum do
    (coroutine.yield)(nil)
  end
  ;
  (coroutine.yield)(cs_WaitForSeconds(0.5))
  self:_ShowBingo(self.circle2IndexList, self.circle2PointIndexDic, eHeroCardRareType.SR)
  ;
  (coroutine.yield)(cs_WaitForSeconds(1))
  if self.scanPointNum == 0 then
    self:_OnShowEnd()
    return 
  end
  self:__ContinuePlayShow()
  ;
  (self.waveRingPool):HideAll()
  ;
  (self.showRingPool):HideAll()
  self:_ChangeRingMaskSize(3)
  self:_KillWaveTweens()
  self:_BalckBgTween(2370, 3230, 0.278, 0.388)
  self:_ShowQuality2BingoExit()
  while self.scanWaveEndNum < self.scanPointNum do
    (coroutine.yield)(nil)
  end
  self.mainCo = nil
  self:_OnShowEnd()
end

LotteryShowCtrl._ClearMainCo = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.mainCo ~= nil then
    (GR.StopCoroutine)(self.mainCo)
    self.mainCo = nil
  end
end

LotteryShowCtrl.__LoadRes = function(self)
  -- function num : 0_6 , upvalues : cs_ResLoader, _ENV, UINLtrShowPoint, UINLtrSPointBingo, UINLtrShowRing, UINLtrSWaveRing
  if self.__resLoaded then
    return false
  end
  self.resLoader = (cs_ResLoader.Create)()
  local path = PathConsts:GetLotteryModelPath("LotteryShow")
  ;
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
  ;
  (self.resLoader):LoadABAssetAsync(path, function(prefab)
    -- function num : 0_6_0 , upvalues : self, _ENV, UINLtrShowPoint, UINLtrSPointBingo, UINLtrShowRing, UINLtrSWaveRing
    if prefab == nil then
      return 
    end
    self.ltrShowGo = prefab:Instantiate()
    self.bind = {}
    ;
    (UIUtil.LuaUIBindingTable)(self.ltrShowGo, self.bind)
    ;
    (UIUtil.AddButtonListener)((self.bind).btn_start, self, self._OnClickStart)
    local codeActionBinding = ((self.bind).timeLine):FindComponent(eUnityComponentID.CodeActionBinding)
    codeActionBinding:RegisterAction("WaitStart", BindCallback(self, self.__OnWaitStart))
    codeActionBinding:RegisterAction("StartCamMove", BindCallback(self, self.__OnStartCamMove))
    codeActionBinding:RegisterAction("Quilaty1Stop", BindCallback(self, self.__OnQuilaty1Stop))
    codeActionBinding:RegisterAction("Quilaty2Stop", BindCallback(self, self.__OnQuilaty2Stop))
    codeActionBinding:RegisterAction("Quilaty3Stop", BindCallback(self, self.__OnQuilaty3Stop))
    ;
    ((self.bind).uI_LSPoint):SetActive(false)
    self.showPointPool = (UIItemPool.New)(UINLtrShowPoint, (self.bind).uI_LSPoint)
    ;
    ((self.bind).uI_LSPointBingo):SetActive(false)
    self.pointBingoPool = (UIItemPool.New)(UINLtrSPointBingo, (self.bind).uI_LSPointBingo)
    ;
    ((self.bind).imgRing):SetActive(false)
    self.showRingPool = (UIItemPool.New)(UINLtrShowRing, (self.bind).imgRing)
    ;
    ((self.bind).waveRing):SetActive(false)
    self.waveRingPool = (UIItemPool.New)(UINLtrSWaveRing, (self.bind).waveRing)
    self.__resLoaded = true
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    self:__OnShowStart()
  end
)
  return true
end

LotteryShowCtrl.__OnWaitStart = function(self)
  -- function num : 0_7 , upvalues : LotteryEnum
  self:__StopShowCo()
  self.waitStart = true
  ;
  (self.ltrCtrl):ChangeLotteryState((LotteryEnum.eLotteryState).WaitStartShow)
end

LotteryShowCtrl.__OnShowStart = function(self)
  -- function num : 0_8 , upvalues : _ENV, util
  self.waitStart = false
  ;
  (self.ltrShowGo):SetActive(true)
  ;
  (self.showPointPool):HideAll()
  ;
  (self.showRingPool):HideAll()
  ;
  (self.waveRingPool):HideAll()
  ;
  (self.pointBingoPool):HideAll()
  self:_SetBlackBgSize(0)
  self.scanWaveEndNum = 0
  ;
  ((self.bind).cM_vcam_1end):SetActive(false)
  ;
  (((self.bind).timeLine).gameObject):SetActive(true)
  ;
  ((self.bind).startRingDown):SetActive(false)
  UIManager:HideWindow(UIWindowTypeID.LotteryWindow)
  self:_ClearMainCo()
  self._circle1ScanComplete = false
  self.mainCo = (GR.StartCoroutine)((util.cs_generator)(self.__MainCoroutineFunc))
  self:__StopShowCo()
  self.__ltrShowCo = (TimelineUtil.Play)((self.bind).timeLine)
  self:PlayAllDOTween()
end

LotteryShowCtrl.__OnStartCamMove = function(self)
  -- function num : 0_9 , upvalues : LtrShowCfg, _ENV, LotteryEnum, cs_DOTween, cs_Ease
  local allCfgNum = #LtrShowCfg.CircleOnePoint
  local allNum = #self.showRareList + (math.random)(10, 15)
  if allCfgNum < allNum then
    error("LtrShowCfg.CircleOnePoint error")
    return 
  end
  self.maxRare = eHeroCardRareType.R
  local tempRIndexList = {}
  for k,rare in ipairs(self.showRareList) do
    if rare == eHeroCardRareType.R then
      (table.insert)(tempRIndexList, k)
    end
    if self.maxRare < rare then
      self.maxRare = rare
    end
  end
  local randomNum = 0
  local extraScanIndexDic = {}
  if self.poolType == (LotteryEnum.eLotteryPoolType).Paid and #self.showRareList == 10 then
    local count = (math.random)(0, randomNum)
    for i = 1, count do
      local index = (math.random)(1, #tempRIndexList)
      ;
      (table.remove)(tempRIndexList, index)
      extraScanIndexDic[index] = true
    end
  end
  do
    local tempIndexList = {}
    for i = 1, allCfgNum do
      (table.insert)(tempIndexList, i)
    end
    self.circle1IndexCfgBingoList = {}
    local indexList = {}
    for i = 1, allNum do
      local randomIndex = (math.random)(1, #tempIndexList)
      local posCfgIndex = tempIndexList[randomIndex]
      ;
      (table.remove)(tempIndexList, randomIndex)
      local rare = (self.showRareList)[i]
      local extraScan = extraScanIndexDic[i]
      local tarPosCfg = (LtrShowCfg.CircleOnePoint)[posCfgIndex]
      local tarPos = (Vector2.New)(tarPosCfg[1], tarPosCfg[2])
      local startPos = ((self.bind).uI_LSMainPoint).anchoredPosition
      local sqrMagnt = ((Vector2.New)(startPos.x - tarPos.x, startPos.y - tarPos.y)):SqrMagnitude()
      ;
      (table.insert)(indexList, {tarPos = tarPos, sqrMagnt = sqrMagnt, rare = rare, extraScan = extraScan})
    end
    ;
    (table.sort)(indexList, function(a, b)
    -- function num : 0_9_0
    do return a.sqrMagnt < b.sqrMagnt end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    self.indexList = indexList
    local pintIndex = 1
    self.circle1PointIndexDic = {}
    self.circle1IndexList = indexList
    for k,v in ipairs(indexList) do
      if v.extraScan or v.rare ~= nil and eHeroCardRareType.R < v.rare then
        (table.insert)(self.circle1IndexCfgBingoList, k)
      end
    end
    local rareColor = ((self.bind).rareColorList)[eHeroCardRareType.R]
    local waveRing1 = (self.waveRingPool):GetOne()
    waveRing1:InitLtrSWaveRing(Vector2.zero, rareColor)
    local showRing1 = (self.showRingPool):GetOne()
    showRing1:InitLtrShowRing(((self.bind).uI_LSMainPoint).anchoredPosition, rareColor)
    AudioManager:PlayAudioById(1045)
    local tweenFunc = function(x)
    -- function num : 0_9_1 , upvalues : showRing1, _ENV, indexList, pintIndex, self
    showRing1:SetLtrShowRingSize((Vector2.New)(x, x))
    if x > 1400 then
      showRing1:LtrShowRingFade()
    end
    local sqrMagnt = x / 2 * (x / 2)
    local indexCfg = indexList[pintIndex]
    while pintIndex <= #indexList and indexCfg.sqrMagnt <= sqrMagnt do
      local pointItem = (self.showPointPool):GetOne()
      local pos = indexCfg.tarPos
      pointItem:InitLtrShowPoint(pos, ((self.bind).uI_LSMainPoint).anchoredPosition, indexCfg.rare)
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self.circle1PointIndexDic)[pintIndex] = pointItem
      pintIndex = pintIndex + 1
      indexCfg = indexList[pintIndex]
    end
    do
      if x >= 720 then
        local size = (x - 720) / 780 * 0.155
        self:_SetBlackBgSize(size)
      end
    end
  end

    self.showRare1Tween = (((cs_DOTween.To)(function()
    -- function num : 0_9_2
    return 0
  end
, function(x)
    -- function num : 0_9_3 , upvalues : _ENV, tweenFunc
    local ok, err = xpcall(tweenFunc, debug.traceback, x)
    if not ok then
      error(err)
    end
  end
, 1500, 4)):SetEase(cs_Ease.OutSine)):OnComplete(function()
    -- function num : 0_9_4 , upvalues : self
    self._circle1ScanComplete = true
  end
)
    ;
    (table.insert)(self.tweenList, self.showRare1Tween)
  end
end

LotteryShowCtrl._ShowBingo = function(self, circleIndexList, circlePointIndexDic, curRare)
  -- function num : 0_10 , upvalues : _ENV
  (self.pointBingoPool):HideAll()
  self.scanPointNum = 0
  for k,v in ipairs(circleIndexList) do
    if v.rare ~= nil then
      local pointItem = circlePointIndexDic[k]
      if curRare < v.rare or v.extraScan then
        local pointBingo = (self.pointBingoPool):GetOne()
        pointBingo:InitLtrSPointBingo(v.tarPos)
        pointItem:SetLtrPointBingo(pointBingo)
        self.scanPointNum = self.scanPointNum + 1
      else
        do
          do
            if v.rare == curRare then
              pointItem:ShowLtrSPointFlare()
            end
            -- DECOMPILER ERROR at PC36: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC36: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC36: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC36: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC36: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

LotteryShowCtrl._ShowQuality1BingoExit = function(self)
  -- function num : 0_11 , upvalues : LtrShowCfg, _ENV, cs_WaitForSeconds
  local allCfgNum = #LtrShowCfg.CircleTwoPoint
  local allNum = self.scanPointNum + (math.random)(5, 10)
  if allCfgNum < allNum then
    error((string.format)("LtrShowCfg.CircleTwoPoint error, allNum:%s, allCfgNum:%S", allNum, allCfgNum))
    return 
  end
  local tempIndexList = {}
  for i = 1, allCfgNum do
    (table.insert)(tempIndexList, i)
  end
  local circle2IndexList = {}
  self.circle2IndexList = circle2IndexList
  self.circle2IndexCfgBingoList = {}
  local scanPointIndex = 1
  local randomIndexList = {}
  for i = 1, allNum do
    local index = (math.random)(1, #tempIndexList)
    local posCfgIndex = tempIndexList[index]
    ;
    (table.remove)(tempIndexList, index)
    local posCfg = (LtrShowCfg.CircleTwoPoint)[posCfgIndex]
    local tarPos = (Vector2.New)(posCfg[1], posCfg[2])
    local indexList = randomIndexList[scanPointIndex]
    local isFirst = false
    if indexList == nil then
      indexList = {}
      randomIndexList[scanPointIndex] = indexList
      isFirst = true
    end
    local circle1IndexCfg = (self.circle1IndexList)[(self.circle1IndexCfgBingoList)[scanPointIndex]]
    local startPos = circle1IndexCfg.tarPos
    local pointRare = nil
    if isFirst then
      pointRare = circle1IndexCfg.rare
    end
    local sqrMagnt = ((Vector2.New)(startPos.x - tarPos.x, startPos.y - tarPos.y)):SqrMagnitude()
    local cfg = {scanPointIndex = scanPointIndex, tarPos = tarPos, sqrMagnt = sqrMagnt, rare = pointRare}
    ;
    (table.insert)(indexList, cfg)
    if isFirst then
      (table.insert)(circle2IndexList, cfg)
      if eHeroCardRareType.SR < pointRare then
        (table.insert)(self.circle2IndexCfgBingoList, #circle2IndexList)
      end
    end
    scanPointIndex = scanPointIndex + 1
    if self.scanPointNum < scanPointIndex then
      scanPointIndex = 1
    end
  end
  for k,v in pairs(randomIndexList) do
    (table.sort)(v, function(a, b)
    -- function num : 0_11_0
    do return a.sqrMagnt < b.sqrMagnt end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
  scanPointIndex = 1
  self.circle2PointIndexDic = {}
  local isLastCircle = self.maxRare == eHeroCardRareType.SR
  for k,v in ipairs(self.circle1IndexCfgBingoList) do
    local pointItem = (self.circle1PointIndexDic)[v]
    local pointBingo = pointItem:GetLtrPointBingo()
    pointBingo:PlayLtrSPointBingoExit()
    ;
    (coroutine.yield)(cs_WaitForSeconds(0.5))
    local circle1IndexCfg = (self.circle1IndexList)[v]
    local rareColor = ((self.bind).rareColorList)[eHeroCardRareType.SR]
    local pointItem = (self.circle1PointIndexDic)[v]
    local indexList = randomIndexList[scanPointIndex]
    AudioManager:PlayAudioById(1046)
    self:_ShowScanWave(rareColor, pointItem, circle1IndexCfg.extraScan, indexList, isLastCircle)
    scanPointIndex = scanPointIndex + 1
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

LotteryShowCtrl._ShowScanWave = function(self, rareColor, pointItem, isExtra, indexList, isCircleLast)
  -- function num : 0_12 , upvalues : _ENV, cs_DOTween, cs_Ease
  local waveRingItem = (self.waveRingPool):GetOne()
  local fromItem = pointItem
  local centerPos = (pointItem.transform).anchoredPosition
  local pos = centerPos - ((self.bind).uI_LSMainPoint).anchoredPosition
  pos = pos * 1024 / 3230
  waveRingItem:InitLtrSWaveRing(pos, rareColor)
  local pointIndex = 1
  local ringItem = (self.showRingPool):GetOne()
  ringItem:InitLtrShowRing(centerPos, rareColor)
  local scanOk = false
  local tweenFunc = function(x)
    -- function num : 0_12_0 , upvalues : ringItem, _ENV, indexList, pointIndex, self, centerPos, fromItem, isCircleLast, scanOk
    ringItem:SetLtrShowRingSize((Vector2.New)(x, x))
    if x > 1500 then
      ringItem:LtrShowRingFade()
    end
    local sqrMagnt = x / 2 * (x / 2)
    local indexCfg = indexList[pointIndex]
    while pointIndex <= #indexList and indexCfg.sqrMagnt <= sqrMagnt do
      local pointItem = (self.showPointPool):GetOne()
      local pos = indexCfg.tarPos
      pointItem:InitLtrShowPoint(pos, centerPos, indexCfg.rare, fromItem)
      if indexCfg.rare ~= nil then
        if isCircleLast then
          pointItem:ShowLtrSPointFlare()
        end
        -- DECOMPILER ERROR at PC46: Confused about usage of register: R5 in 'UnsetPending'

        ;
        (self.circle2PointIndexDic)[indexCfg.scanPointIndex] = pointItem
        self.scanWaveEndNum = self.scanWaveEndNum + 1
        scanOk = true
      end
      pointIndex = pointIndex + 1
      indexCfg = indexList[pointIndex]
    end
  end

  self.showScanTween = (((cs_DOTween.To)(function()
    -- function num : 0_12_1
    return 0
  end
, function(x)
    -- function num : 0_12_2 , upvalues : _ENV, tweenFunc
    local ok, err = xpcall(tweenFunc, debug.traceback, x)
    if not ok then
      error(err)
    end
  end
, 2500, 6.67)):SetEase(cs_Ease.OutSine)):OnComplete(function()
    -- function num : 0_12_3 , upvalues : isExtra, pointItem, scanOk, self
    if isExtra then
      pointItem:ShowLtrSPointFlare()
    end
    if not scanOk then
      self.scanWaveEndNum = self.scanWaveEndNum + 1
    end
  end
)
  ;
  (table.insert)(self.tweenList, self.showScanTween)
end

LotteryShowCtrl._BalckBgTween = function(self, from, to, balckBgSizeFrom, balckBgSizeTo, delayTime)
  -- function num : 0_13 , upvalues : cs_DOTween, _ENV, cs_Ease
  if delayTime == nil then
    delayTime = 1.4
  end
  local tweenFunc = function(x)
    -- function num : 0_13_0 , upvalues : from, to, balckBgSizeTo, balckBgSizeFrom, self
    local size = (x - from) / (to - from) * (balckBgSizeTo - balckBgSizeFrom) + balckBgSizeFrom
    self:_SetBlackBgSize(size)
  end

  self._blackBgTween = (((cs_DOTween.To)(function()
    -- function num : 0_13_1 , upvalues : from
    return from
  end
, function(x)
    -- function num : 0_13_2 , upvalues : _ENV, tweenFunc
    local ok, err = xpcall(tweenFunc, debug.traceback, x)
    if not ok then
      error(err)
    end
  end
, to, 4)):SetEase(cs_Ease.OutSine)):SetDelay(delayTime)
  ;
  (table.insert)(self.tweenList, self._blackBgTween)
end

LotteryShowCtrl.__OnQuilaty1Stop = function(self)
  -- function num : 0_14
  self:__StopShowCo()
end

LotteryShowCtrl.__OnQuilaty2Stop = function(self)
  -- function num : 0_15
  self:__StopShowCo()
end

LotteryShowCtrl._ShowQuality2BingoExit = function(self)
  -- function num : 0_16 , upvalues : LtrShowCfg, _ENV, cs_WaitForSeconds
  self.scanWaveEndNum = 0
  local allCfgNum = #LtrShowCfg.CircleThreePoint
  local allNum = self.scanPointNum + (math.random)(5, 10)
  if allCfgNum < allNum then
    error((string.format)("LtrShowCfg.CircleThreePoint error, allNum:%s, allCfgNum:%S", allNum, allCfgNum))
    return 
  end
  local tempIndexList = {}
  for i = 1, allCfgNum do
    (table.insert)(tempIndexList, i)
  end
  local scanPointIndex = 1
  local randomIndexList = {}
  for i = 1, allNum do
    local index = (math.random)(1, #tempIndexList)
    local posCfgIndex = tempIndexList[index]
    ;
    (table.remove)(tempIndexList, index)
    local posCfg = (LtrShowCfg.CircleThreePoint)[posCfgIndex]
    local tarPos = (Vector2.New)(posCfg[1], posCfg[2])
    local indexList = randomIndexList[scanPointIndex]
    local isFirst = false
    if indexList == nil then
      indexList = {}
      randomIndexList[scanPointIndex] = indexList
      isFirst = true
    end
    local circle2IndexCfg = (self.circle2IndexList)[(self.circle2IndexCfgBingoList)[scanPointIndex]]
    local startPos = circle2IndexCfg.tarPos
    local pointRare = nil
    if isFirst then
      pointRare = circle2IndexCfg.rare
    end
    local sqrMagnt = ((Vector2.New)(startPos.x - tarPos.x, startPos.y - tarPos.y)):SqrMagnitude()
    local cfg = {index = index, scanPointIndex = scanPointIndex, tarPos = tarPos, sqrMagnt = sqrMagnt, rare = pointRare}
    ;
    (table.insert)(indexList, cfg)
    scanPointIndex = scanPointIndex + 1
    if self.scanPointNum < scanPointIndex then
      scanPointIndex = 1
    end
  end
  for k,v in pairs(randomIndexList) do
    (table.sort)(v, function(a, b)
    -- function num : 0_16_0
    do return a.sqrMagnt < b.sqrMagnt end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
  scanPointIndex = 1
  self.circle3PointIndexDic = {}
  for k,v in ipairs(self.circle2IndexCfgBingoList) do
    local pointItem = (self.circle2PointIndexDic)[v]
    local pointBingo = pointItem:GetLtrPointBingo()
    pointBingo:PlayLtrSPointBingoExit()
    ;
    (coroutine.yield)(cs_WaitForSeconds(0.5))
    local rareColor = ((self.bind).rareColorList)[eHeroCardRareType.SSR]
    local pointItem = (self.circle2PointIndexDic)[v]
    local indexList = randomIndexList[scanPointIndex]
    AudioManager:PlayAudioById(1047)
    self:_ShowScanWave(rareColor, pointItem, false, indexList, true)
    scanPointIndex = scanPointIndex + 1
  end
end

LotteryShowCtrl.__OnQuilaty3Stop = function(self)
  -- function num : 0_17
  self:__StopShowCo()
end

LotteryShowCtrl._OnShowEnd = function(self)
  -- function num : 0_18
  self:_ClearMainCo()
  self:__CamReturn()
end

LotteryShowCtrl.__CamReturn = function(self)
  -- function num : 0_19 , upvalues : _ENV
  ((self.bind).cM_vcam_1end):SetActive(true)
  ;
  (((self.bind).timeLine).gameObject):SetActive(false)
  self.backTimelineCo = (TimelineUtil.Play)((self.bind).timeLine_Back, self.__OnCamReturnEnd)
end

LotteryShowCtrl.__StopBackTimelineCo = function(self)
  -- function num : 0_20 , upvalues : _ENV
  if self.backTimelineCo ~= nil then
    (TimelineUtil.StopTlCo)(self.backTimelineCo)
    self.backTimelineCo = nil
  end
end

LotteryShowCtrl.__CamReturnEnd = function(self)
  -- function num : 0_21
  (self.ltrCtrl):LtrShowEnd()
end

LotteryShowCtrl.__ContinuePlayShow = function(self)
  -- function num : 0_22 , upvalues : _ENV
  self:__StopShowCo()
  self.__ltrShowCo = (TimelineUtil.Play)((self.bind).timeLine, nil, true)
end

LotteryShowCtrl.__StopShowCo = function(self)
  -- function num : 0_23 , upvalues : _ENV
  if self.__ltrShowCo ~= nil then
    (TimelineUtil.StopTlCo)(self.__ltrShowCo)
    self.__ltrShowCo = nil
  end
end

LotteryShowCtrl._KillWaveTweens = function(self)
  -- function num : 0_24 , upvalues : _ENV
  while #self.tweenList > 0 do
    local tween = (table.remove)(self.tweenList)
    if tween ~= nil then
      tween:Kill()
    end
  end
end

LotteryShowCtrl.SkipShow = function(self)
  -- function num : 0_25
  self:__StopShowCo()
  self:_ClearMainCo()
  self:__StopBackTimelineCo()
  self:_CloseAllAudio()
  self:_KillWaveTweens()
  for i = 0, (self.allTweensAnimation).Length - 1 do
    local tween = (self.allTweensAnimation)[i]
    tween:DOPause()
  end
  ;
  (self.ltrCtrl):LtrShowEnd(true)
end

LotteryShowCtrl._SetBlackBgSize = function(self, size)
  -- function num : 0_26 , upvalues : cs_Material
  if self.blackBgMat == nil then
    self.blackBgMat = cs_Material(((self.bind).blackBg).material)
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.bind).blackBg).material = self.blackBgMat
  end
  ;
  (self.blackBgMat):SetFloat("_Waiquan", size)
end

LotteryShowCtrl.HideLtrShow = function(self)
  -- function num : 0_27
  (self.ltrShowGo):SetActive(false)
end

LotteryShowCtrl._ChangeRingMaskSize = function(self, circleId)
  -- function num : 0_28 , upvalues : cs_Material, LtrShowCfg
  if self.ringMaskMat == nil then
    self.ringMaskMat = cs_Material(((self.bind).img_RingMask).material)
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.bind).img_RingMask).material = self.ringMaskMat
  end
  local cfg = (LtrShowCfg.CircleRingMask)[circleId]
  ;
  (self.ringMaskMat):SetFloat("_DAXIAO", cfg.Size)
  ;
  (self.ringMaskMat):SetFloat("_Waiquan", cfg.OutSize)
end

LotteryShowCtrl._CloseAllAudio = function(self)
  -- function num : 0_29 , upvalues : _ENV
  AudioManager:StopSource(eAudioSourceType.SfxSource)
end

LotteryShowCtrl.OnDelete = function(self)
  -- function num : 0_30 , upvalues : _ENV
  self:__StopShowCo()
  self:_ClearMainCo()
  self:__StopBackTimelineCo()
  self:_CloseAllAudio()
  DestroyUnityObject(self.ltrShowGo)
  DestroyUnityObject(self.blackBgMat)
  DestroyUnityObject(self.ringMaskMat)
  if self.resLoader ~= nil then
    (self.resLoader):Put2Pool()
    self.resLoader = nil
  end
  if self.showPointPool ~= nil then
    (self.showPointPool):DeleteAll()
  end
  if self.showRingPool ~= nil then
    (self.showRingPool):DeleteAll()
  end
  if self.waveRingPool ~= nil then
    (self.waveRingPool):DeleteAll()
  end
  if self.pointBingoPool ~= nil then
    (self.pointBingoPool):DeleteAll()
  end
  self:_KillWaveTweens()
end

return LotteryShowCtrl


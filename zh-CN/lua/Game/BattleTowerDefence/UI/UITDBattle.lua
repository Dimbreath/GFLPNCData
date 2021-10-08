local UITDBattle = class("TDBattle", UIBaseWindow)
local base = UIBaseWindow
local CS_BattleManager = (CS.BattleManager).Instance
local UINTDBattleHeroHeadItem = require("Game.BattleTowerDefence.UI.UINTDBattleHeroHeadItem")
local UINTDLevelView = require("Game.BattleTowerDefence.UI.UINTDLevelView")
local UINTDBattleNextBtn = require("Game.BattleTowerDefence.UI.UINTDBattleNextBtn")
UITDBattle.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINTDBattleHeroHeadItem, UINTDLevelView, UINTDBattleNextBtn
  (UIUtil.AddButtonListener)((self.ui).btn_EpStore, self, self.__OnClickResidentStore)
  ;
  (((self.ui).img_cancle).gameObject):SetActive(false)
  ;
  ((self.ui).heroHeadItem):SetActive(false)
  self.headPool = (UIItemPool.New)(UINTDBattleHeroHeadItem, (self.ui).heroHeadItem)
  self.__OnDragHeroTower = BindCallback(self, self.OnDragHeroTower)
  self.__OnClickHeroHead = BindCallback(self, self.OnClickHeroHead)
  self.__CountDown = BindCallback(self, self.CountDown)
  self.__ShowCD = BindCallback(self, self.ShowCD)
  MsgCenter:AddListener(eMsgEventId.TDNextCountDown, self.__ShowCD)
  self.__ShowNextClick = BindCallback(self, self.ShowNextClick)
  MsgCenter:AddListener(eMsgEventId.TDNextClickActive, self.__ShowNextClick)
  self.__updateMoney = BindCallback(self, self.__UpdateExpMoney)
  MsgCenter:AddListener(eMsgEventId.EpMoneyChange, self.__updateMoney)
  self.__openBulletTime = BindCallback(self, self.__OpenBulletTime)
  MsgCenter:AddListener(eMsgEventId.TDOpenBulletTime, self.__openBulletTime)
  self.__closeBulletTime = BindCallback(self, self.__CloseBulletTime)
  MsgCenter:AddListener(eMsgEventId.TDCloseBulletTime, self.__closeBulletTime)
  self.__switchToTopView = BindCallback(self, self.__SwitchToTopView)
  MsgCenter:AddListener(eMsgEventId.TDOpenTopView, self.__switchToTopView)
  self.__switchToNormalView = BindCallback(self, self.__SwitchToNormalView)
  MsgCenter:AddListener(eMsgEventId.TDCloseTopView, self.__switchToNormalView)
  self.__displayOtherUI = BindCallback(self, self.__DisplayOtherUI)
  MsgCenter:AddListener(eMsgEventId.TDDisplayOtherUI, self.__displayOtherUI)
  self.showNextWave = false
  self.headers = {}
  self.__OnNextWave = BindCallback(self, self.OnNextWave)
  MsgCenter:AddListener(eMsgEventId.TDNextWava, self.__OnNextWave)
  self.__OnMonsterBorn = BindCallback(self, self.OnMonsterBorn)
  MsgCenter:AddListener(eMsgEventId.TDMonsterBorn, self.__OnMonsterBorn)
  self.__OnReceiveMpSpeed = BindCallback(self, self.OnReceiveMpSpeed)
  MsgCenter:AddListener(eMsgEventId.TDMPAddSpeed, self.__OnReceiveMpSpeed)
  self.tdLevelView = (UINTDLevelView.New)()
  ;
  (self.tdLevelView):Init((self.ui).uINTDLevel)
  self.tdNextWaveBtn = (UINTDBattleNextBtn.New)()
  ;
  (self.tdNextWaveBtn):Init((self.ui).btn_BattleNext)
  ;
  (self.tdNextWaveBtn):SetNextWaveCallback(BindCallback(self, self.__OnClickNextWave))
  self._positionTokenInfo = (((self.ui).tokenInfo).transform).localPosition
  self._positionWaitHero = (((self.ui).waitHeroList).transform).localPosition
  self._positionEpStore = (((self.ui).btn_EpStore).transform).localPosition
end

UITDBattle.InitTDBattle = function(self, waitToCasteTowerEntities, theBattleTowerCount, csCallNextWave, csGetTowerMp, csDragWaitTower, csRetreatTower)
  -- function num : 0_1 , upvalues : _ENV
  if waitToCasteTowerEntities == nil then
    return 
  end
  ;
  (self.headPool):HideAll()
  for k,v in pairs(waitToCasteTowerEntities) do
    if v ~= nil then
      local item = (self.headPool):GetOne()
      item:OnInitHeroItem(v, v:GetTDRoleCastCost(), self.__OnDragHeroTower, self.__OnClickHeroHead)
      -- DECOMPILER ERROR at PC23: Confused about usage of register: R13 in 'UnsetPending'

      ;
      (self.headers)[v] = item
    end
  end
  self.__callNextWaveAction = csCallNextWave
  self.__getTowerMpFunction = csGetTowerMp
  self.__dragWaitTower = csDragWaitTower
  self.__retreatTower = csRetreatTower
  ;
  (self.tdNextWaveBtn):Hide()
  ;
  (((self.ui).cDText).gameObject):SetActive(false)
  ;
  (((self.ui).btn_EpStore).gameObject):SetActive(true)
  self:__UpdateExpMoney()
  local maxCount = 0
  local dynPlayer = (BattleUtil.GetCurDynPlayer)()
  if dynPlayer ~= nil then
    maxCount = dynPlayer:GetEnterFiledNum()
  end
  -- DECOMPILER ERROR at PC64: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).tex_Deploy).text = (string.format)("%d/%d", maxCount - theBattleTowerCount, maxCount)
  ;
  ((self.ui).tDInfo):SetActive(false)
  ;
  ((self.ui).battleNum):SetActive(true)
  local opDetail = dynPlayer:GetOperatorDetail()
  local x, y = (BattleUtil.Pos2XYCoord)(opDetail.curPostion)
  local maxDepth = ((ExplorationManager.epCtrl).mapData).maxMapColNumber
  ;
  ((self.ui).tex_Num):SetIndex(0, tostring(y), tostring(maxDepth))
  ;
  (self.tdLevelView):InitTDLevelView(maxDepth, y)
  -- DECOMPILER ERROR at PC103: Confused about usage of register: R13 in 'UnsetPending'

  ;
  ((self.ui).img_TokenBar).fillAmount = 0
  self._mpReplySpeed = 0
  self:LeftPositionSet(false)
end

UITDBattle.GetBtnCancleUI = function(self)
  -- function num : 0_2
  return (self.ui).img_cancle
end

UITDBattle.InjectTimeScaleAction = function(self, changeTimeScale, getLastTimeScale)
  -- function num : 0_3
  self.__changeTimeScale = changeTimeScale
  self.__getLastTimeScale = getLastTimeScale
end

UITDBattle.__UpdateExpMoney = function(self, money)
  -- function num : 0_4
  if money == nil then
    money = self:__GetCurCoin()
  end
  self:UpdateTowerMp(money)
end

UITDBattle.OnDragHeroTower = function(self, battleHeroHead, eventData)
  -- function num : 0_5 , upvalues : _ENV
  local characterWindow = UIManager:GetWindow(UIWindowTypeID.TDCharactorInfo)
  if characterWindow ~= nil and characterWindow.active then
    characterWindow:Hide()
  end
  local roleEntity = battleHeroHead.roleEntity
  if roleEntity ~= nil and roleEntity:IsAbleToCastInBattle() then
    (((self.ui).img_cancle).gameObject):SetActive(true)
    self:__DisplayOtherUI(false)
    self:__SwitchToTopView()
    self:__OpenBulletTime()
    if self.__dragWaitTower ~= nil then
      (self.__dragWaitTower)(roleEntity)
    end
  end
end

UITDBattle.OnTowerPlacement = function(self, role, isOn, towerCasteCost, theBattleTowerCount)
  -- function num : 0_6 , upvalues : _ENV
  if role == nil then
    return 
  end
  do
    if isOn and isOn then
      local headItem = (self.headers)[role]
      if headItem ~= nil then
        (self.headPool):HideOne(headItem)
        -- DECOMPILER ERROR at PC16: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (self.headers)[role] = nil
      end
    end
    self:ClearCurInputTile(role)
    do
      local item = (self.headPool):GetOne()
      item:OnInitHeroItem(role, towerCasteCost, self.__OnDragHeroTower, self.__OnClickHeroHead)
      item:UpdateCostState(self:GetTowerMp())
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R6 in 'UnsetPending'

      if (self.headers)[role] == nil then
        (self.headers)[role] = item
      end
      local maxCount = 0
      local dynPlayer = (BattleUtil.GetCurDynPlayer)()
      if dynPlayer ~= nil then
        maxCount = dynPlayer:GetEnterFiledNum()
      end
      -- DECOMPILER ERROR at PC57: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self.ui).tex_Deploy).text = (string.format)("%d/%d", maxCount - theBattleTowerCount, maxCount)
    end
  end
end

UITDBattle.ClearCurInputTile = function(self, role)
  -- function num : 0_7 , upvalues : _ENV
  if role.hp > 0 then
    return 
  end
  local csBattleCtrl = ((CS.BattleManager).Instance).CurBattleController
  if csBattleCtrl == nil then
    return 
  end
  local battleSkillInputCtrl = (csBattleCtrl.PlayerController).battleSkillInputController
  if battleSkillInputCtrl == nil or not battleSkillInputCtrl:IsActive() or battleSkillInputCtrl.inputRole == nil or battleSkillInputCtrl.inputRole ~= role then
    return 
  end
  if battleSkillInputCtrl.cancleSelect ~= nil then
    (battleSkillInputCtrl.cancleSelect)()
  end
  ;
  ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(705))
end

UITDBattle.EndDragMode = function(self)
  -- function num : 0_8
  (((self.ui).img_cancle).gameObject):SetActive(false)
  self:__DisplayOtherUI(true)
  self:__CloseBulletTime()
  self:__SwitchToNormalView()
end

UITDBattle.OnActiveCancleBtn = function(self)
  -- function num : 0_9
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).img_cancle).color = (self.ui).highlightColor
end

UITDBattle.OnDisActiveCancleBtn = function(self)
  -- function num : 0_10
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).img_cancle).color = (self.ui).normalColor
end

UITDBattle.ShowCD = function(self, frameCount)
  -- function num : 0_11 , upvalues : _ENV
  if frameCount <= 0 then
    self._secCount = 0
    ;
    (((self.ui).cDText).gameObject):SetActive(false)
    return 
  end
  self._secCount = (BattleUtil.FrameToTime)(frameCount)
  if self.timer == nil then
    self.timer = TimerManager:StartTimer(1, self.__CountDown, nil, false, false, false)
  end
  ;
  (((self.ui).cDText).gameObject):SetActive(true)
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).cDText).text = tostring((math.floor)(self._secCount))
end

UITDBattle.OnUpdateHeroCd = function(self)
  -- function num : 0_12 , upvalues : _ENV
  for i,headItem in ipairs((self.headPool).listItem) do
    headItem:UpdateCd()
  end
end

UITDBattle.CountDown = function(self)
  -- function num : 0_13 , upvalues : _ENV
  self._secCount = self._secCount - 1
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  if self._secCount > 0 then
    ((self.ui).cDText).text = tostring((math.floor)(self._secCount))
  else
    ;
    (((self.ui).cDText).gameObject):SetActive(false)
  end
end

UITDBattle.UpdateTowerMp = function(self, mp)
  -- function num : 0_14 , upvalues : _ENV, CS_BattleManager
  if self._lastMp == mp then
    return 
  end
  self._lastMp = mp
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Token).text = tostring(mp)
  for _,headItem in ipairs((self.headPool).listItem) do
    headItem:UpdateCostState(mp)
  end
  local playerCtrl = CS_BattleManager:GetBattlePlayerController()
  if self._mpReplySpeed or playerCtrl == nil or 0 > 0 then
    self._mpReplyOriTime = Time.time
    if self.mpAddTimerId == nil then
      self.mpAddTimerId = TimerManager:StartTimer(1, self.OnTimerMpForecastProcess, self, false, true, false)
    end
    self:OnTimerMpForecastProcess()
  end
end

UITDBattle.OnReceiveMpSpeed = function(self, mpSpeed)
  -- function num : 0_15 , upvalues : _ENV
  self._mpReplySpeed = mpSpeed / 1000 / (ConfigData.game_config).mpGrowInterval * BattleUtil.LogicFrameCount
end

UITDBattle.__GetCurCoin = function(self)
  -- function num : 0_16 , upvalues : _ENV
  local dynPlayer = (BattleUtil.GetCurDynPlayer)()
  if dynPlayer == nil then
    return 0
  end
  return dynPlayer:GetMoneyCount()
end

UITDBattle.ShowNextClick = function(self, flag, displayCost, intervalArg)
  -- function num : 0_17 , upvalues : _ENV
  if self.updateNextWaveCostTimerId ~= nil and self.updateNextWaveCostTimerId > 0 then
    TimerManager:StopTimer(self.updateNextWaveCostTimerId)
    self.updateNextWaveCostTimerId = 0
  end
  ;
  (((self.ui).btn_BattleNext).gameObject):SetActive(flag)
  self.showNextWave = flag
  if flag then
    (self.tdNextWaveBtn):Show()
    self.curNextWaveDisplayCost = displayCost
    ;
    (self.tdNextWaveBtn):RefreshNextBtnState(self._curWave, self._totalWave, displayCost)
    self.updateNextWaveCostTimerId = TimerManager:StartTimer(1, (BindCallback(self, self.UpdateNextWaveCostText, intervalArg)), nil, false, false, false)
  else
    ;
    (self.tdNextWaveBtn):Hide()
  end
end

UITDBattle.UpdateNextWaveCostText = function(self, intervalArg)
  -- function num : 0_18 , upvalues : _ENV
  self.curNextWaveDisplayCost = self.curNextWaveDisplayCost - BattleUtil.LogicFrameCount * intervalArg // 1000
  ;
  (self.tdNextWaveBtn):RefreshRewardCount(self.curNextWaveDisplayCost)
end

UITDBattle.__OnClickNextWave = function(self)
  -- function num : 0_19
  (((self.ui).cDText).gameObject):SetActive(false)
  if self.__callNextWaveAction ~= nil then
    (self.__callNextWaveAction)()
  end
end

UITDBattle.__OnClickResidentStore = function(self)
  -- function num : 0_20 , upvalues : _ENV
  if not ExplorationManager:IsInExploration() then
    return 
  end
  ;
  (ExplorationManager.epCtrl):OpenResidentStore()
end

UITDBattle.GetTowerMp = function(self)
  -- function num : 0_21
  local mp = 0
  if self.__getTowerMpFunction ~= nil then
    mp = (self.__getTowerMpFunction)()
  end
  return mp
end

UITDBattle.OnTdBattleStart = function(self)
  -- function num : 0_22 , upvalues : _ENV
  (((self.ui).btn_EpStore).gameObject):SetActive(false)
  ;
  ((self.ui).tDInfo):SetActive(true)
  ;
  ((self.ui).battleNum):SetActive(false)
  local dungeonInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonInfoWin ~= nil then
    dungeonInfoWin:ShowTopInfo(false)
  end
  self:LeftPositionSet(true)
end

UITDBattle.LeftPositionSet = function(self, isInBattle)
  -- function num : 0_23
  (((self.ui).tokenInfo).transform):DOKill(true)
  ;
  (((self.ui).waitHeroList).transform):DOKill(true)
  ;
  (((self.ui).btn_EpStore).transform):DOKill(true)
  if isInBattle then
    (((self.ui).tokenInfo).transform):DOLocalMove(self._positionTokenInfo, 0.5)
    ;
    (((self.ui).waitHeroList).transform):DOLocalMove(self._positionWaitHero, 0.5)
    ;
    (((self.ui).btn_EpStore).transform):DOLocalMove(self._positionEpStore, 0.5)
  else
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self.ui).tokenInfo).transform).localPosition = self._positionTokenInfo + (self.ui).pos_waitLeftOffset
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self.ui).waitHeroList).transform).localPosition = self._positionWaitHero + (self.ui).pos_waitLeftOffset
    -- DECOMPILER ERROR at PC65: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self.ui).btn_EpStore).transform).localPosition = self._positionEpStore + (self.ui).pos_waitLeftOffset
  end
end

UITDBattle.OnBattleEnd = function(self)
  -- function num : 0_24 , upvalues : _ENV
  self:OnTowerInfoHide()
  if self.mpAddTimerId ~= nil then
    TimerManager:StopTimer(self.mpAddTimerId)
    self.mpAddTimerId = nil
  end
  local dungeonInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonInfoWin ~= nil then
    dungeonInfoWin:ShowTopInfo(true)
  end
end

UITDBattle.OnTowerInfoHide = function(self)
  -- function num : 0_25 , upvalues : _ENV
  local tdTowerInfo = UIManager:GetWindow(UIWindowTypeID.TDCharactorInfo)
  if tdTowerInfo ~= nil then
    tdTowerInfo:Hide()
  end
end

UITDBattle.OnTowerInfoShow = function(self, hero, worldPos)
  -- function num : 0_26 , upvalues : _ENV
  local tdInfoUI = UIManager:GetWindow(UIWindowTypeID.TDCharactorInfo)
  if tdInfoUI == nil then
    tdInfoUI = UIManager:ShowWindow(UIWindowTypeID.TDCharactorInfo)
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (tdInfoUI.transform).sizeDelta = (Vector2.New)(100, 100)
  else
    tdInfoUI:Show()
  end
  tdInfoUI:InitCharactor(hero, BindCallback(self, self.OnRoleRetreat))
  local uiCamera = UIManager.UICamera
  local mainCamera = UIManager:GetMainCamera()
  local pos = UIManager:World2UIPosition(worldPos, (tdInfoUI.transform).parent, uiCamera, mainCamera)
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((tdInfoUI.gameObject).transform).localPosition = (Vector3.New)(pos.x, pos.y, 0)
end

UITDBattle.OnRoleRetreat = function(self, characterEntity)
  -- function num : 0_27
  if self.__retreatTower ~= nil then
    (self.__retreatTower)(characterEntity)
  end
end

UITDBattle.__DisplayOtherUI = function(self, active)
  -- function num : 0_28
  if active then
    self:__ShowOtherUI()
  else
    self:__HideOtherUI()
  end
end

UITDBattle.__HideOtherUI = function(self)
  -- function num : 0_29 , upvalues : _ENV
  if self.showNextWave then
    (self.tdNextWaveBtn):Hide()
  end
  ;
  ((self.ui).waitHeroList):SetActive(false)
  ;
  ((self.ui).tokenInfo):SetActive(false)
  local battleSkillModule = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if battleSkillModule ~= nil and battleSkillModule.active then
    battleSkillModule:Hide(true)
  end
  local UIBattleWin = UIManager:GetWindow(UIWindowTypeID.Battle)
  if UIBattleWin ~= nil and UIBattleWin.active then
    UIBattleWin:Hide()
  end
end

UITDBattle.__ShowOtherUI = function(self)
  -- function num : 0_30 , upvalues : _ENV
  if self.showNextWave then
    (self.tdNextWaveBtn):Show()
  end
  ;
  ((self.ui).waitHeroList):SetActive(true)
  ;
  ((self.ui).tokenInfo):SetActive(true)
  local battleSkillModule = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if battleSkillModule ~= nil and not battleSkillModule.active then
    battleSkillModule:Show(true)
  end
  local UIBattleWin = UIManager:GetWindow(UIWindowTypeID.Battle)
  if UIBattleWin ~= nil and not UIBattleWin.active then
    UIBattleWin:Show()
  end
end

UITDBattle.OnClickHeroHead = function(self, roleEntity)
  -- function num : 0_31 , upvalues : _ENV
  local dungeonStateWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonStateWindow ~= nil then
    self:__OpenBulletTime(true)
    dungeonStateWindow:RegisterHeroListCloseCallBack(function()
    -- function num : 0_31_0 , upvalues : dungeonStateWindow, self
    dungeonStateWindow:CancleHeroListCloseCallBack()
    self:__CloseBulletTime()
  end
)
    dungeonStateWindow:OnHeroCoordChanged()
    dungeonStateWindow:ShowHero(roleEntity.character)
  end
end

UITDBattle.OnNextWave = function(self, curWave, totalWave, remainEmptyCount)
  -- function num : 0_32 , upvalues : _ENV
  ((self.ui).tex_Enemy):SetIndex(0, "0", tostring(remainEmptyCount))
  self._waveEmptyCount = remainEmptyCount
  self._curWave = curWave
  self._totalWave = totalWave
end

UITDBattle.OnMonsterBorn = function(self, remainEmptyCount)
  -- function num : 0_33 , upvalues : _ENV
  ((self.ui).tex_Enemy):SetIndex(0, tostring(self._waveEmptyCount - remainEmptyCount), self._waveEmptyCount)
end

UITDBattle.OnTimerMpForecastProcess = function(self)
  -- function num : 0_34 , upvalues : _ENV
  local diff = Time.time - self._mpReplyOriTime
  local process = (math.clamp)(diff * self._mpReplySpeed, 0, 1)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_TokenBar).fillAmount = process
end

UITDBattle.__OpenBulletTime = function(self, isPause)
  -- function num : 0_35
  self:__RecordTimeScale()
  self:__SetTimeScaleTemply(isPause)
end

UITDBattle.__CloseBulletTime = function(self)
  -- function num : 0_36 , upvalues : _ENV
  if self.curTimeScale ~= (Time.unity_time).timeScale then
    return 
  end
  self:__RecoverTimeScale()
end

UITDBattle.__RecordTimeScale = function(self)
  -- function num : 0_37 , upvalues : _ENV
  self.lastRecordTimeScale = (Time.unity_time).timeScale
end

UITDBattle.__SetTimeScaleTemply = function(self, isPause)
  -- function num : 0_38 , upvalues : _ENV
  if not isPause or not 0 then
    local targetScale = (ConfigData.game_config).bulletTime
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (Time.unity_time).timeScale = targetScale
  self.curTimeScale = (Time.unity_time).timeScale
end

UITDBattle.__RecoverTimeScale = function(self)
  -- function num : 0_39 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  (Time.unity_time).timeScale = self.lastRecordTimeScale
end

UITDBattle.__GetTopViewTimeLine = function(self)
  -- function num : 0_40 , upvalues : _ENV
  return ((CS.CameraController).Instance).SwitchToTopViewTimeLine
end

UITDBattle.__SwitchToTopView = function(self)
  -- function num : 0_41 , upvalues : _ENV
  if self.ToTopViewing then
    return 
  end
  if self.timeLinePlayCoroutine ~= nil then
    (TimelineUtil.StopTlCo)(self.timeLinePlayCoroutine)
    self.timeLinePlayCoroutine = nil
  end
  if not self.switchToTopViewTimeLine then
    self.switchToTopViewTimeLine = self:__GetTopViewTimeLine()
    if self.switchToTopViewTimeLine ~= nil then
      self.timeLinePlayCoroutine = (TimelineUtil.Play)(self.switchToTopViewTimeLine, nil, false, true, true)
    end
    self.ToTopViewing = true
  end
end

UITDBattle.__SwitchToNormalView = function(self, withoutAnim)
  -- function num : 0_42 , upvalues : _ENV
  if not self.ToTopViewing then
    return 
  end
  if self.timeLinePlayCoroutine ~= nil then
    (TimelineUtil.StopTlCo)(self.timeLinePlayCoroutine)
    self.timeLinePlayCoroutine = nil
  end
  if not self.switchToTopViewTimeLine then
    self.switchToTopViewTimeLine = self:__GetTopViewTimeLine()
    if self.switchToTopViewTimeLine ~= nil then
      if not withoutAnim then
        self.timeLinePlayCoroutine = (TimelineUtil.Rewind)(self.switchToTopViewTimeLine, nil, nil, true, true)
      else
        -- DECOMPILER ERROR at PC33: Confused about usage of register: R2 in 'UnsetPending'

        ;
        (self.switchToTopViewTimeLine).time = 0
        ;
        (self.switchToTopViewTimeLine):Evaluate()
      end
    end
    self.ToTopViewing = false
  end
end

UITDBattle.OnDelete = function(self)
  -- function num : 0_43 , upvalues : _ENV, base
  self:__SwitchToNormalView(true)
  if self.timeLinePlayCoroutine ~= nil then
    (TimelineUtil.StopTlCo)(self.timeLinePlayCoroutine)
    self.timeLinePlayCoroutine = nil
  end
  self.switchToTopViewTimeLine = nil
  if self.updateNextWaveCostTimerId ~= nil and self.updateNextWaveCostTimerId > 0 then
    TimerManager:StopTimer(self.updateNextWaveCostTimerId)
  end
  self.__callNextWaveAction = nil
  self.__getTowerMpFunction = nil
  self.__retreatTower = nil
  self.__dragWaitTower = nil
  if self.timer ~= nil and self.timer > 0 then
    TimerManager:StopTimer(self.timer)
    self.timer = nil
  end
  if self.mpAddTimerId ~= nil then
    TimerManager:StopTimer(self.mpAddTimerId)
    self.mpAddTimerId = nil
  end
  self.headers = nil
  for _,headItem in ipairs((self.headPool).listItem) do
    headItem:OnDelete()
  end
  MsgCenter:RemoveListener(eMsgEventId.TDNextCountDown, self.__ShowCD)
  MsgCenter:RemoveListener(eMsgEventId.TDNextClickActive, self.__ShowNextClick)
  MsgCenter:RemoveListener(eMsgEventId.EpMoneyChange, self.__updateMoney)
  MsgCenter:RemoveListener(eMsgEventId.TDOpenBulletTime, self.__openBulletTime)
  MsgCenter:RemoveListener(eMsgEventId.TDCloseBulletTime, self.__closeBulletTime)
  MsgCenter:RemoveListener(eMsgEventId.TDOpenTopView, self.__switchToTopView)
  MsgCenter:RemoveListener(eMsgEventId.TDCloseTopView, self.__switchToNormalView)
  MsgCenter:RemoveListener(eMsgEventId.TDDisplayOtherUI, self.__displayOtherUI)
  MsgCenter:RemoveListener(eMsgEventId.TDNextWava, self.__OnNextWave)
  MsgCenter:RemoveListener(eMsgEventId.TDMonsterBorn, self.__OnMonsterBorn)
  MsgCenter:RemoveListener(eMsgEventId.TDMPAddSpeed, self.__OnReceiveMpSpeed)
  ;
  (base.OnDelete)(self)
end

return UITDBattle


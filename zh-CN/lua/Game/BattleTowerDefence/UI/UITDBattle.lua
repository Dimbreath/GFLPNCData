local UITDBattle = class("TDBattle", UIBaseWindow)
local base = UIBaseWindow
local UINTDBattleHeroHeadItem = require("Game.BattleTowerDefence.UI.UINTDBattleHeroHeadItem")
UITDBattle.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINTDBattleHeroHeadItem
  (UIUtil.AddButtonListener)((self.ui).btn_EpStore, self, self.__OnClickResidentStore)
  ;
  (((self.ui).img_cancle).gameObject):SetActive(false)
  ;
  ((self.ui).heroHeadItem):SetActive(false)
  self.headPool = (UIItemPool.New)(UINTDBattleHeroHeadItem, (self.ui).heroHeadItem)
  self.__OnDragHeroTower = BindCallback(self, self.OnDragHeroTower)
  self.__CountDown = BindCallback(self, self.CountDown)
  self.__ShowCD = BindCallback(self, self.ShowCD)
  MsgCenter:AddListener(eMsgEventId.TDNextCountDown, self.__ShowCD)
  self.__ShowNextClick = BindCallback(self, self.ShowNextClick)
  MsgCenter:AddListener(eMsgEventId.TDNextClickActive, self.__ShowNextClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_BattleNext, self, self.__OnClickNextWave)
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
      item:OnInitHeroItem(v, v:GetTDRoleCastCost(), self.__OnDragHeroTower)
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R13 in 'UnsetPending'

      ;
      (self.headers)[v] = item
    end
  end
  self.__callNextWaveAction = csCallNextWave
  self.__getTowerMpFunction = csGetTowerMp
  self.__dragWaitTower = csDragWaitTower
  self.__retreatTower = csRetreatTower
  ;
  (((self.ui).btn_BattleNext).gameObject):SetActive(false)
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
  -- DECOMPILER ERROR at PC66: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).tex_Deploy).text = (string.format)("%d/%d", maxCount - theBattleTowerCount, maxCount)
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

UITDBattle.__UpdateExpMoney = function(self)
  -- function num : 0_4
  local money = self:__GetCurCoin()
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
    do
      local item = (self.headPool):GetOne()
      item:OnInitHeroItem(role, towerCasteCost, self.__OnDragHeroTower)
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R6 in 'UnsetPending'

      if (self.headers)[role] == nil then
        (self.headers)[role] = item
      end
      local maxCount = 0
      local dynPlayer = (BattleUtil.GetCurDynPlayer)()
      if dynPlayer ~= nil then
        maxCount = dynPlayer:GetEnterFiledNum()
      end
      -- DECOMPILER ERROR at PC49: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self.ui).tex_Deploy).text = (string.format)("%d/%d", maxCount - theBattleTowerCount, maxCount)
    end
  end
end

UITDBattle.EndDragMode = function(self)
  -- function num : 0_7
  (((self.ui).img_cancle).gameObject):SetActive(false)
  self:__DisplayOtherUI(true)
  self:__CloseBulletTime()
  self:__SwitchToNormalView()
end

UITDBattle.OnActiveCancleBtn = function(self)
  -- function num : 0_8
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).img_cancle).color = (self.ui).highlightColor
end

UITDBattle.OnDisActiveCancleBtn = function(self)
  -- function num : 0_9
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).img_cancle).color = (self.ui).normalColor
end

UITDBattle.ShowCD = function(self, frameCount)
  -- function num : 0_10 , upvalues : _ENV
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
  -- function num : 0_11 , upvalues : _ENV
  for i,headItem in ipairs((self.headPool).listItem) do
    headItem:UpdateCd()
  end
end

UITDBattle.CountDown = function(self)
  -- function num : 0_12 , upvalues : _ENV
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
  -- function num : 0_13 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_Token).text = tostring(mp)
end

UITDBattle.__GetCurCoin = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local dynPlayer = (BattleUtil.GetCurDynPlayer)()
  if dynPlayer == nil then
    return 0
  end
  return dynPlayer:GetMoneyCount()
end

UITDBattle.ShowNextClick = function(self, flag, displayCost, intervalArg)
  -- function num : 0_15 , upvalues : _ENV
  if self.updateNextWaveCostTimerId ~= nil and self.updateNextWaveCostTimerId > 0 then
    TimerManager:StopTimer(self.updateNextWaveCostTimerId)
    self.updateNextWaveCostTimerId = 0
  end
  ;
  (((self.ui).btn_BattleNext).gameObject):SetActive(flag)
  self.showNextWave = flag
  if flag then
    self.curNextWaveDisplayCost = displayCost
    ;
    ((self.ui).tex_Cost):SetIndex(0, tostring(displayCost))
    self.updateNextWaveCostTimerId = TimerManager:StartTimer(1, (BindCallback(self, self.UpdateNextWaveCostText, intervalArg)), nil, false, false, false)
  end
end

UITDBattle.UpdateNextWaveCostText = function(self, intervalArg)
  -- function num : 0_16 , upvalues : _ENV
  self.curNextWaveDisplayCost = self.curNextWaveDisplayCost - BattleUtil.LogicFrameCount * intervalArg // 1000
  ;
  ((self.ui).tex_Cost):SetIndex(0, tostring(self.curNextWaveDisplayCost))
end

UITDBattle.__OnClickNextWave = function(self)
  -- function num : 0_17
  (((self.ui).btn_BattleNext).gameObject):SetActive(false)
  ;
  (((self.ui).cDText).gameObject):SetActive(false)
  if self.__callNextWaveAction ~= nil then
    (self.__callNextWaveAction)()
  end
end

UITDBattle.__OnClickResidentStore = function(self)
  -- function num : 0_18 , upvalues : _ENV
  if not ExplorationManager:IsInExploration() then
    return 
  end
  ;
  (ExplorationManager.epCtrl):OpenResidentStore()
end

UITDBattle.GetTowerMp = function(self)
  -- function num : 0_19
  local mp = 0
  if self.__getTowerMpFunction ~= nil then
    mp = (self.__getTowerMpFunction)()
  end
  return mp
end

UITDBattle.OnTdBattleStart = function(self)
  -- function num : 0_20
  (((self.ui).btn_EpStore).gameObject):SetActive(false)
end

UITDBattle.OnBattleEnd = function(self)
  -- function num : 0_21
  self:OnTowerInfoHide()
end

UITDBattle.OnTowerInfoHide = function(self)
  -- function num : 0_22 , upvalues : _ENV
  local tdTowerInfo = UIManager:GetWindow(UIWindowTypeID.TDCharactorInfo)
  if tdTowerInfo ~= nil then
    tdTowerInfo:Hide()
  end
end

UITDBattle.OnTowerInfoShow = function(self, hero, worldPos)
  -- function num : 0_23 , upvalues : _ENV
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
  -- function num : 0_24
  if self.__retreatTower ~= nil then
    (self.__retreatTower)(characterEntity)
  end
end

UITDBattle.__DisplayOtherUI = function(self, active)
  -- function num : 0_25
  if active then
    self:__ShowOtherUI()
  else
    self:__HideOtherUI()
  end
end

UITDBattle.__HideOtherUI = function(self)
  -- function num : 0_26 , upvalues : _ENV
  if self.showNextWave then
    (((self.ui).btn_BattleNext).gameObject):SetActive(false)
  end
  ;
  ((self.ui).waitHeroList):SetActive(false)
  ;
  ((self.ui).tokenInfo):SetActive(false)
  local battleSkillModule = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if battleSkillModule ~= nil and battleSkillModule.active then
    battleSkillModule:Hide(true)
  end
  local dungeonInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonInfoWin ~= nil and dungeonInfoWin.active then
    dungeonInfoWin:ShowTopInfo(false)
  end
  local UIBattleWin = UIManager:GetWindow(UIWindowTypeID.Battle)
  if UIBattleWin ~= nil and UIBattleWin.active then
    UIBattleWin:Hide()
  end
end

UITDBattle.__ShowOtherUI = function(self)
  -- function num : 0_27 , upvalues : _ENV
  if self.showNextWave then
    (((self.ui).btn_BattleNext).gameObject):SetActive(true)
  end
  ;
  ((self.ui).waitHeroList):SetActive(true)
  ;
  ((self.ui).tokenInfo):SetActive(true)
  local battleSkillModule = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if battleSkillModule ~= nil and not battleSkillModule.active then
    battleSkillModule:Show(true)
  end
  local dungeonInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonInfoWin ~= nil and dungeonInfoWin.active then
    dungeonInfoWin:ShowTopInfo(true)
  end
  local UIBattleWin = UIManager:GetWindow(UIWindowTypeID.Battle)
  if UIBattleWin ~= nil and not UIBattleWin.active then
    UIBattleWin:Show()
  end
end

UITDBattle.__OpenBulletTime = function(self, isPause)
  -- function num : 0_28
  self:__RecordTimeScale()
  self:__SetTimeScaleTemply(isPause)
end

UITDBattle.__CloseBulletTime = function(self)
  -- function num : 0_29 , upvalues : _ENV
  if self.curTimeScale ~= (Time.unity_time).timeScale then
    return 
  end
  self:__RecoverTimeScale()
end

UITDBattle.__RecordTimeScale = function(self)
  -- function num : 0_30 , upvalues : _ENV
  self.lastRecordTimeScale = (Time.unity_time).timeScale
end

UITDBattle.__SetTimeScaleTemply = function(self, isPause)
  -- function num : 0_31 , upvalues : _ENV
  if not isPause or not 0 then
    local targetScale = (ConfigData.game_config).bulletTime
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (Time.unity_time).timeScale = targetScale
  self.curTimeScale = (Time.unity_time).timeScale
end

UITDBattle.__RecoverTimeScale = function(self)
  -- function num : 0_32 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  (Time.unity_time).timeScale = self.lastRecordTimeScale
end

UITDBattle.__GetTopViewTimeLine = function(self)
  -- function num : 0_33 , upvalues : _ENV
  return ((CS.CameraController).Instance).SwitchToTopViewTimeLine
end

UITDBattle.__SwitchToTopView = function(self)
  -- function num : 0_34 , upvalues : _ENV
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
  -- function num : 0_35 , upvalues : _ENV
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
  -- function num : 0_36 , upvalues : _ENV, base
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
  ;
  (base.OnDelete)(self)
end

return UITDBattle


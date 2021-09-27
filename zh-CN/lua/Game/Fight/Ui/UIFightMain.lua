local cs_ResLoader = CS.ResLoader
local UIFightNamePlate = require("Game.Fight.Ui.SceneUI.UIFightNamePlate")
local UIFightVitalityBar = require("Game.Fight.Ui.SceneUI.UIFightVitalityBar")
local UIFightMainUserInfoNode = require("Game.Fight.Ui.UIFightMainUserInfoNode")
local DormFightConst = require("Game.Fight.DormFightConst")
local UIFightMain = class("UIFightMain", UIBaseWindow)
UIFightMain.OnInit = function(self)
  -- function num : 0_0 , upvalues : cs_ResLoader, DormFightConst, _ENV, UIFightNamePlate, UIFightVitalityBar, UIFightMainUserInfoNode
  self._resLoader = (cs_ResLoader.Create)()
  self._itemPools = {}
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._itemPools)[(DormFightConst.SceneUiType).NamePlate] = (UIItemPool.New)(UIFightNamePlate, (self.ui).obj_name)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._itemPools)[(DormFightConst.SceneUiType).VitalityBar] = (UIItemPool.New)(UIFightVitalityBar, (self.ui).obj_hp)
  self._index = 0
  self._sceneUiMap = {}
  self._cameraZ = (((UIManager:GetUICamera()).transform).position).z
  self._itemZ = ((((self.ui).obj_hp).transform).position).z
  self._startCountdown = 0
  self._startTimer = nil
  self._displayCountdown = 0
  ;
  (UIUtil.AddButtonListener)((self.ui).return_button, self, self.ExitButtonClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_attack, self, self.OnAttackBtnClick)
  ;
  (((self.ui).btn_run).onPressDown):AddListener(BindCallback(self, self.OnRunBtnPressDown))
  ;
  (((self.ui).btn_run).onPressUp):AddListener(BindCallback(self, self.OnRunBtnPressUp))
  ;
  ((self.ui).joystick):onTouchMove("+", BindCallback(self, self.OnJoyStickMove))
  ;
  ((self.ui).joystick):onTouchUp("+", BindCallback(self, self.OnJoyStickUp))
  self._leftUserInfoNode = (UIFightMainUserInfoNode.New)()
  ;
  (self._leftUserInfoNode):Init((self.ui).leftUserInfo, self._resLoader)
  self._rightUserInfoNode = (UIFightMainUserInfoNode.New)()
  ;
  (self._rightUserInfoNode):Init((self.ui).rightUserInfo, self._resLoader)
end

UIFightMain.ExitButtonClicked = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight, true)
  dormFightCtrl:ExitScene()
end

UIFightMain.OnAttackBtnClick = function(self)
  -- function num : 0_2
  if self._attackCb ~= nil then
    (self._attackCb)()
  end
end

UIFightMain.OnRunBtnPressDown = function(self)
  -- function num : 0_3
  if self._pressDownRunningCb ~= nil then
    (self._pressDownRunningCb)()
  end
end

UIFightMain.OnRunBtnPressUp = function(self)
  -- function num : 0_4
  if self._pressUpRunningCb ~= nil then
    (self._pressUpRunningCb)()
  end
end

UIFightMain.OnJoyStickMove = function(self, joyStickData)
  -- function num : 0_5 , upvalues : _ENV
  local radians = joyStickData.radians
  local radius = joyStickData.power
  local axisH = (math.cos)(radians) * radius
  local axisV = (math.sin)(radians) * radius
  if self._moveCb ~= nil then
    (self._moveCb)(axisH, axisV)
  end
end

UIFightMain.OnJoyStickUp = function(self)
  -- function num : 0_6
  if self._moveCb ~= nil then
    (self._moveCb)(0, 0)
  end
end

UIFightMain.Bind = function(self, moveCb, pressDownRunningCb, pressUpRunningCb, attackCb)
  -- function num : 0_7
  self._moveCb = moveCb
  self._pressDownRunningCb = pressDownRunningCb
  self._pressUpRunningCb = pressUpRunningCb
  self._attackCb = attackCb
end

UIFightMain.ShowStartCountDown = function(self, countdown)
  -- function num : 0_8 , upvalues : _ENV
  if self._startTimer ~= nil then
    TimerManager:StopTimer(self._startTimer)
    self._startTimer = nil
  end
  self._startCountdown = countdown
  self._startTimer = TimerManager:StartTimer(1, self.OnStartCountDown, self, false, false, false)
  ;
  (((self.ui).txt_Start).gameObject):SetActive(true)
end

UIFightMain.OnStartCountDown = function(self)
  -- function num : 0_9 , upvalues : _ENV
  self._startCountdown = self._startCountdown - 1
  if self._startCountdown > 0 then
    self:RefreshStartCountdownDisplay()
  else
    ;
    (((self.ui).txt_Start).gameObject):SetActive(false)
    TimerManager:StopTimer(self._startTimer)
    self._startTimer = nil
  end
end

UIFightMain.RefreshStartCountdownDisplay = function(self)
  -- function num : 0_10 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).txt_Start).text = tostring(self._startCountdown)
end

UIFightMain.CreateSceneUi = function(self, sceneUiType)
  -- function num : 0_11
  if sceneUiType then
    local itemPool = (self._itemPools)[sceneUiType]
  end
  if itemPool == nil then
    return -1
  end
  local item = itemPool:GetOne()
  self._index = self._index + 1
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._sceneUiMap)[self._index] = item
  return self._index
end

UIFightMain.ClearAllSceneUi = function(self)
  -- function num : 0_12 , upvalues : _ENV
  for _,pool in pairs(self._itemPools) do
    pool:HideAll()
  end
  self._index = 0
  self._sceneUiMap = {}
end

UIFightMain.UpdatePosition = function(self, index, screenPos)
  -- function num : 0_13 , upvalues : _ENV
  local item = self:GetSceneUi(index)
  if item == nil then
    return 
  end
  local uiCamera = UIManager:GetUICamera()
  local dz = self._cameraZ - self._itemZ
  local worldPosition = uiCamera:ScreenToWorldPoint(screenPos)
  local ratio = dz / (self._cameraZ - worldPosition.z)
  item:SetPosition((Vector3.New)(worldPosition.x * ratio, worldPosition.y * ratio, self._itemZ))
end

UIFightMain.SetName = function(self, index, name)
  -- function num : 0_14 , upvalues : DormFightConst
  local item = self:GetSceneUi(index)
  if item == nil or item:GetSceneUiType() ~= (DormFightConst.SceneUiType).NamePlate then
    return 
  end
  item:SetName(name)
end

UIFightMain.SetNamePlateStyle = function(self, index, isSelf)
  -- function num : 0_15 , upvalues : DormFightConst
  local item = self:GetSceneUi(index)
  if item == nil or item:GetSceneUiType() ~= (DormFightConst.SceneUiType).NamePlate then
    return 
  end
  item:SetSelfStyle(isSelf)
end

UIFightMain.SetVitalityRatio = function(self, index, ratio)
  -- function num : 0_16 , upvalues : DormFightConst
  local item = self:GetSceneUi(index)
  if item == nil or item:GetSceneUiType() ~= (DormFightConst.SceneUiType).VitalityBar then
    return 
  end
  item:SetVitalityRatio(ratio)
end

UIFightMain.ShowVitalityNode = function(self, index)
  -- function num : 0_17 , upvalues : DormFightConst
  local item = self:GetSceneUi(index)
  if item == nil or item:GetSceneUiType() ~= (DormFightConst.SceneUiType).VitalityBar then
    return 
  end
  item:ShowVitalityNode()
end

UIFightMain.GetSceneUi = function(self, index)
  -- function num : 0_18
  return index and (self._sceneUiMap)[index] or nil
end

UIFightMain.SetUserInfo = function(self, comp, userInfo)
  -- function num : 0_19 , upvalues : DormFightConst
  if comp ~= (DormFightConst.DormFightComp).Myself or not self._leftUserInfoNode then
    local targetNode = self._rightUserInfoNode
  end
  targetNode:SetUserInfo(userInfo)
end

UIFightMain.SetScore = function(self, comp, score, scoreMax)
  -- function num : 0_20 , upvalues : DormFightConst
  if comp ~= (DormFightConst.DormFightComp).Myself or not self._leftUserInfoNode then
    local targetNode = self._rightUserInfoNode
  end
  targetNode:SetScore(score, scoreMax)
end

UIFightMain.SetCountdown = function(self, countdown)
  -- function num : 0_21 , upvalues : _ENV
  local displayCountdown = (math.max)(0, (math.floor)(countdown))
  if (math.abs)(self._displayCountdown - displayCountdown) < 1e-05 then
    return 
  end
  self._displayCountdown = displayCountdown
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).txt_CountDown).text = tostring(displayCountdown)
end

UIFightMain.SetCountdownVisible = function(self, visible)
  -- function num : 0_22
  ((self.ui).obj_countdown):SetActive(visible)
end

UIFightMain.OnDelete = function(self)
  -- function num : 0_23 , upvalues : _ENV
  (UIBaseWindow.OnDelete)(self)
  if self._itemPools ~= nil then
    for _,pool in pairs(self._itemPools) do
      pool:DeleteAll()
    end
    self._itemPools = nil
  end
  if self._resLoader ~= nil then
    (self._resLoader):Put2Pool()
    self._resLoader = nil
  end
  if self._leftUserInfoNode ~= nil then
    (self._leftUserInfoNode):Dispose()
    self._leftUserInfoNode = nil
  end
  if self._rightUserInfoNode ~= nil then
    (self._rightUserInfoNode):Dispose()
    self._rightUserInfoNode = nil
  end
end

return UIFightMain


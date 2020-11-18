-- params : ...
-- function num : 0 , upvalues : _ENV
require("Global")
GameMain = {}
-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

GameMain.Start = function()
  -- function num : 0_0 , upvalues : _ENV
  print("start game...")
  TimerManager:Start()
  UpdateManager:Start()
  NetworkManager:InitNetwork()
  PersistentManager:InitManager()
  ;
  (ControllerManager:GetController(ControllerTypeId.Setting, true)):InitSettingData()
  UIManager:ShowWindow(UIWindowTypeID.Login)
end



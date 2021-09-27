local UINNavSpecialUIBase = require("Game.TopStatus.Navigation.SpecialUI.UINNavSpecialUIBase")
local UINNavSpeciaFactoryTimer = class("UINNavSpeciaFactoryTimer", UINNavSpecialUIBase)
local base = UINNavSpecialUIBase
UINNavSpeciaFactoryTimer.OnInit = function(self)
  -- function num : 0_0 , upvalues : base, _ENV
  (base.OnInit)(self)
  self.__FreshFactoryTime = BindCallback(self, self.FreshFactoryTime)
end

UINNavSpeciaFactoryTimer.GetSpecialUI = function(item, go, resloader)
  -- function num : 0_1 , upvalues : base, UINNavSpeciaFactoryTimer
  local specialUI = (base.GetSpecialUI)(UINNavSpeciaFactoryTimer, item, go)
  specialUI:FreshFactoryTime()
  ;
  (base.__Add2TimerFuncs)(specialUI.__FreshFactoryTime)
end

UINNavSpeciaFactoryTimer.FreshFactoryTime = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local factoryEnergyItemId = (ConfigData.game_config).factoryEnergyItemId
  local num, nextTime = (PlayerDataCenter.allEffectorData):GetCurrentARGNum(factoryEnergyItemId)
  local speed = (PlayerDataCenter.allEffectorData):GetCurrentARGSpeed(factoryEnergyItemId)
  local ceiling = (PlayerDataCenter.allEffectorData):GetCurrentARGCeiling(factoryEnergyItemId)
  local isCanCountdown = num < ceiling and speed > 0
  ;
  (self.gameObject):SetActive(isCanCountdown)
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R7 in 'UnsetPending'

  if isCanCountdown then
    ((self.ui).tex_Timer).text = TimestampToTime((ceiling - num - 1) / speed + nextTime)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINNavSpeciaFactoryTimer.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.__RemoveFromTimerFuncs)(self.__FreshFactoryTime)
  ;
  (base.OnDelete)(self)
end

return UINNavSpeciaFactoryTimer


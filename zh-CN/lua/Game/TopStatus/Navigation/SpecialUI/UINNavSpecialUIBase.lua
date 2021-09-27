local UINNavSpecialUIBase = class("UINNavSpecialUIBase", UIBaseNode)
local base = UIBaseNode
UINNavSpecialUIBase.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINNavSpecialUIBase
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  if UINNavSpecialUIBase.TimerId == nil then
    UINNavSpecialUIBase.TimerFuncs = {}
    UINNavSpecialUIBase.TimerId = TimerManager:StartTimer(1, UINNavSpecialUIBase.__NavSpecialUIBaseTimer, nil, false)
  end
end

UINNavSpecialUIBase.GetSpecialUI = function(class, item, go)
  -- function num : 0_1
  local newGo = go:Instantiate()
  local specialUI = (class.New)()
  specialUI:Init(newGo)
  specialUI:SetSpecialUI2Parent(item)
  return specialUI
end

UINNavSpecialUIBase.__NavSpecialUIBaseTimer = function()
  -- function num : 0_2 , upvalues : _ENV, UINNavSpecialUIBase
  for func,_ in pairs(UINNavSpecialUIBase.TimerFuncs) do
    func()
  end
end

UINNavSpecialUIBase.__Add2TimerFuncs = function(func)
  -- function num : 0_3 , upvalues : UINNavSpecialUIBase
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (UINNavSpecialUIBase.TimerFuncs)[func] = true
end

UINNavSpecialUIBase.__RemoveFromTimerFuncs = function(func)
  -- function num : 0_4 , upvalues : UINNavSpecialUIBase
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (UINNavSpecialUIBase.TimerFuncs)[func] = nil
end

UINNavSpecialUIBase.CleanSpecialUIBaseTimer = function()
  -- function num : 0_5 , upvalues : UINNavSpecialUIBase, _ENV
  UINNavSpecialUIBase.TimerFuncs = {}
  if UINNavSpecialUIBase.TimerId ~= nil then
    TimerManager:StopTimer(UINNavSpecialUIBase.TimerId)
    UINNavSpecialUIBase.TimerId = nil
  end
end

UINNavSpecialUIBase.PauseSpecialUIBaseTimer = function()
  -- function num : 0_6 , upvalues : _ENV, UINNavSpecialUIBase
  TimerManager:PauseTimer(UINNavSpecialUIBase.TimerId)
end

UINNavSpecialUIBase.ResumeSpecialUIBaseTimer = function()
  -- function num : 0_7 , upvalues : UINNavSpecialUIBase, _ENV
  (UINNavSpecialUIBase.__NavSpecialUIBaseTimer)()
  TimerManager:ResumeTimer(UINNavSpecialUIBase.TimerId)
end

UINNavSpecialUIBase.SetSpecialUI2Parent = function(self, item)
  -- function num : 0_8
  (self.transform):SetParent(item.transform, false)
end

UINNavSpecialUIBase.OnDelete = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnDelete)(self)
end

return UINNavSpecialUIBase


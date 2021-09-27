local UIDailyDungeonComplete = class("UIDailyDungeonComplete", UIBaseWindow)
local base = UIBaseWindow
UIDailyDungeonComplete.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Bg, self, self._OnClickBg)
end

UIDailyDungeonComplete.InitDailyDungeonComplete = function(self, nameStr)
  -- function num : 0_1 , upvalues : _ENV
  ((self.ui).tex_Tips):SetIndex(0, nameStr)
  local length = (((self.ui).anima).clip).length
  self.timerId = TimerManager:StartTimer(length, function()
    -- function num : 0_1_0 , upvalues : self
    self:_OnClickBg()
  end
, nil, true)
  ;
  ((self.ui).anima):Play()
end

UIDailyDungeonComplete._OnClickBg = function(self)
  -- function num : 0_2
  self:Delete()
end

UIDailyDungeonComplete.OnDelete = function(self)
  -- function num : 0_3 , upvalues : _ENV, base
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIDailyDungeonComplete


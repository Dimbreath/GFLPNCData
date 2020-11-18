-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDungeonWaveTip = class("UIDungeonWaveTip", UIBaseWindow)
local base = UIBaseWindow
UIDungeonWaveTip.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.__onFadeCompletedEvent = BindCallback(self, self.__onFadeCompleted)
end

UIDungeonWaveTip.InjectWave = function(self, wave)
  -- function num : 0_1 , upvalues : _ENV
  if wave ~= nil then
    ((self.ui).wave_Count):SetIndex(0, tostring(wave.cur), tostring(wave.total))
    local strCurWave = ""
    if wave.cur <= 9 then
      strCurWave = "0" .. tostring(wave.cur)
    else
      strCurWave = tostring(wave.cur)
    end
    ;
    ((self.ui).tex_WaveTip):SetIndex(0, strCurWave)
  end
end

UIDungeonWaveTip.OnShow = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnShow)(self)
  ;
  (((self.ui).tween).onComplete):AddListener(self.__onFadeCompletedEvent)
  ;
  ((self.ui).tween):DORestart()
end

UIDungeonWaveTip.__onFadeCompleted = function(self)
  -- function num : 0_3 , upvalues : base
  (((self.ui).tween).onComplete):RemoveListener(self.__onFadeCompletedEvent)
  ;
  (base.Hide)(self)
end

UIDungeonWaveTip.OnDelete = function(self)
  -- function num : 0_4 , upvalues : _ENV, base
  if not IsNull((self.ui).tween) then
    ((self.ui).tween):DOKill()
  end
  ;
  (base.OnDelete)(self)
end

return UIDungeonWaveTip


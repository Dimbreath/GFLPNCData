local UIMovieBlack = class("UIMovieBlack", UIBaseWindow)
local cs_DoTween = ((CS.DG).Tweening).DOTween
UIMovieBlack.OnInit = function(self)
  -- function num : 0_0
end

UIMovieBlack.SlowClose = function(self, time, callback)
  -- function num : 0_1 , upvalues : cs_DoTween
  local doTweenSequence = (cs_DoTween.Sequence)()
  doTweenSequence:Append((((self.ui).up):DOLocalMoveY((((self.ui).up).sizeDelta).y, time)):SetRelative(true))
  doTweenSequence:Join((((self.ui).down):DOLocalMoveY(-(((self.ui).down).sizeDelta).y, time)):SetRelative(true))
  doTweenSequence:AppendCallback(function()
    -- function num : 0_1_0 , upvalues : self, callback
    self:Delete()
    if callback ~= nil then
      callback()
    end
    self.doTweenSequence = nil
  end
)
  doTweenSequence:SetAutoKill(true)
  self.doTweenSequence = doTweenSequence
end

UIMovieBlack.OnDelete = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.doTweenSequence ~= nil then
    (self.doTweenSequence):Kill()
    self.doTweenSequence = nil
  end
  ;
  (UIBaseWindow.OnDelete)(self)
end

return UIMovieBlack


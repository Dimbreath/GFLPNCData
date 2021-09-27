local UIDormTransAnima = class("UIDormTransAnima", UIBaseWindow)
local base = UIBaseWindow
local cs_Ease = ((CS.DG).Tweening).Ease
local cs_DoTween = ((CS.DG).Tweening).DOTween
UIDormTransAnima.OnInit = function(self)
  -- function num : 0_0 , upvalues : cs_DoTween, _ENV
  local se = (cs_DoTween.Sequence)()
  se:Insert(0, (((self.ui).img_Mask).transform):DOSizeDelta((Vector2.New)(4096, 4096), 0.75))
  se:InsertCallback(0, BindCallback(self, self._OnSceneOpen))
  se:Pause()
  se:SetAutoKill(false)
  self._seq = se
end

UIDormTransAnima.InitDormTransAnima = function(self, startPos, waitTime, onStarFunc, onEndFunc)
  -- function num : 0_1 , upvalues : _ENV
  self._onStarFunc = onStarFunc
  self._onEndFunc = onEndFunc
  ;
  ((self.ui).ani_Node):Stop()
  ;
  ((self.ui).twenn_Gear):DOPause()
  self:_InitDormTransTimer(waitTime or 1)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'

  if startPos == nil or not startPos then
    (((self.ui).img_Mask).transform).localPosition = Vector3.zero
    ;
    (self._seq):Restart()
  end
end

UIDormTransAnima._InitDormTransTimer = function(self, waitTime)
  -- function num : 0_2 , upvalues : _ENV
  self._timerID = TimerManager:StartTimer(waitTime, self._OnSceneClose, self, true, false, false)
end

UIDormTransAnima._OnSceneOpen = function(self)
  -- function num : 0_3
  self:_PlayIcon()
  if self._onStarFunc ~= nil then
    (self._onStarFunc)()
  end
end

UIDormTransAnima._OnSceneClose = function(self)
  -- function num : 0_4
  ((self.ui).canvasGroup):DOKill()
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).canvasGroup).alpha = 1
  ;
  ((((self.ui).canvasGroup):DOFade(0, 0.25)):SetRecyclable(true)):OnComplete(function()
    -- function num : 0_4_0 , upvalues : self
    ((self.ui).twenn_Gear):DOPause()
    ;
    (self._seq):Pause()
    ;
    ((self.ui).ani_Node):Stop()
    self:Hide()
  end
)
  if self._onEndFunc ~= nil then
    (self._onEndFunc)()
  end
end

UIDormTransAnima._PlayIcon = function(self)
  -- function num : 0_5
  ((self.ui).ani_Node):Play()
  ;
  ((self.ui).twenn_Gear):DORestart()
end

UIDormTransAnima.OnDelete = function(self)
  -- function num : 0_6 , upvalues : _ENV
  ((self.ui).twenn_Gear):DOKill()
  ;
  ((self.ui).ani_Node):Stop()
  ;
  ((self.ui).canvasGroup):DOKill()
  if self._seq ~= nil then
    (self._seq):Kill()
    self._seq = nil
  end
  if self._timerID ~= nil then
    TimerManager:StopTimer(self._timerID)
    self._timerID = nil
  end
end

return UIDormTransAnima


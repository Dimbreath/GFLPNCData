local UISceneChangesMask = class("UISceneChangesMask", UIBaseWindow)
local base = UIBaseWindow
local CS_Material = (CS.UnityEngine).Material
local cs_Ease = ((CS.DG).Tweening).Ease
local cs_DoTween = ((CS.DG).Tweening).DOTween
local MatRangeProperty = "_Range"
UISceneChangesMask.OnInit = function(self)
  -- function num : 0_0 , upvalues : CS_Material, MatRangeProperty, cs_DoTween, cs_Ease, _ENV
  self._maskMat = CS_Material(((self.ui).img_BlackMask).material)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_BlackMask).material = self._maskMat
  ;
  (self._maskMat):SetFloat(MatRangeProperty, 0)
  local se = (cs_DoTween.Sequence)()
  ;
  ((((((se:Append(((self._maskMat):DOFloat(1, MatRangeProperty, 0.5)):SetEase(cs_Ease.OutQuad))):AppendCallback(BindCallback(self, self._OnSceneClose))):AppendInterval(0.1)):Append(((self._maskMat):DOFloat(0, MatRangeProperty, 0.5)):SetEase(cs_Ease.InQuad))):AppendCallback(BindCallback(self, self._OnSceneOpen))):Pause()):SetAutoKill(false)
  self.maskMatSeq = se
end

UISceneChangesMask.InitSceneChangesMask = function(self, onCloseSceneFunc, onOpenSceneFunc)
  -- function num : 0_1
  self.onCloseSceneFunc = onCloseSceneFunc
  self.onOpenSceneFunc = onOpenSceneFunc
  ;
  (self.maskMatSeq):Restart()
end

UISceneChangesMask._OnSceneClose = function(self)
  -- function num : 0_2
  if self.onCloseSceneFunc ~= nil then
    (self.onCloseSceneFunc)()
  end
end

UISceneChangesMask._OnSceneOpen = function(self)
  -- function num : 0_3
  if self.onOpenSceneFunc ~= nil then
    (self.onOpenSceneFunc)()
  end
  self:Hide()
end

UISceneChangesMask.OnDelete = function(self)
  -- function num : 0_4 , upvalues : _ENV, base
  if self.maskMatSeq ~= nil then
    (self.maskMatSeq):Kill()
    self.maskMatSeq = nil
  end
  DestroyUnityObject(self._maskMat)
  ;
  (base.OnDelete)(self)
end

return UISceneChangesMask


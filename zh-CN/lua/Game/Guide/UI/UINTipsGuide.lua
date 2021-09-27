local UINTipsGuide = class("UINTipsGuide", UIBaseNode)
UINTipsGuide.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self:_DefaultUI()
end

UINTipsGuide._DefaultUI = function(self)
  -- function num : 0_1
  (((self.ui).tween_TipsGuide).gameObject):SetActive(false)
  ;
  (((self.ui).tween_TargetArea).gameObject):SetActive(false)
  ;
  (((self.ui).fXP_UI_Guide3).gameObject):SetActive(false)
end

UINTipsGuide.ShowUITipsGuideArrow = function(self, curTargetTransform, showDir)
  -- function num : 0_2 , upvalues : _ENV
  if not (((self.ui).tween_TipsGuide).gameObject).avtive then
    (((self.ui).tween_TipsGuide).gameObject):SetActive(true)
  end
  local sizeDelta = curTargetTransform.sizeDelta
  local guideSizeX = ((self.transform).sizeDelta).x
  local offsetPos = nil
  if showDir == 1 then
    offsetPos = (Vector3.New)(-(guideSizeX + sizeDelta.y) / 2, 0)
  else
    if showDir == 2 then
      offsetPos = (Vector3.New)((guideSizeX + sizeDelta.x) / 2, 0)
    else
      if showDir == 3 then
        offsetPos = (Vector3.New)((guideSizeX + sizeDelta.y) / 2, 0)
      else
        offsetPos = (Vector3.New)(-(guideSizeX + sizeDelta.x) / 2, 0)
      end
    end
  end
  local rotZ = showDir * 90
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (self.transform).localEulerAngles = (Vector3.New)(0, 0, rotZ)
  -- DECOMPILER ERROR at PC70: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (self.transform).anchoredPosition = offsetPos
  ;
  ((self.ui).tween_TipsGuide):DOPlay()
end

UINTipsGuide.ShowUITipsGuideArea = function(self, curTargetTransform)
  -- function num : 0_3 , upvalues : _ENV
  local targetPos = curTargetTransform.localPosition
  if not (((self.ui).tween_TargetArea).gameObject).avtive then
    (((self.ui).tween_TargetArea).gameObject):SetActive(true)
  end
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.transform).localPosition = curTargetTransform.localPosition
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.transform).anchoredPosition = Vector2.zero
  ;
  ((self.ui).tween_TargetArea):DOPlay()
end

UINTipsGuide.ShowUITipsGuideFX = function(self, curTargetTransform)
  -- function num : 0_4 , upvalues : _ENV
  local targetPos = curTargetTransform.localPosition
  if not (((self.ui).fXP_UI_Guide3).gameObject).avtive then
    (((self.ui).fXP_UI_Guide3).gameObject):SetActive(true)
  end
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.transform).localPosition = curTargetTransform.localPosition
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.transform).anchoredPosition = Vector2.zero
  ;
  ((self.ui).fXP_UI_Guide3):Stop()
  ;
  ((self.ui).fXP_UI_Guide3):Play()
end

return UINTipsGuide


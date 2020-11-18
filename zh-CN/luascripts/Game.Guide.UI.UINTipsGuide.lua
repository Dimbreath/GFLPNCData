-- params : ...
-- function num : 0 , upvalues : _ENV
local UINTipsGuide = class("UINTipsGuide", UIBaseNode)
UINTipsGuide.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINTipsGuide.ShowUITipsGuide = function(self, curTargetTransform, showDir)
  -- function num : 0_1 , upvalues : _ENV
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
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (self.transform).localEulerAngles = (Vector3.New)(0, 0, rotZ)
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (self.transform).anchoredPosition = offsetPos
  ;
  ((self.ui).tween_TipsGuide):DOPlay()
end

return UINTipsGuide


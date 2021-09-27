local CS_DOTween = ((CS.DG).Tweening).DOTween
local VitalityActionDuration = 0.5
local VitalityBarFadeDuration = 0.5
local VitalityBarDisplayInterval = 1
local DormFightConst = require("Game.Fight.DormFightConst")
local UIFightSceneUiItem = require("Game.Fight.Ui.SceneUI.UIFightSceneUiItem")
local UIFightVitalityBar = class("UIFightVitalityBar", UIFightSceneUiItem)
UIFightVitalityBar.OnInit = function(self)
  -- function num : 0_0 , upvalues : UIFightSceneUiItem
  (UIFightSceneUiItem.OnInit)(self)
  self._vitalityValue = 1
  self._vitalityTweener = nil
  self._vitalityFadeTweener = nil
end

UIFightVitalityBar.SetVitalityRatio = function(self, ratio)
  -- function num : 0_1 , upvalues : _ENV, VitalityActionDuration
  local diff = (math.abs)(self._vitalityValue - ratio)
  if diff < 1e-05 then
    return 
  end
  self._vitalityValue = ratio
  if self._vitalityTweener ~= nil then
    (self._vitalityTweener):Kill(false)
    self._vitalityTweener = nil
  end
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

  if diff < 0.05 then
    ((self.ui).img_hp).fillAmount = ratio
  else
    self._vitalityTweener = ((self.ui).img_hp):DOFillAmount(ratio, VitalityActionDuration)
  end
end

UIFightVitalityBar.ShowVitalityNode = function(self)
  -- function num : 0_2 , upvalues : CS_DOTween, VitalityBarFadeDuration, VitalityBarDisplayInterval
  if self._vitalityFadeTweener ~= nil then
    (self._vitalityFadeTweener):Kill(false)
    self._vitalityFadeTweener = nil
  end
  local current = 0
  self._vitalityFadeTweener = (CS_DOTween.Sequence)()
  local alphaDiff = 1 - ((self.ui).cgp_hp).alpha
  do
    if alphaDiff > 0.0001 then
      local duration = alphaDiff * VitalityBarFadeDuration
      ;
      (self._vitalityFadeTweener):Insert(current, ((self.ui).cgp_hp):DOFade(1, duration))
      current = current + duration
    end
    current = current + VitalityBarDisplayInterval
    ;
    (self._vitalityFadeTweener):Insert(current, ((self.ui).cgp_hp):DOFade(0, VitalityBarFadeDuration))
  end
end

UIFightVitalityBar.GetSceneUiType = function(self)
  -- function num : 0_3 , upvalues : DormFightConst
  return (DormFightConst.SceneUiType).VitalityBar
end

return UIFightVitalityBar


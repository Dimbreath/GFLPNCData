local HeroLookTargetController = class("HeroLookTargetController")
HeroLookTargetController.OpenLookTarget = function(cubismLookController, target, camera)
  -- function num : 0_0 , upvalues : _ENV
  cubismLookController.enabled = true
  cubismLookController:SetCamera(camera)
  local lookTarget = target:GetComponent(typeof((((((CS.Live2D).Cubism).Samples).OriginalWorkflow).Demo).CubismLookTarget))
  lookTarget:SetCamera(camera)
  lookTarget:SetTimeClip(0.2)
end

return HeroLookTargetController


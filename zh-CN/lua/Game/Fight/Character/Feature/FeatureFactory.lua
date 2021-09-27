local DormFightConst = require("Game.Fight.DormFightConst")
local FeatureFactory = {}
FeatureFactory.CreateFeature = function(featureType)
  -- function num : 0_0 , upvalues : DormFightConst, _ENV
  local res = nil
  if featureType == (DormFightConst.FeatureEnum).ModelController then
    res = ((require("Game.Fight.Character.Feature.DormFightModelController")).New)()
  else
    if featureType == (DormFightConst.FeatureEnum).PropertyController then
      res = ((require("Game.Fight.Character.Feature.DormFightPropertyController")).New)()
    else
      if featureType == (DormFightConst.FeatureEnum).AnimatorController then
        res = ((require("Game.Fight.Character.Feature.DormFightAnimatorController")).New)()
      else
        if featureType == (DormFightConst.FeatureEnum).VitalityController then
          res = ((require("Game.Fight.Character.Feature.DormFightVitalityController")).New)()
        else
          if featureType == (DormFightConst.FeatureEnum).InputController then
            res = ((require("Game.Fight.Character.Feature.DormFightInputController")).New)()
          else
            if featureType == (DormFightConst.FeatureEnum).AiController then
              res = ((require("Game.Fight.Character.Feature.DormFightAiController")).New)()
            else
              if featureType == (DormFightConst.FeatureEnum).SceneUiController then
                res = ((require("Game.Fight.Character.Feature.DormFightUiController")).New)()
              end
            end
          end
        end
      end
    end
  end
  return res
end

return FeatureFactory


local DormFightCharacterBase = require("Game.Fight.Character.Entity.DormFightCharacterBase")
local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightNpcCharacter = class("DormFightNpcCharacter", DormFightCharacterBase)
DormFightNpcCharacter.FillFeatures = function(self)
  -- function num : 0_0 , upvalues : DormFightConst
  self:AddFeature((DormFightConst.FeatureEnum).ModelController)
  self:AddFeature((DormFightConst.FeatureEnum).AnimatorController)
  self:AddFeature((DormFightConst.FeatureEnum).AiController)
  self:AddFeature((DormFightConst.FeatureEnum).VitalityController)
  self:AddFeature((DormFightConst.FeatureEnum).PropertyController)
  self:AddFeature((DormFightConst.FeatureEnum).SceneUiController)
end

DormFightNpcCharacter.GetCharacterType = function(self)
  -- function num : 0_1 , upvalues : DormFightConst
  return (DormFightConst.CharacterType).Npc
end

return DormFightNpcCharacter


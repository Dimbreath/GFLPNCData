local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightHelper = require("Game.Fight.DormFightHelper")
local DormFightCharacterFeatureBase = require("Game.Fight.Character.Feature.DormFightCharacterFeatureBase")
local DormFightPropertyController = class("DormFightPropertyController", DormFightCharacterFeatureBase)
DormFightPropertyController.ctor = function(self)
  -- function num : 0_0
end

DormFightPropertyController.OnInit = function(self)
  -- function num : 0_1
end

DormFightPropertyController.GetProperty = function(self, propertyType)
  -- function num : 0_2 , upvalues : DormFightHelper
  return (DormFightHelper.GetPropertyValue)(propertyType)
end

return DormFightPropertyController


-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthItemSimpleAttr = class("UINAthItemSimpleAttr", UIBaseNode)
local base = UIBaseNode
local AthEnum = require("Game.Arithmetic.ArthmeticEnum")
UINAthItemSimpleAttr.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINAthItemSimpleAttr.InitAthItemSimpleAttr = function(self, quality)
  -- function num : 0_1 , upvalues : AthEnum
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).simpleAtt).color = (AthEnum.AthQualityColor)[quality]
end

UINAthItemSimpleAttr.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthItemSimpleAttr


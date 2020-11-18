-- params : ...
-- function num : 0 , upvalues : _ENV
local base = require("Game.Arithmetic.Common.UIAthItemBase")
local UIAthItemBar = class("UIAthItemBar", base)
UIAthItemBar.OnInit = function(self)
  -- function num : 0_0 , upvalues : base
  (base.OnInit)(self)
end

UIAthItemBar.InitAthItem = function(self, color, height, space, athData)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitAthItem)(self, color, height, space, athData)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_ATHSpace).text = tostring(space)
end

UIAthItemBar.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UIAthItemBar


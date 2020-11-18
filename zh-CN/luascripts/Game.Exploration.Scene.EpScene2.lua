-- params : ...
-- function num : 0 , upvalues : _ENV
local base = require("Game.Exploration.Scene.EpSceneA")
local EpScene2 = class("EpSceneA", base)
EpScene2.OnDelete = function(self)
  -- function num : 0_0 , upvalues : base
  (base.OnDelete)(self)
end

return EpScene2


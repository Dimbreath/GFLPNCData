-- params : ...
-- function num : 0 , upvalues : _ENV
local base = require("Game.Exploration.Scene.EpSceneA")
local EpScene3 = class("EpSceneA", base)
EpScene3.OnDelete = function(self)
    -- function num : 0_0 , upvalues : base
    (base.OnDelete)(self)
end

return EpScene3


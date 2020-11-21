-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10015 = require("GamePlay.SkillScripts.FunctionSkill.10015_Anger")
local bs_10026 = class("bs_10026", bs_10015)
local base = bs_10015
bs_10026.config = {buffId = 75}
bs_10026.config = setmetatable(bs_10026.config, {__index = base.config})
bs_10026.ctor = function(self)
    -- function num : 0_0
end

bs_10026.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base
    (base.InitSkill)(self, isMidwaySkill)
end

bs_10026.OnCasterDie = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10026


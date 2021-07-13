-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_530 = class("bs_530", bs_1)
local base = bs_1
bs_530.config = {effectId_1 = 10573, effectId_2 = 10574}
bs_530.config = setmetatable(bs_530.config, {__index = base.config})
bs_530.ctor = function(self)
  -- function num : 0_0
end

bs_530.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_530.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_530


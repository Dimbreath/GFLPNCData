-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_37 = class("bs_37", bs_1)
local base = bs_1
bs_37.config = {targetSelect = 12}
bs_37.config = setmetatable(bs_37.config, {__index = base.config})
bs_37.ctor = function(self)
  -- function num : 0_0
end

bs_37.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_37.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_37


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_516 = class("bs_516", bs_1)
local base = bs_1
bs_516.config = {}
bs_516.config = setmetatable(bs_516.config, {__index = base.config})
bs_516.ctor = function(self)
  -- function num : 0_0
end

bs_516.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_516.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_516


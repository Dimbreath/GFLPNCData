local bs_200001 = require("GamePlay.SkillScripts.MonsterSkill.200001_Boss_mianyi")
local bs_202001 = class("bs_202001", bs_200001)
local base = bs_200001
bs_202001.config = {}
bs_202001.config = setmetatable(bs_202001.config, {__index = base.config})
bs_202001.ctor = function(self)
  -- function num : 0_0
end

bs_202001.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["520_arg1"] = (self.arglist)[1]
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["520_arg2"] = (self.arglist)[2]
end

bs_202001.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202001


local bs_200001 = require("GamePlay.SkillScripts.MonsterSkill.200001_Boss_mianyi")
local bs_40029 = class("bs_40029", bs_200001)
local base = bs_200001
bs_40029.config = {}
bs_40029.config = setmetatable(bs_40029.config, {__index = base.config})
bs_40029.ctor = function(self)
  -- function num : 0_0
end

bs_40029.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).Roll = (self.arglist)[1]
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).arg = (self.arglist)[2]
end

bs_40029.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnAfterBattleStart)(self)
end

bs_40029.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40029


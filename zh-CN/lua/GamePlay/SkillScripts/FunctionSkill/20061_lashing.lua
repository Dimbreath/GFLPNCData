local bs_20061 = class("bs_20061", LuaSkillBase)
local base = LuaSkillBase
bs_20061.config = {formula1 = 10106, formula2 = 10158}
bs_20061.ctor = function(self)
  -- function num : 0_0
end

bs_20061.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20061_1", 1, self.OnAfterBattleStart)
end

bs_20061.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if (self.caster).maxHp <= 0 then
    return 
  end
  if (self.caster).hp * 1000 // (self.caster).maxHp > 150 then
    local hurt1 = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).formula1, self.caster, self.caster, self)
    LuaSkillCtrl:RemoveLife(hurt1, self, self.caster, true, nil, true, false, eHurtType.RealDmg)
  else
    do
      if (self.caster).hp * 1000 // (self.caster).maxHp > 50 then
        local hurt2 = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).formula2, self.caster, self.caster, self)
        LuaSkillCtrl:RemoveLife(hurt2, self, self.caster, true, nil, true, false, eHurtType.RealDmg)
      else
        do
          do return  end
        end
      end
    end
  end
end

bs_20061.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20061


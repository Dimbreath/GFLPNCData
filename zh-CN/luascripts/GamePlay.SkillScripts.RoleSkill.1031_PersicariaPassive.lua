-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1031 = class("bs_1031", LuaSkillBase)
local base = LuaSkillBase
bs_1031.config = {selectId = 20, effectId1 = 10040, effectId2 = 10041, effectId3 = 10345, healFormula = 10087}
bs_1031.ctor = function(self)
  -- function num : 0_0
end

bs_1031.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_1031_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_1031_2", 15, self.OnSetHurt)
end

bs_1031.OnAfterBattleStart = function(self)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.caster).recordTable)["1031_Times"] = 1
end

bs_1031.OnSetHurt = function(self, context)
  -- function num : 0_3 , upvalues : _ENV
  if ((self.caster).recordTable)["1031_Times"] ~= nil and ((self.caster).recordTable)["1031_Times"] > 0 and (context.target).hp <= context.hurt and (context.target).belongNum == (self.caster).belongNum and (context.target).hp > 0 and (context.target).roleType == 1 then
    context.hurt = 0
    LuaSkillCtrl:CallEffectWithArg(context.target, (self.config).effectId3, self, true, self.SkillEventFunc, context.target)
    LuaSkillCtrl:CallEffect(context.target, (self.config).effectId1, self, nil, self.caster, nil, true)
    self:OnSkillTake()
    do
      if (self.arglist)[3] > 0 then
        local targetList = LuaSkillCtrl:CallTargetSelect(self, 26, 0)
        if targetList.Count ~= 0 then
          LuaSkillCtrl:CallEffectWithArgOverride(targetList[0], (self.config).effectId3, self, context.target, true, self.SkillEventFunc, (targetList[0]).targetRole)
          LuaSkillCtrl:CallEffect(targetList[0], (self.config).effectId1, self, nil, context.target, nil, true)
        end
      end
      -- DECOMPILER ERROR at PC95: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.caster).recordTable)["1031_Times"] = ((self.caster).recordTable)["1031_Times"] - 1
    end
  end
end

bs_1031.SkillEventFunc = function(self, target, effect, eventId)
  -- function num : 0_4 , upvalues : _ENV
  if effect.dataId == (self.config).effectId3 and eventId == eBattleEffectEvent.Create then
    local healNum = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).healFormula, self.caster, nil, self)
    LuaSkillCtrl:CallHeal(healNum, self, target)
  end
end

bs_1031.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1031


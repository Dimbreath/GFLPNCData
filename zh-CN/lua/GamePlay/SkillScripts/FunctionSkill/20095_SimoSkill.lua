local bs_20095 = class("bs_20095", LuaSkillBase)
local base = LuaSkillBase
bs_20095.config = {buffId = 32}
bs_20095.ctor = function(self)
  -- function num : 0_0
end

bs_20095.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_20095_3", 1, self.OnAfterHurt)
  self:AddSetHurtTrigger("bs_20095_2", 99, self.OnSetHurt, nil, self.caster)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20095_1", 1, self.OnAfterBattleStart)
  self.undead = true
end

bs_20095.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if target ~= self.caster and target.roleDataId ~= 40003 and not self.undead then
    local damage = (self.caster).hp // 20
    LuaSkillCtrl:RemoveLife(damage, self, self.caster, true, nil, true)
  else
    do
      if target ~= self.caster and target.roleDataId == 40003 then
        local damage = (self.caster).maxHp * hurt // (target.maxHp + 1)
        LuaSkillCtrl:RemoveLife(damage, self, self.caster, true, nil, true)
      else
        do
          if target == self.caster and sender.roleDataId == 40003 then
            local damage = sender.maxHp * hurt // ((self.caster).maxHp + 1)
            LuaSkillCtrl:RemoveLife(damage, self, sender, true, nil, true)
          end
        end
      end
    end
  end
end

bs_20095.OnSetHurt = function(self, context)
  -- function num : 0_3
  if context.target == self.caster and (self.caster).hp < context.hurt then
    context.hurt = 0
  end
end

bs_20095.OnAfterBattleStart = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, 150, arriveCallBack)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1, nil, true)
end

bs_20095.OnArriveAction = function(self)
  -- function num : 0_5
  self.undead = false
end

bs_20095.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20095


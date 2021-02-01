-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10225 = class("bs_10225", LuaSkillBase)
local base = LuaSkillBase
bs_10225.config = {buffId = 1081, buffTier = 1, effectId = 10754, effectId2 = 10755}
bs_10225.ctor = function(self)
  -- function num : 0_0
end

bs_10225.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10225_3", 3, self.OnAfterPlaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterHurt, "bs_10225_2", 1, self.OnAfterHurt)
end

bs_10225.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  local tier = (self.caster):GetBuffTier((self.config).buffId)
  if tier == 0 and skill.maker == self.caster and not skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 7, 10)
    if targetlist.Count < 1 then
      return 
    end
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.caster).recordTable).lastAttackRole = (targetlist[0]).targetRole
    self.effect = LuaSkillCtrl:CallEffect((targetlist[0]).targetRole, (self.config).effectId, self)
    self.flag = true
  end
end

bs_10225.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_3 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and self.flag and not isTriggerSet then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((self.caster).recordTable).lastAttackRole = nil
    if self.effect ~= nil then
      (self.effect):Die()
      self.effect = nil
    end
    LuaSkillCtrl:CallEffect(target, (self.config).effectId2, self)
    self.flag = false
  end
end

bs_10225.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10225


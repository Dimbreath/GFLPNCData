-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100201 = class("bs_100201", LuaSkillBase)
local base = LuaSkillBase
bs_100201.config = {buffId_110 = 110, buffId_66 = 66, effectId_trail = 10050, effectId_line = 10049, time = nil, tier = 1, tier_skill = 1, selectId_pass = 20, selectId_skill = 29, select_range = 10}
bs_100201.ctor = function(self)
  -- function num : 0_0
end

bs_100201.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddAfterAddBuffTrigger("bs_100201_7", 1, self.OnAfterAddBuff, nil, nil, nil, nil, (self.config).buffId_110)
  self:AddAfterHurtTrigger("bs_100201_1", 1, self.OnAfterHurt, self.caster)
  if (self.arglist)[4] > 0 then
    self:AddSetDeadHurtTrigger("bs_100201_3", 20, self.OnSetDeadHurt)
  end
end

bs_100201.OnSetDeadHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if (self.caster).belongNum ~= (context.target).belongNum and (context.target):GetBuffTier((self.config).buffId_110) > 0 then
    if (self.arglist)[4] > 0 then
      local targetList = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId_pass, (self.config).select_range, context.target)
      if targetList.Count > 0 then
        for i = 0, targetList.Count - 1 do
          local role_target = (targetList[i]).targetRole
          if role_target.intensity ~= 0 then
            local tier = (context.target):GetBuffTier((self.config).buffId_110)
            LuaSkillCtrl:CallEffect((targetList[i]).targetRole, (self.config).effectId_line, self, nil, context.target)
            LuaSkillCtrl:CallEffectWithArgOverride((targetList[i]).targetRole, (self.config).effectId_trail, self, context.target, false, false, self.SkillEventFunc, tier)
            break
          end
        end
      end
    end
    do
      LuaSkillCtrl:DispelBuff(context.target, (self.config).buffId_110, 0, true)
    end
  end
end

bs_100201.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_3 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and not isMiss and target.intensity ~= 0 and target.hp > 0 then
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_110, (self.config).tier, (self.config).time)
  end
  if sender == self.caster and skill.dataId == 100202 and isTriggerSet ~= true then
    local transferList = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId_skill, (self.config).select_range)
    if transferList ~= 0 then
      for i = 0, transferList.Count - 1 do
        local role = (transferList[i]).targetRole
        if role ~= nil and role.intensity ~= 0 then
          LuaSkillCtrl:CallBuff(self, role, (self.config).buffId_110, (self.config).tier_skill, (self.config).time)
        end
      end
    end
  end
end

bs_100201.OnAfterAddBuff = function(self, buff, target)
  -- function num : 0_4 , upvalues : _ENV
  if buff.dataId == (self.config).buffId_110 then
    local restTier = target:GetBuffTier((self.config).buffId_110)
    if (self.arglist)[1] <= restTier then
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_66, (self.config).tier, (self.arglist)[2])
      LuaSkillCtrl:DispelBuff(target, (self.config).buffId_110, (self.arglist)[1], true)
    end
  end
end

bs_100201.SkillEventFunc = function(self, tier, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBuff(self, target.targetRole, (self.config).buffId_110, tier, (self.config).time)
  end
end

bs_100201.OnCasterDie = function(self)
  -- function num : 0_6
  self:RemoveAllTimers()
  self:RemoveAllBreakKillEffects()
end

return bs_100201


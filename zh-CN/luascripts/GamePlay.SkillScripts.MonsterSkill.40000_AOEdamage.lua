-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40000 = class("40000_AOEdamage", LuaSkillBase)
local base = LuaSkillBase
bs_40000.config = {attackdelay = 15, effectId1 = 10124, effectId2 = 10125, damageFormula = 10012, audioId1 = 54}
bs_40000.ctor = function(self)
  -- function num : 0_0
end

bs_40000.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_40000.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  self:CallCasterWait(30)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 5, attackTrigger)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
end

bs_40000.OnAttackTrigger = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  ((self.caster).auSource):PlayAudioById((self.config).audioId1)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetList.Count <= 0 then
    return 
  end
  for i = 0, targetList.Count - 1 do
    LuaSkillCtrl:CallEffectWithArg((targetList[i]).targetRole, (self.config).effectId2, self, true, self.SkillEventFunc)
  end
end

bs_40000.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if effect.dataId == (self.config).effectId2 and eventId == eBattleEffectEvent.Trigger then
    local targetRole = target.targetRole
    local damageNum = nil
    damageNum = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).damageFormula, self.caster, targetRole, self)
    if damageNum < 1 then
      damageNum = 1
    end
    LuaSkillCtrl:RemoveLife(damageNum, self, target)
  end
end

bs_40000.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40000


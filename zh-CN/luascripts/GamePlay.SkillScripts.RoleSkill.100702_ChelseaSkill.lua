-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1028 = class("bs_1028", LuaSkillBase)
local base = LuaSkillBase
bs_1028.config = {
hurt_config = {basehurt_formula = 10076}
, 
aoe_config = {effect_shape = 2, aoe_select_code = 4, aoe_range = 1}
, effectId = 10017, effectId1 = 10016, damInter = 4, buffId = 116, speed = 1, audioId = 42}
bs_1028.ctor = function(self)
  -- function num : 0_0
end

bs_1028.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.BeforePlaySkill, "bs_1028_1", 1, self.OnBeforePlaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_1028_2", 1, self.BeforeEndBattle)
  self.aoeRestTime = 0
end

bs_1028.OnBeforePlaySkill = function(self, role, context)
  -- function num : 0_2 , upvalues : _ENV
  if role == self.caster and (context.skill).isCommonAttack and self.aoeRestTime > 0 then
    local preList = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
    if preList.Count > 0 then
      context.active = false
      self:RealPlaySkill()
    end
  end
end

bs_1028.PlaySkill = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self.aoeRestTime = (self.arglist)[2]
  self.loop = LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId)
end

bs_1028.RealPlaySkill = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self:CallCasterWait(15)
  LuaSkillCtrl:CallRoleAction(self.caster, 1002, (self.config).speed)
  LuaSkillCtrl:CallEffectWithArgAndSpeed(self.caster, (self.config).effectId1, self, (self.config).speed, true, self.SkillEventFunc)
  self.aoeRestTime = self.aoeRestTime - 1
  if self.aoeRestTime == 0 then
    LuaSkillCtrl:StartTimer(nil, 15, function()
    -- function num : 0_4_0 , upvalues : self, _ENV
    if self.loop ~= nil then
      AudioManager:StopAudioByBack(self.loop)
      self.loop = nil
    end
  end
)
  end
end

bs_1028.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, (self.config).aoe_config)
    for i = 0, (skillResult.roleList).Count - 1 do
      local role = (skillResult.roleList)[i]
      LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
      if (self.arglist)[3] == 1 then
        LuaSkillCtrl:CallBuff(self, role, (self.config).buffId, 1, (self.arglist)[4], false)
      end
    end
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config, nil, false)
    skillResult:EndResult()
    LuaSkillCtrl:StartTimer(self, 30, BindCallback(LuaSkillCtrl, LuaSkillCtrl.BreakCurrentAction, self.caster))
  end
end

bs_1028.BeforeEndBattle = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.loop ~= nil then
    AudioManager:StopAudioByBack(self.loop)
    self.loop = nil
  end
end

bs_1028.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1028


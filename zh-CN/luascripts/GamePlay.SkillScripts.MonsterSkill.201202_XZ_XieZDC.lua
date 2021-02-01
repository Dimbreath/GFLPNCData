-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40010 = class("bs_40010", LuaSkillBase)
local base = LuaSkillBase
bs_40010.config = {effectId1 = 10277, effectId2 = 10278, effectId3 = 10279, effectId4 = 10280, 
aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 1}
, monsterEffectId = 10221, buffId = 1007, buffDamageFormula = 10078, effecthurtId = 10275, audioId1 = 78, audioId2 = 79, audioId3 = 80, audioId4 = 81}
bs_40010.ctor = function(self)
  -- function num : 0_0
end

bs_40010.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_40010.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local belongNum = 1
  self.grid = LuaSkillCtrl:CallFindGridMostRolesArounded(belongNum)
  if self.grid ~= nil then
    local target = LuaSkillCtrl:GetTargetWithGrid((self.grid).x, (self.grid).y)
    local roles = LuaSkillCtrl:FindRolesAroundGrid(self.grid, belongNum)
    local triggerCallBack = BindCallback(self, self.OnActionCallBack, target, roles)
    if roles ~= nil then
      (self.caster):LookAtTarget(target)
      self:CallCasterWait(27)
      LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 12, triggerCallBack)
    end
  end
end

bs_40010.OnActionCallBack = function(self, target, role)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(target, (self.config).effectId1, self)
  LuaSkillCtrl:StartTimer(nil, 1, function()
    -- function num : 0_3_0 , upvalues : _ENV, target, self
    LuaSkillCtrl:CallEffect(target, (self.config).effectId3, self)
  end
)
  LuaSkillCtrl:StartTimer(nil, 3, function()
    -- function num : 0_3_1 , upvalues : _ENV, target, self
    LuaSkillCtrl:CallEffect(target, (self.config).effectId2, self, self.SkillEventFunc)
  end
)
end

bs_40010.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local loop = LuaSkillCtrl:CallEffect(target, (self.config).monsterEffectId, self)
    self.loopAudio = LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId2)
    local Cishu = (self.arglist)[2] // 15
    LuaSkillCtrl:StartTimer(nil, 15, function()
    -- function num : 0_4_0 , upvalues : _ENV, self
    local roles = LuaSkillCtrl:FindRolesAroundGrid(self.grid, 1)
    if roles ~= nil then
      for i = 0, roles.Count - 1 do
        LuaSkillCtrl:CallBuffRepeated(self, roles[i], (self.config).buffId, 1, (self.arglist)[4], false, self.OnBuffExecute)
        LuaSkillCtrl:PlayAuSource(roles[i], (self.config).audioId3)
      end
    end
  end
, self, Cishu)
    LuaSkillCtrl:StartTimer(nil, (self.arglist)[2], BindCallback(self, self.__killEffectAndAudio, loop))
  end
end

bs_40010.__killEffectAndAudio = function(self, effect)
  -- function num : 0_5 , upvalues : _ENV
  if effect ~= nil then
    effect:Die()
    effect = nil
  end
  if self.loopAudio ~= nil then
    AudioManager:StopAudioByBack(self.loopAudio)
  end
end

bs_40010.OnBuffExecute = function(self, buff, targetRole)
  -- function num : 0_6 , upvalues : _ENV
  LuaSkillCtrl:PlayAuSource(targetRole, (self.config).audioId4)
  LuaSkillCtrl:CallEffect(targetRole, (self.config).effecthurtId, self)
  local damage = (math.max)(LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).buffDamageFormula, self.caster, targetRole, self), 1)
  damage = damage * buff.tier
  LuaSkillCtrl:RemoveLife(damage, self, targetRole, false, false, buff)
end

bs_40010.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40010


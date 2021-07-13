-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102702 = class("bs_102702", LuaSkillBase)
local base = LuaSkillBase
bs_102702.config = {
aoe_config = {effect_shape = 2, aoe_select_code = 4, aoe_range = 1}
, effectId1 = 10383, speed = 1, actionId = 1002, action_speed = 1, 
buffIdList = {176, 177, 178}
, skill_time = 15, start_time = 16}
bs_102702.ctor = function(self)
  -- function num : 0_0
end

bs_102702.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_102702.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local preList = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
  if preList.Count == 0 then
    return 
  end
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait((self.config).skill_time)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, (self.config).action_speed, (self.config).start_time, attackTrigger)
  LuaSkillCtrl:StartTimer(self, 6, function()
    -- function num : 0_2_0 , upvalues : _ENV, self
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self, nil, nil, (self.config).speed, true)
  end
)
end

bs_102702.OnAttackTrigger = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, (self.config).aoe_config)
  for i = 0, (skillResult.roleList).Count - 1 do
    local role = (skillResult.roleList)[i]
    self:CallRandomBuff(role)
  end
  skillResult:EndResult()
end

bs_102702.CallRandomBuff = function(self, role)
  -- function num : 0_4 , upvalues : _ENV
  if role.intensity ~= 0 then
    local randIndex1 = LuaSkillCtrl:CallRange(1, 3)
    local buffId1 = ((self.config).buffIdList)[randIndex1]
    local scale = (Vector3.New)(1, 1, 1)
    self:SetBuffScale(randIndex1, scale)
    if (self.arglist)[4] == 1 then
      local randIndex2 = randIndex1 + LuaSkillCtrl:CallRange(1, 2)
      if randIndex2 > 3 then
        randIndex2 = randIndex2 - 3
      end
      local buffId2 = ((self.config).buffIdList)[randIndex2]
      self:SetBuffScale(randIndex2, scale)
      LuaSkillCtrl:CallBuff(self, role, buffId2, 1, (self.arglist)[5])
    end
    do
      LuaSkillCtrl:CallBuffLifeEvent(self, role, buffId1, 1, (self.arglist)[5], BindCallback(self, self.OnBuffLifeEvent, role, scale))
    end
  end
end

bs_102702.SetBuffScale = function(self, index, scale)
  -- function num : 0_5
  if index == 1 then
    scale.z = 0.7
  else
    if index == 2 then
      scale.x = 0.7
    else
      scale.y = 0.7
    end
  end
end

bs_102702.OnBuffLifeEvent = function(self, role, scale, lifeType, arg)
  -- function num : 0_6 , upvalues : _ENV
  if lifeType == eBuffLifeEvent.NewAdd then
    LuaSkillCtrl:CallStartLocalScale(role, (Vector3.New)(2, 0.4, 2), 0.4)
    LuaSkillCtrl:StartTimer(self, 2, function()
    -- function num : 0_6_0 , upvalues : role, self, _ENV
    if role:GetBuffTier(((self.config).buffIdList)[1]) > 0 or role:GetBuffTier(((self.config).buffIdList)[2]) > 0 or role:GetBuffTier(((self.config).buffIdList)[3]) > 0 then
      LuaSkillCtrl:CallStartLocalScale(role, (Vector3.New)(0.4, 2, 0.4), 0.4)
    end
  end
)
    LuaSkillCtrl:StartTimer(self, 4, function()
    -- function num : 0_6_1 , upvalues : role, self, _ENV
    if role:GetBuffTier(((self.config).buffIdList)[1]) > 0 or role:GetBuffTier(((self.config).buffIdList)[2]) > 0 or role:GetBuffTier(((self.config).buffIdList)[3]) > 0 then
      LuaSkillCtrl:CallStartLocalScale(role, (Vector3.New)(2, 0.4, 2), 0.4)
    end
  end
)
    LuaSkillCtrl:StartTimer(self, 6, function()
    -- function num : 0_6_2 , upvalues : role, self, _ENV, scale
    if role:GetBuffTier(((self.config).buffIdList)[1]) > 0 or role:GetBuffTier(((self.config).buffIdList)[2]) > 0 or role:GetBuffTier(((self.config).buffIdList)[3]) > 0 then
      LuaSkillCtrl:CallStartLocalScale(role, scale, 0.4)
    end
  end
)
  else
    if lifeType == eBuffLifeEvent.Remove then
      LuaSkillCtrl:CallStartLocalScale(role, (Vector3.New)(1, 1, 1), 1)
    end
  end
end

bs_102702.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102702


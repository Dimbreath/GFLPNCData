local bs_40010 = class("bs_40010", LuaSkillBase)
local base = LuaSkillBase
bs_40010.config = {effectId1 = 10277, effectId2 = 10278, effectId3 = 10279, effectId4 = 10280, 
aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 1}
, monsterEffectId = 10221, buffId_1007 = 1007, buffId_1130 = 1130, buffDamageFormula = 10078, effecthurtId = 10275, audioId1 = 78, audioId2 = 79, audioId3 = 80, startAnimId = 1002, skill_time = 27, start_time = 12, freq = 15}
bs_40010.ctor = function(self)
  -- function num : 0_0
end

bs_40010.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_40010_3", 1, self.BeforeEndBattle)
end

bs_40010.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local belongNum = 1
  local target = ((self.caster).recordTable).lastAttackRole
  do
    if target == nil or target.hp <= 0 or target.belongNum == eBattleRoleBelong.neutral then
      local tempTarget = self:GetMoveSelectTarget()
      target = tempTarget.targetRole
    end
    if target == nil then
      return 
    end
    local triggerCallBack = BindCallback(self, self.OnActionCallBack, target)
    ;
    (self.caster):LookAtTarget(target)
    self:CallCasterWait((self.config).skill_time)
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).startAnimId, 1, (self.config).start_time, triggerCallBack)
  end
end

bs_40010.OnActionCallBack = function(self, target)
  -- function num : 0_3 , upvalues : _ENV
  local grid = LuaSkillCtrl:GetGridWithRole(target)
  if grid == nil then
    return 
  end
  LuaSkillCtrl:CallEffect(target, (self.config).effectId1, self)
  LuaSkillCtrl:StartTimer(nil, 1, function()
    -- function num : 0_3_0 , upvalues : _ENV, target, self
    LuaSkillCtrl:CallEffect(target, (self.config).effectId3, self)
  end
)
  LuaSkillCtrl:StartTimer(nil, 3, function(csGrid)
    -- function num : 0_3_1 , upvalues : _ENV, target, self
    LuaSkillCtrl:CallEffectWithArg(target, (self.config).effectId2, self, nil, nil, self.SkillEventFunc, csGrid)
  end
, grid)
end

bs_40010.SkillEventFunc = function(self, grid, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local gridTarget = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
    local loop = LuaSkillCtrl:CallEffect(gridTarget, (self.config).monsterEffectId, self)
    local loopAudio = LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId2)
    self.loopAudio = loopAudio
    local Cishu = (self.arglist)[2] // (self.config).freq
    LuaSkillCtrl:StartTimer(nil, (self.config).freq, function()
    -- function num : 0_4_0 , upvalues : self, _ENV, grid
    if self.caster == nil or (self.caster).hp <= 0 then
      return 
    end
    local roles = LuaSkillCtrl:FindRolesAroundGrid(grid, 1)
    if roles ~= nil then
      for i = 0, roles.Count - 1 do
        LuaSkillCtrl:CallBuff(self, roles[i], (self.config).buffId_1130, 1, nil)
        LuaSkillCtrl:DispelBuff(roles[i], (self.config).buffId_1130, 0, true)
        LuaSkillCtrl:PlayAuSource(roles[i], (self.config).audioId3)
      end
    end
  end
, self, Cishu)
    LuaSkillCtrl:StartTimer(nil, (self.arglist)[2], BindCallback(self, self.__killEffectAndAudio, loop, loopAudio))
  end
end

bs_40010.__killEffectAndAudio = function(self, effect, loopAudio)
  -- function num : 0_5 , upvalues : _ENV
  if effect ~= nil then
    effect:Die()
    effect = nil
  end
  if loopAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(loopAudio)
  end
end

bs_40010.BeforeEndBattle = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.loopAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopaudio)
    self.loopAudio = nil
  end
end

bs_40010.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base, _ENV
  (base.OnCasterDie)(self)
  if self.loopAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopaudio)
    self.loopAudio = nil
  end
end

bs_40010.LuaDispose = function(self)
  -- function num : 0_8 , upvalues : base
  (base.LuaDispose)(self)
  self.loopAudio = nil
end

return bs_40010


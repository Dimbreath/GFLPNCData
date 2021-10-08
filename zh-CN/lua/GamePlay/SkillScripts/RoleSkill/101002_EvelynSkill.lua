local bs_101002 = class("bs_101002", LuaSkillBase)
local base = LuaSkillBase
bs_101002.config = {effectId_skill = 101003, actionId = 1002, buffId_66 = 101002, 
hurtConfig = {hit_formula = 0, basehurt_formula = 3010, crit_formula = 0, returndamage_formula = 0}
, audioId1 = 101003, skill_time = 33, start_time = 15}
bs_101002.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_101002.PlaySkill = function(self, data)
  -- function num : 0_1 , upvalues : _ENV
  local belongNum = 2
  local grid = LuaSkillCtrl:CallFindGridMostRolesArounded(belongNum)
  if grid ~= nil then
    local target = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
    self:CallCasterWait((self.config).skill_time)
    local roles = LuaSkillCtrl:FindRolesAroundGrid(grid, belongNum)
    local roles_net = LuaSkillCtrl:FindRolesAroundGrid(grid, 0)
    local triggerCallBack = BindCallback(self, self.OnActionCallBack, target, roles, roles_net)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, 1, (self.config).start_time, triggerCallBack)
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  end
end

bs_101002.OnActionCallBack = function(self, target, roles, roles_net)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallEffectWithArg(target, (self.config).effectId_skill, self, false, false, self.OnEffectTrigger, roles, roles_net)
end

bs_101002.OnEffectTrigger = function(self, roles, roles_net, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if effect.dataId == (self.config).effectId_skill and eventId == eBattleEffectEvent.Trigger then
    if roles ~= nil and roles.Count > 0 then
      for i = 0, roles.Count - 1 do
        if roles[i] ~= nil and (roles[i]).hp > 0 then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, roles[i], (self.config).hurtConfig)
          LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurtConfig, {(self.arglist)[1]})
          skillResult:EndResult()
          LuaSkillCtrl:CallBuff(self, roles[i], (self.config).buffId_66, 1, (self.arglist)[2])
        end
      end
    end
    do
      if roles_net ~= nil and roles_net.Count > 0 then
        for i = 0, roles_net.Count - 1 do
          if roles_net[i] ~= nil and (roles_net[i]).hp > 0 then
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, roles_net[i], (self.config).hurtConfig)
            LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurtConfig, {(self.arglist)[1]})
            skillResult:EndResult()
          end
        end
      end
    end
  end
end

bs_101002.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101002


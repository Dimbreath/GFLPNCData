-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_101002 = class("bs_101002", LuaSkillBase)
local base = LuaSkillBase
bs_101002.config = {effectId_skill = 10203, actionId = 1002, buffId_66 = 66, buffId_115 = 115, 
hurtConfig = {hit_formula = 0, basehurt_formula = 10076, crit_formula = 0, crithur_ratio = 0}
, audioId1 = 74, skill_time = 17, start_time = 15}
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
    local triggerCallBack = BindCallback(self, self.OnActionCallBack, target, roles)
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, 1, (self.config).start_time, triggerCallBack)
  end
end

bs_101002.OnActionCallBack = function(self, target, roles)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallEffectWithArg(target, (self.config).effectId_skill, self, false, false, self.OnEffectTrigger, roles)
end

bs_101002.OnEffectTrigger = function(self, roles, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if effect.dataId == (self.config).effectId_skill and eventId == eBattleEffectEvent.Trigger and roles ~= nil and roles.Count > 0 then
    for i = 0, roles.Count - 1 do
      do
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, roles[i], (self.config).hurtConfig)
        LuaSkillCtrl:PlayAuHit(self, roles[i])
        LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurtConfig)
        skillResult:EndResult()
        LuaSkillCtrl:CallBuff(self, roles[i], (self.config).buffId_66, 1, (self.arglist)[2])
        if (self.arglist)[4] > 0 then
          LuaSkillCtrl:StartTimer(nil, (self.arglist)[2], function()
    -- function num : 0_3_0 , upvalues : _ENV, self, roles, i
    LuaSkillCtrl:CallBuff(self, roles[i], (self.config).buffId_115, 1, (self.arglist)[3])
  end
)
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


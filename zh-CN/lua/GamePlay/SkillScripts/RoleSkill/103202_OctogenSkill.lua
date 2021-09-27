local bs_103202 = class("bs_103202", LuaSkillBase)
local base = LuaSkillBase
bs_103202.config = {actionId = 1002, skill_time = 50, start_time = 5, skill_speed = 1, selectId_skill = 9, 
aoe_config = {effect_shape = eSkillResultShapeType.Block, aoe_select_code = 5, aoe_range = 1}
, 
hurt_config1 = {hit_formula = 0, basehurt_formula = 10078, crit_formula = 0, crithur_ratio = 0}
, 
hurt_config2 = {hit_formula = 0, basehurt_formula = 10079, crit_formula = 0, crithur_ratio = 0}
, effectId_C4trail = 103204, effectId_C4_loop = 103205, audioId1 = 103205, audioId2 = 103206}
bs_103202.ctor = function(self)
  -- function num : 0_0
end

bs_103202.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self.grid_list = {}
  self.boom = {}
  self.boom_Em = {}
  self.boom_time = {}
  self.skill_num = 0
end

bs_103202.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  self.skill_num = self.skill_num + 1
  local skilltime = (self.config).skill_time * 100 // ((self.config).skill_speed * 100)
  local starttime = (self.config).start_time * 100 // ((self.config).skill_speed * 100)
  self:CallCasterWait(skilltime)
  local triggerCallBack = BindCallback(self, self.OnActionCallBack)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, (self.config).skill_speed, starttime, triggerCallBack)
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
end

bs_103202.OnActionCallBack = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId_skill, 10)
  local grid_list = {}
  local time = (self.arglist)[1]
  local times = (self.arglist)[1]
  if targetList.Count > 0 then
    for i = 1, times do
      if time > 0 then
        do
          for i = 0, targetList.Count - 1 do
            local role = (targetList[i]).targetRole
            if role.belongNum == eBattleRoleBelong.enemy and time > 0 then
              local grid_dict = LuaSkillCtrl:FindEmptyGridsWithinRange(role.x, role.y, 5)
              if grid_dict ~= nil and grid_dict.Count > 0 then
                for i = 0, grid_dict.Count - 1 do
                  if (self.grid_list)[grid_dict[i]] == nil then
                    local target_role = LuaSkillCtrl:GetTargetWithGrid((grid_dict[i]).x, (grid_dict[i]).y)
                    do
                      local BJ = time + self.skill_num * 5
                      LuaSkillCtrl:StartTimer(self, (times - time) * 5, function()
    -- function num : 0_3_0 , upvalues : _ENV, target_role, self, BJ
    LuaSkillCtrl:CallEffectWithArg(target_role, (self.config).effectId_C4trail, self, nil, nil, self.OnEffectTrigger, BJ)
  end
)
                      time = time - 1
                      -- DECOMPILER ERROR at PC76: Confused about usage of register: R21 in 'UnsetPending'

                      ;
                      (self.grid_list)[grid_dict[i]] = true
                      break
                    end
                  end
                end
                do
                  -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
        end
      else
        break
      end
    end
  end
  do
    if time > 0 then
      for i = 1, (time) * 2 do
        local grid = LuaSkillCtrl:FindEmptyGrid(nil)
        if grid ~= nil and (self.grid_list)[grid] == nil then
          local target_role = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
          local BJ = time + self.skill_num * 5
          LuaSkillCtrl:StartTimer(self, (times - (time)) * 5, function()
    -- function num : 0_3_1 , upvalues : _ENV, target_role, self, BJ
    LuaSkillCtrl:CallEffectWithArg(target_role, (self.config).effectId_C4trail, self, nil, nil, self.OnEffectTrigger, BJ)
  end
)
          time = time - 1
        end
      end
    end
    do
      if time > 0 then
      end
    end
  end
end

bs_103202.OnEffectTrigger = function(self, time, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R5 in 'UnsetPending'

  if eventId == eBattleEffectEvent.Trigger then
    if (self.boom)[time] == nil then
      (self.boom)[time] = LuaSkillCtrl:CallEffect(target, (self.config).effectId_C4_loop, self)
    end
    local collisionEnter = BindCallback(self, self.OnCollisionEnter, time, target)
    LuaSkillCtrl:CallAddCircleColliderForEffect((self.boom)[time], 30, eColliderInfluenceType.Enemy, nil, collisionEnter, nil)
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.boom_time)[time] = LuaSkillCtrl:StartTimer(nil, (self.arglist)[2], function()
    -- function num : 0_4_0 , upvalues : _ENV, self, target, time
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, (self.config).aoe_config)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config1)
    skillResult:EndResult()
    if (self.boom)[time] ~= nil then
      ((self.boom)[time]):Die()
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (self.boom)[time] = nil
    end
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

    if (self.boom_time)[time] ~= nil then
      (self.boom_time)[time] = nil
    end
    local grid = LuaSkillCtrl:GetGridWithPos(target.x, target.y)
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R2 in 'UnsetPending'

    if (self.grid_list)[grid] ~= nil then
      (self.grid_list)[grid] = nil
    end
  end
)
  end
end

bs_103202.OnCollisionEnter = function(self, time, target, collider, index, entity)
  -- function num : 0_5 , upvalues : _ENV
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity, (self.config).aoe_config)
  LuaSkillCtrl:PlayAuHit(self, entity)
  LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config2)
  skillResult:EndResult()
  if (self.boom)[time] ~= nil then
    ((self.boom)[time]):Die()
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self.boom)[time] = nil
  end
  if (self.boom_time)[time] ~= nil then
    ((self.boom_time)[time]):Stop()
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self.boom_time)[time] = nil
  end
  local grid = LuaSkillCtrl:GetGridWithPos(target.x, target.y)
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R8 in 'UnsetPending'

  if (self.grid_list)[grid] ~= nil then
    (self.grid_list)[grid] = nil
  end
end

bs_103202.LuaDispose = function(self)
  -- function num : 0_6 , upvalues : base
  (base.LuaDispose)(self)
  self.grid_list = nil
  self.boom = nil
  self.boom_Em = nil
  self.boom_time = nil
end

bs_103202.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103202


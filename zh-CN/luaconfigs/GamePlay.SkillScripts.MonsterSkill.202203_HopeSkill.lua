-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202203 = class("bs_202203", LuaSkillBase)
local base = LuaSkillBase
bs_202203.config = {effectIdline = 10430, effectId1 = 10428, effectId2 = 10429, effectId3 = 10431, effectId4 = 10432, monsterId = 11, 
HurtConfig = {def_formula = 9996, basehurt_formula = 10079, minhurt_formula = 9994, crithur_ratio = 9995, correct_formula = 9989, lifesteal_formula = 1001, spell_lifesteal_formula = 1002, returndamage_formula = 1000, hit_formula = 0, crit_formula = 0}
, skill_time = 30, start_time = 18, startAnimId = 1002, maxNum = 5, select_id = 42, select_range = 10, radius = 10, speed = 5}
bs_202203.ctor = function(self)
  -- function num : 0_0
end

bs_202203.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self.summonerEffectSkill = {}
  self.timenumSkill = {}
  self.summnerListSkill = {}
  self.startCleanSkill = false
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).num = 0
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).hope_hurt = (self.arglist)[4]
end

bs_202203.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  if ((self.caster).recordTable).num < (self.config).maxNum then
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
    self:CallCasterWait((self.config).skill_time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).startAnimId, 1, (self.config).start_time, attackTrigger)
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self, nil, nil, nil, true)
  end
end

bs_202203.FindEmptyGrid = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local grid = nil
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, (self.config).select_id, (self.config).select_range)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      grid = LuaSkillCtrl:FindEmptyGridAroundRole((targetlist[i]).targetRole)
      if grid ~= nil then
        return grid
      end
    end
  end
  do
    grid = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
    return grid
  end
end

bs_202203.OnAttackTrigger = function(self, data)
  -- function num : 0_4 , upvalues : _ENV
  local grid = self:FindEmptyGrid()
  if grid == nil then
    return 
  end
  local target = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
  LuaSkillCtrl:CallEffect(target, (self.config).effectId2, self)
  local summoner = LuaSkillCtrl:CreateSummoner(self, (self.config).monsterId, grid.x, grid.y)
  summoner:SetAttr(eHeroAttr.maxHp, (self.caster).maxHp * (self.arglist)[2] // 1000)
  summoner:SetAttr(eHeroAttr.pow, (self.caster).pow)
  summoner:SetAttr(eHeroAttr.speed, (self.caster).speed)
  summoner:SetAttr(eHeroAttr.def, (self.caster).def)
  summoner:SetAttr(eHeroAttr.skill_intensity, (self.caster).skill_intensity)
  summoner:SetAsRealEntity(1)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  if self.summnerListSkill == nil then
    self.summnerListSkill = {}
  end
  ;
  (table.insert)(self.summnerListSkill, summonerEntity)
  if summonerEntity ~= nil then
    if self.summonerEffectSkill == nil then
      self.summonerEffectSkill = {}
    end
    if self.timenumSkill == nil then
      self.timenumSkill = {}
    end
    -- DECOMPILER ERROR at PC98: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.summonerEffectSkill)[summonerEntity] = LuaSkillCtrl:CallEffect(summonerEntity, (self.config).effectIdline, self, nil, nil, nil, false)
    local cb = BindCallback(self, self.CheckSummonerSkill, summonerEntity)
    -- DECOMPILER ERROR at PC115: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self.timenumSkill)[summonerEntity] = LuaSkillCtrl:StartTimer(nil, (self.arglist)[3], cb, nil, -1, 0)
    -- DECOMPILER ERROR at PC122: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.caster).recordTable).num = ((self.caster).recordTable).num + 1
  end
end

bs_202203.CheckSummonerSkill = function(self, summonerEntity)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  if (self.timenumSkill)[summonerEntity] ~= nil and ((self.timenumSkill)[summonerEntity]):IsOver() then
    (self.timenumSkill)[summonerEntity] = nil
  end
  if self.startCleanSkill then
    return 
  end
  if summonerEntity.hp > 0 then
    local cusEffect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId3, self)
    local target2 = summonerEntity
    local collisionTrigger = BindCallback(self, self.OnCollision)
    LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target2, (self.config).radius, (self.config).speed, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, cusEffect, false, true, nil)
  else
    do
      if self.summonerEffectSkill ~= nil then
        if (self.summonerEffectSkill)[summonerEntity] ~= nil then
          ((self.summonerEffectSkill)[summonerEntity]):Die()
          -- DECOMPILER ERROR at PC62: Confused about usage of register: R2 in 'UnsetPending'

          ;
          (self.summonerEffectSkill)[summonerEntity] = nil
        end
        if (self.timenumSkill)[summonerEntity] ~= nil then
          ((self.timenumSkill)[summonerEntity]):Stop()
          -- DECOMPILER ERROR at PC72: Confused about usage of register: R2 in 'UnsetPending'

          ;
          (self.timenumSkill)[summonerEntity] = nil
        end
      end
      if self.summnerListSkill ~= nil then
        (table.removebyvalue)(self.summnerListSkill, summonerEntity)
      end
      -- DECOMPILER ERROR at PC87: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.caster).recordTable).num = ((self.caster).recordTable).num - 1
    end
  end
end

bs_202203.OnCollision = function(self, collider, index, entity)
  -- function num : 0_6 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(entity, (self.config).effectId4, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:PlayAuHit(self, entity)
  LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig)
  skillResult:EndResult()
end

bs_202203.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnCasterDie)(self)
  self.startCleanSkill = true
  if self.summnerListSkill ~= nil then
    for i = 1, #self.summnerListSkill do
      local summonerEntity = (self.summnerListSkill)[i]
      if (self.summonerEffectSkill)[summonerEntity] ~= nil then
        ((self.summonerEffectSkill)[summonerEntity]):Die()
        -- DECOMPILER ERROR at PC23: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (self.summonerEffectSkill)[summonerEntity] = nil
      end
      if (self.timenumSkill)[summonerEntity] ~= nil then
        ((self.timenumSkill)[summonerEntity]):Stop()
        -- DECOMPILER ERROR at PC33: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (self.timenumSkill)[summonerEntity] = nil
      end
    end
  end
  do
    self.summnerListSkill = nil
    self.summonerEffectSkill = nil
    self.timenumSkill = nil
  end
end

bs_202203.LuaDispose = function(self)
  -- function num : 0_8 , upvalues : base
  (base.LuaDispose)(self)
  self.summnerListSkill = nil
  self.summonerEffectSkill = nil
  self.timenumSkill = nil
end

return bs_202203


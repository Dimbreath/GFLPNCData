-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202201 = class("bs_202201", LuaSkillBase)
local base = LuaSkillBase
bs_202201.config = {effectIdline = 10430, effectId1 = 10428, effectId2 = 10429, effectId3 = 10431, effectId4 = 10432, monsterId = 11, 
HurtConfig = {def_formula = 9996, basehurt_formula = 10086, minhurt_formula = 9994, crithur_ratio = 9995, correct_formula = 9989, lifesteal_formula = 1001, spell_lifesteal_formula = 1002, returndamage_formula = 1000, hit_formula = 0, crit_formula = 0}
, select_id = 42, select_range = 10, calFormula = 10006, maxNum = 5, skill_time = 30, start_time = 18, startAnimId = 1002, radius = 10, speed = 5}
bs_202201.ctor = function(self)
  -- function num : 0_0
end

bs_202201.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_202201_3", 1, self.OnAfterHurt, nil, self.caster)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).hurt = 0
  self.summonerEffect = {}
  self.timenum = {}
  self.summnerList = {}
  self.startClean = false
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).num = 0
end

bs_202201.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R9 in 'UnsetPending'

  if target == self.caster and sender ~= self.caster and ((self.caster).recordTable).num < (self.config).maxNum then
    ((self.caster).recordTable).hurt = ((self.caster).recordTable).hurt + hurt
    local hurt_num = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).calFormula, self.caster, sender, self)
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R10 in 'UnsetPending'

    if hurt_num <= ((self.caster).recordTable).hurt then
      ((self.caster).recordTable).hurt = 0
      local grid = nil
      local targetlist = LuaSkillCtrl:CallTargetSelect(self, (self.config).select_id, (self.config).select_range)
      if targetlist.Count > 0 then
        for i = 0, targetlist.Count - 1 do
          grid = LuaSkillCtrl:FindEmptyGridAroundRole((targetlist[i]).targetRole)
        end
      end
      do
        if grid ~= nil or grid == nil then
          grid = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
        end
        if grid == nil then
          return 
        end
        if grid ~= nil then
          LuaSkillCtrl:CallBreakAllSkill(self.caster)
          local attackTrigger = BindCallback(self, self.OnAttackTrigger, grid, data)
          self:CallCasterWait((self.config).skill_time)
          LuaSkillCtrl:CallRoleAction(self.caster, (self.config).startAnimId)
          LuaSkillCtrl:StartTimer(self, (self.config).start_time, attackTrigger)
          LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self, nil, nil, nil, true)
        end
      end
    end
  end
end

bs_202201.OnAttackTrigger = function(self, grid, data)
  -- function num : 0_3 , upvalues : _ENV
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
  ;
  (table.insert)(self.summnerList, summonerEntity)
  -- DECOMPILER ERROR at PC78: Confused about usage of register: R6 in 'UnsetPending'

  if summonerEntity ~= nil then
    (self.summonerEffect)[summonerEntity] = LuaSkillCtrl:CallEffect(summonerEntity, (self.config).effectIdline, self, nil, nil, nil, false)
    local cb = BindCallback(self, self.CheckSummoner, summonerEntity)
    -- DECOMPILER ERROR at PC95: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self.timenum)[summonerEntity] = LuaSkillCtrl:StartTimer(nil, (self.arglist)[3], cb, nil, -1, 0)
    -- DECOMPILER ERROR at PC102: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.caster).recordTable).num = ((self.caster).recordTable).num + 1
  end
end

bs_202201.CheckSummoner = function(self, summonerEntity)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  if (self.timenum)[summonerEntity] ~= nil and ((self.timenum)[summonerEntity]):IsOver() then
    (self.timenum)[summonerEntity] = nil
  end
  if self.startClean then
    return 
  end
  if summonerEntity.hp > 0 then
    local cusEffect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId3, self)
    local target2 = summonerEntity
    local collisionTrigger = BindCallback(self, self.OnCollision)
    self.skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target2, (self.config).radius, (self.config).speed, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, cusEffect, false, true, nil)
  else
    do
      if self.summonerEffect ~= nil then
        if (self.summonerEffect)[summonerEntity] ~= nil then
          ((self.summonerEffect)[summonerEntity]):Die()
          -- DECOMPILER ERROR at PC63: Confused about usage of register: R2 in 'UnsetPending'

          ;
          (self.summonerEffect)[summonerEntity] = nil
        end
        if (self.timenum)[summonerEntity] ~= nil then
          ((self.timenum)[summonerEntity]):Stop()
          -- DECOMPILER ERROR at PC73: Confused about usage of register: R2 in 'UnsetPending'

          ;
          (self.timenum)[summonerEntity] = nil
        end
      end
      ;
      (table.removebyvalue)(self.summnerList, summonerEntity)
      -- DECOMPILER ERROR at PC85: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.caster).recordTable).num = ((self.caster).recordTable).num - 1
    end
  end
end

bs_202201.OnCollision = function(self, collider, index, entity)
  -- function num : 0_5 , upvalues : _ENV
  local num = ((self.caster).recordTable).hope_hurt
  LuaSkillCtrl:CallEffect(entity, (self.config).effectId4, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:PlayAuHit(self, entity)
  LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {num})
  skillResult:EndResult()
end

bs_202201.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
  self.startClean = true
  if self.summnerList ~= nil then
    for i = 1, #self.summnerList do
      local summonerEntity = (self.summnerList)[i]
      if (self.summonerEffect)[summonerEntity] ~= nil then
        ((self.summonerEffect)[summonerEntity]):Die()
        -- DECOMPILER ERROR at PC23: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (self.summonerEffect)[summonerEntity] = nil
      end
      if (self.timenum)[summonerEntity] ~= nil then
        ((self.timenum)[summonerEntity]):Stop()
        -- DECOMPILER ERROR at PC33: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (self.timenum)[summonerEntity] = nil
      end
    end
  end
  do
    self.summnerList = nil
    self.summonerEffect = nil
    self.timenum = nil
  end
end

bs_202201.LuaDispose = function(self)
  -- function num : 0_7 , upvalues : base
  (base.LuaDispose)(self)
  self.summnerList = nil
  self.summonerEffect = nil
  self.timenum = nil
end

return bs_202201


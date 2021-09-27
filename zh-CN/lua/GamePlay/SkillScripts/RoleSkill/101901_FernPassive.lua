local bs_101901 = class("bs_101901", LuaSkillBase)
local base = LuaSkillBase
bs_101901.config = {monsterId = 14, effectId1 = 10687, effectId2 = 10686, effectId3 = 10699, effectId_db = 10700, 
hurtConfig = {hit_formula = 0, basehurt_formula = 10081, crit_formula = 0, crithur_ratio = 0}
, buffId_229 = 229, skill_time = 47, start_time = 27, actionId = 1002, action_speed = 1, audioId1 = 219, audioId2 = 220}
bs_101901.ctor = function(self)
  -- function num : 0_0
end

bs_101901.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_101901_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_101901_10", 1, self.OnRoleDie)
  self.summonerEntity = nil
end

bs_101901.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if LuaSkillCtrl.IsInTDBattle ~= true then
    self:PlaySkill()
  end
end

bs_101901.PlaySkill = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if (self.caster).hp <= 0 then
    return 
  end
  local Grid = LuaSkillCtrl:FindRoleRightEmptyGrid(self.caster, 10)
  if Grid == nil then
    Grid = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
  end
  if Grid ~= nil then
    local speed = (self.caster).speed
    do
      speed = speed + (self.arglist)[6]
      local summoner = LuaSkillCtrl:CreateSummoner(self, (self.config).monsterId, Grid.x, Grid.y)
      summoner:SetAttr(eHeroAttr.maxHp, (self.caster).skill_intensity * (self.arglist)[1] // 1000)
      summoner:SetAttr(eHeroAttr.pow, (self.caster).skill_intensity * (self.arglist)[2] // 1000)
      summoner:SetAttr(eHeroAttr.speed, speed)
      summoner:SetAttr(eHeroAttr.moveSpeed, (self.caster).moveSpeed)
      summoner:SetAttr(eHeroAttr.def, (self.caster).skill_intensity * (self.arglist)[3] // 1000)
      summoner:SetAttr(eHeroAttr.magic_res, (self.caster).skill_intensity * (self.arglist)[3] // 1000)
      summoner:SetAttr(eHeroAttr.lucky, (self.arglist)[5])
      summoner:SetAsRealEntity(1)
      LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, (self.config).start_time)
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_229, 1, (self.config).skill_time - 2)
      if self.effect2 ~= nil then
        (self.effect2):Die()
        self.effect2 = nil
      end
      local maxhp = (self.caster).skill_intensity * (self.arglist)[1] // 1000 * 10
      self.summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
      LuaSkillCtrl:CallBuff(self, self.summonerEntity, 270, 1, 27, true)
      LuaSkillCtrl:StartTimer(nil, 26, function()
    -- function num : 0_3_0 , upvalues : self, _ENV, maxhp
    if self.caster == nil or (self.caster).hp <= 0 then
      LuaSkillCtrl:RemoveLife(maxhp, self, self.summonerEntity, true, nil, false, true, 2)
    end
  end
)
      local target = LuaSkillCtrl:GetTargetWithGrid(Grid.x, Grid.y)
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, Grid, summoner, target)
      ;
      (self.caster):LookAtTarget(target)
      self:CallCasterWait((self.config).skill_time)
      LuaSkillCtrl:CallRoleAction(self, (self.config).actionId, 1)
      LuaSkillCtrl:StartTimer(nil, (self.config).start_time, attackTrigger)
      LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
      self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self, nil, nil, nil, true)
      self.effect2 = LuaSkillCtrl:CallEffect(target, (self.config).effectId_db, self, nil, nil, nil, true)
    end
  end
end

bs_101901.OnAttackTrigger = function(self, grid, summoner, target)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(target, (self.config).effectId2, self)
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId2)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.caster).recordTable).sum = true
  LuaSkillCtrl:StartTimer(nil, 10, function()
    -- function num : 0_4_0 , upvalues : self
    if self.effect ~= nil then
      (self.effect):Die()
      self.effect = nil
    end
    if self.effect2 ~= nil then
      (self.effect2):Die()
      self.effect2 = nil
    end
  end
)
end

bs_101901.OnRoleDie = function(self, killer, role)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  if role == self.summonerEntity then
    ((self.caster).recordTable).sum = false
    self.again = LuaSkillCtrl:StartTimer(nil, (self.arglist)[4], function()
    -- function num : 0_5_0 , upvalues : self
    if self.again ~= nil and (self.again):IsOver() then
      self.again = nil
    end
    self:PlaySkill()
  end
, self)
  end
end

bs_101901.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
  if self.again ~= nil then
    (self.again):Stop()
    self.again = nil
  end
end

bs_101901.LuaDispose = function(self)
  -- function num : 0_7 , upvalues : base
  (base.LuaDispose)(self)
  self.effect = nil
  self.effect2 = nil
  self.summonerEntity = nil
  if self.again ~= nil then
    (self.again):Stop()
    self.again = nil
  end
end

return bs_101901


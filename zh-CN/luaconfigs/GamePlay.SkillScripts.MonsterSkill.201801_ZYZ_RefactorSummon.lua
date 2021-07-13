-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40035 = class("bs_40035", LuaSkillBase)
local base = LuaSkillBase
bs_40035.config = {
smallMonsterId = {3, 4, 5}
, 
middleMonsterId = {6, 7, 8}
, 
bigMonsterId = {9, 10}
, buffId = 1033, effectId = 10264, effectId1 = 10263, startAnimID = 1002, maxEnemyNum = 8, maxSummonNum = 10, buffId_196 = 196, buffId_1033 = 1033, skill_time = 18, maxHpPer = 150, powPer = 700}
bs_40035.ctor = function(self)
  -- function num : 0_0
end

bs_40035.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_40035_1", 1, self.OnAfterBattleStart)
end

bs_40035.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.damTimer = LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], self.CallBack, self, -1, (self.arglist)[1])
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_1033, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_196, 1, nil, true)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["40035_SummonTime"] = 0
end

bs_40035.CallBack = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.enemy)
  if targetList.Count < (self.config).maxEnemyNum then
    local gridData = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
    if gridData == nil then
      return 
    end
    self:CallCasterWait((self.config).skill_time)
    local moveAttackTrigger = BindCallback(self, self.OnMoveAttackTrigger, self.caster, data, gridData)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).startAnimID, 1, (self.config).skill_time, moveAttackTrigger)
  end
end

bs_40035.OnMoveAttackTrigger = function(self, target, data, gridData)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
  local cback = BindCallback(self, self.CallBack1, gridData.x, gridData.y)
  self.damTimer2 = LuaSkillCtrl:StartTimer(nil, 2, cback, nil, 0, 0)
end

bs_40035.CallBack1 = function(self, x, y)
  -- function num : 0_5 , upvalues : _ENV
  if self.damTimer2 ~= nil and (self.damTimer2):IsOver() then
    self.damTimer2 = nil
  end
  local gridData = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
  if gridData == nil then
    return 
  end
  x = gridData.x
  y = gridData.y
  local target = LuaSkillCtrl:GetTargetWithGrid(gridData.x, gridData.y)
  LuaSkillCtrl:CallEffect(target, (self.config).effectId, self)
  if ((self.caster).recordTable)["40035_SummonTime"] < (self.config).maxSummonNum then
    local summoner = LuaSkillCtrl:CreateSummoner(self, ((self.config).middleMonsterId)[LuaSkillCtrl:CallRange(1, 3)], x, y)
    summoner:SetAttr(eHeroAttr.maxHp, (self.caster).maxHp * (self.config).maxHpPer // 1000)
    summoner:SetAttr(eHeroAttr.pow, (self.caster).pow * (self.config).powPer // 1000)
    summoner:SetAttr(eHeroAttr.speed, (self.caster).speed)
    summoner:SetAsRealEntity(1)
    local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  else
    do
      local summoner = LuaSkillCtrl:CreateSummoner(self, ((self.config).middleMonsterId)[LuaSkillCtrl:CallRange(1, 3)], x, y)
      summoner:SetAttr(eHeroAttr.maxHp, (self.caster).maxHp * (self.config).maxHpPer // 1000)
      summoner:SetAttr(eHeroAttr.pow, (self.caster).pow * (self.config).powPer // 1000)
      summoner:SetAttr(eHeroAttr.speed, (self.caster).speed)
      summoner:SetAsRealEntity(1)
      do
        local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
        local damage = (self.caster).maxHp * (self.arglist)[2] // 1000
        if (self.caster).hp > 1 then
          LuaSkillCtrl:RemoveLife(damage, self, self.caster)
          -- DECOMPILER ERROR at PC154: Confused about usage of register: R6 in 'UnsetPending'

          ;
          ((self.caster).recordTable)["40035_SummonTime"] = ((self.caster).recordTable)["40035_SummonTime"] + 1
        end
      end
    end
  end
end

bs_40035.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
  if self.damTimer then
    (self.damTimer):Stop()
    self.damTimer = nil
  end
  if self.damTimer2 then
    (self.damTimer2):Stop()
    self.damTimer2 = nil
  end
end

return bs_40035


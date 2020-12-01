-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1069 = class("bs_1069", LuaSkillBase)
local base = LuaSkillBase
bs_1069.config = {monsterId1 = 12, monsterId2 = 13}
bs_1069.ctor = function(self)
  -- function num : 0_0
end

bs_1069.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_1069_10", 1, self.OnRoleDie)
end

bs_1069.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 15, 10)
  if targetList.Count <= 0 then
    return 
  end
  self:CallCasterWait(30)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, (targetList[0]).targetRole)
  ;
  (self.caster):LookAtTarget((targetList[0]).targetRole)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectStartId, self)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 1, attackTrigger)
end

bs_1069.OnAttackTrigger = function(self, target)
  -- function num : 0_3 , upvalues : _ENV
  local summoner = LuaSkillCtrl:CreateSummoner(self, (self.config).monsterId2, target.x, target.y)
  summoner:SetAttr(eHeroAttr.maxHp, 300)
  summoner:SetAttr(eHeroAttr.pow, 100)
  summoner:SetAttr(eHeroAttr.speed, 100)
  summoner:SetAsRealEntity(6)
  local tab = {attackTarget = target}
  summoner:SetRecordTable(tab)
  local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  summonerEntity:BindHostEntity(target)
end

bs_1069.OnRoleDie = function(self, killer, role)
  -- function num : 0_4
end

bs_1069.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1069

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1069 = class("bs_1069", LuaSkillBase)
local base = LuaSkillBase
bs_1069.config = {monsterId1 = 12, monsterId2 = 13}
bs_1069.ctor = function(self)
    -- function num : 0_0
end

bs_1069.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.RoleDie, "bs_1069_10", 1, self.OnRoleDie)
end

bs_1069.PlaySkill = function(self, data)
    -- function num : 0_2 , upvalues : _ENV
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 15, 10)
    if targetList.Count <= 0 then return end
    self:CallCasterWait(30)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger,
                                       (targetList[0]).targetRole);
    (self.caster):LookAtTarget((targetList[0]).targetRole)
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectStartId, self)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 1,
                                           attackTrigger)
end

bs_1069.OnAttackTrigger = function(self, target)
    -- function num : 0_3 , upvalues : _ENV
    local summoner = LuaSkillCtrl:CreateSummoner(self, (self.config).monsterId2,
                                                 target.x, target.y)
    summoner:SetAttr(eHeroAttr.maxHp, 300)
    summoner:SetAttr(eHeroAttr.pow, 100)
    summoner:SetAttr(eHeroAttr.speed, 100)
    summoner:SetAsRealEntity(6)
    local tab = {attackTarget = target}
    summoner:SetRecordTable(tab)
    local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
    summonerEntity:BindHostEntity(target)
end

bs_1069.OnRoleDie = function(self, killer, role)
    -- function num : 0_4
end

bs_1069.OnCasterDie = function(self)
    -- function num : 0_5 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_1069


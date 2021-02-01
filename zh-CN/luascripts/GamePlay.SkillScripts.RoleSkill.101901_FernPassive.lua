-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_201901 = class("bs_201901", LuaSkillBase)
local base = LuaSkillBase
bs_201901.config = {monsterId = 14, effectId1 = 10687, effectId2 = 10686, effectId3 = 10699, effectId_db = 10700, 
hurtConfig = {hit_formula = 0, basehurt_formula = 10081, crit_formula = 0, crithur_ratio = 0}
, buffId229 = 229}
bs_201901.ctor = function(self)
  -- function num : 0_0
end

bs_201901.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_201901_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_201901_10", 1, self.OnRoleDie)
end

bs_201901.OnAfterBattleStart = function(self)
  -- function num : 0_2
  self:PlaySkill()
end

bs_201901.PlaySkill = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local Grid = LuaSkillCtrl:FindRoleRightEmptyGrid(self.caster, 10)
  if Grid == nil then
    Grid = LuaSkillCtrl:CallFindEmptyGridNearest(self.caster)
  end
  if Grid ~= nil then
    local speed = (self.caster).speed
    if (self.arglist)[5] > 0 then
      speed = speed + (self.arglist)[6]
    end
    local summoner = LuaSkillCtrl:CreateSummoner(self, (self.config).monsterId, Grid.x, Grid.y)
    summoner:SetAttr(eHeroAttr.maxHp, (self.caster).skill_intensity * (self.arglist)[1] // 1000)
    summoner:SetAttr(eHeroAttr.pow, (self.caster).skill_intensity * (self.arglist)[2] // 1000)
    summoner:SetAttr(eHeroAttr.speed, speed)
    summoner:SetAttr(eHeroAttr.moveSpeed, (self.caster).moveSpeed)
    summoner:SetAttr(eHeroAttr.def, (self.caster).skill_intensity * (self.arglist)[3] // 1000)
    summoner:SetAttr(eHeroAttr.lucky, (self.arglist)[5])
    summoner:SetAsRealEntity(1)
    LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 27)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId229, 1, 44)
    self.isPreSet = true
    LuaSkillCtrl:PreSetRolePos(Grid, self.caster)
    LuaSkillCtrl:StartTimer(nil, 28, BindCallback(self, self.__canclePreSetPos))
    local target = LuaSkillCtrl:GetTargetWithGrid(Grid.x, Grid.y)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, Grid, summoner, target)
    ;
    (self.caster):LookAtTarget(target)
    self:CallCasterWait(47)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 27, attackTrigger)
    self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self, nil, nil, nil, true)
    self.effect2 = LuaSkillCtrl:CallEffect(target, (self.config).effectId_db, self, nil, nil, nil, true)
  end
end

bs_201901.__canclePreSetPos = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self.caster ~= nil and self.isPreSet then
    LuaSkillCtrl:CanclePreSetPos(self.caster)
    self.isPreSet = false
  end
end

bs_201901.OnAttackTrigger = function(self, grid, summoner, target)
  -- function num : 0_5 , upvalues : _ENV
  self:__canclePreSetPos()
  LuaSkillCtrl:CallEffect(target, (self.config).effectId2, self)
  self.summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.caster).recordTable).sum = true
  LuaSkillCtrl:StartTimer(nil, 10, function()
    -- function num : 0_5_0 , upvalues : self
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

bs_201901.OnRoleDie = function(self, killer, role)
  -- function num : 0_6 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  if role == self.summonerEntity then
    ((self.caster).recordTable).sum = false
    LuaSkillCtrl:StartTimer(nil, (self.arglist)[4], function()
    -- function num : 0_6_0 , upvalues : self
    self:PlaySkill()
  end
)
  end
end

bs_201901.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnCasterDie)(self)
  self:__canclePreSetPos()
end

return bs_201901


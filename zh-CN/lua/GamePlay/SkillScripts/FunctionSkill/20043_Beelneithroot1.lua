local bs_20043 = class("bs_20043", LuaSkillBase)
local base = LuaSkillBase
bs_20043.config = {cakeSummonerId = 16, buffId_198 = 198, buffId_253 = 253, cakeBornInterval = 300, cakeFallEffect = 10832, cakeEffect = 10408}
bs_20043.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.__createCakeFunc = BindCallback(self, self.CreateCakeAndTauntToCaster)
end

bs_20043.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_20043_1", 1, self.OnAfterBattleStart)
end

bs_20043.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.checkAndCreateCakeTimer = LuaSkillCtrl:StartTimer(self, (self.config).cakeBornInterval, self.__createCakeFunc, nil, -1, (self.config).cakeBornInterval)
end

bs_20043.CreateCakeAndTauntToCaster = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.checkAndCreateCakeTimer ~= nil and (self.checkAndCreateCakeTimer):IsOver() then
    self.checkAndCreateCakeTimer = nil
  end
  local grid = LuaSkillCtrl:FindEmptyGrid(nil)
  if grid == nil then
    if self.checkAndCreateCakeTimer ~= nil then
      (self.checkAndCreateCakeTimer):Stop()
      self.checkAndCreateCakeTimer = nil
    end
    return 
  end
  local gridTarget = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
  local cakeEffect = LuaSkillCtrl:CallEffectWithArg(gridTarget, (self.config).cakeFallEffect, self, false, false, self.AfterEffectArive, grid)
  LuaSkillCtrl:PreSetRolePos(grid, self.caster)
end

bs_20043.AfterEffectArive = function(self, grid, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CanclePreSetPos(self.caster)
    local cakeSum = LuaSkillCtrl:CreateSummoner(self, (self.config).cakeSummonerId, grid.x, grid.y, eBattleRoleBelong.player)
    if cakeSum == nil then
      return 
    end
    cakeSum:SetAttr(eHeroAttr.maxHp, 99999)
    cakeSum:SetAttr(eHeroAttr.attackRange, 10)
    cakeSum:SetAsRealEntity(1)
    local summonerEntity = LuaSkillCtrl:AddSummonerRole(cakeSum)
    LuaSkillCtrl:CallBuff(self, summonerEntity, (self.config).buffId_253, 1, nil, true)
    LuaSkillCtrl:CallEffect(summonerEntity, (self.config).cakeEffect, self)
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (summonerEntity.recordTable).caster = self.caster
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (summonerEntity.recordTable).cakeEffect = effect
  end
end

bs_20043.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : _ENV, base
  LuaSkillCtrl:CanclePreSetPos(self.caster)
  if self.checkAndCreateCakeTimer ~= nil then
    (self.checkAndCreateCakeTimer):Stop()
    self.checkAndCreateCakeTimer = nil
  end
  ;
  (base.OnCasterDie)(self)
end

return bs_20043


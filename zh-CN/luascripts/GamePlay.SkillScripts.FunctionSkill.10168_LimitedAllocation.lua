-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10168 = class("bs_10168", LuaSkillBase)
local base = LuaSkillBase
bs_10168.config = {damageFormular = 1047, buffId1 = 1003, buffId2 = 1011}
bs_10168.ctor = function(self)
  -- function num : 0_0
end

bs_10168.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10168_1", 1, self.OnAfterBattleStart)
end

bs_10168.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local sender = self.caster
  local damageNum = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).damageFormular, self.caster, target, self)
  if damageNum < 1 then
    return 
  end
  self:PlayChipEffect()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 0)
  if targetList.Count <= 0 then
    return 
  end
  local target = nil
  for i = 0, targetList.Count - 1 do
    local target_tmp = (targetList[i]).targetRole
    if target_tmp.y == (self.caster).y and target_tmp.x == (self.caster).x - 1 then
      target = (targetList[i]).targetRole
    end
  end
  if target == nil then
    return 
  end
  local buffTier2 = (self.arglist)[1] // 10
  local buffTier1 = damageNum * 1000 // target.maxHp
  LuaSkillCtrl:CallBuff(self, sender, (self.config).buffId2, buffTier2)
  LuaSkillCtrl:CallBuff(self, target, (self.config).buffId1, buffTier1)
  LuaSkillCtrl:RemoveLife(damageNum, self, sender, true, true)
  LuaSkillCtrl:CallHeal(damageNum, self, target)
end

bs_10168.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10168

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10168 = class("bs_10168", LuaSkillBase)
local base = LuaSkillBase
bs_10168.config = {damageFormular = 1047, buffId1 = 1003, buffId2 = 1011}
bs_10168.ctor = function(self)
    -- function num : 0_0
end

bs_10168.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10168_1", 1,
                    self.OnAfterBattleStart)
end

bs_10168.OnAfterBattleStart = function(self)
    -- function num : 0_2 , upvalues : _ENV
    local sender = self.caster
    local damageNum = LuaSkillCtrl:CallFormulaNumberWithSkill(
                          (self.config).damageFormular, self.caster, target,
                          self)
    if damageNum < 1 then return end
    self:PlayChipEffect()
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 0)
    if targetList.Count <= 0 then return end
    local target = nil
    for i = 0, targetList.Count - 1 do
        local target_tmp = (targetList[i]).targetRole
        if target_tmp.y == (self.caster).y and target_tmp.x == (self.caster).x -
            1 then target = (targetList[i]).targetRole end
    end
    if target == nil then return end
    local buffTier2 = (self.arglist)[1] // 10
    local buffTier1 = damageNum * 1000 // target.maxHp
    LuaSkillCtrl:CallBuff(self, sender, (self.config).buffId2, buffTier2)
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId1, buffTier1)
    LuaSkillCtrl:RemoveLife(damageNum, self, sender, true, true)
    LuaSkillCtrl:CallHeal(damageNum, self, target)
end

bs_10168.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10168


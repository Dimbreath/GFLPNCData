-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10210 = class("bs_10210", LuaSkillBase)
local base = LuaSkillBase
bs_10210.config = {checkBuffId = 1059, buffId = 1060}
bs_10210.ctor = function(self)
  -- function num : 0_0
end

bs_10210.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterAddBuff, "bs_10210_7", 1, self.OnAfterAddBuff)
  self:AddTrigger(eSkillTriggerType.BuffDie, "bs_10210_9", 1, self.OnBuffDie)
end

bs_10210.OnAfterAddBuff = function(self, buff, target)
  -- function num : 0_2
  if buff.dataId == (self.config).checkBuffId then
    self:addBuff()
  end
end

bs_10210.OnBuffDie = function(self, buff, target, removeType)
  -- function num : 0_3
  if buff.dataId == (self.config).checkBuffId then
    self:addBuff()
  end
end

bs_10210.addBuff = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local preBuffTier = (self.caster):GetBuffTier((self.config).buffId)
  if preBuffTier > 0 then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
  end
  local buffTier = self:getTotalBuffNum((self.config).checkBuffId)
  if buffTier <= 0 then
    return 
  end
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, buffTier)
end

bs_10210.getTotalBuffNum = function(self, buffId)
  -- function num : 0_5 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetList.Count <= 0 then
    return 0
  end
  local buffTiers = 0
  for i = 0, targetList.Count - 1 do
    buffTiers = buffTiers + ((targetList[i]).targetRole):GetBuffTier((self.config).checkBuffId)
  end
  return buffTiers
end

bs_10210.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10210

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10210 = class("bs_10210", LuaSkillBase)
local base = LuaSkillBase
bs_10210.config = {checkBuffId = 1059, buffId = 1060}
bs_10210.ctor = function(self)
    -- function num : 0_0
end

bs_10210.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterAddBuff, "bs_10210_7", 1,
                    self.OnAfterAddBuff)
    self:AddTrigger(eSkillTriggerType.BuffDie, "bs_10210_9", 1, self.OnBuffDie)
end

bs_10210.OnAfterAddBuff = function(self, buff, target)
    -- function num : 0_2
    if buff.dataId == (self.config).checkBuffId then self:addBuff() end
end

bs_10210.OnBuffDie = function(self, buff, target, removeType)
    -- function num : 0_3
    if buff.dataId == (self.config).checkBuffId then self:addBuff() end
end

bs_10210.addBuff = function(self)
    -- function num : 0_4 , upvalues : _ENV
    local preBuffTier = (self.caster):GetBuffTier((self.config).buffId)
    if preBuffTier > 0 then
        LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
    end
    local buffTier = self:getTotalBuffNum((self.config).checkBuffId)
    if buffTier <= 0 then return end
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, buffTier)
end

bs_10210.getTotalBuffNum = function(self, buffId)
    -- function num : 0_5 , upvalues : _ENV
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    if targetList.Count <= 0 then return 0 end
    local buffTiers = 0
    for i = 0, targetList.Count - 1 do
        buffTiers = buffTiers +
                        ((targetList[i]).targetRole):GetBuffTier(
                            (self.config).checkBuffId)
    end
    return buffTiers
end

bs_10210.OnCasterDie = function(self)
    -- function num : 0_6 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10210


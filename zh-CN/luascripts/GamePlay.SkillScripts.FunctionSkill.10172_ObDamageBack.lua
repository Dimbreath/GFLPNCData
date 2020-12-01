-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10172 = class("bs_10172", LuaSkillBase)
local base = LuaSkillBase
bs_10172.config = {damageFormula = 10011}
bs_10172.ctor = function(self)
  -- function num : 0_0
end

bs_10172.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10172_3", 1, self.OnSetHurt)
end

bs_10172.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if (context.target).intensity == 0 and (context.sender).belongNum == 2 and self:IsReadyToTake() and (context.target).hp <= context.hurt and (context.target).hp > 0 then
    local damage = (math.max)(1, LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).damageFormula, self.caster, context.sender, self))
    LuaSkillCtrl:RemoveLife(damage, self, context.sender)
    self:OnSkillTake()
  end
end

bs_10172.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10172

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10172 = class("bs_10172", LuaSkillBase)
local base = LuaSkillBase
bs_10172.config = {damageFormula = 10011}
bs_10172.ctor = function(self)
    -- function num : 0_0
end

bs_10172.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10172_3", 1, self.OnSetHurt)
end

bs_10172.OnSetHurt = function(self, context)
    -- function num : 0_2 , upvalues : _ENV
    if (context.target).intensity == 0 and (context.sender).belongNum == 2 and
        self:IsReadyToTake() and (context.target).hp <= context.hurt and
        (context.target).hp > 0 then
        local damage = (math.max)(1,
                                  LuaSkillCtrl:CallFormulaNumberWithSkill(
                                      (self.config).damageFormula, self.caster,
                                      context.sender, self))
        LuaSkillCtrl:RemoveLife(damage, self, context.sender)
        self:OnSkillTake()
    end
end

bs_10172.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10172


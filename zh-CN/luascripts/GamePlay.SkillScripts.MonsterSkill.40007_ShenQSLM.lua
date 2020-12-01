-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40007 = class("bs_40007", LuaSkillBase)
local base = LuaSkillBase
bs_40007.config = {hurtformula = 10093}
bs_40007.ctor = function(self)
  -- function num : 0_0
end

bs_40007.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_40007_2", 2, self.OnSetHurt)
end

bs_40007.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster then
    local damageNum = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).hurtformula, self.caster, context.target, self)
    context.hurt = context.hurt + context.hurt * damageNum // 1000
  end
end

bs_40007.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40007

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40007 = class("bs_40007", LuaSkillBase)
local base = LuaSkillBase
bs_40007.config = {hurtformula = 10093}
bs_40007.ctor = function(self)
    -- function num : 0_0
end

bs_40007.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self:AddTrigger(eSkillTriggerType.SetHurt, "bs_40007_2", 2, self.OnSetHurt)
end

bs_40007.OnSetHurt = function(self, context)
    -- function num : 0_2 , upvalues : _ENV
    if context.sender == self.caster then
        local damageNum = LuaSkillCtrl:CallFormulaNumberWithSkill(
                              (self.config).hurtformula, self.caster,
                              context.target, self)
        context.hurt = context.hurt + context.hurt * damageNum // 1000
    end
end

bs_40007.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_40007


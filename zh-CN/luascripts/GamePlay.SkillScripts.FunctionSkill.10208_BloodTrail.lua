-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10208 = class("bs_10208", LuaSkillBase)
local base = LuaSkillBase
bs_10208.config = {checkBuffId = 195, buffId = 1058}
bs_10208.ctor = function(self)
  -- function num : 0_0
end

bs_10208.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10208_2", 1, self.OnSetHurt)
end

bs_10208.OnSetHurt = function(self, context)
  -- function num : 0_2
  if context.sender == self.caster and (context.target).belongNum ~= (self.caster).belongNum and (context.skill).isCommonAttack then
    local buffTier = (context.target):GetBuffTier((self.config).checkBuffId)
    context.hurt = context.hurt * (buffTier * (self.arglist)[1] + 1000) // 1000
  end
end

bs_10208.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10208

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10208 = class("bs_10208", LuaSkillBase)
local base = LuaSkillBase
bs_10208.config = {checkBuffId = 195, buffId = 1058}
bs_10208.ctor = function(self)
    -- function num : 0_0
end

bs_10208.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10208_2", 1, self.OnSetHurt)
end

bs_10208.OnSetHurt = function(self, context)
    -- function num : 0_2
    if context.sender == self.caster and (context.target).belongNum ~=
        (self.caster).belongNum and (context.skill).isCommonAttack then
        local buffTier = (context.target):GetBuffTier((self.config).checkBuffId)
        context.hurt = context.hurt * (buffTier * (self.arglist)[1] + 1000) //
                           1000
    end
end

bs_10208.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10208


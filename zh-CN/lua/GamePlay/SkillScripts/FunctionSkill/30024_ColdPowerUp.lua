local bs_30024 = class("bs_30024", LuaSkillBase)
local base = LuaSkillBase
bs_30024.config = {freezeBuff = 1178, increase_skill_intensity_buff = 1181}
bs_30024.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0
  self:AddAfterAddBuffTrigger("bs_30024_1", 1, self.OnAfterAddBuff, self.caster, nil, nil, nil, (self.config).freezeBuff)
end

bs_30024.OnAfterAddBuff = function(self, buff, target)
  -- function num : 0_1 , upvalues : _ENV
  if (buff.maker).hp <= 0 then
    return 
  end
  if self:IsReadyToTake() then
    local curTier = (self.caster):GetBuffTier((self.config).increase_skill_intensity_buff)
    if curTier < (self.arglist)[2] then
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).increase_skill_intensity_buff, 1, nil, true)
    end
  end
end

bs_30024.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30024


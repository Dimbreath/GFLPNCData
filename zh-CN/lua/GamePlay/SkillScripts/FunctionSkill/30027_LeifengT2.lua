local bs_30027 = class("bs_30027", LuaSkillBase)
local base = LuaSkillBase
bs_30027.config = {buffId = 1188, buffIdDouble = 1121}
bs_30027.ctor = function(self)
  -- function num : 0_0
end

bs_30027.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterAddBuffHitMaxTierTrigger("bs_30027_1", 1, self.OnBuffHitMaxTier, nil, nil, nil, nil, (self.config).buffId)
end

bs_30027.OnBuffHitMaxTier = function(self, buff, role, isOverlay, maxTier)
  -- function num : 0_2 , upvalues : _ENV
  if self:IsReadyToTake() then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 0)
    if targetlist.Count < 1 then
      return 
    end
    for i = 0, targetlist.Count - 1 do
      local targetRole = (targetlist[i]).targetRole
      if targetRole.hp > 0 then
        LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffIdDouble, 1, (self.arglist)[2], true)
      end
    end
    self:OnSkillTake()
  end
end

bs_30027.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30027


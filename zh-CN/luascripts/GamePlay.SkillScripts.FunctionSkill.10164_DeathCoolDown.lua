-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10164 = class("bs_10164", LuaSkillBase)
local base = LuaSkillBase
bs_10164.config = {buffId = 1118, buffTier = 1}
bs_10164.ctor = function(self)
  -- function num : 0_0
end

bs_10164.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_10164.OnRoleDie = function(self, killer, role)
  -- function num : 0_2
end

bs_10164.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base, _ENV
  (base.OnCasterDie)(self)
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetlist.Count < 1 then
    return 
  end
  for i = 1, targetlist.Count - 1 do
    local targetRole = (targetlist[i]).targetRole
    LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId, (self.config).buffTier, nil, true)
  end
end

return bs_10164


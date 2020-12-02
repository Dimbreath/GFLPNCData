-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5025 = class("bs_5025", LuaSkillBase)
local base = LuaSkillBase
bs_5025.config = {effectId = 10042}
bs_5025.ctor = function(self)
  -- function num : 0_0
end

bs_5025.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_5025.PlaySkill = function(self, data, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  if selectRoles ~= nil and selectRoles.Count > 0 and selectRoles.Count % 2 == 0 then
    for i = 0, selectRoles.Count - 2, 2 do
      local target = LuaSkillCtrl:GetTargetWithGrid(selectRoles[i], selectRoles[i + 1])
      if target:GetRole() ~= nil then
        LuaSkillCtrl:CallEffect(target, (self.config).effectId, self, self.SkillEventFunc)
      end
    end
    return true
  end
  return false
end

bs_5025.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local role = target:GetRole()
    if role == nil then
      return 
    end
    LuaSkillCtrl:CallHeal(99, self, role)
  end
end

bs_5025.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5025


-- params : ...
-- function num : 0 , upvalues : _ENV
local HotfixBattleSkillCasterEntityState = class("HotfixBattleSkillCasterEntityState", HotfixBase)
;
(xlua.private_accessible)(CS.BattleSkillCasterEntity)
local OnRoleBorn = function(self)
  -- function num : 0_0
  self:OnRoleBorn()
  self:RefreshFromLuaData()
end

HotfixBattleSkillCasterEntityState.Register = function(self)
  -- function num : 0_1 , upvalues : _ENV, OnRoleBorn
  self:RegisterHotfix(CS.BattleSkillCasterEntity, "OnRoleBorn", OnRoleBorn, true)
end

return HotfixBattleSkillCasterEntityState


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_20009 = class("bs_20009", LuaSkillBase)
local base = LuaSkillBase
bs_20009.config = {buffId = 1098}
bs_20009.ctor = function(self)
  -- function num : 0_0
end

bs_20009.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20009_1", 1, self.OnAfterBattleStart)
end

bs_20009.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local target = (targetList[i]).targetRole
      if target.career ~= 5 then
        local powAdd = target.pow * 50 // 100
        local slAdd = target.skill_intensity * 50 // 100
        LuaSkillCtrl:CallAddRoleProperty(target, eHeroAttr.pow, powAdd, eHeroAttrType.Extra)
        LuaSkillCtrl:CallAddRoleProperty(target, eHeroAttr.skill_intensity, -slAdd, eHeroAttrType.Extra)
      end
    end
  end
end

bs_20009.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20009


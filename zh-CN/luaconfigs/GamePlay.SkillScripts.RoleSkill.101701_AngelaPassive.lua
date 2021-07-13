-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_101701 = class("bs_101701", LuaSkillBase)
local base = LuaSkillBase
bs_101701.config = {buffId_266 = 266, buffId_267 = 267, selectId = 2}
bs_101701.ctor = function(self)
  -- function num : 0_0
end

bs_101701.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_101701_1", 1, self.OnAfterBattleStart)
  if (self.arglist)[2] > 0 then
    self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_101701_2", 1, self.OnAfterPlaySkill)
  end
end

bs_101701.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId, 10)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      local role = (targetlist[i]).targetRole
      LuaSkillCtrl:CallBuff(self, role, (self.config).buffId_266, 1, nil)
    end
  end
end

bs_101701.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_3 , upvalues : _ENV
  if role.belongNum == (self.caster).belongNum and role ~= self.caster and skill.isCommonAttack ~= true then
    LuaSkillCtrl:CallBuff(self, role, (self.config).buffId_267, 1, (self.arglist)[4])
  end
end

bs_101701.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : _ENV, base
  local targetList = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId, 10)
  for i = 0, targetList.Count - 1 do
    LuaSkillCtrl:DispelBuff((targetList[i]).targetRole, (self.config).buffId_266, 0)
  end
  ;
  (base.OnCasterDie)(self)
end

return bs_101701


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10245 = class("bs_10245", LuaSkillBase)
local base = LuaSkillBase
bs_10245.config = {
hurt_config = {basehurt_formula = 10076}
, effectIdAttack = 10638}
bs_10245.ctor = function(self)
  -- function num : 0_0
end

bs_10245.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnSelfAfterMove, "bs_10245_1", 1, self.OnAfterMove)
end

bs_10245.OnAfterMove = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if LuaSkillCtrl:GetRoleEfcGrid(self.caster) ~= 0 then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 1001, 10)
    if targetlist.Count < 1 then
      return 
    end
    LuaSkillCtrl:CallEffect((targetlist[0]).targetRole, (self.config).effectIdAttack, self, self.SkillEventFunc)
  end
end

bs_10245.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, nil, true)
    skillResult:EndResult()
  end
end

bs_10245.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10245


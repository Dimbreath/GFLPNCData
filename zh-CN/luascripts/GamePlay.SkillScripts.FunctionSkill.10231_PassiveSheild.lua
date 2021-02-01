-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10231 = class("bs_10231", LuaSkillBase)
local base = LuaSkillBase
bs_10231.config = {buffId = 1086, effectId = 10643}
bs_10231.ctor = function(self)
  -- function num : 0_0
end

bs_10231.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10231_1", 1, self.OnAfterBattleStart)
end

bs_10231.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetlist.Count < 1 then
    return 
  end
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
  for i = 0, targetlist.Count - 1 do
    local targetRole = (targetlist[i]).targetRole
    local buffTier = targetRole:GetBuffTier((self.config).buffId)
    if buffTier == 0 then
      LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId, (self.arglist)[1])
    end
  end
end

bs_10231.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10231


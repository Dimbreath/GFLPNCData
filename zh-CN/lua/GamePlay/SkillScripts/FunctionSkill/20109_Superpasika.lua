local bs_20109 = class("bs_20109", LuaSkillBase)
local base = LuaSkillBase
bs_20109.config = {buffId = 1215}
bs_20109.ctor = function(self)
  -- function num : 0_0
end

bs_20109.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20109_1", 1, self.OnAfterBattleStart)
end

bs_20109.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1, nil, true)
  LuaSkillCtrl:CallStartLocalScale(self.caster, (Vector3.New)(1.3, 1.3, 1.3), 0.2)
end

bs_20109.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20109


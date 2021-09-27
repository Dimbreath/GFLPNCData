local bs_10135 = class("bs_10135", LuaSkillBase)
local base = LuaSkillBase
bs_10135.config = {
heal_config = {baseheal_formula = 10076, heal_number = 0, correct_formula = 9990}
, effectId = 10092}
bs_10135.ctor = function(self)
  -- function num : 0_0
end

bs_10135.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_10135_7", 1, self.OnAfterAddBuff, self.caster)
end

bs_10135.OnAfterAddBuff = function(self, buff, target, isOverlay)
  -- function num : 0_2 , upvalues : _ENV
  if buff.buffType ~= 0 and buff.maker == self.caster and self:IsReadyToTake() then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 14, 10)
    if targetlist.Count < 1 then
      return 
    end
    LuaSkillCtrl:CallEffect((targetlist[0]).targetRole, (self.config).effectId, self, self.SkillEventFunc)
    self:PlayChipEffect()
    self:OnSkillTake()
  end
end

bs_10135.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, (self.config).aoe_config)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config)
    skillResult:EndResult()
  end
end

bs_10135.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10135


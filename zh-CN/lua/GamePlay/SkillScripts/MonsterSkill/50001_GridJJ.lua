local bs_50001 = class("bs_50001", LuaSkillBase)
local base = LuaSkillBase
bs_50001.config = {}
bs_50001.ctor = function(self)
  -- function num : 0_0
end

bs_50001.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.BeforePlaySkill, "bs_50001_13", 1, self.OnBeforePlaySkill)
end

bs_50001.OnBeforePlaySkill = function(self, role, context)
  -- function num : 0_2 , upvalues : _ENV
  if role == self.caster and context.skill ~= nil and (context.skill).isCommonAttack and (context.skill).moveSelectTarget ~= nil then
    if role:ContainBuffFeature(eBuffFeatureType.Bewitch) or role:ContainBuffFeature(eBuffFeatureType.Taunt) then
      return 
    end
    local targetlist = LuaSkillCtrl:CallTargetSelectWithRange(self, 21, 10)
    if targetlist.Count < 1 then
      return 
    end
    ;
    ((context.skill).moveSelectTarget):SetBattleTarget((targetlist[0]).targetRole)
  end
end

bs_50001.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_50001


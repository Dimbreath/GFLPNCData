-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_15 = class("bs_15", bs_1)
local base = bs_1
bs_15.config = {effectId = 10266, effectstartId1 = 10265, effectId_two = 10269, effectstartId2 = 10268, audioId1 = 63, audioId2 = 63}
bs_15.config = setmetatable(bs_15.config, {__index = base.config})
bs_15.ctor = function(self)
  -- function num : 0_0
end

bs_15.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_15.OnAttackTrigger = function(self, target, data, atkSpeedRatio, atkActionId)
  -- function num : 0_2 , upvalues : _ENV
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, (self.caster).attackRange) then
    if (self.config).audioId4 ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId4)
    end
    if atkActionId == (self.config).action1 then
      LuaSkillCtrl:CallEffectWithArg(target, (self.config).effectId, self, true, self.SkillEventFunc, data)
    else
      LuaSkillCtrl:CallEffectWithArg(target, (self.config).effectId_two, self, true, self.SkillEventFunc, data)
    end
  else
    self:BreakSkill()
  end
  self:CancleCasterWait()
end

bs_15.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_15


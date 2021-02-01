-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_32 = class("bs_32", bs_1)
local base = bs_1
bs_32.config = {effectstartId1 = 10691, effectstartId2 = 10692, action1 = 1001, action2 = 1004, effectId_hit1 = 10693, effectId_hit2 = 10694, effectId_Chit1 = 10695, effectId_Chit2 = 10696}
bs_32.config = setmetatable(bs_32.config, {__index = base.config})
bs_32.ctor = function(self)
  -- function num : 0_0
end

bs_32.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterHurt, "bs_32_3", 1, self.OnAfterHurt)
end

bs_32.OnAttackTrigger = function(self, target, data, atkSpeedRatio, atkActionId)
  -- function num : 0_2 , upvalues : base
  self.actionId = atkActionId
  ;
  (base.OnAttackTrigger)(self, target, data, atkSpeedRatio, atkActionId)
end

bs_32.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_3 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and not isMiss and skill.dataId == 32 then
    local effect_now = nil
    if not isCrit then
      if self.actionId == (self.config).action1 then
        effect_now = (self.config).effectId_hit1
      else
        effect_now = (self.config).effectId_hit2
      end
    end
    if isCrit then
      if self.actionId == (self.config).action1 then
        effect_now = (self.config).effectId_Chit1
      else
        effect_now = (self.config).effectId_Chit2
      end
    end
    LuaSkillCtrl:CallEffect(target, effect_now, self)
    self.actionId = nil
  end
end

bs_32.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_32


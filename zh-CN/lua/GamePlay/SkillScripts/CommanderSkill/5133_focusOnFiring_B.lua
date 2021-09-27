local base = require("GamePlay.SkillScripts.CommanderSkill.5131_focusOnFiring")
local bs_5133 = class("bs_5133", base)
bs_5133.config = {buffId = 513101, buffId_ex = 513201}
bs_5133.config = setmetatable(bs_5133.config, {__index = base.config})
bs_5133.AbandonTakeFeature = {eBuffFeatureType.BeatBack}
bs_5133.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_5133_1", 1, self.OnAfterHurt, nil, nil, eBattleRoleBelong.player, nil, nil, nil, nil, eSkillTag.commonAttack)
  self:AddBuffDieTrigger("bs_5133_2", 1, self.OnBuffDie, nil, nil, (self.config).buffId)
end

bs_5133.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_1 , upvalues : _ENV
  if sender.hp <= 0 or target:GetBuffTier((self.config).buffId_ex) < 1 then
    return 
  end
  if (sender.recordTable)["5133_heal"] == nil then
    local healnum = sender.maxHp * (self.arglist)[2] // 1000
    local heal_config = {heal_number = healnum}
    if healnum > 0 then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, sender)
      LuaSkillCtrl:HealResult(skillResult, heal_config, nil, false, true)
      skillResult:EndResult()
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R12 in 'UnsetPending'

      ;
      (sender.recordTable)["5133_heal"] = true
    end
  end
end

bs_5133.OnBuffDie = function(self, buff, target, removeType)
  -- function num : 0_2 , upvalues : _ENV
  if target.hp <= 0 then
    return 
  end
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R4 in 'UnsetPending'

  if removeType == eBuffRemoveType.Timeout then
    (target.recordTable)["5133_heal"] = nil
  end
end

bs_5133.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5133


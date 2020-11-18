-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_14 = class("bs_14", bs_1)
local base = bs_1
bs_14.config = {effectId = 10208, buffId = 159, buffIdBJ = 160, 
heal_config = {baseheal_formula = 10053, heal_number = 0, crit_formula = 9992, crithur_ratio = 9995, correct_formula = 9990}
}
bs_14.config = setmetatable(bs_14.config, {__index = base.config})
bs_14.ctor = function(self)
  -- function num : 0_0
end

bs_14.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_14.PlaySkill = function(self, passdata)
  -- function num : 0_2 , upvalues : _ENV, base
  if ((self.caster).recordTable).BJ == true then
    local data = self.config
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 3, 10)
    if targetList.Count > 0 then
      local atkRole = (targetList[0]).targetRole
      self:RealPlaySkill(atkRole, data)
    else
      do
        do
          ;
          (base.PlaySkill)(self, passdata)
          ;
          (base.PlaySkill)(self, passdata)
        end
      end
    end
  end
end

bs_14.OnAttackTrigger = function(self, target, data, atkSpeedRatio, atkActionId)
  -- function num : 0_3 , upvalues : _ENV, base
  if target.belongNum == (self.caster).belongNum and ((self.caster).recordTable).BJ == true then
    if (self.caster):GetBuffTier((self.config).buffIdBJ) > 0 then
      local targetListAll = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
      if targetListAll.Count > 0 then
        for i = 0, targetListAll.Count - 1 do
          LuaSkillCtrl:CallEffect((targetListAll[i]).targetRole, (self.config).effectId, self, self.SkillEventFunc2)
        end
      end
    else
      do
        LuaSkillCtrl:CallEffect(target, (self.config).effectId, self, self.SkillEventFunc2)
        ;
        (base.OnAttackTrigger)(self, target, data, atkSpeedRatio, atkActionId)
      end
    end
  end
end

bs_14.SkillEventFunc2 = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  local miss = LuaSkillCtrl:CallFormulaBoolWithSkill(10051, self.caster, self.caster, self)
  if miss and eventId == eBattleEffectEvent.Trigger and effect.dataId == (self.config).effectId then
    local arg = ((self.caster).recordTable)["arglist[1]"]
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, {arg})
    skillResult:EndResult()
  end
end

bs_14.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_14


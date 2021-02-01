-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_515 = class("bs_515", bs_1)
local base = bs_1
bs_515.config = {effectId = 10494, effectStartId = 10493, effectStartId3 = 10509, 
Aoe = {effect_shape = 3, aoe_select_code = 5, aoe_range = 1}
, 
hurtconfig = {basehurt_formula = 10055}
}
bs_515.config = setmetatable(bs_515.config, {__index = base.config})
bs_515.ctor = function(self)
  -- function num : 0_0
end

bs_515.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_515.RealPlaySkill = function(self, target, data)
  -- function num : 0_2 , upvalues : _ENV, base
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 19, 10)
  if targetlist.Count > 0 then
    target = (targetlist[0]).targetRole
    ;
    (self.caster):LookAtTarget(target)
    ;
    (base.RealPlaySkill)(self, target, data)
  end
end

bs_515.SkillEventFunc = function(self, configData, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    if configData.audioId5 ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, configData.audioId5)
    end
    local hurt = BindCallback(self, self.Onhurt, effect, target)
    LuaSkillCtrl:StartTimer(self, 6, hurt, self)
  end
end

bs_515.Onhurt = function(self, effect, target)
  -- function num : 0_4 , upvalues : _ENV
  local arg = ((self.caster).recordTable)["515_arg"]
  local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, (self.config).Aoe)
  LuaSkillCtrl:HurtResult(skillResult, (self.config).hurtconfig, {arg})
  skillResult:EndResult()
end

bs_515.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_515


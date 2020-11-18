-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_10 = class("bs_10", bs_1)
local base = bs_1
bs_10.config = {GS_Id = 8000, effectId = 10179}
bs_10.config = setmetatable(bs_10.config, {__index = base.config})
bs_10.ctor = function(self)
  -- function num : 0_0
end

bs_10.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_10.RealPlaySkill = function(self, target, data)
  -- function num : 0_2 , upvalues : _ENV
  local atkSpeed = LuaSkillCtrl:CallFormulaNumber((self.config).GS_Id, self.caster, self.caster)
  local atkSpeedRatio = 1
  local atkActionId = (self.config).action1
  local atkTriggerFrame = 0
  if self.attackNum > 3 then
    local prob = LuaSkillCtrl:CallRange(1, 2)
    if prob == 1 then
      if (self.config).audioId2 ~= nil then
        ((self.caster).auSource):PlayAudioById((self.config).audioId2)
      end
      atkSpeedRatio = 1
      atkActionId = (self.config).action2
      atkTriggerFrame = 8
      self.attackNum = 0
    else
      if (self.config).audioId1 ~= nil then
        ((self.caster).auSource):PlayAudioById((self.config).audioId1)
      end
      atkSpeedRatio = 1
      atkActionId = (self.config).action1
      atkTriggerFrame = 7
      self.attackNum = self.attackNum + 1
    end
  else
    do
      if (self.config).audioId1 ~= nil then
        ((self.caster).auSource):PlayAudioById((self.config).audioId1)
      end
      atkSpeedRatio = 1
      atkTriggerFrame = 7
      atkActionId = (self.config).action1
      self.attackNum = self.attackNum + 1
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId)
      local waitTime = 150
      if waitTime > 0 then
        self:CallCasterWait(waitTime)
      end
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, atkActionId, atkSpeedRatio, atkTriggerFrame, attackTrigger)
    end
  end
end

bs_10.SkillEventFunc = function(self, configData, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    if (self.config).audioId5 ~= nil then
      ((self.caster).auSource):PlayAudioById((self.config).audioId5)
    end
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(skillResult)
    skillResult:EndResult()
  end
end

bs_10.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10


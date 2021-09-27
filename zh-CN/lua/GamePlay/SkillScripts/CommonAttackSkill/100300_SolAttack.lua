local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_100300 = class("bs_100300", bs_1)
local base = bs_1
bs_100300.config = {effectId1 = 100301, audioId1 = 100301}
bs_100300.config = setmetatable(bs_100300.config, {__index = base.config})
bs_100300.ctor = function(self)
  -- function num : 0_0
end

bs_100300.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_100300.RealPlaySkill = function(self, target, data)
  -- function num : 0_2 , upvalues : base, _ENV
  (base.CallSelectEffect)(self)
  local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
  local atkSpeedRatio = 1
  local atkActionId = (self.config).action1
  local atkTriggerFrame = 0
  atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 1)
  atkTriggerFrame = self:GetAtkTriggerFrame(1, atkSpeed)
  atkActionId = (self.config).action1
  self.attackNum = self.attackNum + 1
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  local waitTime = atkSpeed - 1 - (self.rotateWaited and 3 or 0)
  if waitTime > 0 then
    self:CallCasterWait(waitTime + 2)
  end
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.caster).recordTable).lastAttackRole = target
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, atkActionId, atkSpeedRatio, atkTriggerFrame, attackTrigger)
  if (self.config).audioId1 ~= nil then
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  end
  -- DECOMPILER ERROR at PC85: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, (self.config).effectId1, self, nil, nil, atkSpeedRatio, true)
end

bs_100300.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100300


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_8 = class("bs_8", bs_1)
local base = bs_1
bs_8.config = {effectId1 = 10056, audioId1 = 12}
bs_8.config = setmetatable(bs_8.config, {__index = base.config})
bs_8.ctor = function(self)
  -- function num : 0_0
end

bs_8.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_8.RealPlaySkill = function(self, target, data)
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
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, atkActionId, atkSpeedRatio, atkTriggerFrame, attackTrigger)
  if (self.config).audioId1 ~= nil then
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  end
  -- DECOMPILER ERROR at PC82: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, (self.config).effectId1, self, nil, nil, atkSpeedRatio, true)
end

bs_8.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_8


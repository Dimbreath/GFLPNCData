-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_8 = class("bs_8", bs_1)
local base = bs_1
bs_8.config = {effectId1 = 10056, effectId2 = 10057, effectId3 = 10059, effectId4 = 10060, buffId1 = 112, audioId1 = 12, audioId2 = 14}
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
  if self.attackNum > 3 then
    local prob = 1
    if prob == 2 then
      atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 2)
      atkActionId = (self.config).action2
      atkTriggerFrame = self:GetAtkTriggerFrame(2, atkSpeed)
      self.attackNum = 0
    else
      atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 1)
      atkActionId = (self.config).action1
      atkTriggerFrame = self:GetAtkTriggerFrame(1, atkSpeed)
      self.attackNum = self.attackNum + 1
    end
  else
    do
      atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 1)
      atkTriggerFrame = self:GetAtkTriggerFrame(1, atkSpeed)
      atkActionId = (self.config).action1
      self.attackNum = self.attackNum + 1
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId)
      local waitTime = atkSpeed - 1 - (self.rotateWaited and 3 or 0)
      if waitTime > 0 then
        self:CallCasterWait(waitTime)
      end
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, atkActionId, atkSpeedRatio, atkTriggerFrame, attackTrigger)
      if (self.caster).attackRange == 1 then
        if (self.caster):GetBuffTier((self.config).buffId1) == 0 then
          if atkActionId == (self.config).action1 then
            ((self.caster).auSource):PlayAudioById((self.config).audioId1)
            -- DECOMPILER ERROR at PC127: Confused about usage of register: R9 in 'UnsetPending'

            ;
            ((self.caster).recordTable)["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, (self.config).effectId1, self, nil, nil, atkSpeedRatio)
          else
            -- DECOMPILER ERROR at PC140: Confused about usage of register: R9 in 'UnsetPending'

            ;
            ((self.caster).recordTable)["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, (self.config).effectId2, self, nil, nil, atkSpeedRatio)
          end
        else
          if atkActionId == (self.config).action1 then
            ((self.caster).auSource):PlayAudioById((self.config).audioId2)
            -- DECOMPILER ERROR at PC163: Confused about usage of register: R9 in 'UnsetPending'

            ;
            ((self.caster).recordTable)["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, (self.config).effectId3, self, nil, nil, atkSpeedRatio)
          else
            -- DECOMPILER ERROR at PC176: Confused about usage of register: R9 in 'UnsetPending'

            ;
            ((self.caster).recordTable)["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, (self.config).effectId4, self, nil, nil, atkSpeedRatio)
          end
        end
      end
    end
  end
end

bs_8.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_8


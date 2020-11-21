-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_503 = class("bs_503", bs_1)
local base = bs_1
bs_503.config = {
    effectId1 = 10098,
    effectId2 = 10098,
    action2 = 1001,
    audioId1 = 24
}
bs_503.config = setmetatable(bs_503.config, {__index = base.config})
bs_503.ctor = function(self)
    -- function num : 0_0
end

bs_503.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base
    (base.InitSkill)(self, isMidwaySkill)
end

bs_503.RealPlaySkill = function(self, target, data)
    -- function num : 0_2 , upvalues : _ENV
    local atkSpeed = 28
    local atkSpeedRatio = 1
    local atkActionId = (self.config).action1
    local atkTriggerFrame = 0
    if self.attackNum > 3 then
        local prob = LuaSkillCtrl:CallRange(1, 2)
        if prob == 1 then
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
            self.attackNum = self.attackNum + 1;
            ((self.caster).auSource):PlayAudioById((self.config).audioId1)
            local attackTrigger = BindCallback(self, self.OnAttackTrigger,
                                               target, data, atkSpeedRatio,
                                               atkActionId)
            local waitTime = atkSpeed - 1 - (self.rotateWaited and 3 or 0)
            if waitTime > 0 then self:CallCasterWait(waitTime) end
            LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster,
                                                   atkActionId, atkSpeedRatio,
                                                   atkTriggerFrame,
                                                   attackTrigger)
            -- DECOMPILER ERROR at PC116: Confused about usage of register: R9 in 'UnsetPending'

            if (self.caster).attackRange == 1 then
                if atkActionId == (self.config).action1 then
                    ((self.caster).recordTable)["1_attack_effect"] =
                        LuaSkillCtrl:CallEffect(target, (self.config).effectId1,
                                                self, nil, nil, atkSpeedRatio)
                else
                    -- DECOMPILER ERROR at PC129: Confused about usage of register: R9 in 'UnsetPending'


                    ((self.caster).recordTable)["1_attack_effect"] =
                        LuaSkillCtrl:CallEffect(target, (self.config).effectId2,
                                                self, nil, nil, atkSpeedRatio)
                end
            end
        end
    end
end

bs_503.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_503


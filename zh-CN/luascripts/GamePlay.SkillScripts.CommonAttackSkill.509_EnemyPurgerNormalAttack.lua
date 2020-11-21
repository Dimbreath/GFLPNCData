-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_509 = class("bs_509", bs_1)
local base = bs_1
bs_509.config = {effectId = 10088, effectStartId = nil, audioId4 = 28}
bs_509.config = setmetatable(bs_509.config, {__index = base.config})
bs_509.ctor = function(self)
    -- function num : 0_0
end

bs_509.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base
    (base.InitSkill)(self, isMidwaySkill)
end

bs_509.OnAttackTrigger =
    function(self, target, data, atkSpeedRatio, atkActionId)
        -- function num : 0_2 , upvalues : _ENV
        -- DECOMPILER ERROR at PC22: Unhandled construct in 'MakeBoolean' P1

        if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target,
                                           (self.caster).attackRange) and
            (self.config).effectId ~= nil then
            if (self.config).audioId4 ~= nil then
                ((self.caster).auSource):PlayAudioById((self.config).audioId4)
            end
            LuaSkillCtrl:CallEffectWithArg(target, (self.config).effectId, self,
                                           true, self.SkillEventFunc, data)
        end
        self:BreakSkill()
        self:CancleCasterWait()
    end

bs_509.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_509


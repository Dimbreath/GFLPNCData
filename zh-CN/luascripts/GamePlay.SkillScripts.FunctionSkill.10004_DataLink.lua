-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10004 = class("bs_10004", LuaSkillBase)
local base = LuaSkillBase
bs_10004.config = {}
bs_10004.ctor = function(self)
    -- function num : 0_0
end

bs_10004.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10004_2", 1, self.OnSetHurt)
end

bs_10004.OnSetHurt = function(self, context)
    -- function num : 0_2 , upvalues : _ENV
    if context.target ~= self.caster and (context.target).belongNum ==
        (self.caster).belongNum and (context.target).hp < (self.caster).hp then
        self:PlayChipEffect() -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.caster).recordTable).hurtOffSet =
            context.hurt * (self.arglist)[1] // 1000
        if ((self.caster).recordTable).hurtOffSet > 0 then
            context.hurt = context.hurt - ((self.caster).recordTable).hurtOffSet
            LuaSkillCtrl:RemoveLife(((self.caster).recordTable).hurtOffSet,
                                    self, self.caster, true, true)
        end
    end
end

bs_10004.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10004


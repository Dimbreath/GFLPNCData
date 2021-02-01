-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1038 = class("bs_1038", LuaSkillBase)
local base = LuaSkillBase
bs_1038.config = {effectId1 = 10062, effectId2 = 10058, audioId1 = 39}
bs_1038.ctor = function(self)
  -- function num : 0_0
end

bs_1038.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddSelfTrigger(eSkillTriggerType.SetHurt, "bs_1038_2", 1, self.OnSetHurt)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["1038_hurt"] = 0
end

bs_1038.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.target == self.caster and LuaSkillCtrl:CallRange(1, 100) <= (self.arglist)[3] and (context.skill).dataId ~= 202003 and (LuaSkillCtrl:GetGridsDistance((context.sender).x, (context.sender).y, (self.caster).x, (self.caster).y) > 1 or (context.sender).attackRange > 1 or (context.skill).dataId == 201903) then
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["1038_hurt"] = context.hurt
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
    context.hurt = context.hurt * (1000 - (self.arglist)[1]) // 1000
    if (self.arglist)[2] > 0 then
      LuaSkillCtrl:CallEffectWithArg(context.sender, (self.config).effectId2, self, false, self.SkillEventFunc1, context)
    end
    self:OnSkillTake()
  end
end

bs_1038.SkillEventFunc1 = function(self, context, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == 0 then
    local fantanhurt = ((self.caster).recordTable)["1038_hurt"]
    if fantanhurt < 5 then
      fantanhurt = 5
    end
    LuaSkillCtrl:RemoveLife(fantanhurt * (self.arglist)[4] // 1000, self, context.sender, false, true)
  end
end

bs_1038.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1038


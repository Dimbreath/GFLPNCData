-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10066 = class("bs_10066", LuaSkillBase)
local base = LuaSkillBase
bs_10066.config = {}
bs_10066.ctor = function(self)
  -- function num : 0_0
end

bs_10066.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddSelfTrigger(eSkillTriggerType.BeforeAddBuff, "bs_10066_2", 1, self.OnBeforeAddBuff)
end

bs_10066.OnBeforeAddBuff = function(self, target, context)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R3 in 'UnsetPending'

  if (context.buff).buffType == 2 and (context.buff).maker == self.caster and target.belongNum ~= (self.caster).belongNum and self:IsReadyToTake() and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] then
    (context.buff).tier = (context.buff).tier + 1
    self:PlayChipEffect()
    self:OnSkillTake()
  end
end

bs_10066.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10066


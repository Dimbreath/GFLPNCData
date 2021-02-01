-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10228 = class("bs_10228", LuaSkillBase)
local base = LuaSkillBase
bs_10228.config = {buffId = 1083, buffTier = 1}
bs_10228.ctor = function(self)
  -- function num : 0_0
end

bs_10228.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterAddBuff, "bs_10228_2", 1, self.OnAfterAddBuff)
end

bs_10228.OnAfterAddBuff = function(self, buff, target, isOverlay)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'

  if buff.buffType == 1 and buff.maker == self.caster and target.roleType == 1 then
    (target.recordTable)["10228_time"] = (self.arglist)[1]
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (target.recordTable)["10228_Damage"] = (self.arglist)[2]
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, (self.config).buffTier, (self.arglist)[1], true)
  end
end

bs_10228.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10228


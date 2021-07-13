-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10228 = class("bs_10228", LuaSkillBase)
local base = LuaSkillBase
bs_10228.config = {buffId = 1083, buffTier = 1}
bs_10228.ctor = function(self)
  -- function num : 0_0
end

bs_10228.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_10228_2", 1, self.OnAfterAddBuff, self.caster)
end

bs_10228.OnAfterAddBuff = function(self, buff, target, isOverlay)
  -- function num : 0_2 , upvalues : _ENV
  if buff.buffType ~= 0 and buff.maker == self.caster and self:IsReadyToTake() then
    local buffTier = (self.caster):GetBuffTier((self.config).buffId)
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R5 in 'UnsetPending'

    if buffTier < 1 then
      ((self.caster).recordTable)["10228_time"] = (self.arglist)[1]
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.caster).recordTable)["10228_Damage"] = (self.arglist)[2]
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, (self.arglist)[1], true)
    end
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 46, 10)
    if targetlist.Count < 1 then
      return 
    end
    local buffTier = ((targetlist[0]).targetRole):GetBuffTier((self.config).buffId)
    -- DECOMPILER ERROR at PC63: Confused about usage of register: R7 in 'UnsetPending'

    if buffTier < 1 then
      (((targetlist[0]).targetRole).recordTable)["10228_time"] = (self.arglist)[1]
      -- DECOMPILER ERROR at PC69: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (((targetlist[0]).targetRole).recordTable)["10228_Damage"] = (self.arglist)[2]
      LuaSkillCtrl:CallBuff(self, (targetlist[0]).targetRole, (self.config).buffId, (self.config).buffTier, (self.arglist)[1], true)
    end
  end
end

bs_10228.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10228


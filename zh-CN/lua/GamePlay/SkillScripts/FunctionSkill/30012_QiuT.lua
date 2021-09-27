local bs_30012 = class("bs_30012", LuaSkillBase)
local base = LuaSkillBase
bs_30012.config = {buffId = 1083, buffTier = 1, buffSL = 1184}
bs_30012.ctor = function(self)
  -- function num : 0_0
end

bs_30012.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_30012_2", 1, self.OnAfterAddBuff, self.caster)
end

bs_30012.OnAfterAddBuff = function(self, buff, target, isOverlay)
  -- function num : 0_2 , upvalues : _ENV
  if buff.buffType ~= 0 and buff.maker == self.caster and self:IsReadyToTake() then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 61, 10)
    if targetlist.Count < 1 then
      return 
    end
    for i = 0, targetlist.Count - 1 do
      local targetRole = (targetlist[i]).targetRole
      if targetRole.roleType == 1 then
        local buffTier = targetRole:GetBuffTier((self.config).buffId)
        -- DECOMPILER ERROR at PC43: Confused about usage of register: R11 in 'UnsetPending'

        if buffTier < 1 and targetRole.career ~= 4 then
          (targetRole.recordTable)["10228_time"] = (self.arglist)[1]
          -- DECOMPILER ERROR at PC47: Confused about usage of register: R11 in 'UnsetPending'

          ;
          (targetRole.recordTable)["10228_Damage"] = (self.arglist)[2]
          LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId, (self.config).buffTier, (self.arglist)[1], true)
          if ((self.caster).recordTable)["30013_arg"] then
            LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffSL, (self.config).buffTier, (self.arglist)[1], true)
          end
          self:OnSkillTake()
          break
        end
      end
    end
  end
end

bs_30012.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30012


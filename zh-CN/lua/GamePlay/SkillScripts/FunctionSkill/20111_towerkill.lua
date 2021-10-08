local bs_20111 = class("bs_20111", LuaSkillBase)
local base = LuaSkillBase
bs_20111.config = {}
bs_20111.ctor = function(self)
  -- function num : 0_0
end

bs_20111.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_20111", 1, self.BeforeEndBattle)
end

bs_20111.Boom = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local IfRoleCotainsIgnoreDieBuff = LuaSkillCtrl:RoleContainsBuffFeature(self.caster, (self.config).buffFeature_ignoreDie)
  if IfRoleCotainsIgnoreDieBuff == true then
    local buff_ignoreDie = LuaSkillCtrl:GetRoleAllBuffsByFeature(self.caster, (self.config).buffFeature_ignoreDie)
    if buff_ignoreDie.Count > 0 then
      for i = 0, buff_ignoreDie.Count - 1 do
        LuaSkillCtrl:DispelBuff(self.caster, (buff_ignoreDie[i]).dataId, 0)
        IfRoleCotainsIgnoreDieBuff = false
      end
    end
  end
  do
    if (self.caster).hp > 0 and IfRoleCotainsIgnoreDieBuff == false then
      (self.caster):SubHp((self.caster).hp + 10000)
    end
  end
end

bs_20111.BeforeEndBattle = function(self)
  -- function num : 0_3
  self:Boom()
end

bs_20111.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20111


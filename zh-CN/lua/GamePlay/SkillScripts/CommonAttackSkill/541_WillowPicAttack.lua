local bs_541 = class("bs_541", LuaSkillBase)
local base = LuaSkillBase
bs_541.config = {buffId_Taunt = 3002, buffId_Blind = 115, buffFeature_ignoreDie = 6}
bs_541.ctor = function(self)
  -- function num : 0_0
end

bs_541.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_541_1", 99, self.OnSetHurt, nil, self.caster)
  self:AddSetHealTrigger("bs_541_2", 99, self.OnAfterHeal, nil, self.caster)
  self.arg1 = ((self.caster).recordTable).arg_1
  self.arg2 = ((self.caster).recordTable).arg_2
  self.arg3 = ((self.caster).recordTable).arg_3
  local over = BindCallback(self, self.Onover)
  LuaSkillCtrl:StartTimer(nil, self.arg2, over)
  self.over_time = true
  LuaSkillCtrl:StartTimer(nil, self.arg2 - 1, function()
    -- function num : 0_1_0 , upvalues : self
    self.over_time = false
  end
)
end

bs_541.PlaySkill = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local targetlist_enemy = LuaSkillCtrl:FindAllRolesWithinRange(self.caster, 1, false)
  if targetlist_enemy.Count > 0 then
    for i = 0, targetlist_enemy.Count - 1 do
      if (targetlist_enemy[i]).belongNum == eBattleRoleBelong.enemy and not (targetlist_enemy[i]).unableSelect then
        LuaSkillCtrl:CallBuff(self, targetlist_enemy[i], (self.config).buffId_Taunt, 1, self.arg2)
      end
    end
  end
end

bs_541.Onover = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local IfRoleCotainsIgnoreDieBuff = LuaSkillCtrl:RoleContainsBuffFeature(self.caster, (self.config).buffFeature_ignoreDie)
  if IfRoleCotainsIgnoreDieBuff == true then
    local buff_ignoreDie = LuaSkillCtrl:GetRoleAllBuffsByFeature(self.caster, (self.config).buffFeature_ignoreDie)
    if buff_ignoreDie.Count > 0 then
      for i = 0, buff_ignoreDie.Count - 1 do
        LuaSkillCtrl:DispelBuff(self.caster, (buff_ignoreDie[i]).dataId, 0, true)
        IfRoleCotainsIgnoreDieBuff = false
      end
    end
  end
  do
    if (self.caster).hp > 0 and IfRoleCotainsIgnoreDieBuff == false then
      LuaSkillCtrl:RemoveLife((self.caster).hp + 10000, self, self.caster, false, nil, false, false, eHurtType.RealDmg)
      local targetlist_enemy = LuaSkillCtrl:FindAllRolesWithinRange(self.caster, 1, false)
      if targetlist_enemy.Count > 0 then
        for i = 0, targetlist_enemy.Count - 1 do
          if (targetlist_enemy[i]).belongNum == eBattleRoleBelong.enemy and not (targetlist_enemy[i]).unableSelect then
            LuaSkillCtrl:DispelBuffByMaker(self.caster, targetlist_enemy[i], (self.config).buffId_Taunt, 1)
            LuaSkillCtrl:CallBuff(self, targetlist_enemy[i], (self.config).buffId_Blind, 1, self.arg3)
          end
        end
      end
    end
  end
end

bs_541.OnSetHurt = function(self, context)
  -- function num : 0_4
  if context.target == self.caster and context.hurt > 0 and self.over_time == true then
    context.hurt = 1
  end
end

bs_541.OnAfterHeal = function(self, context)
  -- function num : 0_5
  if context.target == self.caster and context.heal > 0 and self.over_time == true then
    context.heal = 0
  end
end

bs_541.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : _ENV, base
  local targetlist_enemy = LuaSkillCtrl:FindAllRolesWithinRange(self.caster, 1, false)
  if targetlist_enemy.Count > 0 then
    for i = 0, targetlist_enemy.Count - 1 do
      if (targetlist_enemy[i]).belongNum == eBattleRoleBelong.enemy and not (targetlist_enemy[i]).unableSelect then
        LuaSkillCtrl:CallBuff(self, targetlist_enemy[i], (self.config).buffId_Blind, 1, self.arg3)
      end
    end
  end
  do
    ;
    (base.OnCasterDie)(self)
  end
end

return bs_541


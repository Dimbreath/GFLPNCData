-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202602 = class("bs_202602", LuaSkillBase)
local base = LuaSkillBase
bs_202602.config = {}
bs_202602.ctor = function(self)
  -- function num : 0_0
end

bs_202602.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_202602_3", 1, self.OnAfterHurt)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_202602_10", 1, self.OnRoleDie)
end

bs_202602.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2
end

bs_202602.OnRoleDie = function(self, killer, role)
  -- function num : 0_3 , upvalues : _ENV
  if killer == self.caster then
    local skills = (self.caster):GetBattleSkillList()
    if skills ~= nil then
      for j = 0, skills.Count - 1 do
        if (skills[j]).isCommonAttack ~= true and (skills[j]).useLimitTime == 0 then
          local curTotalCd = (skills[j]).totalCDTime
          LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd - 5)
          break
        end
      end
    end
  end
end

bs_202602.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202602


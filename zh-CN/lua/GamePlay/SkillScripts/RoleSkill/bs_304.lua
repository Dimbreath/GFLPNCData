local bs_304 = class("bs_304", LuaSkillBase)
local base = LuaSkillBase
bs_304.config = {effectId = 10133, buffId = 137}
bs_304.ctor = function(self)
  -- function num : 0_0
end

bs_304.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_304.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.caster).recordTable)["304_T"] = 1
  self:CallCasterWait(30)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 20, attackTrigger)
end

bs_304.OnAttackTrigger = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  local targetListall = LuaSkillCtrl:CallTargetSelect(self, 35, 10)
  if targetListall.Count ~= 0 then
    for i = 0, targetListall.Count - 1 do
      local skills = ((targetListall[i]).targetRole):GetBattleSkillList()
      if skills ~= nil and ((self.caster).recordTable)["304_T"] > 0 and skills.Count > 0 then
        for j = 0, skills.Count - 1 do
          if (skills[j]).isCommonAttack ~= true and (skills[j]).useLimitTime == 0 then
            local curTotalCd = (skills[j]).totalCDTime
            LuaSkillCtrl:CallEffect((targetListall[i]).targetRole, (self.config).effectId, self, nil, nil, 0.7)
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd - 5)
            -- DECOMPILER ERROR at PC64: Confused about usage of register: R13 in 'UnsetPending'

            ;
            ((self.caster).recordTable)["304_T"] = ((self.caster).recordTable)["304_T"] - 1
            if (self.arglist)[1] >= 0 then
              LuaSkillCtrl:CallBuff(self, (targetListall[i]).targetRole, (self.config).buffId, 1, 75)
            end
            break
          end
        end
      end
    end
  end
end

bs_304.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_304


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10121 = class("bs_10121", LuaSkillBase)
local base = LuaSkillBase
bs_10121.config = {
aoe_config = {effect_shape = 1, aoe_select_code = 4, aoe_range = 10}
}
bs_10121.ctor = function(self)
  -- function num : 0_0
end

bs_10121.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10121_1", 1, self.OnAfterBattleStart)
end

bs_10121.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if (self.caster).x == 1 and (self.caster).y == 3 then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, (self.config).aoe_config)
    skillResult:BuffResult(67, 1, 45)
    skillResult:EndResult()
  else
    do
      if (self.caster).x == 1 and (self.caster).y == 2 then
        LuaSkillCtrl:CallBuff(self, self.caster, 1000, 1, 45)
        LuaSkillCtrl:CallBuff(self, self.caster, 95, 1000, 90)
      else
        if (self.caster).x == 0 and (self.caster).y == 0 then
          local skills = (self.caster):GetBattleSkillList()
          if skills ~= nil then
            local skillCount = skills.Count
            if skillCount > 0 then
              for j = 0, skillCount - 1 do
                local curTotalCd = (skills[j]).totalCDTime
                LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
              end
            end
          end
        end
      end
    end
  end
end

bs_10121.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10121


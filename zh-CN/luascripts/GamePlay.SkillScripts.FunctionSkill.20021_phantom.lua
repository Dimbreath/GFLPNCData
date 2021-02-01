-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_20021 = class("bs_20021", LuaSkillBase)
local base = LuaSkillBase
bs_20021.config = {}
bs_20021.ctor = function(self)
  -- function num : 0_0
end

bs_20021.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self.timer = LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], function()
    -- function num : 0_1_0 , upvalues : self, _ENV
    local skills = (self.caster):GetBattleSkillList()
    if skills ~= nil then
      local count = skills.Count
      if count > 0 then
        for i = 0, count - 1 do
          local curCd = (skills[i]).totalCDTime
          if not (skills[i]).isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[i], curCd)
          end
        end
        self:PlayChipEffect()
      end
    end
  end
)
end

bs_20021.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20021


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10179 = class("bs_10179", LuaSkillBase)
local base = LuaSkillBase
bs_10179.config = {}
bs_10179.ctor = function(self)
  -- function num : 0_0
end

bs_10179.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnSheldBroken, self.OnSheldBroken)
end

bs_10179.OnSheldBroken = function(self, sender, targetRole)
  -- function num : 0_2 , upvalues : _ENV
  local skills = sender:GetBattleSkillList()
  if skills ~= nil then
    local skillCount = skills.Count
    if skillCount > 0 then
      for j = 0, skillCount - 1 do
        local curTotalCd = (skills[j]).totalCDTime
        if not (skills[j]).isCommonAttack then
          LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
        end
      end
    end
  end
end

bs_10179.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10179

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10179 = class("bs_10179", LuaSkillBase)
local base = LuaSkillBase
bs_10179.config = {}
bs_10179.ctor = function(self)
    -- function num : 0_0
end

bs_10179.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddLuaTrigger(eSkillLuaTrigger.OnSheldBroken, self.OnSheldBroken)
end

bs_10179.OnSheldBroken = function(self, sender, targetRole)
    -- function num : 0_2 , upvalues : _ENV
    local skills = sender:GetBattleSkillList()
    if skills ~= nil then
        local skillCount = skills.Count
        if skillCount > 0 then
            for j = 0, skillCount - 1 do
                local curTotalCd = (skills[j]).totalCDTime
                if not (skills[j]).isCommonAttack then
                    LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
                end
            end
        end
    end
end

bs_10179.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10179


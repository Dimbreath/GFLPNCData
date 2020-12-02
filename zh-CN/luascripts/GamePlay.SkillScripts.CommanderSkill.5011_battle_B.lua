-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5011 = class("bs_5011", LuaSkillBase)
local base = LuaSkillBase
bs_5011.config = {effectIdAttack = 10308}
bs_5011.ctor = function(self)
  -- function num : 0_0
end

bs_5011.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_5011.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBattleCamShake(2)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["5011_time"] = (self.arglist)[2]
  return self:OnCallback()
end

bs_5011.OnCallback = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 20)
  if targetList.Count >= 1 then
    for i = 0, targetList.Count - 1 do
      if ((self.caster).recordTable)["5011_time"] > 0 then
        local targetRole = (targetList[i]).targetRole
        do
          local time = ((self.caster).recordTable)["5011_time"] * 2
          LuaSkillCtrl:StartTimer(self, time, function()
    -- function num : 0_3_0 , upvalues : _ENV, targetRole, self
    LuaSkillCtrl:CallEffect(targetRole, (self.config).effectIdAttack, self, self.SkillEventFunc)
  end
)
          -- DECOMPILER ERROR at PC37: Confused about usage of register: R8 in 'UnsetPending'

          ;
          ((self.caster).recordTable)["5011_time"] = ((self.caster).recordTable)["5011_time"] - 1
        end
      end
    end
    if ((self.caster).recordTable)["5011_time"] > 0 then
      self:OnCallback()
    end
    return true
  end
  return false
end

bs_5011.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 31, 20)
    if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
      local hurt = ((highAttRole[0]).targetRole).pow * (self.arglist)[1] // 1000
      if hurt <= 0 then
        hurt = 1
      end
      LuaSkillCtrl:RemoveLife(hurt, self, target)
    end
  end
end

bs_5011.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5011


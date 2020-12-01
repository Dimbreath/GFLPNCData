-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5026 = class("bs_5026", LuaSkillBase)
local base = LuaSkillBase
bs_5026.config = {effectIdAttack = 10294}
bs_5026.ctor = function(self)
  -- function num : 0_0
end

bs_5026.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_5026.PlaySkill = function(self, data, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  if selectRoles ~= nil and selectRoles.Count > 0 and selectRoles.Count % 2 == 0 then
    for i = 0, selectRoles.Count - 2, 2 do
      local target = LuaSkillCtrl:GetTargetWithGrid(selectRoles[i], selectRoles[i + 1])
      if target:GetRole() ~= self.caster then
        LuaSkillCtrl:CallEffect(target, (self.config).effectIdAttack, self, self.SkillEventFunc)
      end
    end
    return true
  end
  return false
end

bs_5026.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local role = target:GetRole()
    if role == nil then
      return 
    end
    LuaSkillCtrl:CallBattleCamShake(1)
    local hurt = role.pow * (self.arglist)[1] // 1000
    if hurt <= 0 then
      hurt = 1
    end
    LuaSkillCtrl:RemoveLife(hurt, self, role)
  end
end

bs_5026.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5026

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5026 = class("bs_5026", LuaSkillBase)
local base = LuaSkillBase
bs_5026.config = {effectIdAttack = 10294}
bs_5026.ctor = function(self)
    -- function num : 0_0
end

bs_5026.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1
end

bs_5026.PlaySkill = function(self, data, selectRoles)
    -- function num : 0_2 , upvalues : _ENV
    if selectRoles ~= nil and selectRoles.Count > 0 and selectRoles.Count % 2 ==
        0 then
        for i = 0, selectRoles.Count - 2, 2 do
            local target = LuaSkillCtrl:GetTargetWithGrid(selectRoles[i],
                                                          selectRoles[i + 1])
            if target:GetRole() ~= self.caster then
                LuaSkillCtrl:CallEffect(target, (self.config).effectIdAttack,
                                        self, self.SkillEventFunc)
            end
        end
        return true
    end
    return false
end

bs_5026.SkillEventFunc = function(self, effect, eventId, target)
    -- function num : 0_3 , upvalues : _ENV
    if eventId == eBattleEffectEvent.Trigger then
        local role = target:GetRole()
        if role == nil then return end
        LuaSkillCtrl:CallBattleCamShake(1)
        local hurt = role.pow * (self.arglist)[1] // 1000
        if hurt <= 0 then hurt = 1 end
        LuaSkillCtrl:RemoveLife(hurt, self, role)
    end
end

bs_5026.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_5026


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10188 = class("bs_10188", LuaSkillBase)
local base = LuaSkillBase
bs_10188.config = {buffId = 175}
bs_10188.ctor = function(self)
  -- function num : 0_0
end

bs_10188.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["10188_time"] = 1
end

bs_10188.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  if ((self.caster).recordTable)["10188_time"] <= 0 then
    return 
  end
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["10188_time"] = 0
  local grid = LuaSkillCtrl:GetNearestEmptyEfcGrid(self.caster, 10)
  if grid ~= nil then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1, (self.arglist)[2])
    LuaSkillCtrl:CallEffect(self.caster, 10263, self)
    LuaSkillCtrl:SetRolePos(grid, self.caster)
    LuaSkillCtrl:CallEffect(self.caster, 10264, self)
  end
end

bs_10188.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10188

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10188 = class("bs_10188", LuaSkillBase)
local base = LuaSkillBase
bs_10188.config = {buffId = 175}
bs_10188.ctor = function(self)
    -- function num : 0_0
end

bs_10188.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base
    (base.InitSkill)(self, isMidwaySkill) -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.caster).recordTable)["10188_time"] = 1
end

bs_10188.PlaySkill = function(self, data)
    -- function num : 0_2 , upvalues : _ENV
    if ((self.caster).recordTable)["10188_time"] <= 0 then return end -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'
    
    ((self.caster).recordTable)["10188_time"] = 0
    local grid = LuaSkillCtrl:GetNearestEmptyEfcGrid(self.caster, 10)
    if grid ~= nil then
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1,
                              (self.arglist)[2])
        LuaSkillCtrl:CallEffect(self.caster, 10263, self)
        LuaSkillCtrl:SetRolePos(grid, self.caster)
        LuaSkillCtrl:CallEffect(self.caster, 10264, self)
    end
end

bs_10188.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10188


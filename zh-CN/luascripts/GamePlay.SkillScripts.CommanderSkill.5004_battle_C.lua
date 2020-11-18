-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5004 = class("bs_5004", LuaSkillBase)
local base = LuaSkillBase
bs_5004.config = {effectIdAttack = 10127, effectIdAttack2 = 10127, effectId1 = 10297, effectId2 = 10003, effectId3 = 10299}
bs_5004.ctor = function(self)
  -- function num : 0_0
end

bs_5004.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_5004.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBattleCamShake(1)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 19, 20)
  if targetList.Count >= 1 and targetList[0] ~= nil then
    LuaSkillCtrl:CallEffect((targetList[0]).targetRole, (self.config).effectId1, self)
    local callback2 = BindCallback(self, self.OnCallback2, (targetList[0]).targetRole)
    LuaSkillCtrl:StartTimer(self, 3, callback2, (targetList[0]).targetRole)
  end
end

bs_5004.OnCallback2 = function(self, target)
  -- function num : 0_3 , upvalues : _ENV
  local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 31, 20)
  if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
    local hurt = ((highAttRole[0]).targetRole).pow * (self.arglist)[1] // 1000
    if hurt <= 0 then
      hurt = 1
    end
    LuaSkillCtrl:RemoveLife(hurt, self, target)
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R4 in 'UnsetPending'

    if LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[2] then
      ((self.caster).recordTable)["5005_time"] = 0
      self.callback = BindCallback(self, self.OnCallback, hurt, target)
      local targetListall = LuaSkillCtrl:CallTargetSelect(self, 2, 20, target)
      if targetListall.Count > 1 then
        self:OnCallback(hurt, target)
      end
    end
  else
    do
      do return  end
    end
  end
end

bs_5004.OnCallback = function(self, hurt, target)
  -- function num : 0_4 , upvalues : _ENV
  local highAttRole2 = LuaSkillCtrl:CallTargetSelect(self, 20, 20, target)
  LuaSkillCtrl:CallEffect((highAttRole2[0]).targetRole, (self.config).effectId3, self, nil, target)
  local callback3 = BindCallback(self, self.OnCallback3, (highAttRole2[0]).targetRole, hurt)
  LuaSkillCtrl:StartTimer(self, 3, callback3)
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["5005_time"] = ((self.caster).recordTable)["5005_time"] + 1
end

bs_5004.OnCallback3 = function(self, target, hurt)
  -- function num : 0_5 , upvalues : _ENV
  LuaSkillCtrl:RemoveLife(hurt, self, target)
  if LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[2] and ((self.caster).recordTable)["5005_time"] < (self.arglist)[3] and target.hp > 0 then
    self:OnCallback(hurt, target)
  end
end

bs_5004.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5004


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_310 = class("bs_310", LuaSkillBase)
local base = LuaSkillBase
bs_310.config = {buffId = 139}
bs_310.ctor = function(self)
  -- function num : 0_0
end

bs_310.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_310.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 31, 10)
  if targetList.Count == 0 then
    return 
  end
  ;
  (self.caster):LookAtTarget((targetList[0]).targetRole)
  self:CallCasterWait(30)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, (targetList[0]).targetRole, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 20, attackTrigger)
end

bs_310.OnAttackTrigger = function(self, target, data)
  -- function num : 0_3 , upvalues : _ENV
  local grid = LuaSkillCtrl:FindEmptyGrid(function(x, y)
    -- function num : 0_3_0
    do return x >= 3 end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  if grid ~= nil then
    LuaSkillCtrl:CallEffect(target, 10157, self)
    LuaSkillCtrl:SetRolePos(grid, target)
    LuaSkillCtrl:CallEffect(target, 10141, self)
    if (self.arglist)[3] >= 0 then
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, 1, 30)
    end
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 33, 1, target)
    if targetList.Count == 0 then
      return 
    end
    for i = 0, targetList.Count - 1 do
      local distance = LuaSkillCtrl:GetRoleGridsDistance((targetList[i]).targetRole, target)
      if distance < 2 then
        LuaSkillCtrl:RemoveLife(target.pow * (self.arglist)[2] // 1000, self, (targetList[i]).targetRole)
        LuaSkillCtrl:CallBuff(self, (targetList[i]).targetRole, 66, 1, (self.arglist)[1])
      end
    end
  end
end

bs_310.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_310


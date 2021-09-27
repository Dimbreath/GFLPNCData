local bs_101703 = class("bs_101703", LuaSkillBase)
local base = LuaSkillBase
bs_101703.config = {effectMap = 101708, effectBuff = 101712, buffExile = 279, buffDragon = 101702, movieEndRoleActionId = 1006, audioIdStart = 346, audioIdMovie = 347, audioIdEnd = 348}
bs_101703.ctor = function(self)
  -- function num : 0_0
end

bs_101703.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_101703.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  self:CallCasterWait(20)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

bs_101703.CallSelectExecute = function(self, role)
  -- function num : 0_3
  if role ~= nil and role.belongNum ~= (self.caster).belongNum and not role.unableSelect then
    self:RealPlaySkill(role)
  end
end

bs_101703.RealPlaySkill = function(self, target)
  -- function num : 0_4 , upvalues : _ENV
  local effectTarget = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  self.effectMap = LuaSkillCtrl:CallEffect(effectTarget, (self.config).effectMap, self)
  LuaSkillCtrl:StartTimer(self, (self.arglist)[1], function()
    -- function num : 0_4_0 , upvalues : self
    if self.effectMap ~= nil then
      (self.effectMap):Die()
      self.effectMap = nil
    end
  end
)
  LuaSkillCtrl:CallEffect(target, (self.config).effectBuff, self)
  LuaSkillCtrl:CallBuff(self, target, (self.config).buffDragon, (self.arglist)[3], (self.arglist)[1])
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetList ~= nil and targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      if (targetList[i]).targetRole ~= target and ((targetList[i]).targetRole).belongNum ~= eBattleRoleBelong.neutral then
        LuaSkillCtrl:CallBuff(self, (targetList[i]).targetRole, (self.config).buffExile, 1, (self.arglist)[1])
      end
    end
  end
end

bs_101703.PlayUltEffect = function(self)
  -- function num : 0_5 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_101703.OnUltRoleAction = function(self)
  -- function num : 0_6 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 15, self.PlayUltMovie, self)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

bs_101703.OnMovieFadeOut = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnMovieFadeOut)(self)
end

bs_101703.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_101703.LuaDispose = function(self)
  -- function num : 0_9 , upvalues : base
  (base.LuaDispose)(self)
  self.effectMap = nil
end

return bs_101703


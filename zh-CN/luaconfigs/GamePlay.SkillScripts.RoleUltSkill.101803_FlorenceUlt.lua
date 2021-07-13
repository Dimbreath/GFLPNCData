-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10803 = class("bs_10803", LuaSkillBase)
local base = LuaSkillBase
bs_10803.config = {effectId_start = 10833, buffId = 274, actionId_start = 1005, actionId_end = 1002}
bs_10803.ctor = function(self)
  -- function num : 0_0
end

bs_10803.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_10803.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(20)
  LuaSkillCtrl:StartTimer(self, 3, function()
    -- function num : 0_2_0 , upvalues : _ENV, self
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_start, self)
  end
, nil)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
  LuaSkillCtrl:CallBattleCamShake()
end

bs_10803.CallSelectExecute = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if role ~= nil and role.belongNum == (self.caster).belongNum then
    LuaSkillCtrl:CallBuffRepeated(self, role, (self.config).buffId, 1, (self.arglist)[1], false, self.OnBuffExecute)
  end
end

bs_10803.OnBuffExecute = function(self, buff, targetRole)
  -- function num : 0_4 , upvalues : _ENV
  if targetRole:GetBuffTier((self.config).buffId) > 0 then
    local hurt = targetRole.hp * (self.arglist)[3] // 1000
    if hurt < targetRole.hp and hurt ~= 0 then
      LuaSkillCtrl:RemoveLife(hurt, self, targetRole, false, false)
    end
  end
end

bs_10803.PlayUltEffect = function(self)
  -- function num : 0_5 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_10803_3", 1, self.OnMovieFadeOut)
end

bs_10803.OnUltRoleAction = function(self)
  -- function num : 0_6 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, function()
    -- function num : 0_6_0 , upvalues : _ENV
    LuaSkillCtrl:CallPlayUltMovie()
  end
, nil)
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).actionId_start)
end

bs_10803.OnMovieFadeOut = function(self)
  -- function num : 0_7 , upvalues : _ENV
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).actionId_end)
  self:RemoveSkillTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
end

bs_10803.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10803


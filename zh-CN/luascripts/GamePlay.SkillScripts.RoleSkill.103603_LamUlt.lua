-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1061 = class("bs_1061", LuaSkillBase)
local base = LuaSkillBase
bs_1061.config = {
hurt_config = {hit_formula = 10010, basehurt_formula = 10090}
, startEffect = 10311, mainEffect = 10312, audioId1 = 114, audioId2 = 115, audioId3 = 116}
bs_1061.ctor = function(self)
  -- function num : 0_0
end

bs_1061.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self.hurt_config = {}
end

bs_1061.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(13)
  if selectTargetCoord ~= nil then
    local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    do
      (self.caster):LookAtTarget(inputTarget)
      LuaSkillCtrl:CallRoleAction(self.caster, 1010)
      LuaSkillCtrl:StartTimer(self, 3, function()
    -- function num : 0_2_0 , upvalues : _ENV, self, inputTarget, selectRoles
    LuaSkillCtrl:CallRoleAction(self.caster, 1006)
    LuaSkillCtrl:CallEffect(inputTarget, (self.config).mainEffect, self)
    self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
  end
)
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.caster).recordTable).lastAttackRole = nil
      -- DECOMPILER ERROR at PC34: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.caster).recordTable).lastComAttackRole = nil
    end
  end
end

bs_1061.CallSelectExecute = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if role ~= nil and role.belongNum ~= (self.caster).belongNum and not role.unableSelect then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
    skillResult:EndResult()
  end
end

bs_1061.PlayUltEffect = function(self)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15)
  self:AddTrigger(eSkillTriggerType.AfterSelfUltMovieEnd, "bs_1061_2", 1, self.OnMovieEnd)
  self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_1061_3", 1, self.OnMovieFadeOut)
end

bs_1061.OnUltRoleAction = function(self)
  -- function num : 0_5 , upvalues : _ENV, base
  LuaSkillCtrl:StartTimerInUlt(11, function()
    -- function num : 0_5_0 , upvalues : _ENV, self
    LuaSkillCtrl:CallPlayUltMovie()
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId2)
  end
, nil)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 7, 10)
  if targetList.Count == 0 then
    return 
  end
  ;
  (base.OnUltRoleAction)(self)
  self:CallCasterWait(15)
  ;
  (self.caster):LookAtTarget((targetList[0]).targetRole)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
  LuaSkillCtrl:PlaySkillCv((self.caster).roleDataId)
  self.startEffect = LuaSkillCtrl:CallEffect(self.caster, (self.config).startEffect, self)
end

bs_1061.OnMovieFadeOut = function(self)
  -- function num : 0_6 , upvalues : _ENV
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId3)
  LuaSkillCtrl:CallRoleAction(self.caster, 1006)
  self:RemoveTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  self:RemoveTrigger(eSkillTriggerType.AfterSelfUltMovieEnd)
end

bs_1061.OnMovieEnd = function(self)
  -- function num : 0_7
end

bs_1061.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1061


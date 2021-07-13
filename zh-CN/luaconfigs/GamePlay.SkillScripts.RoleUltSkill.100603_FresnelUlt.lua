-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100603 = class("bs_100603", LuaSkillBase)
local base = LuaSkillBase
bs_100603.config = {
hurt_config = {hit_formula = 0, basehurt_formula = 10076, crit_formula = 0, crithur_ratio = 0, returndamage_formula = 0}
, effectId_start = 10517, buffId_115 = 115, selectId = 9, select_range = 10, start_time = 5}
bs_100603.ctor = function(self)
  -- function num : 0_0
end

bs_100603.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_100603.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(20)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId, (self.config).select_range)
  if targetList.Count <= 0 then
    return 
  end
  local effectTarget = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(effectTarget, (self.config).effectId_start, self)
  LuaSkillCtrl:StartTimer(nil, (self.config).start_time, function()
    -- function num : 0_2_0 , upvalues : targetList, _ENV, self
    for i = 0, targetList.Count - 1 do
      local target = (targetList[i]).targetRole
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config)
      skillResult:EndResult()
      if target.intensity ~= 0 then
        LuaSkillCtrl:CallBuff(self, (targetList[i]).targetRole, (self.config).buffId_115, 1, (self.arglist)[2])
      end
    end
  end
, nil)
  LuaSkillCtrl:CallBattleCamShake()
end

bs_100603.PlayUltEffect = function(self)
  -- function num : 0_3 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_100603_3", 1, self.OnMovieFadeOut)
end

bs_100603.OnUltRoleAction = function(self)
  -- function num : 0_4 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 8, function()
    -- function num : 0_4_0 , upvalues : _ENV
    LuaSkillCtrl:CallPlayUltMovie()
  end
, nil)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

bs_100603.OnMovieFadeOut = function(self)
  -- function num : 0_5 , upvalues : _ENV
  LuaSkillCtrl:CallRoleAction(self.caster, 1006)
  self:RemoveSkillTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
end

bs_100603.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100603


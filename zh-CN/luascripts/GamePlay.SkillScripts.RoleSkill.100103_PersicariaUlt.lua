-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1059 = class("bs_1059", LuaSkillBase)
local base = LuaSkillBase
bs_1059.config = {effectId1 = 10222, effectId3 = 10223, buffId = 162, 
aoe_config = {effect_shape = 1, aoe_select_code = 3, aoe_range = 10}
, 
heal_config = {baseheal_formula = 10011, heal_number = 0, correct_formula = 9990}
, audioId1 = 100, audioId2 = 101, audioId3 = 102}
bs_1059.ctor = function(self)
  -- function num : 0_0
end

bs_1059.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self.hurt_config = {}
  self.buff_during_time = (self.arglist)[2]
end

bs_1059.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self, nil, nil, 0.5)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
  LuaSkillCtrl:CallBattleCamShake()
end

bs_1059.CallSelectExecute = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if role ~= nil and role ~= nil and role.belongNum == (self.caster).belongNum and not role.unableSelect then
    LuaSkillCtrl:CallBuff(self, role, (self.config).buffId, 1, self.buff_during_time)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, nil, false, false)
    skillResult:EndResult()
  end
end

bs_1059.PlayUltEffect = function(self)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15)
  self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_1059_3", 1, self.OnMovieFadeOut)
end

bs_1059.OnUltRoleAction = function(self)
  -- function num : 0_5 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(7, function()
    -- function num : 0_5_0 , upvalues : _ENV, self
    LuaSkillCtrl:CallPlayUltMovie()
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId2)
  end
, nil)
  self:CallCasterWait(20)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
  LuaSkillCtrl:PlaySkillCv((self.caster).roleDataId)
end

bs_1059.OnMovieFadeOut = function(self)
  -- function num : 0_6 , upvalues : _ENV
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId3)
  LuaSkillCtrl:CallRoleAction(self.caster, 1006)
  self:RemoveTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
end

bs_1059.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1059


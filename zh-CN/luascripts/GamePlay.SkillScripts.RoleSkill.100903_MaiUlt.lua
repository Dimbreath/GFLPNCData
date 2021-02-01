-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100903 = class("bs_100903", LuaSkillBase)
local base = LuaSkillBase
bs_100903.config = {}
bs_100903.ctor = function(self)
  -- function num : 0_0
end

bs_100903.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_100903.PlaySkill = function(self, data)
  -- function num : 0_2
end

bs_100903.PlayUltEffect = function(self)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
  self:AddTrigger(eSkillTriggerType.AfterSelfUltMovieEnd, "bs_100903_2", 1, self.OnMovieEnd)
end

bs_100903.OnUltRoleAction = function(self)
  -- function num : 0_4 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(15, function()
    -- function num : 0_4_0 , upvalues : _ENV
    LuaSkillCtrl:CallPlayUltMovie()
  end
, nil)
  self:CallCasterWait(20)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
  LuaSkillCtrl:PlaySkillCv((self.caster).roleDataId)
end

bs_100903.OnMovieEnd = function(self)
  -- function num : 0_5 , upvalues : _ENV
  LuaSkillCtrl:CallRoleAction(self.caster, 1002)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  self:RemoveTrigger(eSkillTriggerType.AfterSelfUltMovieEnd)
end

bs_100903.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100903


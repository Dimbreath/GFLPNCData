-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1023 = class("bs_1023", LuaSkillBase)
local base = LuaSkillBase
bs_1023.config = {
hurt_config = {basehurt_formula = 10076}
, effectIdTornado1 = 10007, effectIdTornado2 = 10005, effetcIdTornadoRadius = 100, buffId = 115, audioId1 = 46, audioId2 = 47}
bs_1023.ctor = function(self)
  -- function num : 0_0
end

bs_1023.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_1023_1", 1, self.BeforeEndBattle)
end

bs_1023.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  ((self.caster).auSource):PlayAudioById((self.config).audioId1)
  LuaSkillCtrl:CallEffect(self.caster, 10014, self)
  LuaSkillCtrl:CallRoleAction(self.caster, 1002)
  self:CallCasterWait(12)
  local gridTemp = LuaSkillCtrl:CallFindGridMostRolesArounded(2)
  local gridTarget = LuaSkillCtrl:GetTargetWithGrid(gridTemp.x, gridTemp.y)
  if gridTarget ~= nil then
    self.feng = ((self.caster).auSource):PlayAudioById((self.config).audioId2)
    LuaSkillCtrl:StartTimer(self, 5, function()
    -- function num : 0_2_0 , upvalues : self, _ENV, gridTarget
    if self.effect ~= nil then
      (self.effect):Die()
      self.effect = nil
    end
    self.effect = LuaSkillCtrl:CallEffect(gridTarget, (self.config).effectIdTornado2, self, nil, nil, nil, false)
    self._callHurt = BindCallback(self, self.CallHurt, self.effect)
    local _onCollision = BindCallback(self, self.OnCollisionStay)
    LuaSkillCtrl:CallAddCircleColliderForEffect(self.effect, (self.config).effetcIdTornadoRadius, eColliderInfluenceType.Enemy, _onCollision)
    self.colliDetectTime = (LuaSkillCtrl.battleCtrl).frame
  end
, nil)
    LuaSkillCtrl:StartTimer(nil, (self.arglist)[3], function()
    -- function num : 0_2_1 , upvalues : self, _ENV
    if self.effect ~= nil then
      (self.effect):Die()
      self.effect = nil
      if self.feng ~= nil then
        AudioManager:StopAudioByBack(self.feng)
      end
    end
  end
)
  end
end

bs_1023.OnCollisionStay = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if (LuaSkillCtrl.battleCtrl).frame == self.colliDetectTime then
    (self._callHurt)(role)
    self.colliDetectTime = (LuaSkillCtrl.battleCtrl).frame
  else
    if (self.arglist)[2] - 1 <= (LuaSkillCtrl.battleCtrl).frame - self.colliDetectTime then
      self.colliDetectTime = (LuaSkillCtrl.battleCtrl).frame + 1
    end
  end
end

bs_1023.CallHurt = function(self, effect, target)
  -- function num : 0_4 , upvalues : _ENV
  if target ~= nil and effect ~= nil then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    if (self.arglist)[5] == 1 then
      skillResult:BuffResult((self.config).buffId, 1, (self.arglist)[4])
    end
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
    skillResult:EndResult()
  end
end

bs_1023.BeforeEndBattle = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.feng ~= nil then
    AudioManager:StopAudioByBack(self.feng)
    self.feng = nil
  end
end

bs_1023.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1023


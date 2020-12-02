-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1044 = class("bs_1044", LuaSkillBase)
local base = LuaSkillBase
bs_1044.config = {buffId1 = 145, buffId2 = 146, effectId = 10185, audioId = 106}
bs_1044.ctor = function(self)
  -- function num : 0_0
end

bs_1044.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_1044_3", 1, self.OnAfterHurt)
  self.BJ = nil
end

bs_1044.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and not isMiss and (skill.dataId == 11 or skill.dataId == 1044 or skill.dataId == 1045) then
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId1, 1, (self.arglist)[2])
    ;
    ((self.caster).auSource):PlayAudioById((self.config).audioId)
    if skill.isCommonAttack then
      if self.BJ ~= nil then
        (self.BJ):Die()
        self.BJ = LuaSkillCtrl:CallEffect(target, (self.config).effectId, self)
      else
        self.BJ = LuaSkillCtrl:CallEffect(target, (self.config).effectId, self)
      end
    end
  end
end

bs_1044.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1044


local bs_102901 = class("bs_102901", LuaSkillBase)
local base = LuaSkillBase
bs_102901.config = {buffId_blind = 3012, buffId_115 = 115, buffId_102900 = 102900, selectId_pass = 5}
bs_102901.ctor = function(self)
  -- function num : 0_0
end

bs_102901.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_102901_2", 1, self.OnAfterAddBuff, nil, nil, nil, 2, nil, 2)
  self:AddTrigger(eSkillTriggerType.BuffDie, "bs_102901_buffDie", 1, self.OnBuffDie)
  self:AddAfterHurtTrigger("bs_102901_3", 1, self.OnAfterHurt, self.caster)
  self.tigers = 0
end

bs_102901.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[2] and sender == self.caster and skill.isCommonAttack == true and target ~= nil and target.hp > 0 and target.belongNum ~= (self.caster).belongNum and target.intensity ~= 0 then
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_blind, 1, (self.arglist)[3])
  end
end

bs_102901.OnAfterAddBuff = function(self, buff, target, isOverlay)
  -- function num : 0_3 , upvalues : _ENV
  if buff.dataId == (self.config).buffId_115 or buff.dataId == 3012 then
    local tiger = 0
    local targetList = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId_pass, 10)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local role = (targetList[i]).targetRole
        if role:GetBuffTier((self.config).buffId_115) > 0 then
          tiger = tiger + 1
        end
        if role:GetBuffTier(3012) > 0 then
          tiger = tiger + 1
        end
      end
    end
    do
      if tiger ~= self.tigers then
        LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_102900, 0, true)
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_102900, tiger, nil, true)
        self.tigers = tiger
      end
    end
  end
end

bs_102901.OnBuffDie = function(self, buff, target, removeType)
  -- function num : 0_4 , upvalues : _ENV
  if (buff.dataId == (self.config).buffId_115 or buff.dataId == 3012) and removeType ~= eBuffRemoveType.Conflict then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_102900, 1, true)
    self.tigers = self.tigers - 1
  end
end

bs_102901.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102901


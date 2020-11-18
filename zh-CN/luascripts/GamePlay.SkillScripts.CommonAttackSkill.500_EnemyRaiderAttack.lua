-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_500 = class("bs_500", bs_1)
local base = bs_1
bs_500.config = {effectId1 = 10081, effectId2 = 10082, audioId1 = 22, audioId2 = 22}
bs_500.config = setmetatable(bs_500.config, {__index = base.config})
bs_500.ctor = function(self)
  -- function num : 0_0
end

bs_500.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_500.PlaySkill = function(self, passdata)
  -- function num : 0_2 , upvalues : _ENV
  self.lastAttackRole = ((self.caster).recordTable).lastAttackRole
  local data = nil
  if passdata ~= nil then
    data = setmetatable(passdata, {__index = self.config})
  else
    data = self.config
  end
  local bewitch = (self.caster):ContainBuffFeature(eBuffFeatureType.Bewitch)
  if bewitch ~= self.lastBewitch then
    self.lastAttackRole = nil
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.caster).recordTable).lastAttackRole = nil
    self.lastBewitch = bewitch
  else
    if ((self.caster).recordTable).lastAttackRole ~= nil and LuaSkillCtrl:IsAbleAttackTarget(self.caster, self.lastAttackRole, data.rangeOffset + (self.caster).attackRange) and LuaSkillCtrl:IsWorthAttacking(self.lastAttackRole) then
      (self.caster):LookAtTarget(self.lastAttackRole)
      if LuaSkillCtrl:IsAbleAttackCheckExcludedDir(self.caster, self.lastAttackRole, 30) then
        self.rotateWaited = true
        LuaSkillCtrl:StartTimer(self, 3, BindCallback(self, self.RealPlaySkill, self.lastAttackRole, data))
      else
        self.rotateWaited = false
        self:RealPlaySkill(self.lastAttackRole, data)
      end
      return 
    end
  end
  local targetList = LuaSkillCtrl:CallTargetSelect(self, data.targetSelect, data.rangeOffset)
  if targetList.Count ~= 0 then
    self.lastAttackRole = (targetList[0]).targetRole
    -- DECOMPILER ERROR at PC98: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.caster).recordTable).lastAttackRole = self.lastAttackRole
    ;
    (self.caster):LookAtTarget(self.lastAttackRole)
    if LuaSkillCtrl:IsAbleAttackCheckExcludedDir(self.caster, self.lastAttackRole, 30) then
      self.rotateWaited = true
      LuaSkillCtrl:StartTimer(self, 3, BindCallback(self, function(atkRole, data)
    -- function num : 0_2_0 , upvalues : self, _ENV
    if ((self.caster).recordTable).completeFirstComatk or (self.caster):ContainBuffFeature(eBuffFeatureType.Taunt) then
      LuaSkillCtrl:CallSelectTargetEffect(self, atkRole)
    end
    self:RealPlaySkill(atkRole, data)
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

    if ((self.caster).recordTable).completeFirstComatk == nil then
      ((self.caster).recordTable).completeFirstComatk = true
    end
  end
, self.lastAttackRole, data))
    else
      self.rotateWaited = false
      if ((self.caster).recordTable).completeFirstComatk or (self.caster):ContainBuffFeature(eBuffFeatureType.Taunt) then
        LuaSkillCtrl:CallSelectTargetEffect(self, self.lastAttackRole)
      end
      self:RealPlaySkill(self.lastAttackRole, data)
      -- DECOMPILER ERROR at PC153: Confused about usage of register: R5 in 'UnsetPending'

      if ((self.caster).recordTable).completeFirstComatk == nil then
        ((self.caster).recordTable).completeFirstComatk = true
      end
    end
  else
    self.lastAttackRole = nil
    -- DECOMPILER ERROR at PC158: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.caster).recordTable).lastAttackRole = nil
  end
end

bs_500.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_500


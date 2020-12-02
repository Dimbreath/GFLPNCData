-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_201902 = class("bs_201902", LuaSkillBase)
local base = LuaSkillBase
local Stack = require("Framework.Lib.Stack")
bs_201902.config = {effecttrail = 10405, effecthit = 10406, effectSC = 10407, effectSY = 10408, effectSYend = 10410, buffIdSC = 186, buffIdSY = 187}
bs_201902.ctor = function(self)
  -- function num : 0_0
end

bs_201902.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_201902_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_201902_2", 2, self.OnAfterHurt)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["2019_times"] = (self.arglist)[3]
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["514_arg2"] = (self.arglist)[2]
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["514_arg6"] = (self.arglist)[6]
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["514_arg7"] = (self.arglist)[7]
end

bs_201902.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local pz = BindCallback(self, self.Passiveback)
  self.time = LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], pz, self, -1, 0)
end

bs_201902.Passiveback = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local target = LuaSkillCtrl:CallTargetSelect(self, 42, 10)
  if target.Count > 0 then
    for i = 0, target.Count - 1 do
      if ((target[i]).targetRole):GetBuffTier((self.config).buffIdSY) < 1 then
        LuaSkillCtrl:CallEffect((target[0]).targetRole, (self.config).effecttrail, self, self.SkillEventFunc)
        break
      end
    end
  end
end

bs_201902.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_4 , upvalues : _ENV, Stack
  if sender == self.caster and skill.dataId == 201903 and target:GetBuffTier((self.config).buffIdSY) < 1 and target.intensity ~= 0 then
    if target:GetBuffTier((self.config).buffIdSC) < (self.arglist)[3] - 1 then
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffIdSC, 1)
    else
      LuaSkillCtrl:DispelBuff(target, (self.config).buffIdSC, 0)
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffIdSY, 1, (self.arglist)[8])
      -- DECOMPILER ERROR at PC59: Confused about usage of register: R8 in 'UnsetPending'

      if ((self.caster).recordTable).SYRecordRoles == nil then
        ((self.caster).recordTable).SYRecordRoles = (Stack.New)()
      end
      ;
      (((self.caster).recordTable).SYRecordRoles):Push(target)
    end
  end
end

bs_201902.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV, Stack
  if effect.dataId ~= (self.config).effecttrail or (target.targetRole):GetBuffTier((self.config).buffIdSY) >= 1 and target.intensity ~= 0 then
    return 
  end
  if eventId == eBattleEffectEvent.Trigger then
    if (target.targetRole):GetBuffTier((self.config).buffIdSC) < (self.arglist)[3] - 1 then
      LuaSkillCtrl:CallBuff(self, target.targetRole, (self.config).buffIdSC, 1)
    else
      LuaSkillCtrl:DispelBuff(target.targetRole, (self.config).buffIdSC, 0)
      LuaSkillCtrl:CallBuff(self, target.targetRole, (self.config).buffIdSY, 1, (self.arglist)[8])
      -- DECOMPILER ERROR at PC65: Confused about usage of register: R4 in 'UnsetPending'

      if ((self.caster).recordTable).SYRecordRoles == nil then
        ((self.caster).recordTable).SYRecordRoles = (Stack.New)()
      end
      ;
      (((self.caster).recordTable).SYRecordRoles):Push(target.targetRole)
    end
  end
end

bs_201902.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
  if self.time ~= nil then
    (self.time):Stop()
    self.time = nil
  end
end

return bs_201902


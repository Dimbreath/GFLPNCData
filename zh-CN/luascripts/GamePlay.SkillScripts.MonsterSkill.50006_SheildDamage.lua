-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_50006 = class("bs_50006", LuaSkillBase)
local base = LuaSkillBase
local ShieldSkillBase = require("GamePlay.SkillScripts.BaseSkill.ShieldSkillBase")
bs_50006.config = {sheildBuffId = 174, shieldKeyYuan = "50002_HuDun", shieldKeyJin = "50003_HuDun", buffIdYuan = 1047, effectIdYuan = 10371, buffIdJin = 1048, effectIdJin = 10373, fakeYuanId = 1055, fakeJinId = 1056}
bs_50006.ctor = function(self)
  -- function num : 0_0
end

bs_50006.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_50006_1", 1000, self.OnSetHurt)
end

bs_50006.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV, ShieldSkillBase
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

  -- DECOMPILER ERROR at PC38: Unhandled construct in 'MakeBoolean' P1

  if (context.sender).attackRange > 1 and context.sender == self.caster and ((context.target).recordTable).sheildValue_50002 ~= nil and ((context.target).recordTable).sheildValue_50002hurt ~= nil and ((context.target).recordTable).sheildValue_50002 > 0 then
    ((context.target).recordTable).sheildValue_50002 = (math.max)(0, ((context.target).recordTable).sheildValue_50002 - ((context.target).recordTable).sheildValue_50002hurt * 500 // 1000)
    ;
    (ShieldSkillBase.ShieldBaseFunc)(((context.target).recordTable).sheildValue_50002hurt * 500 // 1000, context.target, (self.config).shieldKeyYuan)
    if ((context.target).recordTable).sheildValue_50002 == 0 and (context.target):GetBuffTier((self.config).sheildBuffId) > 0 then
      LuaSkillCtrl:DispelBuff(context.target, (self.config).buffIdYuan)
      LuaSkillCtrl:DispelBuff(context.target, (self.config).sheildBuffId)
      LuaSkillCtrl:CallSheldBroken(context.sender, context.target)
      LuaSkillCtrl:CallEffect(context.target, (self.config).effectIdYuan, self)
    end
  end
  -- DECOMPILER ERROR at PC124: Confused about usage of register: R2 in 'UnsetPending'

  if (context.sender).attackRange == 1 and context.sender == self.caster and ((context.target).recordTable).sheildValue_50003 ~= nil and ((context.target).recordTable).sheildValue_50003hurt ~= nil and ((context.target).recordTable).sheildValue_50003 > 0 then
    ((context.target).recordTable).sheildValue_50003 = (math.max)(0, ((context.target).recordTable).sheildValue_50003 - ((context.target).recordTable).sheildValue_50003hurt * 500 // 1000)
    ;
    (ShieldSkillBase.ShieldBaseFunc)(((context.target).recordTable).sheildValue_50003hurt * 500 // 1000, context.target, (self.config).shieldKeyJin)
    if ((context.target).recordTable).sheildValue_50003 == 0 and (context.target):GetBuffTier((self.config).sheildBuffId) > 0 then
      LuaSkillCtrl:DispelBuff(context.target, (self.config).buffIdJin)
      LuaSkillCtrl:DispelBuff(context.target, (self.config).sheildBuffId)
      LuaSkillCtrl:CallSheldBroken(context.sender, context.target)
      LuaSkillCtrl:CallEffect(context.target, (self.config).effectIdJin, self)
    end
  end
end

bs_50006.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_50006


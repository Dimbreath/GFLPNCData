-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10136 = class("bs_10136", LuaSkillBase)
local base = LuaSkillBase
local ShieldSkillBase = require("GamePlay.SkillScripts.BaseSkill.ShieldSkillBase")
bs_10136.config = {effectId1 = 10243, effectId2 = 10244, buffDefenceId = 1076}
bs_10136.ctor = function(self)
  -- function num : 0_0
end

bs_10136.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10136_1", 1, self.OnAfterBattleStart)
end

bs_10136.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetlist.Count <= 0 then
    return 
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = (targetlist[i]).targetRole
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (targetRole.recordTable)["10136_arg"] = (math.max)(1, (self.arglist)[1] * (self.caster).hp // 1000)
    LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffDefenceId, 1)
  end
end

bs_10136.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10136


-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_200001 = require("GamePlay.SkillScripts.MonsterSkill.200001_Boss_mianyi")
local bs_201901 = class("bs_201901", bs_200001)
local base = bs_200001
bs_201901.config = {buffIdSC = 186, buffIdSY = 187, buffSilence = 1159}
bs_201901.config = setmetatable(bs_201901.config, {__index = base.config})
bs_201901.ctor = function(self)
  -- function num : 0_0
end

bs_201901.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["514_Roll"] = (self.arglist)[1]
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["514_skill"] = true
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["514_arg"] = (self.arglist)[2]
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["514_buffarg"] = (self.arglist)[3]
  self:AddAfterHurtTrigger("bs_201901_3", 1, self.OnAfterHurt, nil, self.caster)
end

bs_201901.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender.roleDataId == 30004 and skill.dataId == 202003 and not ((self.caster).recordTable).SkillFlag and self:IsReadyToTake() then
    self:OnSkillTake()
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffSilence, 0)
    local skills = (self.caster):GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if skillCount > 0 then
        for j = 0, skillCount - 1 do
          local curTotalCd = (skills[j]).totalCDTime
          if (skills[j]).dataId == 201905 then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
          end
        end
      end
    end
  end
end

bs_201901.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base, _ENV
  (base.OnCasterDie)(self)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      LuaSkillCtrl:DispelBuff((targetList[i]).targetRole, (self.config).buffIdSC, 10, true)
      LuaSkillCtrl:DispelBuff((targetList[i]).targetRole, (self.config).buffIdSY, 10, true)
    end
  end
end

return bs_201901


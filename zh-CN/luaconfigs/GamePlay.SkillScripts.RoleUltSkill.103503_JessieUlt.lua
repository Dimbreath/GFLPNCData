-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_103503 = class("bs_103503", LuaSkillBase)
local base = LuaSkillBase
bs_103503.config = {startEffect1 = 10518, startEffect2 = 10519, effectRole = 10520, effectRoleKey = "103503_clean", 
hurt_config = {basehurt_formula = 10094}
}
bs_103503.ctor = function(self)
  -- function num : 0_0
end

bs_103503.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self.hurt_config = {}
end

bs_103503.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(5)
  local targetList = nil
  local preList = LuaSkillCtrl:CallTargetSelect(self, 5, 10)
  if preList.Count <= 0 then
    return 
  end
  local effectTarget = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  local map = LuaSkillCtrl:GetMapBorder()
  if map.x == 6 then
    LuaSkillCtrl:CallEffect(effectTarget, (self.config).startEffect1, self, nil, nil, 1)
  else
    LuaSkillCtrl:CallEffect(effectTarget, (self.config).startEffect2, self, nil, nil, 1)
  end
  local allBuffTier = 0
  LuaSkillCtrl:StartTimer(nil, 5, function()
    -- function num : 0_2_0 , upvalues : targetList, _ENV, self, allBuffTier
    targetList = LuaSkillCtrl:CallTargetSelect(self, 5, 10)
    for i = 0, targetList.Count - 1 do
      local role = (targetList[i]).targetRole
      if role.belongNum == (self.caster).belongNum then
        local debuffs = LuaSkillCtrl:GetRoleBuffs(role)
        do
          do
            if debuffs.Count > 0 then
              local num = 0
              for i = 0, debuffs.Count - 1 do
                if (debuffs[i]).buffType == 2 then
                  num = num + 1
                  LuaSkillCtrl:DispelBuff(role, (debuffs[i]).dataId, 0)
                end
              end
              if num > 0 then
                LuaSkillCtrl:CallEffect(role, (self.config).effectRole, self)
                allBuffTier = allBuffTier + (num)
              end
            end
            LuaSkillCtrl:CallBuff(self, role, 240, 1, (self.arglist)[3])
            if role.intensity ~= 0 then
              local buffs = LuaSkillCtrl:GetRoleBuffs(role)
              if buffs.Count > 0 then
                local num = 0
                for i = 0, buffs.Count - 1 do
                  if (buffs[i]).buffType == 1 then
                    num = num + 1
                    LuaSkillCtrl:DispelBuff(role, (buffs[i]).dataId, 0)
                  end
                end
                if num > 0 then
                  LuaSkillCtrl:CallEffect(role, (self.config).effectRole, self)
                  allBuffTier = allBuffTier + (num)
                end
              end
            end
            do
              -- DECOMPILER ERROR at PC108: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC108: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC108: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC108: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
    local hurtList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    if hurtList ~= nil and hurtList.Count > 0 then
      for i = 0, hurtList.Count - 1 do
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, (hurtList[i]).targetRole)
        LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, {allBuffTier})
        skillResult:EndResult()
      end
    end
  end
, nil)
end

bs_103503.PlayUltEffect = function(self)
  -- function num : 0_3 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_103503_3", 1, self.OnMovieFadeOut)
end

bs_103503.OnUltRoleAction = function(self)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:StartTimerInUlt(self, 7, function()
    -- function num : 0_4_0 , upvalues : _ENV
    LuaSkillCtrl:CallPlayUltMovie()
  end
, nil)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

bs_103503.OnMovieFadeOut = function(self)
  -- function num : 0_5 , upvalues : _ENV
  LuaSkillCtrl:CallRoleAction(self.caster, 1006)
  self:RemoveSkillTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
end

bs_103503.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103503


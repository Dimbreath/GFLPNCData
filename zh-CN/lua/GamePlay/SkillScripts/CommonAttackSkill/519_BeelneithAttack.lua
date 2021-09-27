local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_519 = class("bs_519", bs_1)
local base = bs_1
bs_519.config = {effectId_1 = 10402, effectId_2 = 10402, effectId_heal = 10410, effectId_three = 10403, action2 = 1001, buffId_186SC = 186, buffId_187SY = 187, 
HurtConfig2 = {basehurt_formula = 10055, lifesteal_formula = 10074}
, 
HurtConfig = {lifesteal_formula = 10074}
, action3 = 1021, 
SYhurtconfig = {hit_formula = 10010, basehurt_formula = 10082}
, effectId_up = 10263, effectId_down = 10264, audioId1 = 331, audioId2 = 331, audioId_three = 374, audioId_pow = 375, audioId3 = 373, audioId_up = 376, audioId_down = 377, audioId_heavy = 336, 
HealConfig = {baseheal_formula = 501}
}
bs_519.config = setmetatable(bs_519.config, {__index = base.config})
bs_519.ctor = function(self)
  -- function num : 0_0
end

bs_519.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_519_2", 2, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, 519)
  self.roleRecord = nil
  self.buffFlag = true
end

bs_519.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and target:GetBuffTier((self.config).buffId_187SY) > 0 and skill.dataId == 519 then
    local arg6 = ((self.caster).recordTable)["514_arg6"]
    local healback = BindCallback(self, self.Onhealback, target, arg6, hurt)
    LuaSkillCtrl:StartTimer(self, 14, healback, self)
  end
end

bs_519.RealPlaySkill = function(self, target, data)
  -- function num : 0_3 , upvalues : _ENV, base
  if ((self.caster).recordTable).SYRecordRoles ~= nil and (((self.caster).recordTable).SYRecordRoles):Count() > 0 then
    local role = nil
    do
      for i = 0, 10 do
        role = (((self.caster).recordTable).SYRecordRoles):Peek()
        if role ~= nil and role:GetBuffTier((self.config).buffId_187SY) == 0 then
          (((self.caster).recordTable).SYRecordRoles):Pop()
          role = nil
        else
        end
      end
    end
    do
      if (role ~= nil and role:GetBuffTier((self.config).buffId_187SY) >= 1) or role ~= nil then
        if LuaSkillCtrl:GetRoleGridsDistance(self.caster, role) > 1 then
          local grid = LuaSkillCtrl:FindEmptyGridAroundRole(role)
          if grid == nil then
            local targetlist = LuaSkillCtrl:CallTargetSelect(self, 33, 10)
            if targetlist.Count > 0 then
              for i = 0, targetlist.Count - 1 do
                if ((targetlist[i]).targetRole):GetBuffTier((self.config).buffId_187SY) >= 1 then
                  if LuaSkillCtrl:GetRoleGridsDistance(self.caster, role) > 1 then
                    grid = LuaSkillCtrl:FindEmptyGridAroundRole(role)
                    if grid ~= nil then
                      role = (targetlist[i]).targetRole
                      break
                    end
                  else
                    role = (targetlist[i]).targetRole
                    grid = nil
                    break
                  end
                end
              end
            end
          end
          do
            do
              if grid == nil then
                (base.RealPlaySkill)(self, target, data)
                return 
              end
              LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId_up)
              LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_up, self, nil, nil, nil, true)
              LuaSkillCtrl:SetRolePos(grid, self.caster)
              LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_down, self, nil, nil, nil, true)
              LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId_down)
              local arg6 = ((self.caster).recordTable)["514_arg6"]
              do
                local SYTrigger = BindCallback(self, self.OnSYTrigger, role, data, arg6)
                self:CallCasterWait(36)
                ;
                (self.caster):LookAtTarget(role)
                LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1021, 1, 11, SYTrigger)
                LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId_pow)
                LuaSkillCtrl:CallEffect(role, 10404, self, nil, nil, nil, true)
                do return  end
                if ((self.caster).recordTable)["514_skill"] == true then
                  local Roll = ((self.caster).recordTable)["514_Roll"]
                  if Roll == nil then
                    Roll = 0
                  end
                  if LuaSkillCtrl:CallRange(1, 1000) <= Roll then
                    self.attackTime = 3
                    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
                    if targetList.Count > 0 then
                      LuaSkillCtrl:CallRoleAction(self.caster, 1004)
                      LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId_three)
                      self:CallCasterWait(21)
                      LuaSkillCtrl:StartTimer(self, 6, function()
    -- function num : 0_3_0 , upvalues : targetList, _ENV, target, self
    local step = 4
    for j = 0, step do
      for i = 0, targetList.Count - 1 do
        if (targetList[i]).targetRole ~= nil and LuaSkillCtrl:IsRoleAdjacent((targetList[i]).targetRole, target) then
          LuaSkillCtrl:StartTimer(self, (3 - self.attackTime) * 3, BindCallback(self, self.OnPassive01, (targetList[i]).targetRole))
          self.attackTime = self.attackTime - 1
          if self.roleRecord == nil then
            self.roleRecord = (targetList[i]).targetRole
          else
            if self.roleRecord ~= (targetList[i]).targetRole then
              self.buffFlag = false
            end
          end
        end
        if self.attackTime <= 0 then
          if self.buffFlag == true and ((targetList[i]).targetRole).intensity ~= 0 then
            LuaSkillCtrl:CallBuff(self, (targetList[i]).targetRole, (self.config).buffId_186SC, ((self.caster).recordTable)["514_buffarg"])
          end
          self.buffFlag = true
          return 
        end
      end
    end
  end
)
                    end
                  else
                    do
                      do
                        ;
                        (base.RealPlaySkill)(self, target, data)
                        ;
                        (base.RealPlaySkill)(self, target, data)
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

bs_519.OnPassive01 = function(self, targetRole)
  -- function num : 0_4 , upvalues : _ENV
  local arg = ((self.caster).recordTable)["514_arg"]
  local arglist2 = ((self.caster).recordTable)["514_arg2"]
  ;
  (self.caster):LookAtTarget(targetRole)
  LuaSkillCtrl:CallEffect(targetRole, (self.config).effectId_three, self)
  LuaSkillCtrl:StartTimer(self, 2, function()
    -- function num : 0_4_0 , upvalues : _ENV, self, targetRole, arg, arglist2
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
    local number = targetRole:GetBuffTier((self.config).buffId_186SC)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig2, {arg, arglist2, number})
    skillResult:EndResult()
  end
, nil, 0)
end

bs_519.OnSYTrigger = function(self, target, data, arg6)
  -- function num : 0_5 , upvalues : _ENV
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId_heavy)
  LuaSkillCtrl:HurtResult(self, skillResult, (self.config).SYhurtconfig, {arg6})
  skillResult:EndResult()
end

bs_519.Onhealback = function(self, target, arg6, hurt)
  -- function num : 0_6 , upvalues : _ENV
  if ((self.caster).recordTable).SYRecordRoles == nil then
    return 
  end
  ;
  (((self.caster).recordTable).SYRecordRoles):Pop()
  LuaSkillCtrl:CallEffect(target, (self.config).effectId_heal, self, nil, self.caster)
  LuaSkillCtrl:DispelBuff(target, (self.config).buffId_187SY, 1)
  local arg7 = ((self.caster).recordTable)["514_arg7"]
  local heal = hurt * arg7 // 1000
  if ((self.caster).recordTable)["20044_root3arg1"] ~= nil then
    heal = heal + heal * ((self.caster).recordTable)["20044_root3arg1"] // 1000
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
  LuaSkillCtrl:HealResult(skillResult, (self.config).HealConfig, {heal}, true)
  skillResult:EndResult()
end

bs_519.OnAttackTrigger = function(self, target, data, atkSpeedRatio, atkActionId)
  -- function num : 0_7 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R5 in 'UnsetPending'

  ((self.caster).recordTable).lastAttackRole = target
  if (self.caster).attackRange == 1 then
    if data.audioId3 ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, data.audioId3)
    end
    if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, (self.caster).attackRange) then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      local number = target:GetBuffTier((self.config).buffId_186SC)
      local arglist2 = ((self.caster).recordTable)["514_arg2"]
      LuaSkillCtrl:PlayAuSource(target, (self.config).audioId1)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {arglist2, arglist2, number})
      skillResult:EndResult()
      -- DECOMPILER ERROR at PC63: Confused about usage of register: R8 in 'UnsetPending'

      if ((self.caster).recordTable).completeFirstComatk == nil then
        ((self.caster).recordTable).completeFirstComatk = true
      end
    else
      do
        self:BreakSkill()
        self:CancleCasterWait()
      end
    end
  end
end

bs_519.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_519


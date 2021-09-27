local bs_70006 = class("bs_70006", LuaSkillBase)
local base = LuaSkillBase
bs_70006.config = {timeDuration = 15, effectId = 10910, buffFeature_ignoreDie = 6, effectDelaytime = 30, effectTime = 55}
bs_70006.ctor = function(self)
  -- function num : 0_0
end

bs_70006.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self.totalTime = (self.arglist)[1]
  self.timeValue = self.totalTime
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, (self.config).timeDuration, arriveCallBack, self, -1)
  local timeCallBack = BindCallback(self, self.TimeUp)
  LuaSkillCtrl:StartTimer(nil, self.totalTime - (self.config).effectTime, timeCallBack)
end

bs_70006.OnArriveAction = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.timeValue = self.timeValue - (self.config).timeDuration
  local showTime = (math.max)(0, self.timeValue // 15)
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
end

bs_70006.TimeUp = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(1)
  if targetlist.Count < 1 then
    return 
  end
  local target = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(target, (self.config).effectId, self)
  LuaSkillCtrl:StartTimer(nil, (self.config).effectDelaytime + (self.config).effectTime - 20, function()
    -- function num : 0_3_0 , upvalues : _ENV
    LuaSkillCtrl:CallUltSkillScreenEffect()
  end
)
  LuaSkillCtrl:StartTimer(nil, (self.config).effectDelaytime + (self.config).effectTime - 10, function()
    -- function num : 0_3_1 , upvalues : _ENV
    LuaSkillCtrl:CallUltSkillScreenEffect()
  end
)
  LuaSkillCtrl:StartTimer(nil, (self.config).effectDelaytime + (self.config).effectTime, function()
    -- function num : 0_3_2 , upvalues : targetlist, _ENV, self
    for i = 0, targetlist.Count - 1 do
      local targetRole = targetlist[i]
      local IfRoleCotainsIgnoreDieBuff = LuaSkillCtrl:RoleContainsBuffFeature(targetRole, (self.config).buffFeature_ignoreDie)
      if IfRoleCotainsIgnoreDieBuff then
        local buff_ignoreDie = LuaSkillCtrl:GetRoleAllBuffsByFeature(targetRole, (self.config).buffFeature_ignoreDie)
        if buff_ignoreDie.Count > 0 then
          for i = 0, buff_ignoreDie.Count - 1 do
            LuaSkillCtrl:DispelBuff(targetRole, (buff_ignoreDie[i]).dataId, 0)
          end
        end
      end
      do
        do
          local damage = targetRole.maxHp * 10
          targetRole:SubHp(damage)
          -- DECOMPILER ERROR at PC41: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
  end
)
  LuaSkillCtrl:StartTimer(nil, (self.config).effectDelaytime + (self.config).effectTime + 10, function()
    -- function num : 0_3_3 , upvalues : _ENV
    LuaSkillCtrl:ForceEndBattle(false)
  end
)
end

bs_70006.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_70006


local bs_104001 = class("bs_104001", LuaSkillBase)
local base = LuaSkillBase
bs_104001.config = {buffId_1 = 104004, buffId_2 = 104005, selectId_player = 34, selectId_enemy = 33, buffId_attack = 104006, buffId_skill = 104007}
bs_104001.ctor = function(self)
  -- function num : 0_0
end

bs_104001.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_104001_7", 1, self.OnAfterAddBuff, self.caster, self.caster)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["arglist[3]"] = (self.arglist)[3]
end

bs_104001.OnAfterAddBuff = function(self, buff, target)
  -- function num : 0_2 , upvalues : _ENV
  if buff.dataId == (self.config).buffId_attack then
    local num = 2 - (self.caster).attackRange
    local targetList_player = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId_player, num)
    if targetList_player.Count > 0 then
      for i = 0, targetList_player.Count - 1 do
        LuaSkillCtrl:CallBuff(self, (targetList_player[i]).targetRole, (self.config).buffId_1, 1, (self.arglist)[5])
      end
    end
    do
      local targetList_enemy = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId_enemy, num)
      if targetList_enemy.Count > 0 then
        for i = 0, targetList_enemy.Count - 1 do
          LuaSkillCtrl:CallBuff(self, (targetList_enemy[i]).targetRole, (self.config).buffId_2, 1, (self.arglist)[5])
        end
      end
      do
        if buff.dataId == (self.config).buffId_skill and ((self.caster).recordTable).skill_open == true then
          local targetList_player = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId_player, 10)
          if targetList_player.Count > 0 then
            for i = 0, targetList_player.Count - 1 do
              LuaSkillCtrl:CallBuff(self, (targetList_player[i]).targetRole, (self.config).buffId_1, 1, (self.arglist)[5])
            end
          end
          do
            local targetList_enemy = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId_enemy, 10)
            if targetList_enemy.Count > 0 then
              for i = 0, targetList_enemy.Count - 1 do
                LuaSkillCtrl:CallBuff(self, (targetList_enemy[i]).targetRole, (self.config).buffId_2, 1, (self.arglist)[5])
              end
            end
          end
        end
      end
    end
  end
end

bs_104001.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_104001


local bs_19999 = class("bs_19999", LuaSkillBase)
local base = LuaSkillBase
bs_19999.config = {logPath = "D:/Project3/BattleLog.txt", logNum = 10}
bs_19999.ctor = function(self)
  -- function num : 0_0
end

bs_19999.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_19999_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_19999_3", 1, self.OnAfterHurt)
  self:AddTrigger(eSkillTriggerType.AfterHeal, "bs_19999_5", 1, self.OnAfterHeal)
  self:AddTrigger(eSkillTriggerType.AfterAddBuff, "bs_19999_7", 1, self.OnAfterAddBuff)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_19999_10", 1, self.OnRoleDie)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_19999_12", 1, self.OnAfterPlaySkill)
  file = (io.open)((self.config).logPath, "a")
end

bs_19999.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  file:write("战斗开始。。。。" .. "\n")
  file:write("分类 " .. "角色 " .. "技能id " .. "数值 " .. "闪避 " .. "暴击\n")
end

bs_19999.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_3 , upvalues : _ENV
  if sender.belongNum == 1 and target.belongNum == 2 then
    file:write("伤害 " .. sender.name .. " " .. tostring(skill.dataId) .. " " .. tostring(hurt) .. " " .. tostring(isMiss) .. " " .. tostring(isCrit) .. "\n")
  end
end

bs_19999.OnAfterHeal = function(self, sender, target, skill, heal)
  -- function num : 0_4 , upvalues : _ENV
  if sender.belongNum == 1 and target.belongNum == 1 then
    file:write("治疗 " .. sender.name .. " " .. tostring(skill.dataId) .. " " .. tostring(heal) .. "\n")
  end
end

bs_19999.OnAfterAddBuff = function(self, buff, target)
  -- function num : 0_5 , upvalues : _ENV
  file:write("buff " .. target.name .. " " .. tostring(buff.dataId) .. "\n")
end

bs_19999.OnRoleDie = function(self, killer, role)
  -- function num : 0_6 , upvalues : _ENV
  if role.belongNum == 1 then
    file:write("死亡 " .. role.name .. tostring((LuaSkillCtrl.battleCtrl).frame) .. "\n")
  end
end

bs_19999.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_7 , upvalues : _ENV
  file:write("放技能 " .. role.name .. tostring(skill.dataId) .. "\n")
end

bs_19999.OnCasterDie = function(self)
  -- function num : 0_8
end

return bs_19999


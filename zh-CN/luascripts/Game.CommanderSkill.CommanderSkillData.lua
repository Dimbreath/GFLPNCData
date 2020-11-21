-- params : ...
-- function num : 0 , upvalues : _ENV
local CommanderSkillData = class("CommanderSkillData")
local cs_GameData_ins = (CS.GameData).instance
CommanderSkillData.skillType = {active = 1, passive = 2, master = 3}
CommanderSkillData.ctor = function(self, dataId, unlockLevel)
    -- function num : 0_0 , upvalues : CommanderSkillData, cs_GameData_ins, _ENV
    self.dataId = dataId
    self.unlockLevel = unlockLevel
    self.isUnlock = false
    self.type = (CommanderSkillData.skillType).passive
    self.place = 0
    self.isNewUnlock = false
    local battleSkillCfg = (cs_GameData_ins.listBattleSkillDatas):GetDataById(
                               self.dataId)
    if battleSkillCfg == nil then
        error("Battle Skill Cfg is null,Id:" .. tostring(self.dataId))
        return
    end
    self.battleSkillCfg = battleSkillCfg
    self.mpCost = (self.battleSkillCfg).PlayerMpCost
end

CommanderSkillData.GetName = function(self)
    -- function num : 0_1
    return (self.battleSkillCfg).Name
end

CommanderSkillData.GetIcon = function(self)
    -- function num : 0_2
    return (self.battleSkillCfg).Icon
end

CommanderSkillData.GetDescribe = function(self)
    -- function num : 0_3
    local des = (self.battleSkillCfg):GetLevelDescribe(1)
    if des == "" then des = (self.battleSkillCfg).Describe end
    return des
end

CommanderSkillData.GetID = function(self)
    -- function num : 0_4
    return self.dataId
end

CommanderSkillData.SetMasterSkilllevel =
    function(self, level)
        -- function num : 0_5
        self.masterLevel = level or 0
    end

CommanderSkillData.GetMasterSkilllevel =
    function(self)
        -- function num : 0_6
        return self.masterLevel
    end

CommanderSkillData.GetMasterSkillAddVaule =
    function(self)
        -- function num : 0_7 , upvalues : _ENV
        local hasPercentSign = false
        local value = nil
        if self.masterLevel == 0 then
            value = "0"
        else
            value = (self.battleSkillCfg):GetLevelArgValue(self.masterLevel, 0)
            if (string.match)((self.battleSkillCfg).DescribeLv, "{0}%%") ~= nil then
                hasPercentSign = true
            end
        end
        if hasPercentSign then
            return tostring(GetPreciseDecimalStr(value, 0)) .. "%"
        end
        return tostring(GetPreciseDecimalStr(value, 0))
    end

return CommanderSkillData


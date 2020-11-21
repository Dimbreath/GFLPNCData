-- params : ...
-- function num : 0 , upvalues : _ENV
local CommanderSkillTreeData = class("CommanderSkillTreeData")
local CommanderSkillData = require("Game.CommanderSkill.CommanderSkillData")
local CommanderSkillTreeColor = {
    [1] = (Color.New)(0.81960784313725, 0.2156862745098, 0.30588235294118),
    [2] = (Color.New)(0.57, 0.82, 0.16, 1),
    [3] = (Color.New)(0.2156862745098, 0.54117647058824, 0.90196078431373),
    [4] = (Color.New)(0.49, 0.54, 0.63, 1)
}
CommanderSkillTreeData.ctor = function(self, treeId, level, exp)
    -- function num : 0_0 , upvalues : _ENV, CommanderSkillData
    self.treeId = treeId
    if (ConfigData.commander_skill)[treeId] == nil then
        error("can\'t read commander_skill by id:" .. treeId)
        return
    end
    self.treeCfg = (ConfigData.commander_skill)[treeId]
    self.level = level or 1
    self.curExp = exp or 0
    self.isUnlock = false
    self.commanderSkillDataDic = {}
    self.slotSkillList = {[1] = 0, [2] = 0, [3] = 0}
    self.slotSkillOverloadList = {[1] = {}, [2] = {}, [3] = {}}
    self.masterSkillList = {[1] = {}, [2] = {}, [3] = {}}
    local unlockSkillCfg = (ConfigData.commander_skill_unlock)[treeId]
    for unlocklevel, skillCfgs in pairs(unlockSkillCfg) do
        for skillId, skillCfg in pairs(skillCfgs) do
            local commanderSkillData = (CommanderSkillData.New)(skillId,
                                                                unlocklevel)
            commanderSkillData.type = skillCfg.skill_type
            commanderSkillData.isUnlock = unlocklevel <= self.level
            commanderSkillData.place = skillCfg.place -- DECOMPILER ERROR at PC74: Confused about usage of register: R16 in 'UnsetPending'
            ;
            (self.commanderSkillDataDic)[skillId] = commanderSkillData
            if skillCfg.skill_type == (CommanderSkillData.skillType).active then
                (table.insert)((self.slotSkillOverloadList)[skillCfg.place],
                               skillId)
                -- DECOMPILER ERROR at PC98: Confused about usage of register: R16 in 'UnsetPending'

                if commanderSkillData.isUnlock and
                    (self.slotSkillList)[skillCfg.place] == 0 then
                    (self.slotSkillList)[skillCfg.place] =
                        commanderSkillData.dataId
                end
            elseif skillCfg.skill_type == (CommanderSkillData.skillType).master then
                (table.insert)((self.masterSkillList)[skillCfg.place],
                               commanderSkillData)
                commanderSkillData:SetMasterSkilllevel(0)
            end
        end
    end
    self:__SortActiveSkill()
    self.OnSlotSkillChangeFuncList = {}
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

CommanderSkillTreeData.TryToUnlock = function(self)
    -- function num : 0_1 , upvalues : _ENV
    if (CheckCondition.CheckLua)((self.treeCfg).pre_condition,
                                 (self.treeCfg).pre_para1,
                                 (self.treeCfg).pre_para2) then
        (NetworkManager:GetNetwork(NetworkTypeID.CommanderSkill)):CS_COMMANDSKILL_Unlock(
            self.treeId)
        self.isUnlock = true
    end
end

CommanderSkillTreeData.SetLevel = function(self, level)
    -- function num : 0_2 , upvalues : _ENV, CommanderSkillData
    if type(level) ~= "number" then
        error("set commander skill tree level without num")
        return
    end
    if level ~= self.level then
        self.level = level
        MsgCenter:Broadcast(eMsgEventId.OnCommanderSkillLevelDiffer)
        for skillId, skillData in pairs(self.commanderSkillDataDic) do
            if not skillData.isUnlock and skillData.unlockLevel <= level then
                skillData.isUnlock = true
                if skillData.type == (CommanderSkillData.skillType).active and
                    self:GetActiveSlotCurSkill(skillData.place) == 0 then
                    self:SetSlotSkillList(skillData.place, skillId)
                end
            end
        end
    end
end

CommanderSkillTreeData.SetSlotSkillList =
    function(self, place, skillId)
        -- function num : 0_3 , upvalues : _ENV
        -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

        (self.slotSkillList)[place] = skillId
        MsgCenter:Broadcast(eMsgEventId.OnCommanderSkillOverLoad, place,
                            (self.commanderSkillDataDic)[skillId])
    end

CommanderSkillTreeData.GetName = function(self)
    -- function num : 0_4 , upvalues : _ENV
    return (LanguageUtil.GetLocaleText)((self.treeCfg).name)
end

CommanderSkillTreeData.GetIcon = function(self)
    -- function num : 0_5
    local icon = (self.treeCfg).icon
    return icon
end

CommanderSkillTreeData.GetColor = function(self)
    -- function num : 0_6 , upvalues : CommanderSkillTreeColor
    local colorIndex = (self.treeCfg).color
    if colorIndex < 1 or colorIndex > 4 then
        return CommanderSkillTreeColor[4]
    end
    return CommanderSkillTreeColor[colorIndex]
end

CommanderSkillTreeData.GetDescribe = function(self)
    -- function num : 0_7 , upvalues : _ENV
    return (LanguageUtil.GetLocaleText)((self.treeCfg).describe)
end

CommanderSkillTreeData.GetUnlockNum = function(self, index)
    -- function num : 0_8 , upvalues : _ENV
    local totalNum = #(self.slotSkillOverloadList)[index]
    local unlockNum = 0
    for _, skillId in ipairs((self.slotSkillOverloadList)[index]) do
        if ((self.commanderSkillDataDic)[skillId]).isUnlock then
            unlockNum = unlockNum + 1
        end
    end
    return totalNum, unlockNum
end

CommanderSkillTreeData.__SortActiveSkill =
    function(self)
        -- function num : 0_9 , upvalues : _ENV
        for place, list in ipairs(self.slotSkillOverloadList) do
            (table.sort)(list, function(id1, id2)
                -- function num : 0_9_0 , upvalues : self
                local unlockLevel1 =
                    ((self.commanderSkillDataDic)[id1]).unlockLevel
                local unlockLevel2 =
                    ((self.commanderSkillDataDic)[id2]).unlockLevel
                if id1 >= id2 then
                    do return unlockLevel1 ~= unlockLevel2 end
                    do return unlockLevel1 < unlockLevel2 end
                    -- DECOMPILER ERROR: 4 unprocessed JMP targets
                end
            end)
        end
    end

CommanderSkillTreeData.GetActiveSlotCurSkill =
    function(self, slotIndex)
        -- function num : 0_10
        if (self.slotSkillList)[slotIndex] ~= nil then
            return (self.slotSkillList)[slotIndex]
        else
            return 0
        end
    end

CommanderSkillTreeData.GetActiveSlotOverloadSkill =
    function(self, slotIndex)
        -- function num : 0_11
        if (self.slotSkillOverloadList)[slotIndex] ~= nil then
            return (self.slotSkillOverloadList)[slotIndex]
        else
            return {}
        end
    end

CommanderSkillTreeData.UpdateTreeData = function(self, level, exp)
    -- function num : 0_12 , upvalues : _ENV
    self:SetLevel(level)
    self.curExp = exp
    MsgCenter:Broadcast(eMsgEventId.OnCommanderSkillTreeDataDiffer, self.treeId)
end

CommanderSkillTreeData.ApplySavingData =
    function(self, savingData)
        -- function num : 0_13 , upvalues : _ENV
        for index, id in ipairs(savingData.skillActive) do
            -- DECOMPILER ERROR at PC5: Confused about usage of register: R7 in 'UnsetPending'

            (self.slotSkillList)[index] = id
        end
        for skillId, data in pairs(savingData.skillProficient) do
            ((self.commanderSkillDataDic)[skillId]):SetMasterSkilllevel(
                data.level)
        end
    end

return CommanderSkillTreeData


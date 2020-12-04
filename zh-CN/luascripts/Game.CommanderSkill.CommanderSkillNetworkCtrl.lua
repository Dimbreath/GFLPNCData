-- params : ...
-- function num : 0 , upvalues : _ENV
local CommanderSkillNetworkCtrl = class("CommanderSkillNetworkCtrl", NetworkCtrlBase)
local CommanderSkillModulaData = require("Game.CommanderSkill.CommanderSkillModulaData")
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
CommanderSkillNetworkCtrl.ctor = function(self)
  -- function num : 0_0
end

CommanderSkillNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_COMMANDSKILL_Detail, self, proto_csmsg.SC_COMMANDSKILL_Detail, self.SC_COMMANDSKILL_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_COMMANDSKILL_SyncUpdate, self, proto_csmsg.SC_COMMANDSKILL_SyncUpdate, self.SC_COMMANDSKILL_SyncUpdate)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_COMMANDSKILL_Upgrade, self, proto_csmsg.SC_COMMANDSKILL_Upgrade, self.SC_COMMANDSKILL_Upgrade)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_COMMANDSKILL_SaveFromFormation, self, proto_csmsg.SC_COMMANDSKILL_SaveFromFormation, self.SC_COMMANDSKILL_SaveFromFormation)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_COMMANDSKILL_Unlock, self, proto_csmsg.SC_COMMANDSKILL_Unlock, self.SC_COMMANDSKILL_Unlock)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_COMMANDSKILL_SaveSheet, self, proto_csmsg.SC_COMMANDSKILL_SaveSheet, self.SC_COMMANDSKILL_SaveSheet)
end

CommanderSkillNetworkCtrl.CS_COMMANDSKILL_Detail = function(self, callback)
  -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_COMMANDSKILL_Detail, proto_csmsg.CS_COMMANDSKILL_Detail, {})
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_COMMANDSKILL_Detail, callback, proto_csmsg_MSG_ID.MSG_SC_COMMANDSKILL_Detail)
end

CommanderSkillNetworkCtrl.SC_COMMANDSKILL_Detail = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV, CommanderSkillModulaData
  if not (msg.data).pLevel then
    local masterLevel = msg.data == nil or 1
  end
  do
    local masterExp = (msg.data).pExp or 0
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

    PlayerDataCenter.CommanderSkillModualData = (CommanderSkillModulaData.New)(masterLevel, masterExp, (msg.data).tree)
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

    PlayerDataCenter.CommanderSkillModualData = (CommanderSkillModulaData.New)(1, 0, nil)
  end
end

CommanderSkillNetworkCtrl.SC_COMMANDSKILL_SyncUpdate = function(self, msg)
  -- function num : 0_4 , upvalues : _ENV, CommanderSkillModulaData
  if PlayerDataCenter.CommanderSkillModualData == nil then
    local treeData = {}
    for treeId,data in pairs(msg.update) do
      local level = data.first
      local exp = data.second
      treeData[treeId] = {id = treeId, level = level, exp = exp}
    end
    if msg.proficentUpdate ~= nil then
      local masterLevel = (msg.proficentUpdate).first
      local masterExp = (msg.proficentUpdate).second
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

      PlayerDataCenter.CommanderSkillModualData = (CommanderSkillModulaData.New)(masterLevel, masterExp, treeData)
    else
      do
        do
          -- DECOMPILER ERROR at PC39: Confused about usage of register: R3 in 'UnsetPending'

          PlayerDataCenter.CommanderSkillModualData = (CommanderSkillModulaData.New)(1, 0, treeData)
          PlayerDataCenter:UnlockCommanderSkill()
          do return  end
          -- DECOMPILER ERROR at PC50: Confused about usage of register: R2 in 'UnsetPending'

          if not self.isHandyUpgrade then
            ((PlayerDataCenter.CommanderSkillModualData).lastDiff).differMsg = msg
          end
          if msg.update ~= nil then
            for treeId,data in pairs(msg.update) do
              local level = data.first
              local exp = data.second
              local treeData = ((PlayerDataCenter.CommanderSkillModualData).CommanderSkillTreeDataDic)[treeId]
              if treeData == nil then
                error("can\'t read treeData with treeId " .. treeId)
              else
                -- DECOMPILER ERROR at PC79: Confused about usage of register: R10 in 'UnsetPending'

                if not self.isHandyUpgrade then
                  ((PlayerDataCenter.CommanderSkillModualData).lastDiff).oldTreelevel = treeData.level
                  -- DECOMPILER ERROR at PC84: Confused about usage of register: R10 in 'UnsetPending'

                  ;
                  ((PlayerDataCenter.CommanderSkillModualData).lastDiff).oldTreeExp = treeData.curExp
                end
                treeData:UpdateTreeData(level, exp)
              end
            end
          end
          do
            if msg.proficentUpdate ~= nil then
              local masterLevel = (msg.proficentUpdate).first
              local masterExp = (msg.proficentUpdate).second
              -- DECOMPILER ERROR at PC107: Confused about usage of register: R4 in 'UnsetPending'

              if not self.isHandyUpgrade then
                ((PlayerDataCenter.CommanderSkillModualData).lastDiff).oldMasterlevel = (PlayerDataCenter.CommanderSkillModualData).masterLevel
                -- DECOMPILER ERROR at PC114: Confused about usage of register: R4 in 'UnsetPending'

                ;
                ((PlayerDataCenter.CommanderSkillModualData).lastDiff).oldMasterExp = (PlayerDataCenter.CommanderSkillModualData).masterExp
              end
              ;
              (PlayerDataCenter.CommanderSkillModualData):UpdateMasterLevelAndExp(masterLevel, masterExp)
            end
            do
              self.isHandyUpgrade = false
            end
          end
        end
      end
    end
  end
end

CommanderSkillNetworkCtrl.CS_COMMANDSKILL_Upgrade = function(self, treeId, cost, callback)
  -- function num : 0_5 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {}
  msg.treeId = treeId
  msg.cost = cost
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_COMMANDSKILL_Upgrade, proto_csmsg.CS_COMMANDSKILL_Upgrade, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_COMMANDSKILL_Upgrade, callback, proto_csmsg_MSG_ID.MSG_SC_COMMANDSKILL_Upgrade)
  self.isHandyUpgrade = true
end

CommanderSkillNetworkCtrl.SC_COMMANDSKILL_Upgrade = function(self, msg)
  -- function num : 0_6 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "HeroNetworkCtrl:SC_COMMANDSKILL_Upgrade error:" .. tostring(msg.ret)
    error(errorMsg)
    if isGameDev then
      ((CS.MessageCommon).ShowMessageTips)(errorMsg)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_COMMANDSKILL_Upgrade)
    return 
  end
end

CommanderSkillNetworkCtrl.CS_COMMANDSKILL_SaveSheet = function(self, sheetId, treeId, savingData)
  -- function num : 0_7 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {}
  msg.sheetId = sheetId
  msg.treeId = treeId
  msg.data = savingData
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_COMMANDSKILL_SaveSheet, proto_csmsg.CS_COMMANDSKILL_SaveSheet, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_COMMANDSKILL_SaveSheet, proto_csmsg_MSG_ID.MSG_SC_COMMANDSKILL_SaveSheet)
end

CommanderSkillNetworkCtrl.SC_COMMANDSKILL_SaveSheet = function(self, msg)
  -- function num : 0_8 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "HeroNetworkCtrl:SC_COMMANDSKILL_SaveSheet error:" .. tostring(msg.ret)
    error(errorMsg)
    if isGameDev then
      ((CS.MessageCommon).ShowMessageTips)(errorMsg)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_COMMANDSKILL_SaveSheet)
    return 
  end
end

CommanderSkillNetworkCtrl.CS_COMMANDSKILL_SaveFromFormation = function(self, formId, treeId, savingData)
  -- function num : 0_9 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {}
  msg.formId = formId
  msg.treeId = treeId
  msg.data = savingData
  for index,value in ipairs((msg.data).skillActive) do
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R10 in 'UnsetPending'

    if value == 0 then
      ((msg.data).skillActive)[index] = nil
    end
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_COMMANDSKILL_SaveFromFormation, proto_csmsg.CS_COMMANDSKILL_SaveFromFormation, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_COMMANDSKILL_SaveFromFormation, function()
    -- function num : 0_9_0 , upvalues : _ENV, formId, savingData, treeId
    local formatData = (PlayerDataCenter.formationDic)[formId]
    local saving = {}
    saving.skillActive = {}
    saving.skillProficient = {}
    for key,value in pairs(savingData.skillActive) do
      -- DECOMPILER ERROR at PC14: Confused about usage of register: R7 in 'UnsetPending'

      (saving.skillActive)[key] = value
    end
    for key,value in pairs(savingData.skillProficient) do
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R7 in 'UnsetPending'

      (saving.skillProficient)[key] = value
    end
    formatData.cst = {treeId = treeId, saving = saving}
    formatData.userSkill = ((formatData.cst).saving).skillActive
    MsgCenter:Broadcast(eMsgEventId.OnCommanderSkillChande)
  end
, proto_csmsg_MSG_ID.MSG_SC_COMMANDSKILL_SaveFromFormation)
end

CommanderSkillNetworkCtrl.SC_COMMANDSKILL_SaveFromFormation = function(self, msg)
  -- function num : 0_10 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "HeroNetworkCtrl:SC_COMMANDSKILL_SaveFromFormation error:" .. tostring(msg.ret)
    error(errorMsg)
    if isGameDev then
      ((CS.MessageCommon).ShowMessageTips)(errorMsg)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_COMMANDSKILL_SaveFromFormation)
    return 
  end
end

CommanderSkillNetworkCtrl.CS_COMMANDSKILL_Unlock = function(self, treeId)
  -- function num : 0_11 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {}
  msg.treeId = treeId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_COMMANDSKILL_Unlock, proto_csmsg.CS_COMMANDSKILL_Unlock, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_COMMANDSKILL_Unlock, proto_csmsg_MSG_ID.MSG_SC_COMMANDSKILL_Unlock)
end

CommanderSkillNetworkCtrl.SC_COMMANDSKILL_Unlock = function(self, msg)
  -- function num : 0_12 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "HeroNetworkCtrl:SC_COMMANDSKILL_Unlock error:" .. tostring(msg.ret)
    error(errorMsg)
    if isGameDev then
      ((CS.MessageCommon).ShowMessageTips)(errorMsg)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_COMMANDSKILL_Unlock)
    return 
  end
end

CommanderSkillNetworkCtrl.Reset = function(self)
  -- function num : 0_13
end

return CommanderSkillNetworkCtrl


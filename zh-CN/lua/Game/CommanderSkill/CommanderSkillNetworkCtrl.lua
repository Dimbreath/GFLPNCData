local CommanderSkillNetworkCtrl = class("CommanderSkillNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
CommanderSkillNetworkCtrl.ctor = function(self)
  -- function num : 0_0
  self._modifyFmt = {}
end

CommanderSkillNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_COMMANDSKILL_SaveFromFormation, self, proto_csmsg.SC_COMMANDSKILL_SaveFromFormation, self.SC_COMMANDSKILL_SaveFromFormation)
end

CommanderSkillNetworkCtrl.CS_COMMANDSKILL_SaveFromFormation = function(self, formId, treeId, skills, callBack)
  -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse
  for index,value in ipairs(skills) do
    if value == 0 then
      error("skillActive list has value 0")
      return 
    end
  end
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._modifyFmt).formId = formId
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._modifyFmt).tree = {id = treeId, skills = skills}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_COMMANDSKILL_SaveFromFormation, proto_csmsg.CS_COMMANDSKILL_SaveFromFormation, self._modifyFmt)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_COMMANDSKILL_SaveFromFormation, function()
    -- function num : 0_2_0 , upvalues : _ENV, formId, self, callBack
    local formatData = (PlayerDataCenter.formationDic)[formId]
    formatData:ModifyCSTData((self._modifyFmt).tree)
    MsgCenter:Broadcast(eMsgEventId.OnCommanderSkillChande)
    if callBack ~= nil then
      callBack()
    end
  end
, proto_csmsg_MSG_ID.MSG_SC_COMMANDSKILL_SaveFromFormation)
end

CommanderSkillNetworkCtrl.SC_COMMANDSKILL_SaveFromFormation = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local errorMsg = "HeroNetworkCtrl:SC_COMMANDSKILL_SaveFromFormation error:" .. tostring(msg.ret)
      error(errorMsg)
      if isGameDev then
        ((CS.MessageCommon).ShowMessageTips)(errorMsg)
      end
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_COMMANDSKILL_SaveFromFormation)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

CommanderSkillNetworkCtrl.Reset = function(self)
  -- function num : 0_4
end

return CommanderSkillNetworkCtrl


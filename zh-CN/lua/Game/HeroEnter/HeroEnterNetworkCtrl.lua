local HeroEnterNetworkCtrl = class("HeroEnterNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
local heroEnterDataUtil = require("Game.HeroEnter.HeroEnterDataUtil")
HeroEnterNetworkCtrl.ctor = function(self)
  -- function num : 0_0
end

HeroEnterNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_STATION_Detail, self, proto_csmsg.SC_STATION_Detail, self.SC_STATION_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_STATION_Install, self, proto_csmsg.SC_STATION_Install, self.SC_STATION_Install)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_STATION_Uninstall, self, proto_csmsg.SC_STATION_Uninstall, self.SC_STATION_Uninstall)
end

HeroEnterNetworkCtrl.CS_STATION_Detail = function(self, isAddAttr)
  -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse, heroEnterDataUtil
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter) then
    return 
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_STATION_Detail, proto_csmsg.CS_STATION_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_STATION_Detail, function()
    -- function num : 0_2_0 , upvalues : isAddAttr, heroEnterDataUtil, _ENV
    if isAddAttr then
      heroEnterDataUtil:InitBuff(PlayerDataCenter.allEnterData)
      heroEnterDataUtil:InitMsgListern()
    end
  end
, proto_csmsg_MSG_ID.MSG_SC_STATION_Detail)
end

HeroEnterNetworkCtrl.SC_STATION_Detail = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  PlayerDataCenter.allEnterData = (msg.data).data
  MsgCenter:Broadcast(eMsgEventId.OnHeroEnterDataUpdate)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

HeroEnterNetworkCtrl.CS_STATION_Install = function(self, heroId, buildingId, callBack)
  -- function num : 0_4 , upvalues : _ENV, cs_WaitNetworkResponse, heroEnterDataUtil
  local msgTable = {heroId = heroId, buildingId = buildingId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_STATION_Install, proto_csmsg.CS_STATION_Install, msgTable)
  self:CS_STATION_Detail()
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_AthRefillOp, function()
    -- function num : 0_4_0 , upvalues : callBack, heroEnterDataUtil, heroId, buildingId, _ENV
    if callBack ~= nil then
      callBack()
    end
    heroEnterDataUtil:AddBuff(heroId, buildingId)
    ;
    (PlayerDataCenter.playerBonus):CheckPlayerBonusBroadcast()
  end
, proto_csmsg_MSG_ID.MSG_SC_STATION_Install)
end

HeroEnterNetworkCtrl.SC_STATION_Install = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "SC_STATION_Install error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ATH_AthRefillOp)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

HeroEnterNetworkCtrl.CS_STATION_Uninstall = function(self, heroId, callBack)
  -- function num : 0_6 , upvalues : _ENV, cs_WaitNetworkResponse, heroEnterDataUtil
  local msgTable = {heroId = heroId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_STATION_Uninstall, proto_csmsg.CS_STATION_Uninstall, msgTable)
  self:CS_STATION_Detail()
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_STATION_Uninstall, function()
    -- function num : 0_6_0 , upvalues : callBack, heroEnterDataUtil, heroId, _ENV
    if callBack ~= nil then
      callBack()
    end
    heroEnterDataUtil:RemoveBuff(heroId)
    ;
    (PlayerDataCenter.playerBonus):CheckPlayerBonusBroadcast()
  end
, proto_csmsg_MSG_ID.MSG_SC_STATION_Uninstall)
end

HeroEnterNetworkCtrl.SC_STATION_Uninstall = function(self, msg)
  -- function num : 0_7 , upvalues : _ENV, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "SC_STATION_Uninstall error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_STATION_Uninstall)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

HeroEnterNetworkCtrl.Reset = function(self)
  -- function num : 0_8
end

return HeroEnterNetworkCtrl


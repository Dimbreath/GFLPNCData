-- params : ...
-- function num : 0 , upvalues : _ENV
local PayNetworkCtrl = class("PayNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
local cs_MicaSDKManager = CS.MicaSDKManager
PayNetworkCtrl.ctor = function(self)
  -- function num : 0_0
  self._fakeRechargeTab = {}
  self._rechargeFreeTab = {}
end

PayNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_RECHARGE_ConfirmRewards, self, proto_csmsg.SC_RECHARGE_ConfirmRewards, self.SC_RECHARGE_ConfirmRewards)
end

PayNetworkCtrl.CS_RECHARGE_FakeRecharge = function(self, goodId, amount, callBack)
  -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R4 in 'UnsetPending'

  (self._fakeRechargeTab).goodId = goodId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._fakeRechargeTab).amount = amount
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_RECHARGE_FakeRecharge, proto_csmsg.CS_RECHARGE_FakeRecharge, self._fakeRechargeTab)
  cs_WaitNetworkResponse:StartWait(eCustomWaitType.WaitPayFinish, callBack, proto_csmsg_MSG_ID.MSG_SC_RECHARGE_ConfirmRewards)
end

PayNetworkCtrl.SC_RECHARGE_ConfirmRewards = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MicaSDKManager, cs_MessageCommon
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret == proto_csmsg_rechargeState.rechargeStateNone then
    if cs_WaitNetworkResponse:ContainWait(eCustomWaitType.WaitPayFinish) then
      cs_WaitNetworkResponse:AddWaitData(eCustomWaitType.WaitPayFinish, msg.rb)
    else
      ;
      (ControllerManager:GetController(ControllerTypeId.Pay, true)):ShowPayReward(msg.rb)
    end
  else
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.WaitPayFinish)
    if not (cs_MicaSDKManager.Instance):IsUseSdk() then
      (cs_MessageCommon.ShowMessageBoxConfirm)((ConfigData:GetTipContent(10005)), nil)
    end
  end
end

PayNetworkCtrl.CS_RECHARGE_ConfirmRewards = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_RECHARGE_ConfirmRewards, proto_csmsg.CS_RECHARGE_ConfirmRewards, table.emptytable)
end

PayNetworkCtrl.CS_RECHARGE_RechargeFree = function(self, goodId, callBack)
  -- function num : 0_5 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self._rechargeFreeTab).goodId = goodId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_RECHARGE_RechargeFree, proto_csmsg.CS_RECHARGE_RechargeFree, self._rechargeFreeTab)
  cs_WaitNetworkResponse:StartWait(eCustomWaitType.WaitPayFinish, callBack, proto_csmsg_MSG_ID.MSG_SC_RECHARGE_ConfirmRewards)
end

PayNetworkCtrl.Reset = function(self)
  -- function num : 0_6
end

return PayNetworkCtrl


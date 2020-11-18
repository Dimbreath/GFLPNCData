-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleDungeonNetworkCtrl = class("BattleDungeonNetworkCtrl", NetworkCtrlBase)
local DungeonConst = require("Game.BattleDungeon.DungeonConst")
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
BattleDungeonNetworkCtrl.ctor = function(self)
  -- function num : 0_0
  self.sendChipSelect = {}
  self.sendEnterChapter = {}
end

BattleDungeonNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_NtfEnter, self, proto_csmsg.SC_BATTLE_NtfEnter, self.SC_BATTLE_NtfEnter)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_NtfWaveStep, self, proto_csmsg.SC_BATTLE_NtfWaveStep, self.SC_BATTLE_NtfWaveStep)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_NtfOverRewards, self, proto_csmsg.SC_BATTLE_NtfOverRewards, self.SC_BATTLE_NtfOverRewards)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_NtfMonsterData, self, proto_csmsg.SC_BATTLE_NtfMonsterData, self.SC_BATTLE_NtfMonsterData)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_NtfAlgData, self, proto_csmsg.SC_BATTLE_NtfAlgData, self.SC_BATTLE_NtfAlgData)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_NtfAlgDiff, self, proto_csmsg.SC_BATTLE_NtfAlgDiff, self.SC_BATTLE_NtfAlgDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_BattleSettle, self, proto_csmsg.SC_BATTLE_BattleSettle, self.SC_BATTLE_BattleSettle)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_AlgSelect, self, proto_csmsg.SC_BATTLE_AlgSelect, self.SC_BATTLE_AlgSelect)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_StartBattleWithForm, self, proto_csmsg.SC_BATTLE_StartBattleWithForm, self.SC_BATTLE_StartBattleWithForm)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_Quit, self, proto_csmsg.SC_BATTLE_Quit, self.SC_BATTLE_Quit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_Restart, self, proto_csmsg.SC_BATTLE_Restart, self.SC_BATTLE_Restart)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DUNGEON_STATIC_Detail, self, proto_csmsg.SC_DUNGEON_STATIC_Detail, self.SC_DUNGEON_STATIC_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_DungeonEnter, self, proto_csmsg.SC_BATTLE_DungeonEnter, self.SC_BATTLE_DungeonEnter)
end

BattleDungeonNetworkCtrl.SC_BATTLE_NtfEnter = function(self, msg)
  -- function num : 0_2 , upvalues : _ENV
  BattleDungeonManager:EnterDungeon(msg)
end

BattleDungeonNetworkCtrl.SC_BATTLE_NtfWaveStep = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV, DungeonConst
  BattleDungeonManager:AddDungeonLogic((DungeonConst.LogicType).SceneStep, msg.wave)
end

BattleDungeonNetworkCtrl.SC_BATTLE_NtfMonsterData = function(self, msg)
  -- function num : 0_4 , upvalues : _ENV, DungeonConst
  BattleDungeonManager:AddDungeonLogic((DungeonConst.LogicType).BattleStep, msg)
end

BattleDungeonNetworkCtrl.SC_BATTLE_NtfOverRewards = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV, DungeonConst
  BattleDungeonManager:AddDungeonLogic((DungeonConst.LogicType).OverRewards, msg)
end

BattleDungeonNetworkCtrl.SC_BATTLE_NtfAlgData = function(self, msg)
  -- function num : 0_6 , upvalues : _ENV, DungeonConst
  BattleDungeonManager:AddDungeonLogic((DungeonConst.LogicType).ChipStep, msg)
end

BattleDungeonNetworkCtrl.CS_BATTLE_AlgSelect = function(self, idx, callBack)
  -- function num : 0_7 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.sendChipSelect).idx = idx
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLE_AlgSelect, proto_csmsg.CS_BATTLE_AlgSelect, self.sendChipSelect)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_AlgSelect, callBack, proto_csmsg_MSG_ID.MSG_SC_BATTLE_AlgSelect)
end

BattleDungeonNetworkCtrl.SC_BATTLE_AlgSelect = function(self, msg)
  -- function num : 0_8 , upvalues : _ENV
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "BattleDungeonNetworkCtrl:SC_BATTLE_AlgSelect error:" .. tostring(msg.ret)
    if isGameDev then
      ((CS.MessageCommon).ShowMessageTips)(err)
    end
    error(err)
    return 
  end
end

BattleDungeonNetworkCtrl.SC_BATTLE_NtfAlgDiff = function(self, msg)
  -- function num : 0_9 , upvalues : _ENV
  local diffData = msg.diff
  MsgCenter:Broadcast(eMsgEventId.OnChipDataDiff, diffData)
end

BattleDungeonNetworkCtrl.CS_BATTLE_BattleSettle = function(self, sendMsg, callBack)
  -- function num : 0_10 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLE_BattleSettle, proto_csmsg.CS_BATTLE_BattleSettle, sendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_BattleSettle, callBack, proto_csmsg_MSG_ID.MSG_SC_BATTLE_BattleSettle)
end

BattleDungeonNetworkCtrl.SC_BATTLE_BattleSettle = function(self, msg)
  -- function num : 0_11 , upvalues : _ENV
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "BattleDungeonNetworkCtrl:SC_BATTLE_BattleSettle error:" .. tostring(msg.ret)
    if isGameDev then
      ((CS.MessageCommon).ShowMessageTips)(err)
    end
    error(err)
    return 
  end
end

BattleDungeonNetworkCtrl.CS_BATTLE_StartBattleWithForm = function(self, sendMsg, callBack)
  -- function num : 0_12 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLE_StartBattleWithForm, proto_csmsg.CS_BATTLE_StartBattleWithForm, sendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_StartBattleWithForm, callBack, proto_csmsg_MSG_ID.MSG_SC_BATTLE_StartBattleWithForm)
end

BattleDungeonNetworkCtrl.SC_BATTLE_StartBattleWithForm = function(self, msg)
  -- function num : 0_13 , upvalues : _ENV
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "BattleDungeonNetworkCtrl:SC_BATTLE_StartBattleWithForm error:" .. tostring(msg.ret)
    if isGameDev then
      ((CS.MessageCommon).ShowMessageTips)(err)
    end
    error(err)
    return 
  end
end

BattleDungeonNetworkCtrl.CS_BATTLE_Quit = function(self, callBack)
  -- function num : 0_14 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Quit, proto_csmsg.CS_BATTLE_Quit, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Quit, callBack, proto_csmsg_MSG_ID.MSG_SC_BATTLE_Quit)
end

BattleDungeonNetworkCtrl.SC_BATTLE_Quit = function(self, msg)
  -- function num : 0_15 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "BattleDungeonNetworkCtrl:SC_BATTLE_Quit error:" .. tostring(msg.ret)
    if isGameDev then
      ((CS.MessageCommon).ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Quit)
    return 
  end
end

BattleDungeonNetworkCtrl.CS_BATTLE_Restart = function(self, callBack)
  -- function num : 0_16 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Restart, proto_csmsg.CS_BATTLE_Restart, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Restart, callBack, proto_csmsg_MSG_ID.MSG_SC_BATTLE_Restart)
end

BattleDungeonNetworkCtrl.SC_BATTLE_Restart = function(self, msg)
  -- function num : 0_17 , upvalues : _ENV, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "BattleDungeonNetworkCtrl:SC_BATTLE_Restart error:" .. tostring(msg.ret)
      if isGameDev then
        ((CS.MessageCommon).ShowMessageTips)(err)
      end
      error(err)
      return 
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_Restart)
  end
end

BattleDungeonNetworkCtrl.CS_DUNGEON_STATIC_Detail = function(self, callBack)
  -- function num : 0_18 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DUNGEON_STATIC_Detail, proto_csmsg.CS_DUNGEON_STATIC_Detail, {})
  if callBack ~= nil then
    cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DUNGEON_STATIC_Detail, callBack, proto_csmsg_MSG_ID.MSG_SC_DUNGEON_STATIC_Detail)
  end
end

BattleDungeonNetworkCtrl.SC_DUNGEON_STATIC_Detail = function(self, msg)
  -- function num : 0_19 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  PlayerDataCenter.dungeonDailyBattleTimes = msg.dailyBattleTimes
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  PlayerDataCenter.dungeonTotalBattleTimes = msg.totalBattleTimes
  MsgCenter:Broadcast(eMsgEventId.OnBattleDungeonLimitChange)
end

BattleDungeonNetworkCtrl.CS_BATTLE_DungeonEnter = function(self, stageId, formationData, callBack)
  -- function num : 0_20 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R4 in 'UnsetPending'

  (self.sendEnterChapter).stageId = stageId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.sendEnterChapter).form = formationData
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLE_DungeonEnter, proto_csmsg.CS_BATTLE_DungeonEnter, self.sendEnterChapter)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_DungeonEnter, callBack, proto_csmsg_MSG_ID.MSG_SC_BATTLE_DungeonEnter)
end

BattleDungeonNetworkCtrl.SC_BATTLE_DungeonEnter = function(self, msg)
  -- function num : 0_21 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "BattleDungeonNetworkCtrl:SC_BATTLE_DungeonEnter error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      ((CS.MessageCommon).ShowMessageTips)(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_DungeonEnter)
  end
end

BattleDungeonNetworkCtrl.Reset = function(self)
  -- function num : 0_22
end

return BattleDungeonNetworkCtrl


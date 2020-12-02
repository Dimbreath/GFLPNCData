-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleDungeonCtrlBase = require("Game.BattleDungeon.Ctrl.BattleDungeonCtrlBase")
local BattleDungeonObjectCtrl = class("BattleDungeonObjectCtrl", BattleDungeonCtrlBase)
local DungeonConst = require("Game.BattleDungeon.DungeonConst")
BattleDungeonObjectCtrl.ctor = function(self, bdCtrl)
  -- function num : 0_0 , upvalues : _ENV, DungeonConst
  self.__overRewardLogic = BindCallback(self, self.DungeonOverRewardsLogic)
  ;
  (self.bdCtrl):RegisterDungeonLogic((DungeonConst.LogicType).OverRewards, self.__overRewardLogic)
  self.__ExitDungeonClicked = BindCallback(self, self.ExitDungeonClicked)
  self.__OnChipDataDiff = BindCallback(self, self.OnChipDataDiff)
  MsgCenter:AddListener(eMsgEventId.OnChipDataDiff, self.__OnChipDataDiff)
end

BattleDungeonObjectCtrl.OnChipDataDiff = function(self, diffData)
  -- function num : 0_1 , upvalues : _ENV
  local chipDiff = diffData[proto_csmsg_AlgModule.AlgModuleDungeon]
  if chipDiff ~= nil then
    ((self.bdCtrl).dynPlayer):UpdateChipDiff(chipDiff)
  end
end

BattleDungeonObjectCtrl.DungeonOverRewardsLogic = function(self, rewardMsg)
  -- function num : 0_2
  self.rewardMsg = rewardMsg
end

BattleDungeonObjectCtrl.ExitDungeonClicked = function(self)
  -- function num : 0_3
  (self.bdCtrl):ExitBattleDungeon(self.battleWin)
end

BattleDungeonObjectCtrl.OnDelete = function(self)
  -- function num : 0_4 , upvalues : DungeonConst, _ENV
  (self.bdCtrl):UnRegisterDungeonLogic((DungeonConst.LogicType).OverRewards, self.__overRewardLogic)
  MsgCenter:RemoveListener(eMsgEventId.OnChipDataDiff, self.__OnChipDataDiff)
end

return BattleDungeonObjectCtrl


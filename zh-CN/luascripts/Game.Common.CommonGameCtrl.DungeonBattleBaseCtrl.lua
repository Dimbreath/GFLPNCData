-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonBattleBaseCtrl = class("DungeonBattleBaseCtrl")
local CS_BattleManager_Ins = (CS.BattleManager).Instance
DungeonBattleBaseCtrl.GetHeroObjectDic =
    function(self)
        -- function num : 0_0
    end

DungeonBattleBaseCtrl.OnBattleStateChange =
    function(self, battleCtrl, stateId, isDeployRoom)
        -- function num : 0_1
    end

DungeonBattleBaseCtrl.GetRoleAppearEffect =
    function(self)
        -- function num : 0_2
    end

DungeonBattleBaseCtrl.GetRoleDisappearEffect =
    function(self)
        -- function num : 0_3
    end

DungeonBattleBaseCtrl.BattleLoadReady = function(self, battleController)
    -- function num : 0_4
end

DungeonBattleBaseCtrl.OnBattleStart = function(self, battleCtrl)
    -- function num : 0_5
end

DungeonBattleBaseCtrl.ReqStartBattle = function(self, battleRoomData,
                                                originRoleList, battleAction)
    -- function num : 0_6
end

DungeonBattleBaseCtrl.ReqBattleSettle = function(self, battleEndState,
                                                 playerRoleSettle,
                                                 monsterRoleSettle)
    -- function num : 0_7
end

DungeonBattleBaseCtrl.VictoryBattleEndCoroutine =
    function(self, battleEndState, resultData)
        -- function num : 0_8
    end

DungeonBattleBaseCtrl.ReqBattleFreshFormation =
    function(self, battleController)
        -- function num : 0_9
    end

DungeonBattleBaseCtrl.ReqGiveUpBattle = function(self, battleController)
    -- function num : 0_10
end

DungeonBattleBaseCtrl.OnDeployCoordChanged =
    function(self, battleController)
        -- function num : 0_11 , upvalues : _ENV
        MsgCenter:Broadcast(eMsgEventId.OnDeployCoordChanged)
    end

DungeonBattleBaseCtrl.OnBattleEffectClicked =
    function(self, battleController, battleEffectGrid)
        -- function num : 0_12 , upvalues : _ENV
        local worldPos = (battleController.battleFieldData):GetGridUnityPos(
                             battleEffectGrid.x, battleEffectGrid.y);
        (UIManager:ShowWindow(UIWindowTypeID.BattleEffectGirdInfo)):InitBattleGridInfo(
            battleEffectGrid.gridData, worldPos)
    end

DungeonBattleBaseCtrl.OnDelete = function(self)
    -- function num : 0_13 , upvalues : CS_BattleManager_Ins
    CS_BattleManager_Ins:ClearBattleCache()
end

return DungeonBattleBaseCtrl


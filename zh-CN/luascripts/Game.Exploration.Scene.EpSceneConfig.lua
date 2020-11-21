-- params : ...
-- function num : 0 , upvalues : _ENV
EpSceneConfig = {
    [1] = {EpSceneClass = require("Game.Exploration.Scene.EpScene1")},
    [2] = {EpSceneClass = require("Game.Exploration.Scene.EpScene2")},
    [3] = {EpSceneClass = require("Game.Exploration.Scene.EpScene3")}
}
setmetatable(EpSceneConfig, {
    __index = function(tab, key)
        -- function num : 0_0 , upvalues : _ENV
        return EpSceneConfig[1]
    end
})
TimeLineType = {
    TLEventType = {
        OnSceneLoadedTL = 1,
        OnStartBattleTL = 2,
        OnReconnectToBattleTL = 3,
        OnExitBattleTL = 4
    },
    EventTick = {OnStarted = 1, OnStopped = 2},
    TLAction = {Play = 1, Stop = 2, Pause = 3}
}
VcamType = {ExpVcam = 1, BtlVcam = 2, MainCamFollow = 3}


-- params : ...
-- function num : 0 , upvalues : _ENV
local cs_Debug = (CS.UnityEngine).Debug
error = function(msg)
  -- function num : 0_0 , upvalues : cs_Debug, _ENV
  (cs_Debug.LogError)("LUA Error:" .. msg .. "\n" .. (debug.traceback)())
end

warn = function(msg)
  -- function num : 0_1 , upvalues : cs_Debug, _ENV
  (cs_Debug.LogWarning)("LUA Warn:" .. msg .. "\n" .. (debug.traceback)())
end

require("Consts.Consts")
require("Consts.PathConsts")
require("Consts.LayerMask")
require("Consts.TagConsts")
require("Consts.Platform")
require("Consts.AreaConst")
require("Consts.UIAtlasConsts")
require("Consts.GameDefine")
require("Framework.Enum.UnityEnum")
GR = CS.GlobalRegister
isGameDev = (GR.IsGameDevMode)()
isEditorMode = (GR.IsUnityEditor)()
TimerManager = ((require("Framework.Time.TimerManager")).New)()
UpdateManager = ((require("Framework.Time.UpdateManager")).New)()
MsgCenter = ((require("Framework.Common.Messenger")).New)()
require("Framework.UI.UIUtil")
require("Framework.UI.AtlasUtil")
require("Framework.UI.Base.UIBaseNode")
require("Framework.UI.Base.UIBaseWindow")
UIManager = ((require("Framework.UI.UIManager")).New)()
UIItemPool = require("Game.CommonUI.UIItemPool")
NetworkCtrlBase = require("Framework.Network.NetworkCtrlBase")
NetworkManager = ((require("Framework.Network.NetworkManager")).New)()
require("Framework.Controller.ControllerBase")
ControllerManager = ((require("Framework.Controller.ControllerManager")).New)()
PlayerDataCenter = require("Game.PlayerData.PlayerDataCenter")
LuaSceneManager = require("Game.Scene.LuaSceneManager")
BattleUtil = require("Game.Battle.BattleUtil")
ExplorationCtrlBase = require("Game.Exploration.Ctrl.ExplorationCtrlBase")
require("Game.Exploration.ExplorationManager")
EpSceneBase = require("Game.Exploration.Scene.EpSceneBase")
require("Game.Exploration.Scene.EpSceneConfig")
require("Game.BattleDungeon.BattleDungeonManager")
CheckCondition = require("Game.Common.CheckCondition.CheckCondition")
require("Game.RedDot.RedDotDriver")
require("Game.Common.TimelineUtil")
GuideManager = require("Game.Guide.GuideManager")
GuideUtil = require("Game.Guide.GuideUtil")
AvgUtil = require("Game.Avg.AvgUtil")
require("GamePlay.SkillCore.SkillDefine")
LuaSkillBase = require("GamePlay.SkillCore.LuaSkillBase")
LuaSkillCtrl = ((require("GamePlay.SkillCore.LuaSkillCtrl")).New)()
LuaGridBase = require("GamePlay.SkillCore.LuaGridBase")
AudioManager = require("Framework.Audio.AudioManager")
LocalizeManager = require("Framework.Localize.LocalizeManager")
require("Game.CallCSharp.LuaGR")
CRH = (CS.CommonResHelper).Instance
PersistentManager = ((require("Game.PersistentManager.PersistentManager")).New)()


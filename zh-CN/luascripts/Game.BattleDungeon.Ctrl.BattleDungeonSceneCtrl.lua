-- params : ...
-- function num : 0 , upvalues : _ENV
local base = require("Game.Common.CommonGameCtrl.DungeonSceneBaseCtrl")
local BattleDungeonSceneCtrl = class("BattleDungeonSceneCtrl", base)
local DungeonConst = require("Game.BattleDungeon.DungeonConst")
local CS_GSceneManager_Ins = (CS.GSceneManager).Instance
local util = require("XLua.Common.xlua_util")
BattleDungeonSceneCtrl.ctor = function(self, bdCtrl)
  -- function num : 0_0 , upvalues : _ENV, DungeonConst
  self.bdCtrl = bdCtrl
  ;
  (table.insert)((self.bdCtrl).ctrls, self)
  self.__sceneStepLogic = BindCallback(self, self.DungeonSceneStepLogic)
  ;
  (self.bdCtrl):RegisterDungeonLogic((DungeonConst.LogicType).SceneStep, self.__sceneStepLogic)
end

BattleDungeonSceneCtrl.EnterDungeonScene = function(self, sceneWave, compeleteAction)
  -- function num : 0_1 , upvalues : _ENV
  self.curSceneId = sceneWave.scene
  self.sceneWave = sceneWave
  self:__StartLoadScene(self.curSceneId, function(success)
    -- function num : 0_1_0 , upvalues : _ENV, self, compeleteAction
    if not success then
      error("load scene fail,sceneId:" .. tostring(self.curSceneId))
      return 
    end
    if compeleteAction ~= nil then
      compeleteAction()
    end
  end
)
end

BattleDungeonSceneCtrl.__StartLoadScene = function(self, sceneId, sceneLoadComplete)
  -- function num : 0_2 , upvalues : _ENV, CS_GSceneManager_Ins, util
  local sceneCfg = (ConfigData.scene)[sceneId]
  if sceneCfg == nil then
    error("scene config is null,id:" .. tostring(sceneId))
    return 
  end
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
  end
  self.resloader = ((CS.ResLoader).Create)()
  self.heroPrefabs = {}
  self.heroObjectDic = {}
  local preLoadFunc = function()
    -- function num : 0_2_0 , upvalues : self
    self:__InitDungeonSceneEffect()
    self:__PreLoadCharacterAndSkill((self.bdCtrl).dynPlayer, self.heroPrefabs, self.heroObjectDic)
  end

  CS_GSceneManager_Ins:LoadSceneAsyncByABEx(sceneCfg.scene_name, true, false, function(result)
    -- function num : 0_2_1 , upvalues : _ENV, self, sceneLoadComplete
    local roomRoot = ((((CS.UnityEngine).GameObject).Find)("RoomMap")).transform
    if not IsNull(roomRoot) then
      self.bind = {}
      ;
      (UIUtil.LuaUIBindingTable)(roomRoot, self.bind)
      -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.bind).canvasGroup).alpha = 0
    end
    self.bind = {}
    ;
    (UIUtil.LuaUIBindingTable)((((CS.CameraController).Instance).transform).parent, self.bind)
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.bind).epMapCamera).enabled = false
    if sceneLoadComplete ~= nil then
      sceneLoadComplete(result)
    end
  end
, (util.cs_generator)(preLoadFunc))
end

BattleDungeonSceneCtrl.DungeonSceneStepLogic = function(self, sceneWave)
  -- function num : 0_3
  self.sceneWave = sceneWave
  if self.curSceneId == sceneWave.scene then
    (self.bdCtrl):StartRunNextLogic()
    return 
  end
  self:EnterDungeonScene(sceneWave, function()
    -- function num : 0_3_0 , upvalues : self
    (self.bdCtrl):StartRunNextLogic()
  end
)
end

BattleDungeonSceneCtrl.ChangeBattleScene = function(self, sceneWave)
  -- function num : 0_4
end

BattleDungeonSceneCtrl.GetBattleFieldSizeBySceneId = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local sceneCfg = (ConfigData.scene)[self.curSceneId]
  if sceneCfg == nil then
    error("scene cfg is null,scene_id:" .. tostring(self.curSceneId))
    return 
  end
  return sceneCfg.size_row, sceneCfg.size_col, sceneCfg.deploy_rows
end

BattleDungeonSceneCtrl.OnDelete = function(self)
  -- function num : 0_6 , upvalues : DungeonConst, base
  (self.bdCtrl):UnRegisterDungeonLogic((DungeonConst.LogicType).SceneStep, self.__sceneStepLogic)
  base:OnDelete(self)
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
end

return BattleDungeonSceneCtrl


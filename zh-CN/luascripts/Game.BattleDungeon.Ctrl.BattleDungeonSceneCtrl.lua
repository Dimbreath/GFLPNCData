-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonSceneBaseCtrl = require("Game.Common.CommonGameCtrl.DungeonSceneBaseCtrl")
local BattleDungeonSceneCtrl = class("BattleDungeonSceneCtrl", DungeonSceneBaseCtrl)
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
  self.heroModelHolder = nil
  local preLoadFunc = function()
    -- function num : 0_2_0 , upvalues : self, _ENV
    local waitList = {}
    local dynPlayer = (self.bdCtrl).dynPlayer
    for k,dynHero in pairs(dynPlayer.heroDic) do
      if dynHero ~= nil then
        local modelPath = PathConsts:GetCharacterModelPrefabPath(dynHero:GetResName())
        local wait = (self.resloader):LoadABAssetAsyncAwait(modelPath)
        local heroId = dynHero.dataId
        waitList[heroId] = wait
      end
    end
    for heroId,wait in pairs(waitList) do
      (coroutine.yield)(wait)
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (self.heroPrefabs)[heroId] = wait.Result
    end
    self.heroModelHolder = (((CS.UnityEngine).GameObject)("HeroModelHolder")).transform
    self:__InitDungeonSceneEffect()
    local battlePos = (CS.BattlePosData)(((self.bdCtrl).dungeonCfg).size_row, ((self.bdCtrl).dungeonCfg).size_col, (ConfigData.game_config).battleMap_bench_count)
    for heroId,heroPrefab in pairs(self.heroPrefabs) do
      local heroGo = heroPrefab:Instantiate(self.heroModelHolder)
      local dynHero = (dynPlayer.heroDic)[heroId]
      local logicPos = nil
      if dynHero.onBench then
        logicPos = ((battlePos.benchLogicPosMap)[dynHero.y]):ToVector3()
      else
        logicPos = ((battlePos.boardLogicPosMap):GetValue(dynHero.x, dynHero.y)):ToVector3()
      end
      -- DECOMPILER ERROR at PC86: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (heroGo.transform).position = logicPos
      -- DECOMPILER ERROR at PC89: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (self.heroObjectDic)[dynHero.dataId] = heroGo
      ;
      (coroutine.yield)()
    end
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

BattleDungeonSceneCtrl.OnDelete = function(self)
  -- function num : 0_5 , upvalues : DungeonConst
  (self.bdCtrl):UnRegisterDungeonLogic((DungeonConst.LogicType).SceneStep, self.__sceneStepLogic)
  if self.effectPoolCtrl ~= nil then
    (self.effectPoolCtrl):Dispose()
    self.effectPoolCtrl = nil
  end
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
end

return BattleDungeonSceneCtrl


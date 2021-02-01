-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonSceneBaseCtrl = class("DungeonSceneBaseCtrl")
DungeonSceneBaseCtrl.__PreLoadCharacterAndSkill = function(self, dynPlayer, heroPrefabs, heroObjectDic, noshow)
  -- function num : 0_0 , upvalues : _ENV
  local waitList = {}
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
    heroPrefabs[heroId] = wait.Result
  end
  self.heroModelHolder = (((CS.UnityEngine).GameObject)("HeroModelHolder")).transform
  local size_row, size_col = self:GetBattleFieldSizeBySceneId()
  local battlePos = (CS.BattlePosData)(size_row, size_col, (ConfigData.game_config).battleMap_bench_count)
  for heroId,heroPrefab in pairs(self.heroPrefabs) do
    local heroGo = heroPrefab:Instantiate(self.heroModelHolder)
    local dynHero = (dynPlayer.heroDic)[heroId]
    local logicPos = nil
    if dynHero.onBench then
      logicPos = ((battlePos.benchLogicPosMap)[dynHero.y]):ToVector3()
    else
      logicPos = ((battlePos.boardLogicPosMap):GetValue(dynHero.x, dynHero.y)):ToVector3()
    end
    -- DECOMPILER ERROR at PC78: Confused about usage of register: R17 in 'UnsetPending'

    ;
    (heroGo.transform).position = logicPos
    -- DECOMPILER ERROR at PC81: Confused about usage of register: R17 in 'UnsetPending'

    ;
    (self.heroObjectDic)[dynHero.dataId] = heroGo
    ;
    (coroutine.yield)()
  end
  if noshow then
    for k,gameObject in pairs(self.heroObjectDic) do
      gameObject:SetActive(false)
    end
  end
  do
    for heroId,dynHero in pairs(dynPlayer.heroDic) do
      local originSkillList = dynHero:GetOriginSkillList()
      for _,skill in pairs(originSkillList) do
        skill:PreloadSkill(self.effectPoolCtrl)
      end
      ;
      (coroutine.yield)()
    end
  end
end

DungeonSceneBaseCtrl.__InitDungeonSceneEffect = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self.effectPoolCtrl = (CS.EffectPoolController)()
  ;
  (self.effectPoolCtrl):OnInit()
  local resloader = (self.effectPoolCtrl).resloader
  local leapBackEffectPath = "FX/Common/FX_Transition/FXP_Transition_Back" .. PathConsts.PrefabExtension
  local effectWaitBack = resloader:LoadABAssetAsyncAwait(leapBackEffectPath)
  ;
  (coroutine.yield)(effectWaitBack)
  local roleDisappearEffectPrefab = effectWaitBack.Result
  self.__roleDisappearEffectCode = roleDisappearEffectPrefab.name
  ;
  (self.effectPoolCtrl):AddCommonPrefab(roleDisappearEffectPrefab)
  local leapEffectPath = "FX/Common/FX_Transition/FXP_Transition" .. PathConsts.PrefabExtension
  local effectWait = resloader:LoadABAssetAsyncAwait(leapEffectPath)
  ;
  (coroutine.yield)(effectWait)
  local roleAppearEffectPrefab = effectWait.Result
  self.__roleAppearEffectCode = roleAppearEffectPrefab.name
  ;
  (self.effectPoolCtrl):AddCommonPrefab(roleAppearEffectPrefab)
  ;
  (coroutine.yield)(resloader:LoadABAssetAsyncAwait("FX/Common/FX_Lightpoles/FXP_Lightpoles" .. PathConsts.PrefabExtension))
end

DungeonSceneBaseCtrl.GetRoleAppearEffect = function(self)
  -- function num : 0_2
  return (self.effectPoolCtrl):GetCommonEffect(self.__roleAppearEffectCode)
end

DungeonSceneBaseCtrl.GetRoleDisappearEffect = function(self)
  -- function num : 0_3
  return (self.effectPoolCtrl):GetCommonEffect(self.__roleDisappearEffectCode)
end

DungeonSceneBaseCtrl.GetBattleFieldSizeBySceneId = function(self)
  -- function num : 0_4
end

DungeonSceneBaseCtrl.OnDelete = function(self)
  -- function num : 0_5
  if self.effectPoolCtrl ~= nil then
    (self.effectPoolCtrl):Dispose()
    self.effectPoolCtrl = nil
  end
end

return DungeonSceneBaseCtrl


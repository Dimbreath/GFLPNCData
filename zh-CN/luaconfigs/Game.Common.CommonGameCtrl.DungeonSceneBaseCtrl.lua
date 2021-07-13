-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonSceneBaseCtrl = class("DungeonSceneBaseCtrl")
local cs_ResLoader = CS.ResLoader
DungeonSceneBaseCtrl.ctor = function(self)
  -- function num : 0_0
  self.heroResLoaderDic = {}
end

DungeonSceneBaseCtrl.SaveReuseHeroResloader = function(self, heroResDic)
  -- function num : 0_1
  self.__reuseHeroResDic = heroResDic
end

DungeonSceneBaseCtrl.__PreLoadCharacterAndSkill = function(self, dynPlayer, heroPrefabs, heroObjectDic, noshow)
  -- function num : 0_2 , upvalues : _ENV, cs_ResLoader
  local waitList = {}
  if self.__reuseHeroResDic ~= nil then
    for heroId,resloader in pairs(self.__reuseHeroResDic) do
      -- DECOMPILER ERROR at PC13: Confused about usage of register: R11 in 'UnsetPending'

      if (dynPlayer.heroDic)[heroId] ~= nil then
        (self.heroResLoaderDic)[heroId] = resloader
        -- DECOMPILER ERROR at PC15: Confused about usage of register: R11 in 'UnsetPending'

        ;
        (self.__reuseHeroResDic)[heroId] = nil
      else
        warn("reuse hero id not in dynplayer,heroId:" .. tostring(heroId))
      end
    end
    for heroId,resloader in pairs(self.__reuseHeroResDic) do
      resloader:Put2Pool()
    end
    self.__reuseHeroResDic = nil
  end
  for heroId,dynHero in pairs(dynPlayer.heroDic) do
    if dynHero ~= nil then
      local modelPath = PathConsts:GetCharacterModelPrefabPath(dynHero:GetResModelName())
      local resloader = (self.heroResLoaderDic)[heroId]
      if resloader == nil then
        resloader = (cs_ResLoader.Create)()
        -- DECOMPILER ERROR at PC54: Confused about usage of register: R13 in 'UnsetPending'

        ;
        (self.heroResLoaderDic)[heroId] = resloader
      end
      local wait = resloader:LoadABAssetAsyncAwait(modelPath)
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
    -- DECOMPILER ERROR at PC119: Confused about usage of register: R17 in 'UnsetPending'

    ;
    (heroGo.transform).position = logicPos
    -- DECOMPILER ERROR at PC122: Confused about usage of register: R17 in 'UnsetPending'

    ;
    (self.heroObjectDic)[dynHero.dataId] = heroGo
    if noshow then
      heroGo:SetActive(false)
    end
    ;
    (coroutine.yield)()
  end
  for heroId,dynHero in pairs(dynPlayer.heroDic) do
    local originSkillList = dynHero:GetOriginSkillList()
    for _,skill in pairs(originSkillList) do
      skill:PreloadSkill(self.effectPoolCtrl, dynHero)
    end
    ;
    (coroutine.yield)()
  end
end

DungeonSceneBaseCtrl.__InitDungeonSceneEffect = function(self)
  -- function num : 0_3 , upvalues : _ENV
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
  -- function num : 0_4
  return (self.effectPoolCtrl):GetCommonEffect(self.__roleAppearEffectCode)
end

DungeonSceneBaseCtrl.GetRoleDisappearEffect = function(self)
  -- function num : 0_5
  return (self.effectPoolCtrl):GetCommonEffect(self.__roleDisappearEffectCode)
end

DungeonSceneBaseCtrl.GetDungeonCrazyTime = function(self)
  -- function num : 0_6
end

DungeonSceneBaseCtrl.GetBattleFieldSizeBySceneId = function(self)
  -- function num : 0_7
end

DungeonSceneBaseCtrl.OnDelete = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self.effectPoolCtrl ~= nil then
    (self.effectPoolCtrl):Dispose()
    self.effectPoolCtrl = nil
  end
  if self.heroResLoaderDic ~= nil then
    for k,resLoader in pairs(self.heroResLoaderDic) do
      resLoader:Put2Pool()
    end
    self.heroResLoaderDic = nil
  end
  if self.__reuseHeroResDic ~= nil then
    for k,resLoader in pairs(self.__reuseHeroResDic) do
      resLoader:Put2Pool()
    end
    self.__reuseHeroResDic = nil
  end
end

return DungeonSceneBaseCtrl


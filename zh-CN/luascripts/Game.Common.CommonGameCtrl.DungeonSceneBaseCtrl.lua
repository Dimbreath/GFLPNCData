-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonSceneBaseCtrl = class("DungeonSceneBaseCtrl")
DungeonSceneBaseCtrl.__InitDungeonSceneEffect = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.effectPoolCtrl = (CS.EffectPoolController)()
  ;
  (self.effectPoolCtrl):OnInit()
  local leapBackEffectPath = "FX/Common/FX_Transition/FXP_Transition_Back" .. PathConsts.PrefabExtension
  local effectWaitBack = (self.resloader):LoadABAssetAsyncAwait(leapBackEffectPath)
  ;
  (coroutine.yield)(effectWaitBack)
  local roleDisappearEffectPrefab = effectWaitBack.Result
  self.__roleDisappearEffectCode = roleDisappearEffectPrefab.name
  ;
  (self.effectPoolCtrl):AddCommonPrefab(roleDisappearEffectPrefab)
  local leapEffectPath = "FX/Common/FX_Transition/FXP_Transition" .. PathConsts.PrefabExtension
  local effectWait = (self.resloader):LoadABAssetAsyncAwait(leapEffectPath)
  ;
  (coroutine.yield)(effectWait)
  local roleAppearEffectPrefab = effectWait.Result
  self.__roleAppearEffectCode = roleAppearEffectPrefab.name
  ;
  (self.effectPoolCtrl):AddCommonPrefab(roleAppearEffectPrefab)
end

DungeonSceneBaseCtrl.GetRoleAppearEffect = function(self)
  -- function num : 0_1
  return (self.effectPoolCtrl):GetCommonEffect(self.__roleAppearEffectCode)
end

DungeonSceneBaseCtrl.GetRoleDisappearEffect = function(self)
  -- function num : 0_2
  return (self.effectPoolCtrl):GetCommonEffect(self.__roleDisappearEffectCode)
end

DungeonSceneBaseCtrl.OnDelete = function(self)
  -- function num : 0_3
end

return DungeonSceneBaseCtrl


-- params : ...
-- function num : 0 , upvalues : _ENV
local base = require("Game.Formation.Ctrl.FormationCtrlBase")
local FormationSceneCtrl = class("FormationSceneCtrl", base)
local UIN3DFormation = require("Game.Formation.UI.3DFormation.UIN3DFormation")
local FmtPlatformEntity = require("Game.Formation.Entity.FmtPlatformEntity")
local FmtHeroEntity = require("Game.Formation.Entity.FmtHeroEntity")
local util = require("XLua.Common.xlua_util")
local CS_GameObject = (CS.UnityEngine).GameObject
local CS_Physics = CS.PhysicsUtility
local CS_InputUtility = CS.InputUtility
local FmtGroundCollider = "FmtGroundCollider"
local DragPosOffset = (Vector3.New)(0, 0, -0.3)
FormationSceneCtrl.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.__OnClickPlatform = BindCallback(self, self.OnClickPlatform)
  self.__OnBeginDrag = BindCallback(self, self.OnBeginDrag)
  self.__OnDrag = BindCallback(self, self.OnDrag)
  self.__OnEndDrag = BindCallback(self, self.OnEndDrag)
end

FormationSceneCtrl.InitFmtSceneCtrl = function(self, go)
  -- function num : 0_1 , upvalues : _ENV, UIN3DFormation, FmtPlatformEntity
  self.gameObject = go
  self.transform = go.transform
  self.bind = {}
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.bind)
  local screenWidth = ((CS.UnityEngine).Screen).width
  self.__screenWidthRange = (Vector2.New)((self.bind).screenWidthOffset, screenWidth - (self.bind).screenWidthOffset)
  local halfScreenHeight = ((CS.UnityEngine).Screen).height / 2
  self.__screenHeightRange = (Vector2.New)(halfScreenHeight * ((self.bind).screenHeightOffset).x, halfScreenHeight * ((self.bind).screenHeightOffset).y)
  self.ui3dFmt = (UIN3DFormation.New)(self.fmtCtrl)
  ;
  (self.ui3dFmt):Init((self.bind).uI_3DFormation)
  ;
  (self.ui3dFmt):Init3DFormation()
  self.platformEntityDic = {}
  self.platformEntityGoDic = {}
  for fmtIndex,go in ipairs((self.bind).platform) do
    local isBench = (ConfigData.game_config).max_stage_hero < fmtIndex
    local unlcok = true
    do
      if isBench then
        local benchId = fmtIndex - (ConfigData.game_config).max_stage_hero
        unlcok = ((self.fmtCtrl).BenchUnlock)(benchId)
      end
      do
        local entity = (FmtPlatformEntity.New)()
        entity:InitFmtPlatEntity(go, fmtIndex, self, self.__OnClickPlatform, isBench, unlcok)
        entity:SetFmtPlatformDragEvent(self.__OnBeginDrag, self.__OnDrag, self.__OnEndDrag)
        -- DECOMPILER ERROR at PC96: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (self.platformEntityDic)[fmtIndex] = entity
        -- DECOMPILER ERROR at PC98: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (self.platformEntityGoDic)[go] = entity
        if self.__platformPosY == nil then
          self.__platformPosY = ((go.transform).position).y
        end
        -- DECOMPILER ERROR at PC106: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  self.heroEntityIdDic = {}
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

FormationSceneCtrl.RefreshFmtScene = function(self, fmtData, forceAnim)
  -- function num : 0_2 , upvalues : _ENV
  self.formationData = fmtData
  local newHeroEntityIdDic = {}
  for k,heroId in pairs(fmtData.data) do
    local heroEntity = (self.heroEntityIdDic)[heroId]
    if heroEntity ~= nil then
      heroEntity:UpdateFmtHeroEntityHeadInfo()
      newHeroEntityIdDic[heroId] = heroEntity
    end
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.heroEntityIdDic)[heroId] = nil
  end
  for k,heroEntity in pairs(self.heroEntityIdDic) do
    heroEntity:OnDelete()
  end
  self.heroEntityIdDic = newHeroEntityIdDic
  self.__loadHeroCo = nil
  self.heroEntityDic = {}
  for index,heroId in pairs(fmtData.data) do
    local heroData = PlayerDataCenter:GetHeroData(heroId)
    if heroData ~= nil then
      local platformEntity = (self.platformEntityDic)[index]
      platformEntity:ShowFmtPlatform(true)
      local heroEntity = self:__CreateHeroEntity(heroData, (platformEntity.transform).position, forceAnim)
      -- DECOMPILER ERROR at PC51: Confused about usage of register: R12 in 'UnsetPending'

      ;
      (self.heroEntityDic)[index] = heroEntity
    end
  end
  ;
  (self.ui3dFmt):Refresh3DFmt(self.formationData)
end

FormationSceneCtrl.__CreateHeroEntity = function(self, heroData, position, forceAnim)
  -- function num : 0_3 , upvalues : CS_GameObject, _ENV, FmtHeroEntity, util
  local heroEntity = (self.heroEntityIdDic)[heroData.dataId]
  local coFunc = nil
  if heroEntity == nil then
    local go = CS_GameObject(tostring(heroData.dataId))
    ;
    (go.transform):SetParent((self.bind).characters)
    heroEntity = (FmtHeroEntity.New)()
    coFunc = heroEntity:InitFmtHeroEntity(go, heroData, (self.bind).camera)
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self.heroEntityIdDic)[heroData.dataId] = heroEntity
  else
    do
      if forceAnim then
        (heroEntity.gameObject):SetActive(false)
        coFunc = function()
    -- function num : 0_3_0 , upvalues : _ENV, heroEntity
    if not IsNull(heroEntity.gameObject) then
      (heroEntity.gameObject):SetActive(true)
    end
  end

      end
      heroEntity:SetFmtHeroEntityPos(position)
      if self.__loadHeroCoFuncList == nil then
        self.__loadHeroCoFuncList = {}
      end
      ;
      (table.insert)(self.__loadHeroCoFuncList, coFunc)
      do
        if self.__loadHeroCo == nil then
          local loadHeroListFunc = function()
    -- function num : 0_3_1 , upvalues : self, _ENV
    do
      while #self.__loadHeroCoFuncList > 0 do
        local coFunc = (table.remove)(self.__loadHeroCoFuncList, 1)
        coFunc()
        ;
        (coroutine.yield)(nil)
      end
      self.__loadHeroCo = nil
    end
  end

          self.__loadHeroCo = (GR.StartCoroutine)((util.cs_generator)(loadHeroListFunc))
        end
        return heroEntity
      end
    end
  end
end

FormationSceneCtrl.GetHeroEntity = function(self, fmtIndex)
  -- function num : 0_4
  return (self.heroEntityDic)[fmtIndex]
end

FormationSceneCtrl.GetFmtPlatformEntityByGo = function(self, gameObject)
  -- function num : 0_5
  return (self.platformEntityGoDic)[gameObject]
end

FormationSceneCtrl.SwapFmtPlatformHero = function(self, fromFmtIndex, toFmtIndex)
  -- function num : 0_6
  local heroDic = self.heroEntityDic
  local newFmtData = (self.formationData).data
  heroDic[fromFmtIndex] = heroDic[toFmtIndex]
  newFmtData[fromFmtIndex] = newFmtData[toFmtIndex]
  ;
  (self.fmtCtrl):ModifyFormation(newFmtData)
  ;
  (self.ui3dFmt):RefreshFmtPlatformUI(fromFmtIndex)
  ;
  (self.ui3dFmt):RefreshFmtPlatformUI(toFmtIndex)
end

FormationSceneCtrl.OnClickPlatform = function(self, fmtIndex)
  -- function num : 0_7
  if self.__dragPlatform ~= nil then
    return 
  end
  local heroData = nil
  local heroEntity = (self.heroEntityDic)[fmtIndex]
  if heroEntity ~= nil then
    heroData = heroEntity:GetFmtHeroEntityData()
  end
  ;
  (self.fmtCtrl):ShowQuickFormation(heroData)
end

FormationSceneCtrl.OnBeginDrag = function(self, platformItem, eventData)
  -- function num : 0_8 , upvalues : _ENV
  if self.__dragPlatform ~= nil then
    return 
  end
  if not platformItem:IsFmtPlatformUnlock() then
    return 
  end
  local heroEntity = self:GetHeroEntity(platformItem:GetFmtIndex())
  if heroEntity == nil then
    return 
  end
  self.__dragHero = heroEntity
  ;
  (self.__dragHero):FmtHeroOnDrag(true)
  platformItem:EnableFmtPlatformRaycast(false)
  self.__dragPlatform = platformItem
  AudioManager:PlayAudioById(1018)
end

FormationSceneCtrl.OnDrag = function(self, platformItem, eventData)
  -- function num : 0_9 , upvalues : DragPosOffset
  if self.__dragPlatform == nil or self.__dragPlatform ~= platformItem then
    return 
  end
  local newPos = self:__GetGroundPoint()
  newPos = newPos + DragPosOffset
  ;
  (self.__dragHero):SetFmtHeroEntityPos(newPos)
  local targetPlatform = self:__GetTargetPlatform(newPos)
  -- DECOMPILER ERROR at PC28: Unhandled construct in 'MakeBoolean' P1

  if targetPlatform == nil and self.__swappedHero ~= nil then
    (self.__swappedHero):DragHeroEndTweenHeroDetailItem(((self.__swappedPlatform).transform).position)
    self.__swappedHero = nil
    self.__swappedPlatform = nil
  end
  if targetPlatform ~= platformItem and targetPlatform ~= self.__swappedPlatform and targetPlatform:IsFmtPlatformUnlock() then
    if self.__swappedHero ~= nil then
      (self.__swappedHero):DragHeroEndTweenHeroDetailItem(((self.__swappedPlatform).transform).position)
      self.__swappedHero = nil
      self.__swappedPlatform = nil
    end
    local targetFmtIndex = targetPlatform:GetFmtIndex()
    local heroEntity = self:GetHeroEntity(targetPlatform:GetFmtIndex())
    if heroEntity ~= nil then
      heroEntity:DragHeroEndTweenHeroDetailItem((platformItem.transform).position)
      self.__swappedPlatform = targetPlatform
      self.__swappedHero = heroEntity
    end
  end
end

FormationSceneCtrl.OnEndDrag = function(self, platformItem, eventData)
  -- function num : 0_10 , upvalues : _ENV
  if self.__dragPlatform == nil or self.__dragPlatform ~= platformItem then
    return 
  end
  local targetPlatform = self:__GetTargetPlatform(((self.__dragHero).transform).position)
  if targetPlatform == nil or not targetPlatform:IsFmtPlatformUnlock() then
    (self.__dragHero):DragHeroEndTweenHeroDetailItem((platformItem.transform).position)
  else
    if targetPlatform ~= platformItem then
      local targetFmtIndex = targetPlatform:GetFmtIndex()
      local heroEntity = self:GetHeroEntity(targetPlatform:GetFmtIndex())
      if heroEntity ~= nil then
        heroEntity:DragHeroEndTweenHeroDetailItem((platformItem.transform).position)
      end
      ;
      (self.__dragHero):DragHeroEndTweenHeroDetailItem((targetPlatform.transform).position)
      self:SwapFmtPlatformHero(platformItem:GetFmtIndex(), targetFmtIndex)
      ;
      (self.ui3dFmt):RefreshRefresh3DFmtFightPower()
    end
  end
  do
    ;
    (self.__dragHero):FmtHeroOnDrag(false)
    self.__dragHero = nil
    self.__swappedPlatform = nil
    self.__swappedHero = nil
    self.__dragPlatform = nil
    platformItem:EnableFmtPlatformRaycast(true)
    AudioManager:PlayAudioById(1019)
  end
end

FormationSceneCtrl.__GetGroundPoint = function(self)
  -- function num : 0_11 , upvalues : CS_InputUtility, _ENV
  local mousePos = CS_InputUtility.MousePosition
  mousePos.x = (math.clamp)(mousePos.x, (self.__screenWidthRange).x, (self.__screenWidthRange).y)
  mousePos.y = (math.clamp)(mousePos.y, (self.__screenHeightRange).x, (self.__screenHeightRange).y)
  self:__RaycastGround(mousePos)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.__lastGroundPos).y = self.__platformPosY
  return self.__lastGroundPos
end

FormationSceneCtrl.__RaycastGround = function(self, mousePos)
  -- function num : 0_12 , upvalues : CS_Physics, _ENV, FmtGroundCollider
  local hits = (CS_Physics.Raycast)((self.bind).camera, 1 << LayerMask.Raycast, true, mousePos)
  for i = 0, hits.Length - 1 do
    local hitCollider = (hits[i]).collider
    if not IsNull(hitCollider) and hitCollider.name == FmtGroundCollider then
      self.__lastGroundPos = (hits[i]).point
      break
    end
  end
end

FormationSceneCtrl.__GetTargetPlatform = function(self, originPos)
  -- function num : 0_13 , upvalues : CS_Physics, _ENV
  originPos.y = originPos.y + 5
  local targetGo = nil
  local hits = (CS_Physics.Raycast)(originPos, Vector3.down, 1 << LayerMask.Formation)
  for i = 0, hits.Length - 1 do
    local hitCollider = (hits[i]).collider
    if not IsNull(hitCollider) then
      targetGo = hitCollider.gameObject
      break
    end
  end
  do
    local targetPlatform = nil
    if not IsNull(targetGo) then
      targetPlatform = self:GetFmtPlatformEntityByGo(targetGo)
    end
    return targetPlatform
  end
end

FormationSceneCtrl.SetFormationCameraActive = function(self, active)
  -- function num : 0_14
  ((self.bind).formationCam):SetActive(active)
end

FormationSceneCtrl.OnDelete = function(self)
  -- function num : 0_15 , upvalues : _ENV
  if self.__loadHeroCo ~= nil then
    (GR.StopCoroutine)(self.__loadHeroCo)
  end
  DestroyUnityObject(self.gameObject)
end

return FormationSceneCtrl


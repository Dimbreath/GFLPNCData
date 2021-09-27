local CS_UnityEngine_GameObject = (CS.UnityEngine).GameObject
local DormFightCtrlBase = require("Game.Fight.Ctrl.DormFightCtrlBase")
local CharacterFactory = require("Game.Fight.Character.Entity.CharacterFactory")
local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterCtrl = class("DormFightCharacterCtrl", DormFightCtrlBase)
DormFightCharacterCtrl.ctor = function(self, _)
  -- function num : 0_0 , upvalues : _ENV
  self._resLoader = nil
  self._characterIndex = 0
  self._allCharacters = {}
  self._hittableParts2Char = {}
  self._hitIndexDict = {}
  self._checkHit = false
  self._onCharacterHit = BindCallback(self, self.OnCharacterHitSomeone)
  self._someoneKnockOutDelegate = nil
end

DormFightCharacterCtrl.AddCharacter = function(self, characterId, characterType, isMainCharacter, name, comp, bornPosition, bornRotation)
  -- function num : 0_1 , upvalues : CharacterFactory, DormFightConst, _ENV, CS_UnityEngine_GameObject
  local character = (CharacterFactory.CreateCharacter)(characterType)
  if character == nil then
    return 
  end
  self._characterIndex = self._characterIndex + 1
  local folderKey = nil
  if characterId == DormFightConst.MaleProfessorIdDefine then
    folderKey = "professor_boy"
  else
    if characterId == DormFightConst.FemaleProfessorIdDefine then
      folderKey = "professor"
    else
      local heroCfg = (ConfigData.hero_data)[characterId]
      if heroCfg then
        local cfg = (ConfigData.resource_model)[heroCfg.src_id]
      end
      folderKey = cfg ~= nil and cfg.res_Name or "professor"
    end
  end
  do
    local resPath = PathConsts:GetCharacterFightModelPath(folderKey)
    local modelPrefab = (self._resLoader):LoadABAsset(resPath)
    if modelPrefab == nil then
      return -1
    end
    local modelGo = (CS_UnityEngine_GameObject.Instantiate)(modelPrefab, bornPosition, bornRotation)
    character:Initialize(self._characterIndex, isMainCharacter, name, comp, modelGo)
    character:AddHitSomeoneListener(self._onCharacterHit)
    local hittableParts = character:GetHittableParts()
    for i = 0, hittableParts.Count - 1 do
      local partGo = hittableParts[i]
      -- DECOMPILER ERROR at PC79: Confused about usage of register: R19 in 'UnsetPending'

      if not IsNull(partGo) then
        (self._hittableParts2Char)[partGo:GetInstanceID()] = self._characterIndex
      end
    end
    -- DECOMPILER ERROR at PC83: Confused about usage of register: R14 in 'UnsetPending'

    ;
    (self._allCharacters)[self._characterIndex] = character
    return self._characterIndex
  end
end

DormFightCharacterCtrl.GetCharacter = function(self, characterId)
  -- function num : 0_2
  if characterId then
    return (self._allCharacters)[characterId]
  end
end

DormFightCharacterCtrl.GetAllCharacter = function(self)
  -- function num : 0_3
  return self._allCharacters
end

DormFightCharacterCtrl.OnCharacterHitSomeone = function(self, triggerCharacterId, hitIndex, hitInstanceId, velocity)
  -- function num : 0_4 , upvalues : DormFightConst
  if not self._checkHit then
    return 
  end
  if triggerCharacterId == nil or hitInstanceId == nil or (self._hittableParts2Char)[hitInstanceId] == nil then
    return -1
  end
  local hitCharacterId = (self._hittableParts2Char)[hitInstanceId]
  local hitCharacter = self:GetCharacter(hitCharacterId)
  if hitCharacter == nil then
    return -1
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R7 in 'UnsetPending'

  if (self._hitIndexDict)[triggerCharacterId] == nil then
    (self._hitIndexDict)[triggerCharacterId] = {}
  end
  local hitDict = (self._hitIndexDict)[triggerCharacterId]
  local lastHitIndex = hitDict[hitCharacterId] or -1
  if hitIndex == lastHitIndex then
    return 
  end
  hitDict[hitCharacterId] = hitIndex
  local shouldKnockOut = false
  local vitalityCtrl = hitCharacter:GetFeature((DormFightConst.FeatureEnum).VitalityController)
  if vitalityCtrl ~= nil then
    vitalityCtrl:OnAttacked()
    shouldKnockOut = vitalityCtrl:ShouldKnockOut()
  end
  local sceneUiCtrl = hitCharacter:GetFeature((DormFightConst.FeatureEnum).SceneUiController)
  if sceneUiCtrl ~= nil then
    sceneUiCtrl:ShowVitalityNode()
  end
  local modelCtrl = hitCharacter:GetFeature((DormFightConst.FeatureEnum).ModelController)
  if shouldKnockOut then
    modelCtrl:PostEvent((DormFightConst.EventEnum).KnockOut, velocity)
    if self._someoneKnockOutDelegate ~= nil then
      (self._someoneKnockOutDelegate)(hitCharacter:GetComp())
    end
  else
    modelCtrl:PostEvent((DormFightConst.EventEnum).Hit, velocity)
  end
end

DormFightCharacterCtrl.GetNearestEnemyPosition = function(self, comp, position, containMinor)
  -- function num : 0_5 , upvalues : _ENV
  local res = nil
  local minSqrDistance = 999999
  for _,v in pairs(self._allCharacters) do
    if v:GetComp() ~= comp and (containMinor or v:IsMainCharacter()) then
      local tPosition = v:GetPosition()
      local dx = tPosition.x - position.x
      local dz = tPosition.z - position.z
      local sqrDistance = dx * dx + dz * dz
      if sqrDistance < minSqrDistance then
        res = tPosition
        minSqrDistance = sqrDistance
      end
    end
  end
  return res
end

DormFightCharacterCtrl.SetSomeoneKnockOutDelegate = function(self, listener)
  -- function num : 0_6
  self._someoneKnockOutDelegate = listener
end

DormFightCharacterCtrl.DestroyAllCharacter = function(self)
  -- function num : 0_7 , upvalues : _ENV
  for _,character in pairs(self._allCharacters) do
    character:Destroy()
  end
  self._allCharacters = {}
  self._hittableParts2Char = {}
  self._hitIndexDict = {}
end

DormFightCharacterCtrl.OnUpdate = function(self, deltaTime)
  -- function num : 0_8 , upvalues : _ENV
  for _,v in pairs(self._allCharacters) do
    v:Update(deltaTime)
  end
end

DormFightCharacterCtrl.OnFightStart = function(self)
  -- function num : 0_9
  self._checkHit = true
end

DormFightCharacterCtrl.OnFightEnd = function(self)
  -- function num : 0_10
  self._checkHit = false
end

DormFightCharacterCtrl.OnEnterFightScene = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if self._resLoader == nil then
    self._resLoader = ((CS.ResLoader).Create)()
  end
end

DormFightCharacterCtrl.OnExitFightScene = function(self)
  -- function num : 0_12
  if self._resLoader ~= nil then
    (self._resLoader):Put2Pool()
    self._resLoader = nil
  end
  self:DestroyAllCharacter()
end

return DormFightCharacterCtrl


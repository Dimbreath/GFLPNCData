local FeatureFactory = require("Game.Fight.Character.Feature.FeatureFactory")
local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterBase = class("DormFightCharacterBase")
DormFightCharacterBase.ctor = function(self)
  -- function num : 0_0
  self._uniqueId = -1
  self._comp = -1
  self._name = nil
  self._isMainCharacter = false
  self.gameObject = nil
  self.transform = nil
  self.characterCo = nil
  self.rigidBody = nil
  self.collider = nil
  self.ragBody = nil
  self.animator = nil
  self.modelRoot = nil
  self._featureDict = {}
  self._hitIndex = 0
  self._hitEnabled = false
  self._onHitSomething = nil
end

DormFightCharacterBase.Initialize = function(self, uniqueId, isMainCharacter, name, comp, modelGameObject)
  -- function num : 0_1 , upvalues : _ENV
  self._uniqueId = uniqueId
  self._isMainCharacter = isMainCharacter or false
  self._comp = comp
  self._name = name
  self.gameObject = modelGameObject
  self.transform = modelGameObject.transform
  self.characterCo = modelGameObject:GetComponent(typeof(((CS.FightDemo).Character).CharacterComponent))
  self.rigidBody = (self.characterCo).rigidbody
  self.collider = (self.characterCo).collider
  self.ragBody = (self.characterCo).ragBody
  self.animator = (self.characterCo).animator
  self.modelRoot = (self.characterCo).model
  self:SetIgnoreWallCollider(true)
  self:FillFeatures()
  ;
  ((self.characterCo).onHitSomeone):AddListener(BindCallback(self, self.OnHitSomeone))
  for _,v in pairs(self._featureDict) do
    v:Init(self)
  end
end

DormFightCharacterBase.IsMainCharacter = function(self)
  -- function num : 0_2
  return self._isMainCharacter
end

DormFightCharacterBase.OnHitSomeone = function(self, collision, velocity)
  -- function num : 0_3
  local instanceId = (collision.gameObject):GetInstanceID()
  if self._onHitSomething ~= nil then
    (self._onHitSomething)(self._uniqueId, self._hitIndex, instanceId, velocity)
  end
end

DormFightCharacterBase.AddHitSomeoneListener = function(self, listener)
  -- function num : 0_4
  self._onHitSomething = listener
end

DormFightCharacterBase.GetHittableParts = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if IsNull(self.characterCo) or not (self.characterCo).hittableParts then
    return {}
  end
end

DormFightCharacterBase.GetComp = function(self)
  -- function num : 0_6
  return self._comp or -1
end

DormFightCharacterBase.GetName = function(self)
  -- function num : 0_7
  return self._name or ""
end

DormFightCharacterBase.GetPosition = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if IsNull(self.rigidBody) or not (self.rigidBody).position then
    return Vector3.zero
  end
end

DormFightCharacterBase.SetHandDetectHit = function(self, hitEnabled)
  -- function num : 0_9 , upvalues : _ENV
  if hitEnabled == self._hitEnabled or IsNull(self.characterCo) then
    return 
  end
  self._hitEnabled = hitEnabled
  self._hitIndex = self._hitIndex + 1
  ;
  (self.characterCo):SetHandDetectHit(hitEnabled)
end

DormFightCharacterBase.AddFeature = function(self, featureType)
  -- function num : 0_10 , upvalues : FeatureFactory
  local featureInst = (FeatureFactory.CreateFeature)(featureType)
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._featureDict)[featureType] = featureInst
end

DormFightCharacterBase.GetFeature = function(self, featureType)
  -- function num : 0_11
  if featureType then
    return (self._featureDict)[featureType]
  end
end

DormFightCharacterBase.GetCharacterType = function(self)
  -- function num : 0_12 , upvalues : DormFightConst
  return (DormFightConst.CharacterType).Undefined
end

DormFightCharacterBase.FillFeatures = function(self)
  -- function num : 0_13
end

DormFightCharacterBase.SetIgnoreWallCollider = function(self, ignore)
  -- function num : 0_14 , upvalues : _ENV
  if IsNull(self.characterCo) then
    return 
  end
  local dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight)
  local sceneCtrl = dormFightCtrl:GetSceneCtrl()
  local wallsList = sceneCtrl:GetWallList()
  for _,wall in ipairs(wallsList) do
    (self.characterCo):SetIgnoreWallColliders(ignore, wall)
  end
end

DormFightCharacterBase.Update = function(self, deltaTime)
  -- function num : 0_15 , upvalues : _ENV
  for _,v in pairs(self._featureDict) do
    v:Update(deltaTime)
  end
end

DormFightCharacterBase.Destroy = function(self)
  -- function num : 0_16 , upvalues : _ENV
  if not IsNull(self.gameObject) then
    DestroyUnityObject(self.gameObject, true)
  end
  self.gameObject = nil
  self.transform = nil
  self.characterCo = nil
  self.rigidBody = nil
  self.collider = nil
  self.ragBody = nil
  self.animator = nil
  for _,v in pairs(self._featureDict) do
    v:Destroy()
  end
  self._featureDict = nil
end

return DormFightCharacterBase


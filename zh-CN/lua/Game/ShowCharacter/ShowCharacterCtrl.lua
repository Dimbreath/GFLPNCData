local ShowCharacterCtrl = class("ShowCharacterCtrl", ControllerBase)
local base = ControllerBase
local HeroInfoData = require("Game.Lottery.Data.HeroInfoData")
local util = require("XLua.Common.xlua_util")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local JumpManager = require("Game.Jump.JumpManager")
local CS_LeanTouch = ((CS.Lean).Touch).LeanTouch
local CS_Physics = CS.PhysicsUtility
ShowCharacterCtrl.EnterShowCharacterScene = function(self, heroId, fromPoolId)
  -- function num : 0_0 , upvalues : _ENV, HeroInfoData, util
  UIManager:DeleteAllWindow()
  self.next = 0
  self.fromPoolId = fromPoolId
  if self.heroData == nil then
    self.heroData = HeroInfoData:New()
  end
  ;
  (self.heroData):InitData(heroId)
  if self.characterLoader == nil then
    self.characterLoader = ((CS.ResLoader).Create)()
  end
  local preLoadFunc = function()
    -- function num : 0_0_0 , upvalues : _ENV, self
    local modelPath = PathConsts:GetCharacterModelPrefabPath(((self.heroData).heroData):GetResModelName())
    local showCharacterWait = (self.characterLoader):LoadABAssetAsyncAwait(modelPath)
    ;
    (coroutine.yield)(showCharacterWait)
    self.showCharacterPrefab = showCharacterWait.Result
    UIManager:ShowWindowAsync(UIWindowTypeID.ShowCharacter)
    repeat
      (coroutine.yield)(nil)
      self.showCharacterWindow = UIManager:GetWindow(UIWindowTypeID.ShowCharacter)
    until self.showCharacterWindow
  end

  ;
  ((CS.GSceneManager).Instance):LoadSceneAsyncByAB((Consts.SceneName).ShowCharacter, function(ok)
    -- function num : 0_0_1 , upvalues : self
    self:OnLoadCompeleted()
  end
, (util.cs_generator)(preLoadFunc))
end

ShowCharacterCtrl.OnLoadCompeleted = function(self)
  -- function num : 0_1 , upvalues : _ENV, ExplorationEnum, CS_LeanTouch
  if self.showCharacterPrefab ~= nil then
    self.characterGo = (self.showCharacterPrefab):Instantiate()
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.characterGo).transform).localEulerAngles = (Vector3.New)(0, 90, 0)
    self.characterAnimator = (self.characterGo):GetComponent(typeof((CS.UnityEngine).Animator))
  end
  self.cameraController = (CS.CameraController).Instance
  if self.cameraController ~= nil then
    (self.cameraController):SetControlState((ExplorationEnum.eEpCamControlState).Battle)
  end
  self.onFingerTap = BindCallback(self, self.__onFingerTap)
  ;
  (CS_LeanTouch.OnFingerTap)("+", self.onFingerTap)
end

ShowCharacterCtrl.__onFingerTap = function(self)
  -- function num : 0_2 , upvalues : _ENV, CS_Physics
  if self.cameraController == nil then
    return 
  end
  local mainCamera = (self.cameraController).MainCamera
  if IsNull(mainCamera) then
    return 
  end
  local hits = (CS_Physics.Raycast)(mainCamera, 1 << LayerMask.Character)
  for i = 0, hits.Length - 1 do
    local hitCollider = (hits[i]).collider
    if not IsNull(hitCollider) then
      local hitPos = nil
      if self.characterAnimator ~= nil then
        (self.characterAnimator):Play(self:__GetNextAnimationId())
      end
    end
  end
end

ShowCharacterCtrl.ExitShowCharacterScene = function(self)
  -- function num : 0_3 , upvalues : _ENV, JumpManager
  UIManager:DeleteWindow(UIWindowTypeID.ShowCharacter)
  JumpManager:Jump((JumpManager.eJumpTarget).DynLottery, function(jumpCallback)
    -- function num : 0_3_0 , upvalues : self, _ENV
    if jumpCallback ~= nil then
      jumpCallback()
    end
    self:Delete()
    ;
    ((CS.GSceneManager).Instance):LoadSceneAsyncByAB((Consts.SceneName).Main, function(ok)
      -- function num : 0_3_0_0 , upvalues : _ENV
      (ControllerManager:GetController(ControllerTypeId.HomeController, true)):OnEnterHome()
      UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(win)
        -- function num : 0_3_0_0_0
        if win then
          win:SetFrom2Home(nil, false)
        end
      end
)
    end
)
  end
, function()
    -- function num : 0_3_1 , upvalues : _ENV, self
    local ctrl = ControllerManager:GetController(ControllerTypeId.Lottery, true)
    ctrl:InitLottery(function(win)
      -- function num : 0_3_1_0 , upvalues : _ENV
      win:SetFromWhichUI(eBaseWinFromWhere.home)
    end
, self.fromPoolId)
  end
)
end

ShowCharacterCtrl.__GetNextAnimationId = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self.AnimationIdList == nil then
    self.AnimationIdList = {(((CS.UnityEngine).Animator).StringToHash)("Deploy_Win"), (((CS.UnityEngine).Animator).StringToHash)("Deploy_Idle")}
  end
  if self.next == nil then
    self.next = 0
  end
  if #self.AnimationIdList <= self.next then
    self.next = 0
  end
  self.next = self.next + 1
  return (self.AnimationIdList)[self.next]
end

ShowCharacterCtrl.OnDelete = function(self)
  -- function num : 0_5 , upvalues : CS_LeanTouch, base
  (CS_LeanTouch.OnFingerTap)("-", self.onFingerTap)
  if self.characterLoader ~= nil then
    (self.characterLoader):Put2Pool()
    self.characterLoader = nil
  end
  self.cameraController = nil
  self.showCharacterPrefab = nil
  self.characterGo = nil
  self.characterAnimator = nil
  ;
  (base.OnDelete)(self)
end

return ShowCharacterCtrl


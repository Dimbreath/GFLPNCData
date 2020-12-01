-- params : ...
-- function num : 0 , upvalues : _ENV
local FmtHeroEntity = class("FmtHeroEntity")
local CS_ResLoader = CS.ResLoader
local infoPosOffset = (Vector3.New)(0, 1.1, 0)
FmtHeroEntity.InitFmtHeroEntity = function(self, go, heroData, camera)
  -- function num : 0_0 , upvalues : CS_ResLoader, _ENV
  self.gameObject = go
  self.transform = go.transform
  self.heroData = heroData
  self.camera = camera
  self.resloader = (CS_ResLoader.Create)()
  local modelPath = PathConsts:GetCharacterModelPrefabPath(heroData:GetResName())
  local coroutineFunc = function()
    -- function num : 0_0_0 , upvalues : self, modelPath, _ENV
    if self.isDeleted then
      return 
    end
    local modelWait = (self.resloader):LoadABAssetAsyncAwait(modelPath)
    ;
    (coroutine.yield)(modelWait)
    if self.isDeleted then
      return 
    end
    self.heroGo = (modelWait.Result):Instantiate(self.transform)
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.heroGo).transform).localEulerAngles = (Vector3.New)(0, 180, 0)
    self.animator = (self.heroGo):FindComponent(eUnityComponentID.Animator)
    ;
    (self.animator):SetBool("InFormation", true)
    self:FmtHeroOnDrag(self.__inDrag)
  end

  self.fmtWindow = UIManager:GetWindow(UIWindowTypeID.Formation)
  if self.fmtWindow ~= nil then
    (self.fmtWindow):CreatFmtHeroInfo(self.heroData, self:__GetInfoPos())
  end
  return coroutineFunc
end

FmtHeroEntity.FmtHeroOnDrag = function(self, drag)
  -- function num : 0_1 , upvalues : _ENV
  self.__inDrag = drag or false
  if IsNull(self.animator) then
    return 
  end
  ;
  (self.animator):SetBool("DeployFloat", self.__inDrag)
  if self.fmtWindow ~= nil then
    (self.fmtWindow):ShowFmtHeroInfo((self.heroData).dataId, not self.__inDrag)
  end
end

FmtHeroEntity.__GetInfoPos = function(self)
  -- function num : 0_2 , upvalues : _ENV, infoPosOffset
  local pos = UIManager:World2UIPosition((self.transform).position + infoPosOffset, nil, nil, self.camera)
  return pos
end

FmtHeroEntity.__UpdateInfoPos = function(self)
  -- function num : 0_3
  if self.fmtWindow ~= nil then
    (self.fmtWindow):UpdateFmtHeroInfo(self.heroData, self:__GetInfoPos(), true)
  end
end

FmtHeroEntity.UpdateFmtHeroEntityHeadInfo = function(self)
  -- function num : 0_4
  if self.fmtWindow ~= nil then
    (self.fmtWindow):UpdateFmtHeroInfo(self.heroData, self:__GetInfoPos())
  end
end

FmtHeroEntity.DragHeroEndTweenHeroDetailItem = function(self, position)
  -- function num : 0_5 , upvalues : _ENV
  if self.__updateInfoPosFunc == nil then
    self.__updateInfoPosFunc = BindCallback(self, self.__UpdateInfoPos)
  end
  self:__ClearDragHeroEndTween()
  self.__dragEndTween = ((self.transform):DOMove(position, 0.1)):OnUpdate(self.__updateInfoPosFunc)
end

FmtHeroEntity.SetFmtHeroEntityPos = function(self, position)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.transform).position = position
  self:__UpdateInfoPos()
end

FmtHeroEntity.__ClearDragHeroEndTween = function(self)
  -- function num : 0_7
  if self.__dragEndTween ~= nil then
    (self.__dragEndTween):Kill()
    self.__dragEndTween = nil
  end
end

FmtHeroEntity.GetFmtHeroEntityData = function(self)
  -- function num : 0_8
  return self.heroData
end

FmtHeroEntity.OnDelete = function(self)
  -- function num : 0_9 , upvalues : _ENV
  (self.resloader):Put2Pool()
  self.resloader = nil
  self.isDeleted = true
  local fmtWindow = UIManager:GetWindow(UIWindowTypeID.Formation)
  if fmtWindow ~= nil then
    fmtWindow:ReturnFmtHeroInfo((self.heroData).dataId)
  end
  self:__ClearDragHeroEndTween()
  DestroyUnityObject(self.gameObject)
end

return FmtHeroEntity

-- params : ...
-- function num : 0 , upvalues : _ENV
local FmtHeroEntity = class("FmtHeroEntity")
local CS_ResLoader = CS.ResLoader
local infoPosOffset = (Vector3.New)(0, 1.1, 0)
FmtHeroEntity.InitFmtHeroEntity = function(self, go, heroData, camera)
    -- function num : 0_0 , upvalues : CS_ResLoader, _ENV
    self.gameObject = go
    self.transform = go.transform
    self.heroData = heroData
    self.camera = camera
    self.resloader = (CS_ResLoader.Create)()
    local modelPath = PathConsts:GetCharacterModelPrefabPath(
                          heroData:GetResName())
    local coroutineFunc = function()
        -- function num : 0_0_0 , upvalues : self, modelPath, _ENV
        if self.isDeleted then return end
        local modelWait = (self.resloader):LoadABAssetAsyncAwait(modelPath);
        (coroutine.yield)(modelWait)
        if self.isDeleted then return end
        self.heroGo = (modelWait.Result):Instantiate(self.transform) -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'
        ;
        ((self.heroGo).transform).localEulerAngles = (Vector3.New)(0, 180, 0)
        self.animator = (self.heroGo):FindComponent(eUnityComponentID.Animator);
        (self.animator):SetBool("InFormation", true)
        self:FmtHeroOnDrag(self.__inDrag)
    end

    self.fmtWindow = UIManager:GetWindow(UIWindowTypeID.Formation)
    if self.fmtWindow ~= nil then
        (self.fmtWindow):CreatFmtHeroInfo(self.heroData, self:__GetInfoPos())
    end
    return coroutineFunc
end

FmtHeroEntity.FmtHeroOnDrag = function(self, drag)
    -- function num : 0_1 , upvalues : _ENV
    self.__inDrag = drag or false
    if IsNull(self.animator) then return end
    (self.animator):SetBool("DeployFloat", self.__inDrag)
    if self.fmtWindow ~= nil then
        (self.fmtWindow):ShowFmtHeroInfo((self.heroData).dataId,
                                         not self.__inDrag)
    end
end

FmtHeroEntity.__GetInfoPos = function(self)
    -- function num : 0_2 , upvalues : _ENV, infoPosOffset
    local pos = UIManager:World2UIPosition(
                    (self.transform).position + infoPosOffset, nil, nil,
                    self.camera)
    return pos
end

FmtHeroEntity.__UpdateInfoPos = function(self)
    -- function num : 0_3
    if self.fmtWindow ~= nil then
        (self.fmtWindow):UpdateFmtHeroInfo(self.heroData, self:__GetInfoPos(),
                                           true)
    end
end

FmtHeroEntity.UpdateFmtHeroEntityHeadInfo =
    function(self)
        -- function num : 0_4
        if self.fmtWindow ~= nil then
            (self.fmtWindow):UpdateFmtHeroInfo(self.heroData,
                                               self:__GetInfoPos())
        end
    end

FmtHeroEntity.DragHeroEndTweenHeroDetailItem =
    function(self, position)
        -- function num : 0_5 , upvalues : _ENV
        if self.__updateInfoPosFunc == nil then
            self.__updateInfoPosFunc = BindCallback(self, self.__UpdateInfoPos)
        end
        self:__ClearDragHeroEndTween()
        self.__dragEndTween = ((self.transform):DOMove(position, 0.1)):OnUpdate(
                                  self.__updateInfoPosFunc)
    end

FmtHeroEntity.SetFmtHeroEntityPos = function(self, position)
    -- function num : 0_6
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

    (self.transform).position = position
    self:__UpdateInfoPos()
end

FmtHeroEntity.__ClearDragHeroEndTween = function(self)
    -- function num : 0_7
    if self.__dragEndTween ~= nil then
        (self.__dragEndTween):Kill()
        self.__dragEndTween = nil
    end
end

FmtHeroEntity.GetFmtHeroEntityData = function(self)
    -- function num : 0_8
    return self.heroData
end

FmtHeroEntity.OnDelete = function(self)
    -- function num : 0_9 , upvalues : _ENV
    (self.resloader):Put2Pool()
    self.resloader = nil
    self.isDeleted = true
    local fmtWindow = UIManager:GetWindow(UIWindowTypeID.Formation)
    if fmtWindow ~= nil then
        fmtWindow:ReturnFmtHeroInfo((self.heroData).dataId)
    end
    self:__ClearDragHeroEndTween()
    DestroyUnityObject(self.gameObject)
end

return FmtHeroEntity


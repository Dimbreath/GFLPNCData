local UINStOTechItem = class("UINStOTechItem", UIBaseNode)
local base = UIBaseNode
local BuildingEnum = require("Game.Oasis.Data.BuildingEnum")
UINStOTechItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self._OnClickRoot)
  ;
  ((self.ui).obj_CanLevelUp):SetActive(false)
end

UINStOTechItem.InitStOTechItem = function(self, buildingData, resLoader, stOList, edge)
  -- function num : 0_1 , upvalues : _ENV, BuildingEnum
  self.stOList = stOList
  self.edge = edge
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).enabled = false
  resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("SectorBuilding"), function(spriteAtlas)
    -- function num : 0_1_0 , upvalues : self, buildingData
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = spriteAtlas:GetSprite(buildingData.icon_res)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).enabled = true
  end
)
  self:RefreshStOTechItemData(buildingData)
  ;
  (self.edge):InitEdge(self)
  local isUseRedTip = self.edge ~= nil and (self.edge):GetEdgeType() == (BuildingEnum.TechItemEdgeType).RewardEdge
  ;
  ((self.ui).redDot):SetActive(isUseRedTip)
  ;
  ((self.ui).obj_TypeLevelUp):SetActive(not isUseRedTip)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINStOTechItem.InitStOTechItemLine = function(self)
  -- function num : 0_2
  self:_RefreshLine()
end

UINStOTechItem._RefreshLine = function(self)
  -- function num : 0_3
  local valid = self:IsBuildOrUnlock()
  ;
  (self.stOList):RefreshLine(self, valid)
end

UINStOTechItem.IsBuildOrUnlock = function(self)
  -- function num : 0_4
  if not (self.buildingData).isBuild then
    return ((self.buildingData).dynData):Unlock()
  end
end

UINStOTechItem.RefreshStOTechItemData = function(self, buildingData)
  -- function num : 0_5
  self.buildingData = buildingData
  self:RefreshStOTechItem()
end

UINStOTechItem.RefreshStOTechItem = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local buildingData = self.buildingData
  ;
  ((self.ui).level):SetActive(true)
  self:_RefreshLine()
  ;
  ((self.ui).tex_Level):SetIndex(0, tostring(buildingData.level or 0), tostring(buildingData.maxLevel))
  local unlock = (buildingData.dynData):Unlock()
  self:_RefreshLock(unlock)
  if buildingData.isBuild then
    self:_RefreshLevelUp(buildingData:CanUpgrade())
  else
    if unlock then
      local canBuild = (buildingData.dynData):CanBuild()
      self:_RefreshLevelUp(canBuild)
    else
      do
        ;
        ((self.ui).level):SetActive(false)
        if not buildingData.level then
          (self.edge):SetState(self.edge == nil or 0, unlock)
        end
      end
    end
  end
end

UINStOTechItem._RefreshLock = function(self, unlock)
  -- function num : 0_7 , upvalues : _ENV
  -- DECOMPILER ERROR at PC13: Unhandled construct in 'MakeBoolean' P1

  do
    if self.edge == nil or not (self.edge):GetEdgeType() then
      local edgeType = not unlock or self.lockGo == nil or nil
    end
    ;
    (self.stOList):ReturnStOTechLock((self.edge):GetEdgeType(), self.lockGo)
    self.lockGo = nil
    if self.edge == nil or not (self.edge):GetEdgeType() then
      local edgeType = self.lockGo ~= nil or nil
    end
    local lockGo = (self.stOList):GetStOTechLock(edgeType)
    ;
    (lockGo.transform):SetParent(((self.ui).scaleGroup).transform)
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (lockGo.transform).localPosition = Vector2.zero
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (lockGo.transform).localScale = Vector3.one
    ;
    (lockGo.transform):SetAsLastSibling()
    self.lockGo = lockGo
  end
end

UINStOTechItem._RefreshLevelUp = function(self, canLevelup)
  -- function num : 0_8 , upvalues : _ENV
  ((self.ui).obj_CanLevelUp):SetActive(canLevelup)
  -- DECOMPILER ERROR at PC25: Unhandled construct in 'MakeBoolean' P1

  if canLevelup and self._arrowTween == nil then
    self._arrowTween = (((self.ui).arrow):DOPunchPosition((Vector3.New)(0, 6, 0), 1, 1)):SetLoops(-1)
  end
  self:_ClearArrowTween()
end

UINStOTechItem._ClearArrowTween = function(self)
  -- function num : 0_9
  if self._arrowTween ~= nil then
    (self._arrowTween):Rewind()
    ;
    (self._arrowTween):Kill()
    self._arrowTween = nil
  end
end

UINStOTechItem._OnClickRoot = function(self)
  -- function num : 0_10
  (self.stOList):SelectStOTechItem(self, self.buildingData)
end

UINStOTechItem.GetStOTechItemUpPointPos = function(self)
  -- function num : 0_11
  local pos = nil
  if self.edge ~= nil then
    pos = (self.transform).anchoredPosition + (self.edge):GetUpPointPos()
  else
    pos = (self.transform).anchoredPosition + ((self.ui).upPoint).anchoredPosition
  end
  return pos
end

UINStOTechItem.GetStOTechItemDownPointPos = function(self)
  -- function num : 0_12
  local pos = nil
  if self.edge ~= nil then
    pos = (self.transform).anchoredPosition + (self.edge):GetDownPointPos()
  else
    pos = (self.transform).anchoredPosition + ((self.ui).downPoint).anchoredPosition
  end
  return pos
end

UINStOTechItem.GetSelectObjParent = function(self)
  -- function num : 0_13
  local selectRoot = nil
  if self.edge ~= nil then
    selectRoot = (self.edge):TryGetFxRoot()
  end
  if selectRoot == nil then
    selectRoot = ((self.ui).scaleGroup).gameObject
  end
  return selectRoot
end

UINStOTechItem.OnDelete = function(self)
  -- function num : 0_14 , upvalues : base
  self:_ClearArrowTween()
  ;
  (base.OnDelete)(self)
end

return UINStOTechItem


-- params : ...
-- function num : 0 , upvalues : _ENV
local UINStOTechItem = class("UINStOTechItem", UIBaseNode)
local base = UIBaseNode
UINStOTechItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self._OnClickRoot)
end

UINStOTechItem.InitStOTechItem = function(self, buildingData, resLoader, stOList)
  -- function num : 0_1 , upvalues : _ENV
  self.stOList = stOList
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'

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
end

UINStOTechItem.InitStOTechItemLine = function(self, lineItem)
  -- function num : 0_2 , upvalues : _ENV
  self.lineItem = lineItem
  ;
  (lineItem.transform):SetParent((self.ui).upPoint)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (lineItem.transform).anchoredPosition = Vector2.zero
  if not (self.buildingData).isBuild then
    self:_RefreshLine(((self.buildingData).dynData):Unlock())
  end
end

UINStOTechItem._RefreshLine = function(self, valid)
  -- function num : 0_3
  if self.lineItem == nil then
    return 
  end
  ;
  (self.lineItem):RefreshStOTechLineItem(valid)
end

UINStOTechItem.RefreshStOTechItemData = function(self, buildingData)
  -- function num : 0_4
  self.buildingData = buildingData
  self:RefreshStOTechItem()
end

UINStOTechItem.RefreshStOTechItem = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local buildingData = self.buildingData
  ;
  ((self.ui).level):SetActive(true)
  self:_RefreshLine(true)
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
        self:_RefreshLine(false)
      end
    end
  end
end

UINStOTechItem._RefreshLock = function(self, unlock)
  -- function num : 0_6 , upvalues : _ENV
  -- DECOMPILER ERROR at PC8: Unhandled construct in 'MakeBoolean' P1

  if unlock and self.lockGo ~= nil then
    (self.stOList):ReturnStOTechLock(self.lockGo)
    self.lockGo = nil
  end
  if self.lockGo == nil then
    local lockGo = (self.stOList):GetStOTechLock()
    ;
    (lockGo.transform):SetParent(self.transform)
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (lockGo.transform).localPosition = Vector2.zero
    self.lockGo = lockGo
  end
end

UINStOTechItem._RefreshLevelUp = function(self, canLevelup)
  -- function num : 0_7 , upvalues : _ENV
  ((self.ui).obj_CanLevelUp):SetActive(canLevelup)
  -- DECOMPILER ERROR at PC25: Unhandled construct in 'MakeBoolean' P1

  if canLevelup and self._arrowTween == nil then
    self._arrowTween = (((self.ui).arrow):DOPunchPosition((Vector3.New)(0, 6, 0), 1, 1)):SetLoops(-1)
  end
  self:_ClearArrowTween()
end

UINStOTechItem._ClearArrowTween = function(self)
  -- function num : 0_8
  if self._arrowTween ~= nil then
    (self._arrowTween):Rewind()
    ;
    (self._arrowTween):Kill()
    self._arrowTween = nil
  end
end

UINStOTechItem._OnClickRoot = function(self)
  -- function num : 0_9
  (self.stOList):SelectStOTechItem((self.transform).anchoredPosition, self.buildingData)
end

UINStOTechItem.GetStOTechItemUpPointPos = function(self)
  -- function num : 0_10
  return (self.transform).anchoredPosition + ((self.ui).upPoint).anchoredPosition
end

UINStOTechItem.GetStOTechItemDownPointPos = function(self)
  -- function num : 0_11
  return (self.transform).anchoredPosition + ((self.ui).downPoint).anchoredPosition
end

UINStOTechItem.OnDelete = function(self)
  -- function num : 0_12 , upvalues : base
  self:_ClearArrowTween()
  ;
  (base.OnDelete)(self)
end

return UINStOTechItem


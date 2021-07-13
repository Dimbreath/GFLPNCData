-- params : ...
-- function num : 0 , upvalues : _ENV
local UINStOList = class("UINStOList", UIBaseNode)
local base = UIBaseNode
local UINStOSectorItem = require("Game.StrategyOverview.UI.StOList.UINStOSectorItem")
local UINStOTechItem = require("Game.StrategyOverview.UI.StOList.UINStOTechItem")
local UINStOTechLineItem = require("Game.StrategyOverview.UI.StOList.UINStOTechLineItem")
UINStOList.ctor = function(self, uiStO)
  -- function num : 0_0
  self.uiStO = uiStO
end

UINStOList.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, UINStOSectorItem, UINStOTechItem, UINStOTechLineItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).chessLayout).enabled = false
  ;
  ((self.ui).techTreeSectorItem):SetActive(false)
  self.sectorItemPool = (UIItemPool.New)(UINStOSectorItem, (self.ui).techTreeSectorItem)
  ;
  ((self.ui).fX_LevelUp):SetActive(false)
  ;
  ((self.ui).techItem):SetActive(false)
  self.techItemPool = (UIItemPool.New)(UINStOTechItem, (self.ui).techItem)
  self.techLinePool = (UIItemPool.New)(UINStOTechLineItem, (self.ui).obj_Line)
  self.lockGoList = {}
end

UINStOList.InitStOList = function(self, resLoader, techDataList)
  -- function num : 0_2 , upvalues : _ENV
  self.resLoader = resLoader
  ;
  ((self.ui).tex_SectorLock):SetIndex(0, tostring((ConfigData.sector).maxSectorId + 1))
  for k,sectorId in ipairs((ConfigData.sector).id_sort_list) do
    local sectorItem = (self.sectorItemPool):GetOne()
    sectorItem:InitStOSectorItem(R11_PC24, resLoader)
    -- DECOMPILER ERROR at PC29: Overwrote pending register: R11 in 'AssignReg'

    sectorItem:SetBgImageColor(R11_PC24)
  end
  self.techItemDic = {}
  for k,techData in ipairs(techDataList) do
    -- DECOMPILER ERROR at PC42: Overwrote pending register: R11 in 'AssignReg'

    -- DECOMPILER ERROR at PC43: Overwrote pending register: R11 in 'AssignReg'

    -- DECOMPILER ERROR at PC44: Overwrote pending register: R11 in 'AssignReg'

    -- DECOMPILER ERROR at PC45: Overwrote pending register: R11 in 'AssignReg'

    local pos = self:_GetTechItemPos(techData.sectorId, R11_PC24)
    local buildingData = techData.buildingData
    -- DECOMPILER ERROR at PC49: Overwrote pending register: R11 in 'AssignReg'

    local techItem = (self.techItemPool):GetOne()
    -- DECOMPILER ERROR at PC51: Overwrote pending register: R11 in 'AssignReg'

    R11_PC24.name = tostring(k)
    -- DECOMPILER ERROR at PC56: Overwrote pending register: R11 in 'AssignReg'

    R11_PC24(techItem, buildingData, resLoader, self)
    -- DECOMPILER ERROR at PC61: Overwrote pending register: R11 in 'AssignReg'

    R11_PC24.anchoredPosition = pos
    -- DECOMPILER ERROR at PC63: Overwrote pending register: R11 in 'AssignReg'

    R11_PC24[buildingData.id] = techItem
    -- DECOMPILER ERROR at PC66: Overwrote pending register: R11 in 'AssignReg'

    -- DECOMPILER ERROR at PC69: Overwrote pending register: R11 in 'AssignReg'

    if R11_PC24 then
      R11_PC24(self, pos, techData.buildingData)
    end
    -- DECOMPILER ERROR at PC73: Overwrote pending register: R11 in 'AssignReg'

    -- DECOMPILER ERROR at PC74: Overwrote pending register: R11 in 'AssignReg'

    R11_PC24 = R11_PC24(R11_PC24, 1)
    local preBuildingId = nil
    if preBuildingId ~= nil then
      local preTechItem = (self.techItemDic)[preBuildingId]
      local startPos = techItem:GetStOTechItemUpPointPos()
      local endPos = preTechItem:GetStOTechItemDownPointPos()
      local lineItem = (self.techLinePool):GetOne()
      lineItem:InitStOTechLineItem(startPos, endPos)
      techItem:InitStOTechItemLine(lineItem)
    end
  end
  ;
  (((self.ui).chessLayout).transform):SetAsLastSibling()
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UINStOList._GetTechItemPos = function(self, sectorId, posIndex)
  -- function num : 0_3 , upvalues : _ENV
  if posIndex == 6 then
    posIndex = 1
  else
    posIndex = posIndex + 1
  end
  local padding = ((self.ui).chessLayout).padding
  local cellSize = ((self.ui).chessLayout).cellSize
  local spacing = ((self.ui).chessLayout).spacing
  local x = padding.left + (posIndex - 0.5) * cellSize.x + spacing.x * (posIndex - 1)
  local y = (padding.top + (sectorId - 0.5) * cellSize.y + spacing.y * (sectorId - 1)) * -1
  return (Vector2.New)(x, y)
end

UINStOList.GetStOTechLock = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local lockGo = nil
  if #self.lockGoList > 0 then
    lockGo = (table.remove)(self.lockGoList)
  else
    lockGo = ((self.ui).obj_IsLock):Instantiate()
  end
  return lockGo
end

UINStOList.ReturnStOTechLock = function(self, lockGo)
  -- function num : 0_5 , upvalues : _ENV
  (lockGo.transform):SetParent((self.ui).prefabPool)
  ;
  (table.insert)(self.lockGoList, lockGo)
end

UINStOList.SelectStOTechItem = function(self, position, buildingData)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).obj_OnSelelct).anchoredPosition = position
  ;
  (self.uiStO):ShowStOTechSide(buildingData)
end

UINStOList.OnBuildUpgradeStOList = function(self, buildingData)
  -- function num : 0_7
  self:RefreshAllStOListTech(buildingData)
  local techItem = (self.techItemDic)[buildingData.id]
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  if techItem ~= nil then
    (((self.ui).fX_LevelUp).transform).position = (techItem.transform).position
    ;
    (((self.ui).fX_LevelUp).transform):SetAsLastSibling()
    ;
    ((self.ui).fX_LevelUp):SetActive(false)
    ;
    ((self.ui).fX_LevelUp):SetActive(true)
  end
end

UINStOList.RefreshAllStOListTech = function(self, buildingData)
  -- function num : 0_8 , upvalues : _ENV
  for k,techItem in pairs(self.techItemDic) do
    if buildingData ~= nil and (techItem.buildingData).id == buildingData.id then
      techItem:RefreshStOTechItemData(buildingData)
    else
      techItem:RefreshStOTechItem()
    end
  end
end

UINStOList.OnDelete = function(self)
  -- function num : 0_9 , upvalues : base
  (self.sectorItemPool):DeleteAll()
  ;
  (self.techItemPool):DeleteAll()
  ;
  (self.techLinePool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINStOList


local UINStioListBase = require("Game.StrategyOverview.UI.UINStioListBase")
local UINStOList = class("UINStOList", UINStioListBase)
local base = UINStioListBase
local UINStOSectorItem = require("Game.StrategyOverview.UI.StOList.UINStOSectorItem")
local UINStOTechItem = require("Game.StrategyOverview.UI.StOList.UINStOTechItem")
local UINStOTechLineItem = require("Game.StrategyOverview.UI.StOList.UINStOTechLineItem")
UINStOList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINStOSectorItem, UINStOTechItem, UINStOTechLineItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).chessLayout).enabled = false
  ;
  ((self.ui).techTreeSectorItem):SetActive(false)
  self.sectorItemPool = (UIItemPool.New)(UINStOSectorItem, (self.ui).techTreeSectorItem)
  self.techItemPool = (UIItemPool.New)(UINStOTechItem, (self.prefabUITable).prefab_techItem)
  self.techLinePool = (UIItemPool.New)(UINStOTechLineItem, (self.prefabUITable).prefab_obj_Line)
end

UINStOList.InitStOList = function(self, resLoader, techDataList)
  -- function num : 0_1 , upvalues : _ENV
  self.isInit = true
  self.resLoader = resLoader
  if (CS.ClientConsts).IsAudit then
    ((self.ui).lock):SetActive(false)
  end
  ;
  ((self.ui).tex_SectorLock):SetIndex(0, tostring((ConfigData.sector).maxSectorId + 1))
  for k,sectorId in ipairs((ConfigData.sector).id_sort_list) do
    local sectorItem = (self.sectorItemPool):GetOne()
    sectorItem:InitStOSectorItem(R11_PC35, resLoader)
    -- DECOMPILER ERROR at PC40: Overwrote pending register: R11 in 'AssignReg'

    sectorItem:SetBgImageColor(R11_PC35)
  end
  self:ResetTechItemDic()
  self.lineDic = {}
  for k,techData in ipairs(techDataList) do
    -- DECOMPILER ERROR at PC55: Overwrote pending register: R11 in 'AssignReg'

    -- DECOMPILER ERROR at PC56: Overwrote pending register: R11 in 'AssignReg'

    -- DECOMPILER ERROR at PC57: Overwrote pending register: R11 in 'AssignReg'

    -- DECOMPILER ERROR at PC58: Overwrote pending register: R11 in 'AssignReg'

    local pos = self:_GetTechItemPos(techData.sectorId, R11_PC35)
    local buildingData = techData.buildingData
    -- DECOMPILER ERROR at PC62: Overwrote pending register: R11 in 'AssignReg'

    local techItem = (self.techItemPool):GetOne()
    -- DECOMPILER ERROR at PC64: Overwrote pending register: R11 in 'AssignReg'

    -- DECOMPILER ERROR at PC65: Overwrote pending register: R11 in 'AssignReg'

    R11_PC35(R11_PC35, ((self.ui).chessLayout).transform)
    -- DECOMPILER ERROR at PC70: Overwrote pending register: R11 in 'AssignReg'

    R11_PC35.name = tostring(k)
    -- DECOMPILER ERROR at PC75: Overwrote pending register: R11 in 'AssignReg'

    R11_PC35 = R11_PC35(self, buildingData)
    local edge = nil
    techItem:InitStOTechItem(buildingData, resLoader, self, edge)
    -- DECOMPILER ERROR at PC85: Confused about usage of register: R12 in 'UnsetPending'

    ;
    (techItem.transform).anchoredPosition = pos
    self:AddTechItem(buildingData.id, techItem)
    if techData.selected then
      self:SelectStOTechItem(techItem, techData.buildingData)
    end
    local preBuildingId = ((buildingData.dynData):GetPreBuildingId(1))[1]
    if preBuildingId ~= nil then
      local preTechItem = self:GetTechItem(preBuildingId)
      local startPos = techItem:GetStOTechItemUpPointPos()
      local endPos = preTechItem:GetStOTechItemDownPointPos()
      local lineItem = (self.techLinePool):GetOne()
      lineItem:InitStOTechLineItem(startPos, endPos)
      -- DECOMPILER ERROR at PC119: Confused about usage of register: R17 in 'UnsetPending'

      ;
      (self.lineDic)[techItem] = lineItem
      ;
      (lineItem.transform):SetParent(((self.ui).lineObj).transform)
      -- DECOMPILER ERROR at PC132: Confused about usage of register: R17 in 'UnsetPending'

      ;
      (lineItem.transform).anchoredPosition = (Vector2.New)(startPos.x, startPos.y)
      techItem:InitStOTechItemLine()
    end
  end
  ;
  (((self.ui).chessLayout).transform):SetAsLastSibling()
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UINStOList._GetTechItemPos = function(self, sectorId, posIndex)
  -- function num : 0_2 , upvalues : _ENV
  if posIndex == 5 then
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

UINStOList.RefreshLine = function(self, techItem, valid)
  -- function num : 0_3
  if (self.lineDic)[techItem] ~= nil then
    ((self.lineDic)[techItem]):RefreshStOTechLineItem(valid)
  end
end

UINStOList.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (self.sectorItemPool):DeleteAll()
  ;
  (self.techItemPool):DeleteAll()
  ;
  (self.techLinePool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINStOList


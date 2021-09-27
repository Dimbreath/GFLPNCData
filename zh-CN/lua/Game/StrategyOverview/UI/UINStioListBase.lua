local UINStioListBase = class("UINStioListBase", UIBaseNode)
local base = UIBaseNode
UINStioListBase.ctor = function(self, uiStO, prefabUITable)
  -- function num : 0_0
  self.uiStO = uiStO
  self.prefabUITable = prefabUITable
  self.techItemDic = {}
end

UINStioListBase.AddTechItem = function(self, id, techItem)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.techItemDic)[id] = techItem
end

UINStioListBase.GetTechItem = function(self, id)
  -- function num : 0_2
  return (self.techItemDic)[id]
end

UINStioListBase.ResetTechItemDic = function(self)
  -- function num : 0_3
  self.techItemDic = {}
end

UINStioListBase.GetStOTechLock = function(self, edgeType)
  -- function num : 0_4
  return (self.uiStO):GetStOTechLock(edgeType)
end

UINStioListBase.ReturnStOTechLock = function(self, edgeType, lockGo)
  -- function num : 0_5
  (self.uiStO):ReturnStOTechLock(edgeType, lockGo)
end

UINStioListBase.SelectStOTechItem = function(self, techItem, buildingData)
  -- function num : 0_6
  (self.uiStO):SelectStOTechItem(techItem:GetSelectObjParent(), buildingData)
  self.lastSelectTech = techItem
end

UINStioListBase.GetTechItemEdge = function(self, buildingData)
  -- function num : 0_7 , upvalues : _ENV
  local buildCfg = (ConfigData.building)[buildingData.id]
  return (self.uiStO):GetTechItemEdge(buildCfg.nodeType)
end

UINStioListBase.OnBuildUpgradeStOList = function(self, buildingData)
  -- function num : 0_8 , upvalues : _ENV
  self:RefreshAllStOListTech(buildingData)
  local techItem = (self.techItemDic)[buildingData.id]
  if techItem ~= nil then
    local fX_LevelUp = (self.uiStO):GetFX_LevelUp()
    ;
    (fX_LevelUp.transform):SetParent((techItem.gameObject).transform)
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (fX_LevelUp.transform).localPosition = Vector3.zero
    fX_LevelUp:SetActive(false)
    fX_LevelUp:SetActive(true)
  end
end

UINStioListBase.RefreshAllStOListTech = function(self, buildingData)
  -- function num : 0_9 , upvalues : _ENV
  for k,techItem in pairs(self.techItemDic) do
    if buildingData ~= nil and (techItem.buildingData).id == buildingData.id then
      techItem:RefreshStOTechItemData(buildingData)
    else
      techItem:RefreshStOTechItem()
    end
  end
end

UINStioListBase.EnterStOList = function(self)
  -- function num : 0_10 , upvalues : _ENV
  self:RefreshAllStOListTech()
  local selectItem = self.lastSelectTech
  if selectItem == nil then
    local tempPos = nil
    for k,techItem in pairs(self.techItemDic) do
      local comparePos = ((techItem.gameObject).transform).localPosition
      if tempPos == nil or comparePos.x < tempPos.x and tempPos.y < comparePos.y then
        tempPos = comparePos
        selectItem = techItem
      end
    end
  end
  do
    self:SelectStOTechItem(selectItem, selectItem.buildingData)
  end
end

UINStioListBase.RefreshLine = function(self, techItem, valid)
  -- function num : 0_11
end

return UINStioListBase


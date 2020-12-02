-- params : ...
-- function num : 0 , upvalues : _ENV
local UINSectorBuildingGroup = class("UINSectorBuildingGroup", UIBaseNode)
local base = UIBaseNode
local BuildingItem = require("Game.Sector.Building.UISectorBuildingItem")
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
UINSectorBuildingGroup.ctor = function(self, sctBuilding)
  -- function num : 0_0
  self.sctBuilding = sctBuilding
end

UINSectorBuildingGroup.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).buildingItem):SetActive(false)
end

UINSectorBuildingGroup.InitSctBuildGroup = function(self, buildingIdList, buildType, resloader, clickItemFunc)
  -- function num : 0_2 , upvalues : BuildingBelong, _ENV, BuildingItem
  ;
  ((self.ui).tex_Tile):SetIndex(buildType == (BuildingBelong.SectorType).production and 0 or 1)
  self.groupBuildItems = {}
  for _,id in ipairs(buildingIdList) do
    local data = ((PlayerDataCenter.AllBuildingData).sectorBuilt)[id]
    local built = true
    if data == nil then
      data = ((PlayerDataCenter.AllBuildingData).unbuilt)[id]
      built = false
    end
    if data == nil then
      error("未找到该扇区建筑的数据：id=" .. tostring(id))
    else
      local go = ((self.ui).buildingItem):Instantiate()
      go:SetActive(true)
      go.name = tostring(id)
      local item = (BuildingItem.New)()
      item:Init(go)
      item:InitSectorBdItem(data, built, resloader)
      item.OnClickEvent = clickItemFunc
      -- DECOMPILER ERROR at PC63: Confused about usage of register: R14 in 'UnsetPending'

      ;
      (self.groupBuildItems)[id] = item
      ;
      (self.sctBuilding):AddSctBuildItem(id, item)
    end
  end
end

UINSectorBuildingGroup.OnDelete = function(self)
  -- function num : 0_3 , upvalues : _ENV, base
  for k,v in pairs(self.groupBuildItems) do
    v:Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UINSectorBuildingGroup


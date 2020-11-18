-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBuildingQueueNewItem = class("UIBuildingQueueNewItem", UIBaseNode)
local base = UIBaseNode
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
local state = {none = 0, unfinish = 1, finished = 2}
UIBuildingQueueNewItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : state, _ENV
  self.state = state.none
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_queueItem, self, self.FocusOnBuilding)
end

UIBuildingQueueNewItem.UpdateQueueProgress = function(self, buildData, sectorName)
  -- function num : 0_1 , upvalues : _ENV, state
  self.buildData = buildData
  local name = buildData.name
  local time = buildData.remainSecond
  if sectorName == nil then
    ((self.ui).texInfo_buildingName):SetIndex(0, name)
  else
    ;
    ((self.ui).texInfo_buildingName):SetIndex(1, (LanguageUtil.GetLocaleText)(sectorName), name)
  end
  if time > 0 then
    ((self.ui).texInfo_state):SetIndex(1, TimestampToTime(time))
    if self.state ~= state.unfinish then
      ((self.ui).image_orangeBackground):SetActive(false)
      -- DECOMPILER ERROR at PC45: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).image_icon).color = Color.white
      -- DECOMPILER ERROR at PC50: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).tex_buildingName).color = Color.white
      -- DECOMPILER ERROR at PC55: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).tex_state).color = Color.white
      self.state = state.unfinish
    end
  else
    if self.state ~= state.finished then
      ((self.ui).texInfo_state):SetIndex(0)
      ;
      ((self.ui).image_orangeBackground):SetActive(true)
      -- DECOMPILER ERROR at PC77: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).image_icon).color = (self.ui).color_orange
      -- DECOMPILER ERROR at PC82: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).tex_buildingName).color = (self.ui).color_orange
      -- DECOMPILER ERROR at PC87: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).tex_state).color = (self.ui).color_orange
      self.state = state.finished
    end
  end
end

UIBuildingQueueNewItem.FocusOnBuilding = function(self)
  -- function num : 0_2 , upvalues : BuildingBelong, _ENV
  if self.buildData == nil then
    return 
  end
  if (self.buildData).belong == BuildingBelong.Sector then
    (ControllerManager:GetController(ControllerTypeId.SectorController, false)):StartBuildFocusEnter((self.buildData).sectorId)
  else
    if (self.buildData).belong == BuildingBelong.Oasis then
      (ControllerManager:GetController(ControllerTypeId.OasisController, false)):BuildingUpgrade((self.buildData).id, true)
    end
  end
end

UIBuildingQueueNewItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UIBuildingQueueNewItem


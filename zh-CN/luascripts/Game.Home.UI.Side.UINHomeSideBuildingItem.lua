-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHomeSideBuildingItem = class("UINHomeSideBuildingItem", UIBaseNode)
local base = UIBaseNode
local JumpManager = require("Game.Jump.JumpManager")
UINHomeSideBuildingItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_buildingItem, self, self.OnClick)
end

UINHomeSideBuildingItem.RefreshBuildingItem = function(self, buildData, isSector)
  -- function num : 0_1 , upvalues : _ENV
  if self.buildData ~= buildData then
    self.buildData = buildData
    self.isSector = isSector
    local name = buildData.name
    local sectorName = buildData:GetSectorName()
    if sectorName == nil then
      ((self.ui).textName):SetIndex(0, name)
    else
      ;
      ((self.ui).textName):SetIndex(1, sectorName, name)
    end
  end
  do
    local time = buildData.remainSecond
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R4 in 'UnsetPending'

    if time > 0 then
      ((self.ui).textTime).text = TimestampToTime(time)
      ;
      ((self.ui).complete):SetActive(false)
    else
      ;
      ((self.ui).complete):SetActive(true)
    end
  end
end

UINHomeSideBuildingItem.OnClick = function(self)
  -- function num : 0_2 , upvalues : JumpManager
  if self.isSector then
    JumpManager:Jump((JumpManager.eJumpTarget).SectorBuilding, nil, {(self.buildData).sectorId})
  else
    JumpManager:Jump((JumpManager.eJumpTarget).OasisBuilding, nil, {(self.buildData).id})
  end
end

UINHomeSideBuildingItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINHomeSideBuildingItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHomeSideBuildingItem = class("UINHomeSideBuildingItem", UIBaseNode)
local base = UIBaseNode
local JumpManager = require("Game.Jump.JumpManager")
UINHomeSideBuildingItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_buildingItem, self, self.OnClick)
end

UINHomeSideBuildingItem.RefreshBuildingItem =
    function(self, buildData, isSector)
        -- function num : 0_1 , upvalues : _ENV
        if self.buildData ~= buildData then
            self.buildData = buildData
            self.isSector = isSector
            local name = buildData.name
            local sectorName = buildData:GetSectorName()
            if sectorName == nil then
                ((self.ui).textName):SetIndex(0, name)
            else

                ((self.ui).textName):SetIndex(1, sectorName, name)
            end
        end
        do
            local time = buildData.remainSecond
            -- DECOMPILER ERROR at PC32: Confused about usage of register: R4 in 'UnsetPending'

            if time > 0 then
                ((self.ui).textTime).text = TimestampToTime(time);
                ((self.ui).complete):SetActive(false)
            else

                ((self.ui).complete):SetActive(true)
            end
        end
    end

UINHomeSideBuildingItem.OnClick = function(self)
    -- function num : 0_2 , upvalues : JumpManager
    if self.isSector then
        JumpManager:Jump((JumpManager.eJumpTarget).SectorBuilding, nil,
                         {(self.buildData).sectorId})
    else
        JumpManager:Jump((JumpManager.eJumpTarget).OasisBuilding, nil,
                         {(self.buildData).id})
    end
end

UINHomeSideBuildingItem.OnDelete = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnDelete)(self)
end

return UINHomeSideBuildingItem


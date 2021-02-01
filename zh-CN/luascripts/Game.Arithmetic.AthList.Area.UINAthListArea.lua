-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthListArea = class("UINAthListArea", UIBaseNode)
local base = UIBaseNode
local UINAthListAreaTog = require("Game.Arithmetic.AthList.Area.UINAthListAreaTog")
local UINAthScrollList = require("Game.Arithmetic.AthList.Area.UINAthScrollList")
UINAthListArea.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINAthListAreaTog, UINAthScrollList
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.__onAthListAreaSelect = BindCallback(self, self.__OnAreaSelect)
  ;
  ((self.ui).tog_AreaItem):SetActive(false)
  self.areaTogList = (UIItemPool.New)(UINAthListAreaTog, (self.ui).tog_AreaItem)
  for i = 0, (ConfigData.game_config).athSlotCount do
    local togItem = (self.areaTogList):GetOne()
    togItem:InitAthListAreaTog(i, self.__onAthListAreaSelect)
  end
  ;
  ((self.ui).selectCount):SetActive(false)
  self.athScrollList = (UINAthScrollList.New)()
  ;
  (self.athScrollList):Init((self.ui).scroll)
  ;
  (self.athScrollList):SetAthScrollListRefillFunc(BindCallback(self, self.__RefreshAthCount))
end

UINAthListArea.InitAthListArea = function(self, heroData, areaId, quality, clickItemFunc, itemStartDragFunc, resLoader, withMat, changeAreaFunc, ignoreInstalled)
  -- function num : 0_1
  self.changeAreaFunc = changeAreaFunc
  ;
  (self.athScrollList):InitAthScrollList(heroData, areaId, quality, clickItemFunc, itemStartDragFunc, resLoader, withMat, ignoreInstalled)
  local selecteTogItem = ((self.areaTogList).listItem)[(areaId or 0) + 1]
  ;
  ((self.ui).areaTogGroup):SetAllTogglesOff()
  selecteTogItem:SetAthListAreaTogIsOn()
end

UINAthListArea.SetAthListAreaMultSeletedUidDic = function(self, dic)
  -- function num : 0_2 , upvalues : _ENV
  (self.athScrollList):SetAthScrollListMultSeletedUidDic(dic)
  ;
  ((self.ui).selectCount):SetActive(true)
  ;
  ((self.ui).tex_SelectCount):SetIndex(0, tostring((table.count)(dic)))
end

UINAthListArea.__OnAreaSelect = function(self, areaId)
  -- function num : 0_3
  if areaId == 0 then
    areaId = nil
  end
  self:ChangeAthListArea(areaId)
  if self.changeAreaFunc ~= nil then
    (self.changeAreaFunc)(areaId)
  end
end

UINAthListArea.ChangeAthListArea = function(self, areaId)
  -- function num : 0_4
  (self.athScrollList):SetAthScrollListArea(areaId)
  ;
  (self.athScrollList):RefreshAthScrollListData()
  ;
  (self.athScrollList):RefillAthScrollList()
end

UINAthListArea.__RefreshAthCount = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((self.ui).tex_AthCount):SetIndex(0, tostring(#(PlayerDataCenter.allAthData):GetAllAthList()), (ConfigData.game_config).athMaxNum)
end

UINAthListArea.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (self.athScrollList):Delete()
  ;
  (self.areaTogList):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINAthListArea


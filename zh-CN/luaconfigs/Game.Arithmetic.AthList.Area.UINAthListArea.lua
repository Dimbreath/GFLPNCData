-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthListArea = class("UINAthListArea", UIBaseNode)
local base = UIBaseNode
local UINAthScrollList = require("Game.Arithmetic.AthList.Area.UINAthScrollList")
UINAthListArea.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINAthScrollList
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
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
  (self.athScrollList):InitAthScrollList(heroData, areaId, quality, clickItemFunc, itemStartDragFunc, resLoader, withMat, ignoreInstalled)
end

UINAthListArea.ShowAthListAreaSuitPartTog = function(self, show, suitId)
  -- function num : 0_2 , upvalues : _ENV
  (((self.ui).suitTogGroup).gameObject):SetActive(show)
  if not show then
    return 
  end
  if self.suitPartTogPool == nil then
    self._OnSuitPartSelectFunc = BindCallback(self, self._OnSuitPartSelect)
    ;
    ((self.ui).tog_SuitPartItem):SetActive(false)
    local UINAthListSuitPartTog = require("Game.Arithmetic.AthList.Area.UINAthListSuitPartTog")
    self.suitPartTogPool = (UIItemPool.New)(UINAthListSuitPartTog, (self.ui).tog_SuitPartItem)
  end
  do
    ;
    (self.suitPartTogPool):HideAll()
    local suitPartList = ((ConfigData.arithmetic).suitDic)[suitId]
    for partId = 0, #suitPartList do
      local suitPartTogItem = (self.suitPartTogPool):GetOne()
      suitPartTogItem:InitAthListSuitPartTog(partId, self._OnSuitPartSelectFunc)
    end
    self.suitId = suitId
    -- DECOMPILER ERROR at PC54: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).suitTogGroup).allowSwitchOff = true
    ;
    ((self.ui).suitTogGroup):SetAllTogglesOff()
    -- DECOMPILER ERROR at PC61: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).suitTogGroup).allowSwitchOff = false
    ;
    (((self.suitPartTogPool).listItem)[1]):SetAthListSuitPartTogIsOn()
  end
end

UINAthListArea.SetAthListAreaMultSeletedUidDic = function(self, dic)
  -- function num : 0_3 , upvalues : _ENV
  (self.athScrollList):SetAthScrollListMultSeletedUidDic(dic)
  ;
  ((self.ui).selectCount):SetActive(true)
  ;
  ((self.ui).tex_SelectCount):SetIndex(0, tostring((table.count)(dic)))
end

UINAthListArea._OnSuitPartSelect = function(self, suitPartId)
  -- function num : 0_4
  if suitPartId == 0 then
    suitPartId = nil
  end
  ;
  (self.athScrollList):SetAthScrollListSuitId(self.suitId, suitPartId)
  ;
  (self.athScrollList):RefreshAthScrollListData()
  ;
  (self.athScrollList):SetAthScrollListSiftFunc(nil)
  ;
  (self.athScrollList):RefillAthScrollList(nil, nil, true)
end

UINAthListArea.__RefreshAthCount = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((self.ui).tex_AthCount):SetIndex(0, tostring(#(PlayerDataCenter.allAthData):GetAllAthList()), (ConfigData.game_config).athMaxNum)
end

UINAthListArea.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (self.athScrollList):Delete()
  ;
  (base.OnDelete)(self)
end

return UINAthListArea


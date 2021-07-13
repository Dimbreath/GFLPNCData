-- params : ...
-- function num : 0 , upvalues : _ENV
local UICampFetter = class("UICampFetter", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local UINCampFetterTog = require("Game.Formation.UI.CampBond.UINCampFetterTog")
local UINCampFetterItem = require("Game.Formation.UI.CampBond.UINCampFetterItem")
UICampFetter.OnInit = function(self)
  -- function num : 0_0 , upvalues : cs_ResLoader, _ENV, UINCampFetterTog, UINCampFetterItem
  self.resloader = (cs_ResLoader.Create)()
  ;
  (UIUtil.SetTopStatus)(self, self.OnClickBack)
  ;
  ((self.ui).obj_tog_CampItem):SetActive(false)
  self.campFetterTogPool = (UIItemPool.New)(UINCampFetterTog, (self.ui).obj_tog_CampItem)
  ;
  ((self.ui).obj_bondEffDetailItem):SetActive(false)
  self.campFetterItemPool = (UIItemPool.New)(UINCampFetterItem, (self.ui).obj_bondEffDetailItem)
  self.__ShowBondDetail = BindCallback(self, self.ShowBondDetail)
end

UICampFetter.InitCampBond = function(self, campCountDic, openCampId)
  -- function num : 0_1 , upvalues : _ENV
  local campCountList = {}
  for campId,_ in pairs((ConfigData.camp_connection).fetterList) do
    local count = campCountDic[campId]
    local triggerNum = 0
    for neededHeroNum,_ in pairs((ConfigData.camp_connection)[campId]) do
      if neededHeroNum <= count then
        triggerNum = triggerNum + 1
      end
    end
    local campCount = {campId = campId, count = count, triggerNum = triggerNum}
    ;
    (table.insert)(campCountList, campCount)
  end
  ;
  (table.sort)(campCountList, function(a, b)
    -- function num : 0_1_0
    do return a.campId < b.campId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self.campFetterTogPool):HideAll()
  for index,value in ipairs(campCountList) do
    local togItem = (self.campFetterTogPool):GetOne()
    togItem:InitCampFetterTog(value.campId, value.count, value.triggerNum, self.__ShowBondDetail)
    -- DECOMPILER ERROR at PC58: Confused about usage of register: R10 in 'UnsetPending'

    -- DECOMPILER ERROR at PC58: Unhandled construct in 'MakeBoolean' P1

    if openCampId == nil and index == 1 then
      ((togItem.ui).tog_CampItem).isOn = true
    end
    -- DECOMPILER ERROR at PC65: Confused about usage of register: R10 in 'UnsetPending'

    if openCampId == value.campId then
      ((togItem.ui).tog_CampItem).isOn = true
    end
  end
end

UICampFetter.ShowBondDetail = function(self, campId, count)
  -- function num : 0_2 , upvalues : _ENV
  local campFetterList = ((ConfigData.camp_connection).fetterList)[campId]
  ;
  (self.campFetterItemPool):HideAll()
  for _,neededHeroCount in ipairs(campFetterList) do
    local detailItem = (self.campFetterItemPool):GetOne()
    detailItem:InitCampFetterItem(campId, count, neededHeroCount, self.resloader)
  end
end

UICampFetter.OnClickBack = function(self)
  -- function num : 0_3
  self:Delete()
end

UICampFetter.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (self.campFetterTogPool):DeleteAll()
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  ;
  (base.OnDelete)(self)
end

return UICampFetter


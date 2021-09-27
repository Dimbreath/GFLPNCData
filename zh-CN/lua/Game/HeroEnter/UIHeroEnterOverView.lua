local UIHeroEnterOverView = class("UIHeroEnterOverView", UIBaseWindow)
local base = UIBaseWindow
local UINHeroEnterOverViewItem = require("Game.HeroEnter.UINHeroEnterOverViewItem")
UIHeroEnterOverView.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.slotItemDic = {}
  self.curSlotList = {}
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollView).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollView).onChangeItem = BindCallback(self, self.__OnChangeItem)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.Delete)
  ;
  ((self.ui).obj_buildStationedItem):SetActive(false)
end

UIHeroEnterOverView.InitHeroEnterOverView = function(self, resloader)
  -- function num : 0_1
  self.resloader = resloader
  self:RefreshOverViewItem()
end

UIHeroEnterOverView.RefreshOverViewItem = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local num = 0
  for index,value in pairs((PlayerDataCenter.AllBuildingData).oasisBuilt) do
    if value.state ~= proto_object_BuildingState.BuildingStateCreate then
      (table.insert)(self.curSlotList, value.id)
      num = num + 1
    end
  end
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).scrollView).totalCount = num
  ;
  ((self.ui).scrollView):RefillCells()
end

UIHeroEnterOverView.__OnNewItem = function(self, go)
  -- function num : 0_3 , upvalues : UINHeroEnterOverViewItem
  local slotItem = (UINHeroEnterOverViewItem.New)()
  slotItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.slotItemDic)[go] = slotItem
end

UIHeroEnterOverView.__OnChangeItem = function(self, go, index)
  -- function num : 0_4 , upvalues : _ENV
  local slotItem = (self.slotItemDic)[go]
  if slotItem == nil then
    error("Can\'t find slotItem by gameObject")
    return 
  end
  local slotData = (self.curSlotList)[index + 1]
  if slotData == nil then
    error("Can\'t find slotData by index, index = " .. tonumber(index))
  end
  slotItem:InitOverViewItem(slotData, self.resloader)
end

UIHeroEnterOverView.OnDelete = function(self)
  -- function num : 0_5 , upvalues : _ENV, base
  UIManager:DeleteWindow(UIWindowTypeID.HeroEnterOverView)
  for _,value in pairs(self.slotItemDic) do
    value:Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UIHeroEnterOverView


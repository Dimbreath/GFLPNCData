-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthItemDetail = class("UIAthItemDetail", UIBaseWindow)
local base = UIBaseWindow
local UINAthDetailItem = require("Game.Arithmetic.AthDetail.UINAthDetailItem")
UIAthItemDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINAthDetailItem
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.__OnClickClose)
  ;
  ((self.ui).aTHDetailItem):SetActive(false)
  self.detailItemPool = (UIItemPool.New)(UINAthDetailItem, (self.ui).aTHDetailItem)
end

UIAthItemDetail.InitAthItemDetail = function(self, heroData, athData, replaceAthData)
  -- function num : 0_1 , upvalues : _ENV
  self.athData = athData
  self.replaceAthData = replaceAthData
  local isAdd = true
  if athData.bindInfo ~= nil and (athData.bindInfo).id == heroData.dataId then
    isAdd = false
  end
  ;
  (self.detailItemPool):HideAll()
  if replaceAthData == nil then
    local detailItem = (self.detailItemPool):GetOne()
    if isAdd then
      detailItem:InitAthDetailItem(self, athData, heroData, true, false)
      ;
      (detailItem.transform):SetParent((self.ui).listDetailPos)
    else
      detailItem:InitAthDetailItem(self, athData, heroData, false, false)
      ;
      (detailItem.transform):SetParent((self.ui).tableDetailPos)
    end
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (detailItem.transform).anchoredPosition = Vector2.zero
  else
    do
      local addItem = (self.detailItemPool):GetOne()
      addItem:InitAthDetailItem(self, athData, heroData, true, true)
      ;
      (addItem.transform):SetParent((self.ui).replaceDetailPos)
      -- DECOMPILER ERROR at PC70: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (addItem.transform).anchoredPosition = Vector2.zero
      local removeItem = (self.detailItemPool):GetOne()
      removeItem:InitAthDetailItem(self, replaceAthData, heroData, false, true)
      ;
      (removeItem.transform):SetParent((self.ui).listDetailPos)
      -- DECOMPILER ERROR at PC89: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (removeItem.transform).anchoredPosition = Vector2.zero
    end
  end
end

UIAthItemDetail.SetAthItemDetailFunc = function(self, installFunc, uninstallFunc, replaceFunc)
  -- function num : 0_2
  self.installFunc = installFunc
  self.uninstallFunc = uninstallFunc
  self.replaceFunc = replaceFunc
end

UIAthItemDetail.ChangeAthItemParent = function(self, athItem)
  -- function num : 0_3
  athItem:SetAthItemRootParent(self.transform)
  self.__changeParentItem = athItem
end

UIAthItemDetail.OnClickInstallAth = function(self)
  -- function num : 0_4
  if self.installFunc ~= nil then
    (self.installFunc)(self.athData)
  end
end

UIAthItemDetail.OnClickUninstallAth = function(self)
  -- function num : 0_5
  if self.uninstallFunc ~= nil then
    (self.uninstallFunc)(self.athData)
  end
end

UIAthItemDetail.OnClickReplaceAth = function(self)
  -- function num : 0_6
  if self.replaceFunc ~= nil then
    (self.replaceFunc)(self.replaceAthData, self.athData)
  end
end

UIAthItemDetail.__OnClickClose = function(self)
  -- function num : 0_7
  self:Hide()
end

UIAthItemDetail.OnHide = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self.__changeParentItem ~= nil and not IsNull((self.__changeParentItem).gameObject) then
    (self.__changeParentItem):SetAthItemRootParent(nil, true)
  end
end

UIAthItemDetail.OnDelete = function(self)
  -- function num : 0_9 , upvalues : base
  (self.detailItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UIAthItemDetail


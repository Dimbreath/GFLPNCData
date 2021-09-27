local UIAthItemDetail = class("UIAthItemDetail", UIBaseWindow)
local base = UIBaseWindow
local UINAthDetailItem = require("Game.Arithmetic.AthDetail.UINAthDetailItem")
UIAthItemDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINAthDetailItem
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.__OnClickClose)
  ;
  ((self.ui).aTHDetailItem):SetActive(false)
  self.detailItemPool = (UIItemPool.New)(UINAthDetailItem, (self.ui).aTHDetailItem)
  self.__onAthDataUpdate = BindCallback(self, self.__OnAthDataUpdate)
end

UIAthItemDetail.InitAthItemDetail = function(self, heroData, athData, replaceAthData, inAthTable)
  -- function num : 0_1 , upvalues : _ENV
  AudioManager:PlayAudioById(1072)
  self.athData = athData
  self.replaceAthData = replaceAthData
  ;
  (((self.ui).btn_Close).gameObject):SetActive(true)
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
    else
      detailItem:InitAthDetailItem(self, athData, heroData, false, false)
    end
    if inAthTable then
      (detailItem.transform):SetParent((self.ui).tableDetailPos)
    else
      ;
      (detailItem.transform):SetParent((self.ui).listDetailPos)
    end
    -- DECOMPILER ERROR at PC63: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (detailItem.transform).anchoredPosition = Vector2.zero
  else
    do
      local addItem = (self.detailItemPool):GetOne()
      addItem:InitAthDetailItem(self, athData, heroData, true, true)
      ;
      (addItem.transform):SetParent((self.ui).listDetailPos)
      -- DECOMPILER ERROR at PC83: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (addItem.transform).anchoredPosition = Vector2.zero
      local removeItem = (self.detailItemPool):GetOne()
      removeItem:InitAthDetailItem(self, replaceAthData, heroData, false, true)
      ;
      (removeItem.transform):SetParent((self.ui).replaceDetailPos)
      -- DECOMPILER ERROR at PC102: Confused about usage of register: R8 in 'UnsetPending'

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

UIAthItemDetail.ChangeAthItemParent = function(self, athItem, getAthItemFunc)
  -- function num : 0_3
  athItem:SetAthItemRootParent(self.transform)
  self.__getAthItemFunc = getAthItemFunc
  self.__changeParentItem = athItem
  self.__changeParentAthData = athItem:GetAthItemData()
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

UIAthItemDetail.__OnAthDataUpdate = function(self, updateAthDic, heroSlot, deleteAth)
  -- function num : 0_7 , upvalues : _ENV
  if (self.athData ~= nil and deleteAth[(self.athData).uid] ~= nil) or self.replaceAthData ~= nil and deleteAth[(self.replaceAthData).uid] ~= nil then
    self:__OnClickClose()
    return 
  end
  for k,item in ipairs((self.detailItemPool).listItem) do
    if item.athData ~= nil and updateAthDic[(item.athData).uid] ~= nil then
      item:RefreshAthDetailItemAttr()
    end
  end
  if self.__changeParentItem ~= nil and self.__getAthItemFunc ~= nil then
    (self.__changeParentItem):SetAthItemRootParent(nil, true)
    self.__changeParentItem = nil
    local athItem = (self.__getAthItemFunc)((self.__changeParentAthData).uid)
    if athItem ~= nil then
      athItem:SetAthItemRootParent(self.transform)
      self.__changeParentItem = athItem
    end
  end
end

UIAthItemDetail.__OnClickClose = function(self)
  -- function num : 0_8
  self:Hide()
end

UIAthItemDetail.OnShow = function(self)
  -- function num : 0_9 , upvalues : base, _ENV
  (base.OnShow)(self)
  ;
  (self.transform):SetAsLastSibling()
  MsgCenter:AddListener(eMsgEventId.OnAthDataUpdate1, self.__onAthDataUpdate)
  ;
  (UIUtil.HideTopStatus)()
end

UIAthItemDetail.OnHide = function(self)
  -- function num : 0_10 , upvalues : _ENV, base
  if self.__changeParentItem ~= nil and not IsNull((self.__changeParentItem).gameObject) then
    (self.__changeParentItem):SetAthItemRootParent(nil, true)
    self.__changeParentItem = nil
    self.__changeParentAthData = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.OnAthDataUpdate1, self.__onAthDataUpdate)
  ;
  (UIUtil.ReShowTopStatus)()
  ;
  (base.OnHide)(self)
end

UIAthItemDetail.OnDelete = function(self)
  -- function num : 0_11 , upvalues : base
  (self.detailItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UIAthItemDetail


local UINQuickPrchaseKayItemNodeItem = class("UINQuickPrchaseKayItemNodeItem", UIBaseNode)
local base = UIBaseNode
UINQuickPrchaseKayItemNodeItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.selectNum = 0
  self.warehousNum = 0
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_itemNode, self, self.AddOne)
  ;
  (((self.ui).btn_itemNode).onPress):AddListener(BindCallback(self, self.AddOne))
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_UnSelect, self, self.MineOne)
  ;
  (((self.ui).btn_UnSelect).onPress):AddListener(BindCallback(self, self.MineOne))
end

UINQuickPrchaseKayItemNodeItem.InitQPKItem = function(self, packageItemId, onChangeCallback)
  -- function num : 0_1 , upvalues : _ENV
  self.selectNum = 0
  self.packageItemId = packageItemId
  self.onChangeCallback = onChangeCallback
  self.itemCfg = (ConfigData.item)[packageItemId]
  if self.itemCfg == nil then
    error("can\'t read itemCfg with id:" .. tostring(packageItemId))
  end
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_ItemIcon).sprite = CRH:GetSprite((self.itemCfg).icon)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_ItemName).text = (LanguageUtil.GetLocaleText)((self.itemCfg).name)
  self:RefreshWharehouseNume()
  self:RefreshNum(true)
end

UINQuickPrchaseKayItemNodeItem.AddOne = function(self)
  -- function num : 0_2
  if self.warehousNum <= self.selectNum then
    return 
  end
  self.selectNum = self.selectNum + 1
  self:RefreshNum()
end

UINQuickPrchaseKayItemNodeItem.AddAll = function(self)
  -- function num : 0_3
  if self.warehousNum <= self.selectNum then
    return 
  end
  self.selectNum = self.warehousNum
  self:RefreshNum()
end

UINQuickPrchaseKayItemNodeItem.AddNum = function(self, num)
  -- function num : 0_4
  if self.warehousNum <= self.selectNum then
    return 
  end
  self.selectNum = self.selectNum + num
  self:RefreshNum()
end

UINQuickPrchaseKayItemNodeItem.MineOne = function(self)
  -- function num : 0_5
  if self.selectNum <= 0 then
    return 
  end
  self.selectNum = self.selectNum - 1
  self:RefreshNum()
end

UINQuickPrchaseKayItemNodeItem.CleanAll = function(self)
  -- function num : 0_6
  self.selectNum = 0
  self:RefreshNum()
end

UINQuickPrchaseKayItemNodeItem.RefreshNum = function(self, isInit)
  -- function num : 0_7 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_ItemSelectNum).text = tostring(self.selectNum)
  ;
  (((self.ui).btn_UnSelect).gameObject):SetActive(self.selectNum > 0)
  ;
  ((self.ui).go_imgNumber):SetActive(self.selectNum > 0)
  if not isInit and self.onChangeCallback ~= nil then
    (self.onChangeCallback)(self, self.selectNum)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UINQuickPrchaseKayItemNodeItem.RefreshWharehouseNume = function(self)
  -- function num : 0_8 , upvalues : _ENV
  self.warehousNum = PlayerDataCenter:GetItemCount(self.packageItemId)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Number).text = tostring(self.warehousNum)
end

UINQuickPrchaseKayItemNodeItem.GetKeyNum = function(self)
  -- function num : 0_9 , upvalues : _ENV
  return ((self.itemCfg).giftOptainDic)[ConstGlobalItem.SKey]
end

UINQuickPrchaseKayItemNodeItem.OnDelete = function(self)
  -- function num : 0_10 , upvalues : base
  (base.OnDelete)(self)
end

return UINQuickPrchaseKayItemNodeItem


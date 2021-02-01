-- params : ...
-- function num : 0 , upvalues : _ENV
local UINResourceGroup = class("UINResourceGroup", UIBaseNode)
local base = UIBaseNode
local UINResourceItem = require("Game.CommonUI.ResourceGroup.UINResourceItem")
local DefaultResourceIds = {1001, 1002, 1003}
UINResourceGroup.OnInit = function(self)
  -- function num : 0_0 , upvalues : DefaultResourceIds, _ENV, UINResourceItem
  self.resourceIds = DefaultResourceIds
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.materialItemPool = (UIItemPool.New)(UINResourceItem, (self.ui).obj_resourceItem)
  ;
  ((self.ui).obj_resourceItem):SetActive(false)
  self.__updateTopCurrencys = BindCallback(self, self.__UpdateTopCurrencys)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__updateTopCurrencys)
  self.__updateCurrencys4ARG = BindCallback(self, self.__UpdateCurrencys4ARG)
  MsgCenter:AddListener(eMsgEventId.UpdateARGItem, self.__updateCurrencys4ARG)
  self:__InitTopCurrencys()
end

UINResourceGroup.ChangeResourceItemClass = function(self, newClass)
  -- function num : 0_1 , upvalues : _ENV
  (self.materialItemPool):DeleteAll()
  self.materialItemPool = (UIItemPool.New)(newClass, (self.ui).obj_resourceItem)
  self:__InitTopCurrencys()
end

UINResourceGroup.__InitTopCurrencys = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self.materialItemPool):HideAll()
  for _,id in pairs(self.resourceIds) do
    local item = (self.materialItemPool):GetOne()
    local itemCfg = (ConfigData.item)[id]
    if itemCfg == nil then
      error("item Cfg is null :" .. tostring(id))
      return 
    end
    item:InitCurrencyItem(itemCfg)
  end
end

UINResourceGroup.UpdateResourceGroupTopCurrencys = function(self)
  -- function num : 0_3
  self:__UpdateTopCurrencys()
end

UINResourceGroup.__UpdateTopCurrencys = function(self)
  -- function num : 0_4 , upvalues : _ENV
  for _,item in ipairs((self.materialItemPool).listItem) do
    item:UpdateCount()
  end
end

UINResourceGroup.__UpdateCurrencys4ARG = function(self, changedItemNumDic)
  -- function num : 0_5 , upvalues : _ENV
  for _,item in ipairs((self.materialItemPool).listItem) do
    if changedItemNumDic[(item.itemCfg).id] ~= nil then
      item:UpdateCount()
    end
  end
end

UINResourceGroup.SetResourceIds = function(self, ids)
  -- function num : 0_6 , upvalues : _ENV, DefaultResourceIds
  self.resourceIds = {}
  if (table.count)(ids) <= 0 then
    self.resourceIds = DefaultResourceIds
  else
    for index,id in ipairs(ids) do
      if index <= 7 then
        do
          (table.insert)(self.resourceIds, id)
          -- DECOMPILER ERROR at PC22: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC22: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  self:__InitTopCurrencys()
end

UINResourceGroup.SetResourceAddBtnFunc = function(self, itemId, bool, addBtnCallback)
  -- function num : 0_7 , upvalues : _ENV
  for _,item in ipairs((self.materialItemPool).listItem) do
    if (item.itemCfg).id == itemId then
      item:SetAddBtn(bool, addBtnCallback)
    end
  end
end

UINResourceGroup.GetResourceItem = function(self, id)
  -- function num : 0_8 , upvalues : _ENV
  local resItem = nil
  for _,item in ipairs((self.materialItemPool).listItem) do
    if (item.itemCfg).id == id then
      resItem = item
    end
  end
  return resItem
end

UINResourceGroup.OnDelete = function(self)
  -- function num : 0_9 , upvalues : _ENV, base
  (self.materialItemPool):DeleteAll()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__updateTopCurrencys)
  MsgCenter:RemoveListener(eMsgEventId.UpdateARGItem, self.__updateCurrencys4ARG)
  ;
  (base.OnDelete)(self)
end

return UINResourceGroup


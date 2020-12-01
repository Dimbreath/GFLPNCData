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

UINResourceGroup.__UpdateTopCurrencys = function(self)
  -- function num : 0_3 , upvalues : _ENV
  for _,item in ipairs((self.materialItemPool).listItem) do
    item:UpdateCount()
  end
end

UINResourceGroup.__UpdateCurrencys4ARG = function(self, changedItemNumDic)
  -- function num : 0_4 , upvalues : _ENV
  for _,item in ipairs((self.materialItemPool).listItem) do
    if changedItemNumDic[(item.itemCfg).id] ~= nil then
      item:UpdateCount()
    end
  end
end

UINResourceGroup.SetResourceIds = function(self, ids)
  -- function num : 0_5 , upvalues : _ENV
  self.resourceIds = {}
  for index,id in ipairs(ids) do
    (table.insert)(self.resourceIds, id)
  end
  do
    if index <= 3 then
      self:__InitTopCurrencys()
    end
  end
end

UINResourceGroup.OnDelete = function(self)
  -- function num : 0_6 , upvalues : _ENV, base
  (self.materialItemPool):DeleteAll()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__updateTopCurrencys)
  MsgCenter:RemoveListener(eMsgEventId.UpdateARGItem, self.__updateCurrencys4ARG)
  ;
  (base.OnDelete)(self)
end

return UINResourceGroup

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINResourceGroup = class("UINResourceGroup", UIBaseNode)
local base = UIBaseNode
local UINResourceItem = require("Game.CommonUI.ResourceGroup.UINResourceItem")
local DefaultResourceIds = {1001, 1002, 1003}
UINResourceGroup.OnInit = function(self)
    -- function num : 0_0 , upvalues : DefaultResourceIds, _ENV, UINResourceItem
    self.resourceIds = DefaultResourceIds;
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self.materialItemPool = (UIItemPool.New)(UINResourceItem,
                                             (self.ui).obj_resourceItem);
    ((self.ui).obj_resourceItem):SetActive(false)
    self.__updateTopCurrencys = BindCallback(self, self.__UpdateTopCurrencys)
    MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__updateTopCurrencys)
    self.__updateCurrencys4ARG = BindCallback(self, self.__UpdateCurrencys4ARG)
    MsgCenter:AddListener(eMsgEventId.UpdateARGItem, self.__updateCurrencys4ARG)
    self:__InitTopCurrencys()
end

UINResourceGroup.ChangeResourceItemClass =
    function(self, newClass)
        -- function num : 0_1 , upvalues : _ENV
        (self.materialItemPool):DeleteAll()
        self.materialItemPool = (UIItemPool.New)(newClass,
                                                 (self.ui).obj_resourceItem)
        self:__InitTopCurrencys()
    end

UINResourceGroup.__InitTopCurrencys = function(self)
    -- function num : 0_2 , upvalues : _ENV
    (self.materialItemPool):HideAll()
    for _, id in pairs(self.resourceIds) do
        local item = (self.materialItemPool):GetOne()
        local itemCfg = (ConfigData.item)[id]
        if itemCfg == nil then
            error("item Cfg is null :" .. tostring(id))
            return
        end
        item:InitCurrencyItem(itemCfg)
    end
end

UINResourceGroup.__UpdateTopCurrencys = function(self)
    -- function num : 0_3 , upvalues : _ENV
    for _, item in ipairs((self.materialItemPool).listItem) do
        item:UpdateCount()
    end
end

UINResourceGroup.__UpdateCurrencys4ARG =
    function(self, changedItemNumDic)
        -- function num : 0_4 , upvalues : _ENV
        for _, item in ipairs((self.materialItemPool).listItem) do
            if changedItemNumDic[(item.itemCfg).id] ~= nil then
                item:UpdateCount()
            end
        end
    end

UINResourceGroup.SetResourceIds = function(self, ids)
    -- function num : 0_5 , upvalues : _ENV
    self.resourceIds = {}
    for index, id in ipairs(ids) do (table.insert)(self.resourceIds, id) end
    do if index <= 3 then self:__InitTopCurrencys() end end
end

UINResourceGroup.OnDelete = function(self)
    -- function num : 0_6 , upvalues : _ENV, base
    (self.materialItemPool):DeleteAll()
    MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__updateTopCurrencys)
    MsgCenter:RemoveListener(eMsgEventId.UpdateARGItem,
                             self.__updateCurrencys4ARG);
    (base.OnDelete)(self)
end

return UINResourceGroup


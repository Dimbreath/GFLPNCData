local UINFactoryOrderNodeProductItem = class("UINFactoryOrderNodeProductItem", UIBaseNode)
local base = UIBaseNode
local UINFactoryOrderNodeProductMat = require("Game.Factory.UI.UINFactoryOrderNodeProductMat")
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
local FactoryHelper = require("Game.Factory.FactoryHelper")
UINFactoryOrderNodeProductItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINFactoryOrderNodeProductMat
  self.outPutItemId = nil
  self.matItemDic = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.matItemPool = (UIItemPool.New)(UINFactoryOrderNodeProductMat, (self.ui).matItem)
  ;
  ((self.ui).matItem):SetActive(false)
end

UINFactoryOrderNodeProductItem.InitProductItem = function(self, orderCfg, isFinal)
  -- function num : 0_1 , upvalues : _ENV, UINBaseItem, UINFactoryOrderNodeProductMat
  self.orderCfg = orderCfg
  self.matItemDic = {}
  self.outPutItemId = orderCfg.outPutItemId
  local itemCfg = (ConfigData.item)[self.outPutItemId]
  if isFinal then
    self.item = (UINBaseItem.New)()
    ;
    (self.item):Init((self.ui).uINBaseItem)
    ;
    (self.item):InitBaseItem(itemCfg)
  else
    local output_matItem = (UINFactoryOrderNodeProductMat.New)()
    output_matItem:Init((self.ui).finalMatItem)
    output_matItem:InitProductOut(itemCfg)
  end
  do
    ;
    (self.matItemPool):HideAll()
    local count = 0
    for index,itemId in ipairs(orderCfg.materialOrder) do
      count = count + 1
      local matItem = (self.matItemPool):GetOne()
      local matItemCfg = (ConfigData.item)[itemId]
      matItem:InitProductMat(matItemCfg, count)
      -- DECOMPILER ERROR at PC53: Confused about usage of register: R12 in 'UnsetPending'

      ;
      (self.matItemDic)[itemId] = matItem
    end
    for i = count + 1, 3 do
      local emptyMatItem = (self.matItemPool):GetOne()
      emptyMatItem:InitProductMat(nil, i)
    end
    -- DECOMPILER ERROR at PC75: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).tex_ItemName).text = (LanguageUtil.GetLocaleText)((self.orderCfg).name)
  end
end

UINFactoryOrderNodeProductItem.SetOutPut = function(self, num, isShowUse)
  -- function num : 0_2 , upvalues : _ENV, FactoryHelper
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).tex_outputCount).text = tostring(num * (self.orderCfg).outPutItemNum)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_CostTime).text = (FactoryHelper.ConvertTime2DisplayMode)(num * (self.orderCfg).time_cost)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'

  if isShowUse then
    ((self.ui).tex_outputCount).color = (Color.New)(1, 1, 1, 0.6)
  else
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_outputCount).color = Color.white
  end
  for itemId,matItem in pairs(self.matItemDic) do
    matItem:SetCost(((self.orderCfg).raw_material)[itemId] * num, isShowUse)
  end
end

UINFactoryOrderNodeProductItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINFactoryOrderNodeProductItem


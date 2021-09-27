local UINShopNormalRechargeList = class("UINShopNormalRechargeList", UIBaseNode)
local base = UIBaseNode
local UINShopNormalRechargeItem = require("Game.Shop.UINShopNormalRechargeItem")
local cs_ResLoader = CS.ResLoader
UINShopNormalRechargeList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINShopNormalRechargeItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.itemPool = (UIItemPool.New)(UINShopNormalRechargeItem, (self.ui).quartzItem)
  ;
  ((self.ui).quartzItem):SetActive(false)
end

UINShopNormalRechargeList.InitRechargeList = function(self, goodDataDic)
  -- function num : 0_1 , upvalues : _ENV, cs_ResLoader
  local list = {}
  for k,v in pairs(goodDataDic) do
    (table.insert)(list, v)
  end
  ;
  (table.sort)(list, function(a, b)
    -- function num : 0_1_0
    do return a.shelfId < b.shelfId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  self.resloader = (cs_ResLoader.Create)()
  ;
  (self.itemPool):HideAll()
  for i,v in ipairs(list) do
    local item = (self.itemPool):GetOne()
    item:InitRechargeItem(v, self.resloader)
  end
end

UINShopNormalRechargeList.OnDelete = function(self)
  -- function num : 0_2 , upvalues : _ENV, base
  for i,v in ipairs((self.itemPool).listItem) do
    v:Delete()
  end
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINShopNormalRechargeList


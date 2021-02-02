-- params : ...
-- function num : 0 , upvalues : _ENV
local UICIDJumpInfoItem = class("UICommonItemDetailWinNew", UIBaseNode)
local base = UIBaseNode
local UICIDJumpDescrItem = require("Game.CommonUI.ItemDetail.UICIDJumpDescrItem")
local cs_MessageCommon = CS.MessageCommon
UICIDJumpInfoItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UICIDJumpDescrItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.PoolDescrItem = (UIItemPool.New)(UICIDJumpDescrItem, (self.ui).obj_jumpDescrItem)
  ;
  ((self.ui).obj_jumpDescrItem):SetActive(false)
end

UICIDJumpInfoItem.InitCIDJumpInfoItem = function(self, jumpId, args)
  -- function num : 0_1 , upvalues : _ENV
  local jumpCfg = (ConfigData.system_jump)[jumpId]
  ;
  ((self.ui).tex_tile):SetIndex(0, (LanguageUtil.GetLocaleText)(jumpCfg.title))
  ;
  (self.PoolDescrItem):HideAll()
  if args ~= nil and #args > 0 then
    for _,arg in ipairs(args) do
      local item = (self.PoolDescrItem):GetOne()
      item:InitCIDJumpDescrItem(jumpCfg, jumpId, R14_PC31)
    end
  else
    do
      local item = (self.PoolDescrItem):GetOne()
      item:InitCIDJumpDescrItem(jumpCfg, jumpId)
    end
  end
end

UICIDJumpInfoItem.InitQuickProduce = function(self, targetOrderData, factoryController)
  -- function num : 0_2 , upvalues : _ENV
  ((self.ui).tex_tile):SetIndex(1)
  ;
  (self.PoolDescrItem):HideAll()
  local item = (self.PoolDescrItem):GetOne()
  item:InitCIDJumpDescrItem4Factory(targetOrderData)
  item:SetJumpCallback(function()
    -- function num : 0_2_0 , upvalues : factoryController, targetOrderData, _ENV
    factoryController:OpenQuickProduceUI(targetOrderData, function()
      -- function num : 0_2_0_0 , upvalues : _ENV
      local commonItemDetailWin = UIManager:GetWindow(UIWindowTypeID.GlobalItemDetail)
      if commonItemDetailWin ~= nil then
        commonItemDetailWin:OnBtnReturnClick()
      end
    end
)
  end
)
end

UICIDJumpInfoItem.InitQuickBuy = function(self, shopId, shelfId, resourceIds)
  -- function num : 0_3 , upvalues : _ENV, cs_MessageCommon
  ((self.ui).tex_tile):SetIndex(2)
  ;
  (self.PoolDescrItem):HideAll()
  local item = (self.PoolDescrItem):GetOne()
  item:InitJump2Buy()
  item:SetJumpCallback(function()
    -- function num : 0_3_0 , upvalues : _ENV, shopId, shelfId, cs_MessageCommon, resourceIds
    local ctrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
    ctrl:GetShopData(shopId, function(shopData)
      -- function num : 0_3_0_0 , upvalues : shelfId, cs_MessageCommon, _ENV, resourceIds
      local goodData = (shopData.shopGoodsDic)[shelfId]
      if goodData.isFullRank then
        (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Hero_FullRank))
        return 
      end
      UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
        -- function num : 0_3_0_0_0 , upvalues : _ENV, goodData, resourceIds
        if win == nil then
          error("can\'t open QuickBuy win")
          return 
        end
        local winItemDetail = UIManager:GetWindow(UIWindowTypeID.GlobalItemDetail)
        if winItemDetail ~= nil then
          winItemDetail:OnBtnReturnClick()
        end
        win:SlideIn()
        win:InitBuyTarget(goodData, nil, true, resourceIds)
        win:OnClickAdd()
      end
)
    end
)
  end
)
end

UICIDJumpInfoItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (self.PoolDescrItem):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UICIDJumpInfoItem


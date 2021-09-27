local UINFactoryOrderNodeProductMat = class("UINFactoryOrderNodeProductMat", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
local MAX_MAT = 3
UINFactoryOrderNodeProductMat.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_matItem, self, self.OnClickMatItem)
end

UINFactoryOrderNodeProductMat.InitProductMat = function(self, itemCfg, index)
  -- function num : 0_1 , upvalues : MAX_MAT, _ENV
  self.itemCfg = itemCfg
  if index == MAX_MAT then
    ((self.ui).img_Sign):SetIndex(1)
  end
  if itemCfg == nil then
    ((self.ui).img_Empty):SetActive(true)
    ;
    ((self.ui).normal):SetActive(false)
    return 
  else
    ;
    ((self.ui).img_Empty):SetActive(false)
    ;
    ((self.ui).normal):SetActive(true)
  end
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSpriteByItemConfig(itemCfg)
  self:SetCost(0)
end

UINFactoryOrderNodeProductMat.InitProductOut = function(self, itemCfg)
  -- function num : 0_2 , upvalues : _ENV
  self.itemCfg = itemCfg
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSpriteByItemConfig(itemCfg)
end

UINFactoryOrderNodeProductMat.SetCost = function(self, num, isShowUse)
  -- function num : 0_3 , upvalues : _ENV
  local itemNum = PlayerDataCenter:GetItemCount((self.itemCfg).id)
  if (num == 0 and itemNum == 0) or itemNum < num then
    if isShowUse then
      ((self.ui).tex_Count):SetIndex(2, tostring(itemNum), tostring(num))
    else
      ;
      ((self.ui).tex_Count):SetIndex(0, tostring(itemNum), tostring(num))
    end
    ;
    ((self.ui).imgInfo_normal):SetIndex(1)
    ;
    ((self.ui).obj_CapacityInsufficient):SetActive(true)
  else
    if isShowUse then
      ((self.ui).tex_Count):SetIndex(3, tostring(itemNum), tostring(num))
    else
      ;
      ((self.ui).tex_Count):SetIndex(1, tostring(itemNum), tostring(num))
    end
    ;
    ((self.ui).imgInfo_normal):SetIndex(0)
    ;
    ((self.ui).obj_CapacityInsufficient):SetActive(false)
  end
end

UINFactoryOrderNodeProductMat.OnClickMatItem = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self.itemCfg ~= nil then
    local window = UIManager:ShowWindow(UIWindowTypeID.GlobalItemDetail)
    window:InitCommonItemDetail(self.itemCfg)
  end
end

UINFactoryOrderNodeProductMat.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINFactoryOrderNodeProductMat


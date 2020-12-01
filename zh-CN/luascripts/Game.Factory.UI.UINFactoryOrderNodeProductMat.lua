-- params : ...
-- function num : 0 , upvalues : _ENV
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
  ((self.ui).img_Icon).sprite = CRH:GetSprite(itemCfg.icon)
  self:SetCost(0)
end

UINFactoryOrderNodeProductMat.InitProductOut = function(self, itemCfg)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).img_Icon).sprite = CRH:GetSprite(itemCfg.icon)
end

UINFactoryOrderNodeProductMat.SetCost = function(self, num, isShowUse)
  -- function num : 0_3 , upvalues : _ENV
  local itemNum = PlayerDataCenter:GetItemCount((self.itemCfg).id)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R4 in 'UnsetPending'

  if (num == 0 and itemNum == 0) or itemNum < num then
    if isShowUse then
      ((self.ui).tex_Count).color = (Color.New)(1, 0, 0, 0.6)
    else
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).tex_Count).color = Color.red
    end
    ;
    ((self.ui).obj_CapacityInsufficient):SetActive(true)
  else
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R4 in 'UnsetPending'

    if isShowUse then
      ((self.ui).tex_Count).color = (Color.New)(0, 0, 0, 0.6)
    else
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).tex_Count).color = Color.black
    end
    ;
    ((self.ui).obj_CapacityInsufficient):SetActive(false)
  end
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Count).text = tostring(itemNum) .. "/" .. tostring(num)
end

UINFactoryOrderNodeProductMat.OnClickMatItem = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local window = UIManager:ShowWindow(UIWindowTypeID.GlobalItemDetail)
  window:InitCommonItemDetail(self.itemCfg)
end

UINFactoryOrderNodeProductMat.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINFactoryOrderNodeProductMat

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFactoryOrderNodeProductMat = class("UINFactoryOrderNodeProductMat",
                                            UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
local MAX_MAT = 3
UINFactoryOrderNodeProductMat.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_matItem, self, self.OnClickMatItem)
end

UINFactoryOrderNodeProductMat.InitProductMat =
    function(self, itemCfg, index)
        -- function num : 0_1 , upvalues : MAX_MAT, _ENV
        self.itemCfg = itemCfg
        if index == MAX_MAT then ((self.ui).img_Sign):SetIndex(1) end
        if itemCfg == nil then
            ((self.ui).img_Empty):SetActive(true);
            ((self.ui).normal):SetActive(false)
            return
        else

            ((self.ui).img_Empty):SetActive(false);
            ((self.ui).normal):SetActive(true)
        end -- DECOMPILER ERROR at PC39: Confused about usage of register: R3 in 'UnsetPending'
        
        ((self.ui).img_Icon).sprite = CRH:GetSprite(itemCfg.icon)
        self:SetCost(0)
    end

UINFactoryOrderNodeProductMat.InitProductOut =
    function(self, itemCfg)
        -- function num : 0_2 , upvalues : _ENV
        -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

        ((self.ui).img_Icon).sprite = CRH:GetSprite(itemCfg.icon)
    end

UINFactoryOrderNodeProductMat.SetCost = function(self, num, isShowUse)
    -- function num : 0_3 , upvalues : _ENV
    local itemNum = PlayerDataCenter:GetItemCount((self.itemCfg).id)
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R4 in 'UnsetPending'

    if (num == 0 and itemNum == 0) or itemNum < num then
        if isShowUse then
            ((self.ui).tex_Count).color = (Color.New)(1, 0, 0, 0.6)
        else
            -- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'


            ((self.ui).tex_Count).color = Color.red
        end
        ((self.ui).obj_CapacityInsufficient):SetActive(true)
    else
        -- DECOMPILER ERROR at PC46: Confused about usage of register: R4 in 'UnsetPending'

        if isShowUse then
            ((self.ui).tex_Count).color = (Color.New)(0, 0, 0, 0.6)
        else
            -- DECOMPILER ERROR at PC52: Confused about usage of register: R4 in 'UnsetPending'


            ((self.ui).tex_Count).color = Color.black
        end
        ((self.ui).obj_CapacityInsufficient):SetActive(false)
    end -- DECOMPILER ERROR at PC68: Confused about usage of register: R4 in 'UnsetPending'
    
    ((self.ui).tex_Count).text = tostring(itemNum) .. "/" .. tostring(num)
end

UINFactoryOrderNodeProductMat.OnClickMatItem =
    function(self)
        -- function num : 0_4 , upvalues : _ENV
        local window = UIManager:ShowWindow(UIWindowTypeID.GlobalItemDetail)
        window:InitCommonItemDetail(self.itemCfg)
    end

UINFactoryOrderNodeProductMat.OnDelete =
    function(self)
        -- function num : 0_5 , upvalues : base
        (base.OnDelete)(self)
    end

return UINFactoryOrderNodeProductMat


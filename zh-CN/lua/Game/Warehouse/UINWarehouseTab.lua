local UINWarehouseTab = class("UINWarehouseTab", UIBaseNode)
local base = UIBaseNode
UINWarehouseTab.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Page, self, self.OnClickWarehouseTab)
end

UINWarehouseTab.InitWarehouseTab = function(self, warehouseTabCfg, clickAction, resloader)
  -- function num : 0_1 , upvalues : _ENV
  self.clickAction = clickAction
  self.warehouseTabCfg = warehouseTabCfg
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)((self.warehouseTabCfg).name)
  ;
  (((self.ui).img_Icon).gameObject):SetActive(false)
  resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("UI_Warehouse"), function(spriteAtlas)
    -- function num : 0_1_0 , upvalues : self
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = spriteAtlas:GetSprite((self.warehouseTabCfg).icon)
    ;
    (((self.ui).img_Icon).gameObject):SetActive(true)
  end
)
  self:SetSelectState(false)
  self:RefreshRedDotState()
end

UINWarehouseTab.OnClickWarehouseTab = function(self)
  -- function num : 0_2
  if self.clickAction ~= nil then
    (self.clickAction)((self.warehouseTabCfg).id)
  end
end

UINWarehouseTab.SetSelectState = function(self, flag)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  if not flag or not (self.ui).color_ImgSelected then
    ((self.ui).img_Buttom).color = (self.ui).color_ImgUnSelect
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

    if not flag or not (self.ui).color_TextSelected then
      ((self.ui).tex_Name).color = (self.ui).color_TextUnSelect
    end
  end
end

UINWarehouseTab.RefreshRedDotState = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if (self.warehouseTabCfg).id == 1 then
    ((self.ui).blueDot):SetActive(false)
    return 
  end
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Warehouse, (self.warehouseTabCfg).id)
  ;
  ((self.ui).blueDot):SetActive(not ok or node:GetRedDotCount() > 0)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

return UINWarehouseTab


local UINStOConsumeItem = class("UINStOConsumeItem", UIBaseNode)
local base = UIBaseNode
UINStOConsumeItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Icon, self, self._OnClickIcon)
end

UINStOConsumeItem.InitStOConsumeItem = function(self, itemId, costNum)
  -- function num : 0_1 , upvalues : _ENV
  local itemCfg = (ConfigData.item)[itemId]
  if itemCfg == nil then
    error("Cant get itemCfg, itemId = " .. tostring(itemId))
    return 
  end
  self.itemCfg = itemCfg
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_SmallIcon).sprite = CRH:GetSprite(itemCfg.small_icon)
  local containNum = PlayerDataCenter:GetItemCount(itemId)
  local enough = costNum <= containNum
  ;
  ((self.ui).tex_Consume):SetIndex(enough and 0 or 1, tostring(containNum), tostring(costNum))
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UINStOConsumeItem._OnClickIcon = function(self)
  -- function num : 0_2 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(window)
    -- function num : 0_2_0 , upvalues : self
    window:InitCommonItemDetail(self.itemCfg)
  end
)
end

UINStOConsumeItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINStOConsumeItem


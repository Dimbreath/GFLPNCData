-- params : ...
-- function num : 0 , upvalues : _ENV
local UINBaseItem = class("UINBaseItem", UIBaseNode)
local base = UIBaseNode
UINBaseItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self.OnClickItemRoot)
end

UINBaseItem.InitBaseItem = function(self, itemCfg, clickEvent)
  -- function num : 0_1 , upvalues : _ENV
  self.itemCfg = itemCfg
  self.clickEvent = clickEvent
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).Img_ItemPic).sprite = CRH:GetSprite(itemCfg.icon)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).Img_Quality).sprite = CRH:GetSprite(ItemQualitySprite[itemCfg.quality], CommonAtlasType.BaseItemQuailty)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_QualityColor).color = ItemQualityColor[itemCfg.quality]
  ;
  ((self.ui).obj_IsFrag):SetActive(false)
  ;
  ((self.ui).obj_isHreo):SetActive(false)
  ;
  (((self.ui).img_isSmallIcon).gameObject):SetActive(false)
  local smallIcon = itemCfg.small_icon
  if itemCfg.action_type == eItemActionType.HeroCardFrag then
    ((self.ui).obj_IsFrag):SetActive(true)
    ;
    ((self.ui).obj_isHreo):SetActive(true)
  else
    if smallIcon ~= "" and smallIcon ~= nil then
      ((self.ui).obj_IsFrag):SetActive(true)
      ;
      (((self.ui).img_isSmallIcon).gameObject):SetActive(true)
      -- DECOMPILER ERROR at PC80: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).img_isSmallIcon).sprite = CRH:GetSprite(smallIcon)
    end
  end
end

UINBaseItem.OnClickItemRoot = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.clickEvent ~= nil then
    (self.clickEvent)(self.itemCfg)
  else
    if GuideManager.inGuide then
      return 
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
    -- function num : 0_2_0 , upvalues : self
    if win ~= nil then
      win:InitCommonItemDetail(self.itemCfg)
    end
  end
)
  end
end

UINBaseItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINBaseItem


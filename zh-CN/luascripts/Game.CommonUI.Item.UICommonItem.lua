-- params : ...
-- function num : 0 , upvalues : _ENV
local UICommonItem = class("UINChipItem", UIBaseNode)
local base = UIBaseNode
UICommonItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_commonItem, self, self.OnClick)
  self.canClick = true
end

UICommonItem.OnClick = function(self)
  -- function num : 0_1
  if not self.canClick then
    return 
  end
  if self.clickEvent ~= nil then
    self:clickEvent(self.itemCfg)
  else
    self:DefaultOnClick(self.itemCfg)
  end
end

UICommonItem.InitItem = function(self, itemCfg, num, resloader)
  -- function num : 0_2 , upvalues : _ENV
  self.itemCfg = itemCfg
  if num == nil then
    ((self.ui).Obj_numImage):SetActive(false)
  else
    ;
    ((self.ui).Obj_numImage):SetActive(true)
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).text_numText).text = num
  end
  local action_type = itemCfg.action_type
  if action_type == eItemActionType.HeroCard or action_type == eItemActionType.HeroCardFrag then
    local heroId = (itemCfg.arg)[1]
    ;
    (((self.ui).img_itemImage).gameObject):SetActive(false)
    ;
    (((self.ui).img_HeroRawImage).gameObject):SetActive(true)
    local heroCfg = (ConfigData.hero_data)[heroId]
    if heroCfg == nil then
      return 
    end
    local heroResCfg = (ConfigData.resource_model)[heroCfg.src_id]
    if heroResCfg ~= nil then
      if resloader == nil then
        return 
      end
      resloader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(heroResCfg.res_Name), function(texture)
    -- function num : 0_2_0 , upvalues : _ENV, self
    if IsNull(self.transform) then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_HeroRawImage).texture = texture
  end
)
    end
  else
    do
      -- DECOMPILER ERROR at PC70: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).img_itemImage).sprite = CRH:GetSprite((self.itemCfg).icon)
      -- DECOMPILER ERROR at PC76: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).qualityImage).color = ItemQualityColor[itemCfg.quality]
    end
  end
end

UICommonItem.SetClickable = function(self, canClick)
  -- function num : 0_3
  self.canClick = canClick
end

UICommonItem.SetJumpable = function(self, canJump)
  -- function num : 0_4
  self.canJump = canJump
end

UICommonItem.DefaultOnClick = function(self, itemCfg)
  -- function num : 0_5 , upvalues : _ENV
  local window = UIManager:ShowWindow(UIWindowTypeID.GlobalItemDetail)
  if self.parentWindowType ~= nil then
    window:ParentWindowType(self.parentWindowType)
  end
  if self.canJump ~= nil then
    window:SetJumpable(self.canJump)
  else
    window:SetJumpable(true)
  end
  window:InitCommonItemDetail(itemCfg)
end

UICommonItem.ParentWindowType = function(self, type)
  -- function num : 0_6
  self.parentWindowType = type
end

return UICommonItem


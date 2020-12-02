-- params : ...
-- function num : 0 , upvalues : _ENV
local UINDormHeroSlotItem = class("UINDormHeroSlotItem", UIBaseNode)
local base = UIBaseNode
UINDormHeroSlotItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_theSlot, self, self.OnClickItem)
end

UINDormHeroSlotItem.InitDormHeroSlotItem = function(self, fntData, resloader, clickEvent)
  -- function num : 0_1 , upvalues : _ENV
  self.fntData = fntData
  self.clickEvent = clickEvent
  if fntData == nil then
    (((self.ui).img_Hero).gameObject):SetActive(false)
  else
    local param = (self.fntData):GetFntParam()
    ;
    (((self.ui).img_Hero).gameObject):SetActive(true)
    local heroData = (PlayerDataCenter.heroDic)[param]
    if heroData == nil then
      error("Can\'t get heroData, id = " .. tostring(param))
      return 
    end
    local path = PathConsts:GetCharacterPicPath(heroData:GetResName())
    resloader:LoadABAssetAsync(path, function(texture)
    -- function num : 0_1_0 , upvalues : self
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

    ((self.ui).img_Hero).texture = texture
  end
)
  end
end

UINDormHeroSlotItem.OnClickItem = function(self)
  -- function num : 0_2
  if self.clickEvent ~= nil then
    (self.clickEvent)(self.fntData)
  end
end

UINDormHeroSlotItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINDormHeroSlotItem


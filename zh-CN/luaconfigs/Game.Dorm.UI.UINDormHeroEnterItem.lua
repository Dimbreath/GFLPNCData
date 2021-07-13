-- params : ...
-- function num : 0 , upvalues : _ENV
local UINDormHeroEnterItem = class("UINDormHeroEnterItem", UIBaseNode)
local base = UIBaseNode
UINDormHeroEnterItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).rootBtn, self, self.__OnClick)
end

UINDormHeroEnterItem.RefreshDormHeroEnterItem = function(self, index, heroData, clickEvent, resloader, bind, select)
  -- function num : 0_1 , upvalues : _ENV
  self.index = index
  self.heroData = heroData
  self.clickEvent = clickEvent
  local path = PathConsts:GetCharacterPicPath(heroData:GetResPicName())
  resloader:LoadABAssetAsync(path, function(texture)
    -- function num : 0_1_0 , upvalues : self
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

    ((self.ui).img_Hero).texture = texture
  end
)
  self.bind = bind
  self:SelectDormHeroEnterItem(select)
end

UINDormHeroEnterItem.SelectDormHeroEnterItem = function(self, select)
  -- function num : 0_2
  ((self.ui).onSelect):SetActive(select)
  if select then
    ((self.ui).roomTag):SetActive(false)
  else
    ;
    ((self.ui).roomTag):SetActive(self.bind)
  end
end

UINDormHeroEnterItem.__OnClick = function(self)
  -- function num : 0_3
  if self.clickEvent ~= nil then
    (self.clickEvent)(self)
  end
end

UINDormHeroEnterItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINDormHeroEnterItem


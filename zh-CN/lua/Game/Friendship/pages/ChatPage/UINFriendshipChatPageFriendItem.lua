local UINFriendshipChatPageFriendItem = class("UINFriendshipChatPageFriendItem", UIBaseNode)
local base = UIBaseNode
UINFriendshipChatPageFriendItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_weChatListItem, self, self.OnClick)
  self.__RefreshFavorLevel = BindCallback(self, self.RefreshFavorLevel)
  MsgCenter:AddListener(eMsgEventId.OnHeroFriendshipDataChange, self.__RefreshFavorLevel)
end

UINFriendshipChatPageFriendItem.InitHeroInfo = function(self, heroData, clickEvent, resloader)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R4 in 'UnsetPending'

  ((self.ui).tex_HeroName).text = (LanguageUtil.GetLocaleText)((heroData.heroCfg).name)
  self.heroID = (heroData.heroCfg).id
  self.heroData = heroData
  resloader:LoadABAssetAsync(PathConsts:GetCharacterPicPath((heroData.resCfg).res_Name), function(texture)
    -- function num : 0_1_0 , upvalues : self
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

    ((self.ui).img_HeadIcon).texture = texture
  end
)
  self.clickEvent = clickEvent
  self:RefreshFavorLevel()
end

UINFriendshipChatPageFriendItem.RefreshFavorLevel = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local favoeLevel = (PlayerDataCenter.allFriendshipData):GetLevel(self.heroID)
  ;
  ((self.ui).tex_FavorLevel):SetIndex(0, tostring(favoeLevel))
end

UINFriendshipChatPageFriendItem.OnClick = function(self)
  -- function num : 0_3
  self:SelectThis(true)
  if self.clickEvent ~= nil then
    (self.clickEvent)(self.heroData)
  end
end

UINFriendshipChatPageFriendItem.SelectThis = function(self, bool)
  -- function num : 0_4
  ((self.ui).img_onSelect):SetActive(bool)
end

UINFriendshipChatPageFriendItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnHeroFriendshipDataChange, self.__RefreshFavorLevel)
  ;
  (base.OnDelete)(self)
end

return UINFriendshipChatPageFriendItem


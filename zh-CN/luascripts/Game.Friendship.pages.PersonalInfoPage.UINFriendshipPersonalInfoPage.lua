-- params : ...
-- function num : 0 , upvalues : _ENV
local UUINFriendshipPersonalInfoPage = class("UUINFriendshipPersonalInfoPage", UIBaseNode)
local base = UIBaseNode
local UINFriendshipAttrItem = require("Game.Friendship.pages.PersonalInfoPage.UINFriendshipAttrItem")
UUINFriendshipPersonalInfoPage.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINFriendshipAttrItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_UserName).text = PlayerDataCenter.playerName
  self.attrItemPool = (UIItemPool.New)(UINFriendshipAttrItem, (self.ui).obj_attriItem)
  ;
  ((self.ui).obj_attriItem):SetActive(false)
  self.__RefreshTotalLevel = BindCallback(self, self.RefreshTotalLevel)
  MsgCenter:AddListener(eMsgEventId.OnHeroFriendshipDataChange, self.__RefreshTotalLevel)
end

UUINFriendshipPersonalInfoPage.LaterInit = function(self, resloader)
  -- function num : 0_1
  self.resloader = resloader
  self:RefreshTotalLevel()
end

UUINFriendshipPersonalInfoPage.RefreshAttrs = function(self, totalLevel)
  -- function num : 0_2 , upvalues : _ENV
  (self.attrItemPool):HideAll()
  local cfg = (ConfigData.friendship_total_level)[totalLevel]
  for index,logic in ipairs(cfg.logic) do
    local attrItem = (self.attrItemPool):GetOne(true)
    attrItem:InitAttrItem((cfg.para1)[index], (cfg.para2)[index])
  end
end

UUINFriendshipPersonalInfoPage.RefreshTotalLevel = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local totalLevel = (PlayerDataCenter.allFriendshipData):GetTotalLevel() or 0
  ;
  ((self.ui).tex_TotalfavorLevel):SetIndex(0, tostring(totalLevel))
  self:RefreshAttrs(totalLevel)
end

UUINFriendshipPersonalInfoPage.OnDelete = function(self)
  -- function num : 0_4 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnHeroFriendshipDataChange, self.__RefreshTotalLevel)
  ;
  (self.attrItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UUINFriendshipPersonalInfoPage


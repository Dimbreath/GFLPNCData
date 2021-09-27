local UIChangeDressUp = class("UIChangeDressUp", UIBaseNode)
local UINDressUpItem = require("Game.User.Dialogs.UINDressUpItem")
local base = UIBaseNode
UIChangeDressUp.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.onDressUpItemClick = BindCallback(self, self.OnDressUpItemClick)
end

UIChangeDressUp.RefreshChangeDressUp = function(self, onCloseCallback)
  -- function num : 0_1 , upvalues : _ENV
  self._onCloseCallback = onCloseCallback
  self.dressUpItemDic = {}
  self.cfgList = self:_GetDressUpData()
  if self._resLoader ~= nil then
    (self._resLoader):Put2Pool()
    self._resLoader = nil
  end
  self._resLoader = ((CS.ResLoader).Create)()
  local iconPath = PathConsts:GetSpriteAtlasPath("PreviewDressUp")
  self._atlas = (self._resLoader):LoadABAsset(iconPath)
  self:_ShowUI()
end

UIChangeDressUp._ShowUI = function(self)
  -- function num : 0_2
  self:Show()
  if #self.cfgList < 0 then
    return 
  end
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).totalCount = #self.cfgList
  ;
  ((self.ui).scrollRect):RefillCells(0)
end

UIChangeDressUp.__OnInstantiateItem = function(self, go)
  -- function num : 0_3 , upvalues : UINDressUpItem
  local dressUpItem = (UINDressUpItem.New)()
  dressUpItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.dressUpItemDic)[go] = dressUpItem
end

UIChangeDressUp.__OnChangeItem = function(self, go, index)
  -- function num : 0_4 , upvalues : _ENV
  local dressUpItem = (self.dressUpItemDic)[go]
  if dressUpItem == nil then
    error("Can\'t find goodItem by gameObject")
    return 
  end
  local cfg = (self.cfgList)[index + 1]
  if self._resLoader == nil then
    self._resLoader = ((UIManager:GetWindow(UIWindowTypeID.UserInfo)).userInfoNode).dressUpResloader
  end
  local sprite = (self._atlas):GetSprite(cfg.icon)
  dressUpItem:InitDressUpItem(cfg, self.onDressUpItemClick, sprite, cfg.id)
end

UIChangeDressUp._GetDressUpData = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local cfgList = {}
  for id,cfg in pairs(ConfigData.portrait_card) do
    if not cfg.is_hide then
      local count = PlayerDataCenter:GetItemCount(id)
      if count > 0 then
        (table.insert)(cfgList, cfg)
      end
    end
  end
  return cfgList
end

UIChangeDressUp.OnDressUpItemClick = function(self, cfg)
  -- function num : 0_6 , upvalues : _ENV
  local infoWin = UIManager:GetWindow(UIWindowTypeID.UserInfo)
  if infoWin ~= nil then
    (infoWin.userInfoNode):RefreshDressUp(cfg.id)
    ;
    (NetworkManager:GetNetwork(NetworkTypeID.Object)):CS_User_BGPlateMod(cfg.id)
  end
  if self._onCloseCallback ~= nil then
    (self._onCloseCallback)()
  end
end

UIChangeDressUp.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  if self._resLoader ~= nil then
    (self._resLoader):Put2Pool()
    self._resLoader = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIChangeDressUp


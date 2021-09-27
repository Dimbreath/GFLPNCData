local UIHeadItem = class("UIHeadItem", UIBaseNode)
local base = UIHeadItem
UIHeadItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_HeadItem, self, self.ChangePicAction)
end

UIHeadItem.InitItem = function(self, itemCfg, clickEvent, atlas)
  -- function num : 0_1 , upvalues : _ENV
  if itemCfg == nil then
    self.clickFun = nil
    return 
  end
  self.clickFun = clickEvent
  self.itemCfg = itemCfg
  self.resName = ((self.itemCfg).cfg).icon
  if (self.itemCfg).count > 0 then
    ((self.ui).headItemLock):SetActive(false)
  else
    ;
    ((self.ui).headItemLock):SetActive(true)
  end
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R4 in 'UnsetPending'

  if not (string.IsNullOrEmpty)(self.resName) then
    ((self.ui).img_Head).sprite = CRH:GetSprite(self.resName, CommonAtlasType.HeroHeadIcon)
  end
  ;
  ((self.ui).img_HeadSel):SetActive(false)
end

UIHeadItem.ChangePicAction = function(self)
  -- function num : 0_2
  if self.clickFun ~= nil then
    (self.clickFun)(self.itemCfg, self)
  end
end

UIHeadItem.OnDelte = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UIHeadItem


-- params : ...
-- function num : 0 , upvalues : _ENV
local UINTopBtnGroup = class("UINTopBtnGroup", UIBaseNode)
local base = UIBaseNode
UINTopBtnGroup.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Back, self, self.__OnBtnBackClick)
  if (self.ui).btn_GoHome ~= nil then
    (UIUtil.AddButtonListener)((self.ui).btn_GoHome, self, self.__OnBtnHomeClick)
    ;
    (((self.ui).btn_GoHome).gameObject):SetActive(false)
  end
  if (self.ui).btn_Info ~= nil then
    (UIUtil.AddButtonListener)((self.ui).btn_Info, self, self.__OnBtnInfoClick)
    ;
    (((self.ui).btn_Info).gameObject):SetActive(false)
  end
  ;
  (((self.ui).btn_Back).gameObject):SetActive(false)
end

UINTopBtnGroup.RefreshTopGroupUI = function(self, topData)
  -- function num : 0_1 , upvalues : _ENV
  local backStackCount = (UIUtil.backStack):Count()
  local active = self.__onBackClick ~= nil or backStackCount > 0
  ;
  (((self.ui).btn_Back).gameObject):SetActive(active)
  ;
  (((self.ui).btn_GoHome).gameObject):SetActive(active)
  ;
  (((self.ui).btn_Info).gameObject):SetActive(topData.infoAction ~= nil)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINTopBtnGroup.SetBackClickAction = function(self, onBackClick)
  -- function num : 0_2
  self.__onBackClick = onBackClick
end

UINTopBtnGroup.__OnBtnBackClick = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.__onBackClick ~= nil then
    local backFunc = self.__onBackClick
    backFunc()
    self.__onBackClick = nil
  else
    do
      ;
      (UIUtil.OnClickBack)()
    end
  end
end

UINTopBtnGroup.__OnBtnHomeClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (UIUtil.ReturnHome)()
end

UINTopBtnGroup.SetInfoClickAction = function(self, infoClickAction)
  -- function num : 0_5
  self.__onInfoClick = infoClickAction
end

UINTopBtnGroup.__OnBtnInfoClick = function(self)
  -- function num : 0_6
  if self.__onInfoClick ~= nil then
    (self.__onInfoClick)()
  end
end

UINTopBtnGroup.OnDelete = function(self)
  -- function num : 0_7
end

return UINTopBtnGroup


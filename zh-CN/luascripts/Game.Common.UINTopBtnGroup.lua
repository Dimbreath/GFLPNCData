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
  end
  self:SetBackClickAction(nil)
end

UINTopBtnGroup.SetBackClickAction = function(self, onBackClick)
  -- function num : 0_1
  (((self.ui).btn_Back).gameObject):SetActive(onBackClick ~= nil)
  self.__onBackClick = onBackClick
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINTopBtnGroup.__OnBtnHomeClick = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (UIUtil.ReturnHome)()
end

UINTopBtnGroup.__OnBtnBackClick = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (UIUtil.OnClickBack)()
end

UINTopBtnGroup.OnDelete = function(self)
  -- function num : 0_4
end

return UINTopBtnGroup

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINTopBtnGroup = class("UINTopBtnGroup", UIBaseNode)
local base = UIBaseNode
UINTopBtnGroup.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_Back, self, self.__OnBtnBackClick)
    if (self.ui).btn_GoHome ~= nil then
        (UIUtil.AddButtonListener)((self.ui).btn_GoHome, self,
                                   self.__OnBtnHomeClick)
    end
    self:SetBackClickAction(nil)
end

UINTopBtnGroup.SetBackClickAction = function(self, onBackClick)
    -- function num : 0_1
    (((self.ui).btn_Back).gameObject):SetActive(onBackClick ~= nil)
    self.__onBackClick = onBackClick
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINTopBtnGroup.__OnBtnHomeClick = function(self)
    -- function num : 0_2 , upvalues : _ENV
    (UIUtil.ReturnHome)()
end

UINTopBtnGroup.__OnBtnBackClick = function(self)
    -- function num : 0_3 , upvalues : _ENV
    (UIUtil.OnClickBack)()
end

UINTopBtnGroup.OnDelete = function(self)
    -- function num : 0_4
end

return UINTopBtnGroup


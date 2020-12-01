-- params : ...
-- function num : 0 , upvalues : _ENV
local UIATHSuitContentItem = class("UIATHSuitContentItem", UIBaseNode)
local base = UIBaseNode
UIATHSuitContentItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIATHSuitContentItem.InitWithData = function(self, num, data, resLoader)
  -- function num : 0_1 , upvalues : _ENV
  self.data = data
  ;
  ((self.ui).tex_Content):SetIndex(0, tostring(num), (LanguageUtil.GetLocaleText)(data))
end

UIATHSuitContentItem.OnHide = function(self)
  -- function num : 0_2
  self.data = nil
end

UIATHSuitContentItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UIATHSuitContentItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIATHSuitContentItem = class("UIATHSuitContentItem", UIBaseNode)
local base = UIBaseNode
UIATHSuitContentItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIATHSuitContentItem.InitWithData = function(self, num, data, resLoader)
    -- function num : 0_1 , upvalues : _ENV
    self.data = data;
    ((self.ui).tex_Content):SetIndex(0, tostring(num),
                                     (LanguageUtil.GetLocaleText)(data))
end

UIATHSuitContentItem.OnHide = function(self)
    -- function num : 0_2
    self.data = nil
end

UIATHSuitContentItem.OnDelete = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnDelete)(self)
end

return UIATHSuitContentItem


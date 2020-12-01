-- params : ...
-- function num : 0 , upvalues : _ENV
local UIFilterItem = class("UIFilterItem", UIBaseNode)
local base = UIBaseNode
UIFilterItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CampItem, self, self.__onclick)
end

UIFilterItem.InitWithData = function(self, campId, isDouble)
  -- function num : 0_1 , upvalues : _ENV
  self.campId = campId
  self.isDouble = isDouble
  if campId == 0 then
    self.itemName = "全部"
  else
    local campCfg = (ConfigData.camp)[campId]
    self.itemName = (LanguageUtil.GetLocaleText)(campCfg.name)
  end
  do
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_CampName).text = self.itemName
    ;
    ((self.ui).obj_double):SetActive(isDouble)
  end
end

UIFilterItem.__onclick = function(self)
  -- function num : 0_2
  if self.clickEvent ~= nil then
    (self.clickEvent)(self.campId, self.itemName)
  end
end

UIFilterItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UIFilterItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIFilterItem = class("UIFilterItem", UIBaseNode)
local base = UIBaseNode
UIFilterItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_CampItem, self, self.__onclick)
end

UIFilterItem.InitWithData = function(self, campId, isDouble)
    -- function num : 0_1 , upvalues : _ENV
    self.campId = campId
    self.isDouble = isDouble
    if campId == 0 then
        self.itemName = "全部"
    else
        local campCfg = (ConfigData.camp)[campId]
        self.itemName = (LanguageUtil.GetLocaleText)(campCfg.name)
    end
    do
        -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'


        ((self.ui).tex_CampName).text = self.itemName;
        ((self.ui).obj_double):SetActive(isDouble)
    end
end

UIFilterItem.__onclick = function(self)
    -- function num : 0_2
    if self.clickEvent ~= nil then
        (self.clickEvent)(self.campId, self.itemName)
    end
end

UIFilterItem.OnDelete = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnDelete)(self)
end

return UIFilterItem


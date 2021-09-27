local UIFilterItem = class("UIFilterItem", UIBaseNode)
local base = UIBaseNode
UIFilterItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CampItem, self, self.__onclick)
end

UIFilterItem.InitWithData = function(self, careerId, isDouble)
  -- function num : 0_1 , upvalues : _ENV
  self.careerId = careerId
  self.isDouble = isDouble
  if careerId == 0 then
    self.itemName = "全部"
  else
    local careerCfg = (ConfigData.career)[careerId]
    self.itemName = (LanguageUtil.GetLocaleText)(careerCfg.name)
  end
  do
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_CampName).text = self.itemName
  end
end

UIFilterItem.__onclick = function(self)
  -- function num : 0_2
  if self.clickEvent ~= nil then
    (self.clickEvent)(self.careerId, self.itemName)
  end
end

UIFilterItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UIFilterItem


-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroCardConvert = class("UINHeroCardConvert", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
UINHeroCardConvert.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.baseItem = (UINBaseItem.New)()
  ;
  (self.baseItem):Init((self.ui).uINBaseItem)
end

UINHeroCardConvert.InitHeroCardConvert = function(self, itemId, itemNum)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).tex_Count).text = tostring(itemNum)
  local itemCfg = (ConfigData.item)[itemId]
  if itemCfg == nil then
    error("Cant get itemCfg, id = " .. tostring(itemId))
    return 
  end
  ;
  (self.baseItem):InitBaseItem(itemCfg, function()
    -- function num : 0_1_0
  end
)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).text_Name).text = (LanguageUtil.GetLocaleText)(itemCfg.name)
end

UINHeroCardConvert.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINHeroCardConvert


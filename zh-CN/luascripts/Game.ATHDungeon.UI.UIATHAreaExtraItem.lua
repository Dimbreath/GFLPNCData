-- params : ...
-- function num : 0 , upvalues : _ENV
local UIATHAreaExtraItem = class("UIATHAreaExtraItem", UIBaseNode)
local base = UIBaseNode
UIATHAreaExtraItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).areaItem, self, self.__onClick)
end

UIATHAreaExtraItem.InitWithData = function(self, data, resLoader)
  -- function num : 0_1 , upvalues : _ENV
  self.data = (ConfigData.ath_area)[data]
  ;
  ((self.ui).tex_Name):SetIndex(0, (LanguageUtil.GetLocaleText)((self.data).name1))
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_SubName).text = (LanguageUtil.GetLocaleText)((self.data).name2)
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_SubNameEn).text = (LanguageUtil.GetLocaleText)((self.data).name3)
end

UIATHAreaExtraItem.__onClick = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local name1 = (LanguageUtil.GetLocaleText)((self.data).name1)
  local name2 = (LanguageUtil.GetLocaleText)((self.data).name2)
  ;
  ((CS.MessageCommon).ShowMessageTips)((string.format)(ConfigData:GetTipContent(TipContent.ATH_Dungeon_Area_Extra_Msg), name1, name2))
end

UIATHAreaExtraItem.OnHide = function(self)
  -- function num : 0_3
  self.data = nil
end

UIATHAreaExtraItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UIATHAreaExtraItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIATHAreaExtraItem = class("UIATHAreaExtraItem", UIBaseNode)
local base = UIBaseNode
UIATHAreaExtraItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).areaItem, self, self.__onClick)
end

UIATHAreaExtraItem.InitWithData = function(self, data, resLoader)
    -- function num : 0_1 , upvalues : _ENV
    self.data = (ConfigData.ath_area)[data];
    ((self.ui).tex_Name):SetIndex(0, (LanguageUtil.GetLocaleText)(
                                      (self.data).name1)) -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.ui).tex_SubName).text = (LanguageUtil.GetLocaleText)(
                                       (self.data).name2) -- DECOMPILER ERROR at PC29: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.ui).tex_SubNameEn).text = (LanguageUtil.GetLocaleText)(
                                         (self.data).name3)
end

UIATHAreaExtraItem.__onClick = function(self)
    -- function num : 0_2 , upvalues : _ENV
    local name1 = (LanguageUtil.GetLocaleText)((self.data).name1)
    local name2 = (LanguageUtil.GetLocaleText)((self.data).name2);
    ((CS.MessageCommon).ShowMessageTips)(
        (string.format)(ConfigData:GetTipContent(
                            TipContent.ATH_Dungeon_Area_Extra_Msg), name1, name2))
end

UIATHAreaExtraItem.OnHide = function(self)
    -- function num : 0_3
    self.data = nil
end

UIATHAreaExtraItem.OnDelete = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnDelete)(self)
end

return UIATHAreaExtraItem


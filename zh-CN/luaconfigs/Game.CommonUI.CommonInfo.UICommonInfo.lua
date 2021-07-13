-- params : ...
-- function num : 0 , upvalues : _ENV
local UICommonInfo = class("UICommonInfo", UIBaseWindow)
local base = UIBaseWindow
UICommonInfo.OnInit = function(self)
  -- function num : 0_0
end

UICommonInfo.InitCommonInfo = function(self, infoStr, titleStr)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).tex_Rules).text = infoStr
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).text_Tile).text = titleStr
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self.__onBackClick)
end

UICommonInfo.InitDungeonDropInfo = function(self, dungeonTypeID, backFunc)
  -- function num : 0_2 , upvalues : _ENV
  (UIUtil.SetTopStatus)(self, self.__onBackClick)
  self.onBackCallback = backFunc
  self:__ShowDungeonInfoByTypeID(dungeonTypeID)
end

UICommonInfo.__ShowDungeonInfoByTypeID = function(self, dungeonTypeID)
  -- function num : 0_3 , upvalues : _ENV
  local cfg = (ConfigData.dungeon_info)[dungeonTypeID]
  if cfg == nil then
    error("dungeon_info cfg is Not Find id:" .. tostring(dungeonTypeID))
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Rules).text = (LanguageUtil.GetLocaleText)(cfg.info_text)
end

UICommonInfo.__onBackClick = function(self)
  -- function num : 0_4 , upvalues : base
  if self.onBackCallback ~= nil then
    (self.onBackCallback)()
  end
  ;
  (base.Delete)(self)
end

UICommonInfo.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UICommonInfo


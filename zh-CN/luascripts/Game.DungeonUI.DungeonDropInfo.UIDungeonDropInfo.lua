-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDungeonDropInfo = class("UIDungeonDropInfo", UIBaseWindow)
local base = UIBaseWindow
UIDungeonDropInfo.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.CreateTopBtnGroup)((self.ui).topButtonGroup, self, self.__onBackClick)
end

UIDungeonDropInfo.InitDungeonDropInfo = function(self, dungeonTypeID, backFunc)
  -- function num : 0_1
  self.onBackCallback = backFunc
  self:__ShowDungeonInfoByTypeID(dungeonTypeID)
end

UIDungeonDropInfo.__ShowDungeonInfoByTypeID = function(self, dungeonTypeID)
  -- function num : 0_2 , upvalues : _ENV
  local cfg = (ConfigData.dungeon_info)[dungeonTypeID]
  if cfg == nil then
    error("dungeon_info cfg is Not Find id:" .. tostring(dungeonTypeID))
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Rules).text = (LanguageUtil.GetLocaleText)(cfg.info_text)
end

UIDungeonDropInfo.__onBackClick = function(self)
  -- function num : 0_3 , upvalues : base
  if self.onBackCallback ~= nil then
    (self.onBackCallback)()
  end
  ;
  (base.Delete)(self)
end

UIDungeonDropInfo.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UIDungeonDropInfo


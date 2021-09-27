local UICommonInfo = class("UICommonInfo", UIBaseWindow)
local base = UIBaseWindow
UICommonInfo.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.SetTopStatus)(self, self.__onBackClick, nil, nil, nil, nil, function()
    -- function num : 0_0_0 , upvalues : _ENV
    if ExplorationManager:IsInExploration() then
      (UIUtil.SetTopStatusBtnShow)(false, false)
    end
  end
)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, UIUtil.OnClickBack)
end

UICommonInfo.InitCommonInfo = function(self, infoStr, titleStr, backFunc)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R4 in 'UnsetPending'

  ((self.ui).tex_Rules).text = infoStr
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).text_Tile).text = titleStr
  self.onBackCallback = backFunc
end

UICommonInfo.InitDungeonDropInfo = function(self, dungeonTypeID, backFunc)
  -- function num : 0_2 , upvalues : _ENV
  self.onBackCallback = backFunc
  local cfg = (ConfigData.dungeon_info)[dungeonTypeID]
  if cfg == nil then
    error("dungeon_info cfg is Not Find id:" .. tostring(dungeonTypeID))
  end
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Rules).text = (LanguageUtil.GetLocaleText)(cfg.info_text)
end

UICommonInfo.__onBackClick = function(self)
  -- function num : 0_3 , upvalues : base
  if self.onBackCallback ~= nil then
    (self.onBackCallback)()
  end
  ;
  (base.Delete)(self)
end

UICommonInfo.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UICommonInfo


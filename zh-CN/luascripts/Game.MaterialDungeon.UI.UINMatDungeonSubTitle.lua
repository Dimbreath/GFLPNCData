-- params : ...
-- function num : 0 , upvalues : _ENV
local UINMatDungeonSubTitle = class("UINMatDungeonSubTitle", UIBaseNode)
local base = UIBaseNode
UINMatDungeonSubTitle.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_tile, self, self.OnClickTitle)
end

UINMatDungeonSubTitle.SetSubTitleInfo = function(self, dungeonSubInfoCfg, resLoader, isShowOpen, onClickFunc)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R5 in 'UnsetPending'

  ((self.ui).img_Icon).sprite = (AtlasUtil.GetSpriteFromAtlas)("CommonDungeon", dungeonSubInfoCfg.icon, resLoader)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(dungeonSubInfoCfg.text)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_ENName).text = dungeonSubInfoCfg.name_en
  self.isShowOpen = isShowOpen or false
  self.index = dungeonSubInfoCfg.stage_type
  self.onClickFunc = onClickFunc
  self:RefreshState()
end

UINMatDungeonSubTitle.RefreshState = function(self)
  -- function num : 0_2
  (((self.ui).obj_CloseList).gameObject):SetActive(self.isShowOpen)
  ;
  (((self.ui).obj_OpenList).gameObject):SetActive(not self.isShowOpen)
end

UINMatDungeonSubTitle.OnClickTitle = function(self)
  -- function num : 0_3
  self.isShowOpen = not self.isShowOpen
  self:RefreshState()
  if self.onClickFunc ~= nil then
    (self.onClickFunc)(self.index, self.isShowOpen)
  end
end

UINMatDungeonSubTitle.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINMatDungeonSubTitle


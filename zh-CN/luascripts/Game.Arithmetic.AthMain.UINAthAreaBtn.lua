-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthAreaBtn = class("UINAthAreaBtn", UIBaseNode)
local base = UIBaseNode
UINAthAreaBtn.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self.__OnClickRoot)
end

UINAthAreaBtn.InitAthAreaBtn = function(self, index, heroId, clickFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.index = index
  self.clickFunc = clickFunc
  self.heroId = heroId
  local athAreaCfg = (ConfigData.ath_area)[index]
  if athAreaCfg == nil then
    error("Can\'t get ath_area cfg, id = " .. tostring(index))
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = athAreaCfg.name1
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_SubName).text = (LanguageUtil.GetLocaleText)(athAreaCfg.name2)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.gameObject).name = athAreaCfg.name1
  self:ResetAthAreaBtnSelect()
end

UINAthAreaBtn.RefreshAthAreaBtn = function(self, unlockSpace)
  -- function num : 0_2 , upvalues : _ENV
  local athList = (PlayerDataCenter.allAthData):GetHeroAthList(self.heroId, self.index)
  local installSize = 0
  for k,athData in ipairs(athList) do
    installSize = athData.size + installSize
  end
  if self.isSelect == false then
    ((self.ui).tex_Rate):SetIndex(1, tostring(installSize), tostring(unlockSpace))
  else
    ;
    ((self.ui).tex_Rate):SetIndex(0, tostring(installSize), tostring(unlockSpace))
  end
end

UINAthAreaBtn.AthAreaBtnSelect = function(self, select)
  -- function num : 0_3 , upvalues : _ENV
  if select then
    ((self.ui).img_Select):SetIndex(1)
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).canvasGroup).alpha = 1
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self.ui).img_Select).image).color = Color.white
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).color = Color.black
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_SubName).color = Color.black
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self.ui).tex_Rate).text).color = Color.black
  else
    ;
    ((self.ui).img_Select):SetIndex(0)
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).canvasGroup).alpha = 0.9
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self.ui).img_Select).image).color = Color.gray
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).color = (self.ui).unselectColor
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_SubName).color = (self.ui).unselectColor
    -- DECOMPILER ERROR at PC62: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self.ui).tex_Rate).text).color = (self.ui).unselectColor
  end
  self.isSelect = select
end

UINAthAreaBtn.ResetAthAreaBtnSelect = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((self.ui).img_Select):SetIndex(0)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).canvasGroup).alpha = 1
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self.ui).img_Select).image).color = Color.white
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).color = Color.black
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_SubName).color = Color.black
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self.ui).tex_Rate).text).color = Color.black
  self.isSelect = nil
end

UINAthAreaBtn.__OnClickRoot = function(self)
  -- function num : 0_5
  if self.clickFunc ~= nil then
    (self.clickFunc)(self.index)
  end
end

UINAthAreaBtn.ShowAthAreaBtnBlueDot = function(self, show)
  -- function num : 0_6
  ((self.ui).blueDot):SetActive(show)
end

UINAthAreaBtn.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthAreaBtn


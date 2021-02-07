-- params : ...
-- function num : 0 , upvalues : _ENV
local UINEpCampFetter = class("UINEpCampFetter", UIBaseNode)
local base = UIBaseNode
local UINEpCampFetterSkillItem = require("Game.Exploration.UI.CampFetter.UINEpCampFetterSkillItem")
local UINEpCampFetterDetailCampItem = require("Game.Exploration.UI.CampFetter.UINEpCampFetterDetailCampItem")
UINEpCampFetter.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINEpCampFetterSkillItem, UINEpCampFetterDetailCampItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CampBondSkill, self, self.__OnClickActiveCampFetter)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CampBond, self, self.__ShowAllCampFetterDetail)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.__CloseAllCampFetterDetail)
  self.fetterSkillItemPool = (UIItemPool.New)(UINEpCampFetterSkillItem, (self.ui).obj_effItem)
  ;
  ((self.ui).obj_effItem):SetActive(false)
  self.detailCampItemPool = (UIItemPool.New)(UINEpCampFetterDetailCampItem, (self.ui).obj_campItem)
  ;
  ((self.ui).obj_campItem):SetActive(false)
  self:__CloseAllCampFetterDetail()
end

UINEpCampFetter.InitEpCampFetter = function(self, resLoader)
  -- function num : 0_1
  self.resLoader = resLoader
end

UINEpCampFetter.RefreshAllCampFetter = function(self, usingCampFetterList, totalUsingNum, resLoader)
  -- function num : 0_2 , upvalues : _ENV
  local hasFetterSkill = totalUsingNum > 0
  ;
  ((self.ui).obj_campFetterlist):SetActive(hasFetterSkill)
  ;
  ((self.ui).obj_empty):SetActive(not hasFetterSkill)
  if hasFetterSkill then
    local isFirst = true
    ;
    (self.fetterSkillItemPool):HideAll()
    ;
    (self.detailCampItemPool):HideAll()
    for _,campFetterDatas in ipairs(usingCampFetterList) do
      for _,fetterData in ipairs(campFetterDatas.campFetterList) do
        if fetterData.isUsing then
          local item = (self.fetterSkillItemPool):GetOne()
          item:InitEpCampFetterSkillItem(fetterData.cfg, isFirst, self.resLoader)
          isFirst = false
        end
      end
      local item = (self.detailCampItemPool):GetOne()
      item:InitDetailCampItem(campFetterDatas, self.resLoader)
    end
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UINEpCampFetter.__ShowAllCampFetterDetail = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if ExplorationManager.epCtrl == nil or not ((ExplorationManager.epCtrl).campFetterCtrl):IsHaveCampFetter() then
    return 
  end
  ;
  ((self.ui).obj_bondEff):SetActive(true)
  ;
  (((self.ui).btn_Close).gameObject):SetActive(true)
end

UINEpCampFetter.__CloseAllCampFetterDetail = function(self)
  -- function num : 0_4
  ((self.ui).obj_bondEff):SetActive(false)
  ;
  (((self.ui).btn_Close).gameObject):SetActive(false)
end

UINEpCampFetter.SetHasEpActiveCampFetter = function(self, hasEpActive)
  -- function num : 0_5
  ((self.ui).obj_btn_CampBondSkill):SetActive(hasEpActive)
end

UINEpCampFetter.SetActiveCampFetter = function(self, campId, heroNum, couldUse, cdStr)
  -- function num : 0_6 , upvalues : _ENV
  if couldUse then
    ((self.ui).img_btn_CampBondSkill):SetIndex(0)
    local campFetterCfg = ((ConfigData.camp_connection)[campId])[heroNum]
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).img_CampFetterIcon).sprite = (AtlasUtil.GetSpriteFromAtlas)(UIAtlasConsts.Atlas_CampFetterIcon, campFetterCfg.icon, self.resLoader)
    ;
    ((self.ui).tex_campFetterName):SetIndex(0, (LanguageUtil.GetLocaleText)(campFetterCfg.name))
    ;
    ((self.ui).tex_subText):SetIndex(0, (LanguageUtil.GetLocaleText)(((ConfigData.camp)[campId]).name))
  else
    do
      ;
      ((self.ui).img_btn_CampBondSkill):SetIndex(1)
      local campFetterCfg = ((ConfigData.camp_connection)[campId])[heroNum]
      -- DECOMPILER ERROR at PC61: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).img_CampFetterIcon).sprite = (AtlasUtil.GetSpriteFromAtlas)(UIAtlasConsts.Atlas_CampFetterIcon, campFetterCfg.icon, self.resLoader)
      ;
      ((self.ui).tex_campFetterName):SetIndex(1)
      ;
      ((self.ui).tex_subText):SetIndex(1, cdStr)
    end
  end
end

UINEpCampFetter.SetClickActiveCampFetter = function(self, useCampFetterCallback)
  -- function num : 0_7
  self.useCampFetterCallback = useCampFetterCallback
end

UINEpCampFetter.__OnClickActiveCampFetter = function(self)
  -- function num : 0_8
  if self.useCampFetterCallback ~= nil then
    (self.useCampFetterCallback)()
  end
end

UINEpCampFetter.OnDelete = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnDelete)(self)
end

return UINEpCampFetter


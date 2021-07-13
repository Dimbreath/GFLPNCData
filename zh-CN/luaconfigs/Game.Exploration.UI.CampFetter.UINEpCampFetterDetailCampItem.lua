-- params : ...
-- function num : 0 , upvalues : _ENV
local UINEpCampFetterDetailCampItem = class("UINEpCampFetterDetailCampItem", UIBaseNode)
local base = UIBaseNode
local UINEpCampFetterDetailSkillItem = require("Game.Exploration.UI.CampFetter.UINEpCampFetterDetailSkillItem")
UINEpCampFetterDetailCampItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINEpCampFetterDetailSkillItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.detailCampItemPool = (UIItemPool.New)(UINEpCampFetterDetailSkillItem, (self.ui).obj_bondEffDetailItem)
  ;
  ((self.ui).obj_bondEffDetailItem):SetActive(false)
end

UINEpCampFetterDetailCampItem.InitDetailCampItem = function(self, campFetterDatas, resloader)
  -- function num : 0_1 , upvalues : _ENV
  local campId = campFetterDatas.campId
  local campFetterList = campFetterDatas.campFetterList
  local campHeroCount = campFetterDatas.campHeroCount
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_CampName).text = (LanguageUtil.GetLocaleText)(((ConfigData.camp)[campId]).name)
  ;
  ((self.ui).tex_HeroCount):SetIndex(0, tostring(campHeroCount))
  ;
  (self.detailCampItemPool):HideAll()
  for index,fetterData in ipairs(campFetterList) do
    if fetterData.isUsing then
      local item = (self.detailCampItemPool):GetOne()
      item:InitDetailSkillItem(fetterData.cfg, resloader)
    end
  end
end

UINEpCampFetterDetailCampItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINEpCampFetterDetailCampItem


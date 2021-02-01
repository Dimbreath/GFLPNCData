-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFmtCampFetterItem = class("UINFmtCampFetterItem", UIBaseNode)
local base = UIBaseNode
local UINFmtCampFetterSkillItem = require("Game.Formation.UI.UINFmtCampFetterSkillItem")
UINFmtCampFetterItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINFmtCampFetterSkillItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).bondEffItem):SetActive(false)
  self.FetterSkillItemPool = (UIItemPool.New)(UINFmtCampFetterSkillItem, (self.ui).bondEffItem)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_campItem, self, self.__OnClick)
end

UINFmtCampFetterItem.InitFmtCampFetterItem = function(self, campId, count, resloader, clickCallback)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R5 in 'UnsetPending'

  (self.gameObject).name = tostring(campId)
  self.campId = campId
  self.clickCallback = clickCallback
  local campCfg = (ConfigData.camp)[campId]
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_CampIcon).sprite = CRH:GetSprite(campCfg.icon, CommonAtlasType.CareerCamp)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_HeroCount).text = tostring(count)
  local campFetterList = ((ConfigData.camp_connection).fetterList)[campId]
  ;
  (self.FetterSkillItemPool):HideAll()
  for index,neededHeroCount in ipairs(campFetterList) do
    if neededHeroCount <= count then
      local skillItem = (self.FetterSkillItemPool):GetOne()
      local campFetterCfg = ((ConfigData.camp_connection)[campId])[neededHeroCount]
      skillItem:InitFetterSkillItem(campFetterCfg, index == 1, resloader)
    end
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINFmtCampFetterItem.__OnClick = function(self)
  -- function num : 0_2
  if self.clickCallback ~= nil then
    (self.clickCallback)(self.campId)
  end
end

UINFmtCampFetterItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINFmtCampFetterItem


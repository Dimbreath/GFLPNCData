local UINDungeonInfoHeroDetail = class("UINDungeonInfoHeroDetail", UIBaseNode)
local base = UIBaseNode
local UINDungeonInfoHeroDetailAttr = require("Game.CommonUI.DungeonState.Info.UINDungeonInfoHeroDetailAttr")
local UINDungeonInfoHeroDetailSkill = require("Game.CommonUI.DungeonState.Info.UINDungeonInfoHeroDetailSkill")
local UINHeroCardItem = require("Game.Hero.NewUI.UINHeroCardItem")
local UINDungeonServerGridItem = require("Game.CommonUI.DungeonState.Info.UINDungeonServerGridItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local cs_Edge = ((CS.UnityEngine).RectTransform).Edge
UINDungeonInfoHeroDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroCardItem, UINDungeonInfoHeroDetailAttr, UINDungeonInfoHeroDetailSkill, UINDungeonServerGridItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.cardItem = (UINHeroCardItem.New)()
  ;
  (self.cardItem):Init((self.ui).obj_heroItem)
  self.attrPool = (UIItemPool.New)(UINDungeonInfoHeroDetailAttr, (self.ui).obj_attriItem)
  ;
  ((self.ui).obj_attriItem):SetActive(false)
  self.skillPool = (UIItemPool.New)(UINDungeonInfoHeroDetailSkill, (self.ui).obj_skillItem)
  ;
  ((self.ui).obj_skillItem):SetActive(false)
  self.serverGridPool = (UIItemPool.New)(UINDungeonServerGridItem, (self.ui).gridBuffItem)
  ;
  ((self.ui).gridBuffItem):SetActive(false)
  self.__onShowSkillDetail = BindCallback(self, self.__ShowSkillDetail)
  self.__onHideRichInfoDetail = BindCallback(self, self.__HideRichInfoDetail)
  self.__onShowServerGridDetail = BindCallback(self, self.__ShowServerGridDetail)
end

UINDungeonInfoHeroDetail.InitHeroInfo = function(self, dynHeroData, resloader)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).img_Quality).color = HeroRareColor[(dynHeroData.heroData).rare]
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Power).text = tostring(dynHeroData:GetFightingPower())
  local hpPer = dynHeroData.hpPer / 10000
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_Hp).fillAmount = hpPer
  local maxHp = dynHeroData:GetRealAttr(eHeroAttr.maxHp)
  local realHp = maxHp * dynHeroData.hpPer / 10000
  if dynHeroData.hpPer / 10000 > 0 then
    realHp = (math.max)(1, realHp)
  end
  ;
  ((self.ui).tex_Hp):SetIndex(0, tostring((math.floor)(realHp)), tostring(maxHp))
  ;
  (self.cardItem):InitHeroCardItem(dynHeroData.heroData, resloader, nil)
  ;
  (self.attrPool):HideAll()
  for _,attrId in ipairs((ConfigData.game_config).dungeonHeroMainAttrIds) do
    local attrVal = dynHeroData:GetRealAttr(attrId)
    local attrOriginVal = dynHeroData:GetOriginAttr(attrId)
    local attrItem = (self.attrPool):GetOne(true)
    attrItem:InitAttr(attrId, attrVal, attrOriginVal)
  end
  ;
  (self.skillPool):HideAll()
  for index,skillData in ipairs((dynHeroData.heroData).skillList) do
    if skillData.type ~= eHeroSkillType.LifeSkill and not skillData:IsCommonAttack() then
      local skillItem = (self.skillPool):GetOne(true)
      skillItem:InitSkillItem(skillData, resloader, self.__onShowSkillDetail, self.__onHideRichInfoDetail)
    end
  end
  for _,skillitem in ipairs((self.skillPool).listItem) do
    if (skillitem.skillData):IsPassiveSkill() then
      (skillitem.transform):SetSiblingIndex(0)
    else
      if (skillitem.skillData):IsUniqueSkill() then
        (skillitem.transform):SetSiblingIndex(#(self.skillPool).listItem)
      end
    end
  end
  if ExplorationManager.epCtrl ~= nil then
    (self.serverGridPool):HideAll()
    local dynPlayer = (ExplorationManager.epCtrl).dynPlayer
    local gridlist = (dynPlayer.allDynServerGrid):GetHeroServerGrid(dynHeroData.dataId)
    if gridlist ~= nil then
      for _,serverGrid in pairs(gridlist) do
        local gridItem = (self.serverGridPool):GetOne()
        gridItem:InitServerGridItem(serverGrid, self.__onShowServerGridDetail, self.__onHideRichInfoDetail)
      end
    end
  end
end

UINDungeonInfoHeroDetail.__ShowSkillDetail = function(self, item, skillData)
  -- function num : 0_2 , upvalues : _ENV
  if skillData:GetIsUnlock() then
    self.__onRichIntroOpen = BindCallback(self, self.__RichIntroOpen, skillData)
    UIManager:ShowWindowAsync(UIWindowTypeID.RichIntro, function(win)
    -- function num : 0_2_0 , upvalues : self
    if win ~= nil then
      (self.__onRichIntroOpen)(win)
    end
  end
)
  end
end

UINDungeonInfoHeroDetail.__RichIntroOpen = function(self, skillData, win)
  -- function num : 0_3 , upvalues : _ENV, cs_Edge
  local modifier = nil
  local infowin = UIManager:GetWindow(UIWindowTypeID.DungeonInfoDetail)
  if infowin ~= nil then
    modifier = (infowin.ui).modifier
  end
  win:ShowIntroBySkillData((self.ui).introHolder, skillData, "ff8400", true, modifier)
  win:SetIntroListPosition(cs_Edge.Left)
end

UINDungeonInfoHeroDetail.__HideRichInfoDetail = function(self)
  -- function num : 0_4 , upvalues : _ENV
  UIManager:HideWindow(UIWindowTypeID.RichIntro)
end

UINDungeonInfoHeroDetail.__ShowServerGridDetail = function(self, serverGrid)
  -- function num : 0_5 , upvalues : _ENV, cs_Edge
  UIManager:ShowWindowAsync(UIWindowTypeID.RichIntro, function(win)
    -- function num : 0_5_0 , upvalues : _ENV, serverGrid, self, cs_Edge
    if win == nil then
      return 
    end
    local modifier = nil
    local infowin = UIManager:GetWindow(UIWindowTypeID.DungeonInfoDetail)
    if infowin ~= nil then
      modifier = (infowin.ui).modifier
    end
    local name, desc = serverGrid:GetGridNameAndDesc()
    win:ShowIntroCustom((self.ui).gridIntroHolder, name, desc, true, modifier)
    win:SetIntroListPosition(cs_Edge.Left, cs_Edge.Top)
  end
)
end

UINDungeonInfoHeroDetail.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UINDungeonInfoHeroDetail


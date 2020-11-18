-- params : ...
-- function num : 0 , upvalues : _ENV
local UINDungeonInfoHeroDetail = class("UINDungeonInfoHeroDetail", UIBaseNode)
local base = UIBaseNode
local UINDungeonInfoHeroDetailAttr = require("Game.CommonUI.DungeonState.Info.UINDungeonInfoHeroDetailAttr")
local UINDungeonInfoHeroDetailSkill = require("Game.CommonUI.DungeonState.Info.UINDungeonInfoHeroDetailSkill")
local UINHeroCardItem = require("Game.Hero.NewUI.UINHeroCardItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
UINDungeonInfoHeroDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroCardItem, UINDungeonInfoHeroDetailAttr, UINDungeonInfoHeroDetailSkill
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
  self.__onShowSkillDetail = BindCallback(self, self.__ShowSkillDetail)
  self.__onHideSkillDetail = BindCallback(self, self.__HideSkillDetail)
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
  ;
  ((self.ui).tex_Hp):SetIndex(0, tostring((math.floor)(maxHp * hpPer)), tostring(maxHp))
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
    if skillData.type == eHeroSkillType.BattleSkill and not skillData:IsCommonAttack() then
      local skillItem = (self.skillPool):GetOne(true)
      skillItem:InitSkillItem(skillData, resloader, self.__onShowSkillDetail, self.__onHideSkillDetail)
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
end

UINDungeonInfoHeroDetail.__ShowSkillDetail = function(self, item, skillData)
  -- function num : 0_2 , upvalues : _ENV, HAType, VAType
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  win:SetTitleAndContext(skillData:GetName(), skillData:GetCurLevelDescribe())
  win:FloatTo(item.transform, HAType.center, VAType.up)
end

UINDungeonInfoHeroDetail.__HideSkillDetail = function(self)
  -- function num : 0_3 , upvalues : _ENV
  UIManager:HideWindow(UIWindowTypeID.FloatingFrame)
end

UINDungeonInfoHeroDetail.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINDungeonInfoHeroDetail


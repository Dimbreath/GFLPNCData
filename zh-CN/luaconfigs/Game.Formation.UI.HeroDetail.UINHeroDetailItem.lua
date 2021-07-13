-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroDetailItem = class("UINHeroDetailItem", UIBaseNode)
local base = UIBaseNode
local UINHeroCardItem = require("Game.Hero.NewUI.UINHeroCardItem")
local UINHeroAttributeNode = require("Game.Formation.UI.Common.UINHeroAttributeNode")
local UINBaseSkillItem = require("Game.CommonUI.Item.UINBaseSkillItem")
local FmtEnum = require("Game.Formation.FmtEnum")
local CS_EventTriggerListener = CS.EventTriggerListener
UINHeroDetailItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseSkillItem, CS_EventTriggerListener
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self.OnClickBtnRoot)
  ;
  ((self.ui).uINSkillItem):SetActive(false)
  self.skillItemPool = (UIItemPool.New)(UINBaseSkillItem, (self.ui).uINSkillItem)
  local eventTrigger = (CS_EventTriggerListener.Get)(self.gameObject)
  eventTrigger:onBeginDrag("+", BindCallback(self, self.OnBeginDrag))
  eventTrigger:onDrag("+", BindCallback(self, self.OnDrag))
  eventTrigger:onEndDrag("+", BindCallback(self, self.OnEndDrag))
end

UINHeroDetailItem.InitFmtHeroDetailItem = function(self, fmtIndex, heroId, fmtHeroDetail, resloader, lockStr, clickEvent)
  -- function num : 0_1 , upvalues : _ENV, FmtEnum, UINHeroCardItem, UINHeroAttributeNode
  self.clickEvent = clickEvent
  self.fmtIndex = fmtIndex
  self.fmtHeroDetail = fmtHeroDetail
  ;
  ((self.ui).lock):SetActive(false)
  ;
  ((self.ui).empty):SetActive(false)
  ;
  ((self.ui).hero):SetActive(false)
  self.heroDetailState = nil
  self.heroData = nil
  if not (string.IsNullOrEmpty)(lockStr) then
    self.heroDetailState = (FmtEnum.eFmtHeroDetailState).Lock
    ;
    ((self.ui).lock):SetActive(true)
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).tex_Condition).text = lockStr
  else
    if heroId == nil then
      self.heroDetailState = (FmtEnum.eFmtHeroDetailState).Empty
      ;
      ((self.ui).empty):SetActive(true)
    else
      self.heroDetailState = (FmtEnum.eFmtHeroDetailState).HasHero
      ;
      ((self.ui).hero):SetActive(true)
      local heroData = PlayerDataCenter:GetHeroData(heroId)
      if heroData == nil then
        return 
      end
      self.heroData = heroData
      local fightingPower = heroData:GetFightingPower()
      -- DECOMPILER ERROR at PC72: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((self.ui).tex_Power).text = tostring(fightingPower)
      if self.heroItem == nil then
        self.heroItem = (UINHeroCardItem.New)()
        ;
        (self.heroItem):Init((self.ui).heroItem)
      end
      ;
      (self.heroItem):InitHeroCardItem(heroData, resloader, nil)
      if self.attrNode == nil then
        self.attrNode = (UINHeroAttributeNode.New)()
        ;
        (self.attrNode):Init((self.ui).heroAttributeNode)
      end
      local attrDataList = {}
      for k,attrId in ipairs((ConfigData.game_config).FormationDetailAttr) do
        attrDataList[k] = {attrId = attrId, attrValue = heroData:GetAttr(attrId)}
      end
      ;
      (self.attrNode):InitHeroAttrNode(attrDataList)
      ;
      (self.skillItemPool):HideAll()
      for k,skillData in pairs(heroData.skillList) do
        if skillData.type ~= eHeroSkillType.LifeSkill and not skillData:IsCommonAttack() then
          local skillItem = (self.skillItemPool):GetOne()
          skillItem:InitBaseSkillItem(skillData, resloader)
        end
      end
    end
  end
end

UINHeroDetailItem.OnClickBtnRoot = function(self)
  -- function num : 0_2
  if self.clickEvent ~= nil then
    (self.clickEvent)(self.heroDetailState, self.heroData)
  end
end

UINHeroDetailItem.GetFmtHeroDetailState = function(self)
  -- function num : 0_3
  return self.heroDetailState
end

UINHeroDetailItem.GetFmtHeroDetailIndex = function(self)
  -- function num : 0_4
  return self.fmtIndex
end

UINHeroDetailItem.EnableFmtHeroRaycast = function(self, enable)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).uiNoDrawRaycast).raycastTarget = enable
end

UINHeroDetailItem.SetHeroDetailItemDragEvent = function(self, beginDragFunc, dragFunc, endDragFunc)
  -- function num : 0_6
  self.beginDragFunc = beginDragFunc
  self.dragFunc = dragFunc
  self.endDragFunc = endDragFunc
end

UINHeroDetailItem.OnBeginDrag = function(self, go, eventData)
  -- function num : 0_7
  if self.beginDragFunc ~= nil then
    (self.beginDragFunc)(self, eventData)
  end
end

UINHeroDetailItem.OnDrag = function(self, go, eventData)
  -- function num : 0_8
  if self.dragFunc ~= nil then
    (self.dragFunc)(self, eventData)
  end
end

UINHeroDetailItem.OnEndDrag = function(self, go, eventData)
  -- function num : 0_9
  if self.endDragFunc ~= nil then
    (self.endDragFunc)(self, eventData)
  end
end

UINHeroDetailItem.DragEndTweenHeroDetailItem = function(self, position)
  -- function num : 0_10
  self:ClearDragEndTween()
  self.__dragEndTween = (self.transform):DOMove(position, 0.2)
  self.__rootPos = position
end

UINHeroDetailItem.ClearDragEndTween = function(self)
  -- function num : 0_11
  if self.__dragEndTween ~= nil then
    (self.__dragEndTween):Kill(true)
    self.__dragEndTween = nil
  end
end

UINHeroDetailItem.GetHeroDetailItemRootPos = function(self)
  -- function num : 0_12
  if not self.__rootPos then
    return (self.transform).position
  end
end

UINHeroDetailItem.OnDelete = function(self)
  -- function num : 0_13 , upvalues : base
  self:ClearDragEndTween()
  ;
  (base.OnDelete)(self)
end

return UINHeroDetailItem


-- params : ...
-- function num : 0 , upvalues : _ENV
local UIFormationQuick = class("UIFormationQuick", UIBaseWindow)
local base = UIBaseWindow
local UINHeroAttributeNode = require("Game.Formation.UI.Common.UINHeroAttributeNode")
local UINHeroSortList = require("Game.Hero.NewUI.SortList.UINHeroSortList")
local UINFmtSkillItem = require("Game.Formation.UI.QuickFmt.UINFmtSkillItem")
local UINAthHeroInfo = require("Game.Arithmetic.AthHeroInfo.UINAthHeroInfo")
local UINSortButtonGroup = require("Game.Hero.NewUI.SortList.UINSortButtonGroup")
local UINSiftCondition = require("Game.Hero.NewUI.SortList.UINSiftCondition")
local HeroSortEnum = require("Game.Hero.NewUI.HeroSortEnum")
local HeroFilterEnum = require("Game.Hero.NewUI.HeroFilterEnum")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local CS_ResLoader = CS.ResLoader
local CS_MessageCommon = CS.MessageCommon
UIFormationQuick.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINFmtSkillItem, CS_ResLoader, UINHeroSortList, UINSortButtonGroup, UINAthHeroInfo
  (UIUtil.CreateTopBtnGroup)((self.ui).topButtonGroup, self, self.OnClickBack)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Comfirm, self, self.OnClickConfirm)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Filter, self, self.OnBtnFilterClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Detail, self, self.OnBtnDetailClick)
  ;
  ((self.ui).skillItem):SetActive(false)
  self.skillItemPool = (UIItemPool.New)(UINFmtSkillItem, (self.ui).skillItem)
  self.__ShowSkillDescription = BindCallback(self, self.ShowSkillDescription)
  self.__HideSkillDetail = BindCallback(self, self.HideSkillDetail)
  self.resloader = (CS_ResLoader.Create)()
  local HeroSortList = (UINHeroSortList.New)()
  HeroSortList:Init((self.ui).heroList)
  HeroSortList:InitHeroSortList(self.resloader, nil, BindCallback(self, self.OnSelectHero), false, false, false, false)
  HeroSortList:SetHeroListAnchorPosOffset(1)
  self.heroSortList = HeroSortList
  local sortButtonGroup = (UINSortButtonGroup.New)()
  sortButtonGroup:Init((self.ui).sortButtonGroup)
  self.sortButtonGroup = sortButtonGroup
  self.athNode = (UINAthHeroInfo.New)()
  ;
  (self.athNode):Init((self.ui).algorithmNode)
end

UIFormationQuick.InitQuickFmt = function(self, fmtId, fmtCtrl, selectHeroData)
  -- function num : 0_1 , upvalues : HeroSortEnum, _ENV
  self.fmtCtrl = fmtCtrl
  self:RefreshFmtData(fmtId)
  ;
  (self.sortButtonGroup):InitSortButtonGroup(HeroSortEnum.SortMannerDefine, BindCallback(self, self.__OnBtnSortItemClick))
  ;
  (self.heroSortList):SetInFormationHero(self.inFormationDic)
  self:RefreshSelectedHero(selectHeroData)
  self:RefreshFmtHeroCount()
end

UIFormationQuick.RefreshFmtData = function(self, fmtId)
  -- function num : 0_2 , upvalues : _ENV
  local formationData = (PlayerDataCenter.formationDic)[fmtId]
  if formationData == nil then
    error("Can\'t get formationData, formationId = " .. tostring(fmtId))
    return 
  end
  self.originalFormationData = formationData
  self.inFmtHeroList = {}
  self.inFmtBenchHeroList = {}
  self.inFormationDic = {}
  self.fmtMaxHeroCount = (ConfigData.game_config).max_stage_hero
  self.fmtMaxBenchHeroCount = 0
  for i = 1, self.fmtMaxHeroCount do
    local heroId = (formationData.data)[i]
    if heroId ~= nil then
      (table.insert)(self.inFmtHeroList, heroId)
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self.inFormationDic)[heroId] = false
    end
  end
  for i = 1, (ConfigData.game_config).max_bench_hero do
    local unlock = ((self.fmtCtrl).BenchUnlock)(i)
    if unlock then
      self.fmtMaxBenchHeroCount = self.fmtMaxBenchHeroCount + 1
      local heroId = (formationData.data)[i + self.fmtMaxHeroCount]
      if heroId ~= nil then
        (table.insert)(self.inFmtBenchHeroList, heroId)
        -- DECOMPILER ERROR at PC68: Confused about usage of register: R9 in 'UnsetPending'

        ;
        (self.inFormationDic)[heroId] = true
      end
    end
  end
end

UIFormationQuick.RefreshFmtHeroCount = function(self)
  -- function num : 0_3 , upvalues : _ENV
  ((self.ui).tex_MainNum):SetIndex(0, tostring(#self.inFmtHeroList), tostring(self.fmtMaxHeroCount))
  ;
  ((self.ui).tex_SubNum):SetIndex(0, tostring(#self.inFmtBenchHeroList), tostring(self.fmtMaxBenchHeroCount))
end

UIFormationQuick.RefreshSelectedHero = function(self, heroData)
  -- function num : 0_4 , upvalues : _ENV, UINHeroAttributeNode
  if heroData == nil then
    ((self.ui).heroDetailNode):SetActive(false)
    ;
    ((self.ui).emptyNode):SetActive(true)
    return 
  end
  self.heroData = heroData
  ;
  ((self.ui).heroDetailNode):SetActive(true)
  ;
  ((self.ui).emptyNode):SetActive(false)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = heroData:GetName()
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_FightingPower).text = tostring(heroData:GetFightingPower())
  self:RefreshLevel(heroData.level)
  if self.attrNode == nil then
    self.attrNode = (UINHeroAttributeNode.New)()
    ;
    (self.attrNode):Init((self.ui).heroAttributeNode)
  end
  local attrDataList = {}
  local index = 0
  for _,attrId in ipairs((ConfigData.attribute).baseAttrIds) do
    if index < 10 then
      do
        if ((ConfigData.attribute)[attrId]).merge_attribute == 0 then
          index = index + 1
          attrDataList[index] = {attrId = attrId, attrValue = heroData:GetAttr(attrId)}
        end
        -- DECOMPILER ERROR at PC74: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC74: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  ;
  (self.attrNode):InitHeroAttrNode(attrDataList)
  ;
  (self.skillItemPool):HideAll()
  for k,skillData in pairs(heroData.skillList) do
    if skillData.type ~= eHeroSkillType.LifeSkill and not skillData:IsCommonAttack() then
      local skillItem = (self.skillItemPool):GetOne()
      skillItem:InitFmtSkillItem(skillData, self.resloader, nil, self.__ShowSkillDescription, self.__HideSkillDetail)
    end
  end
  ;
  (self.athNode):InitAthHeroInfo(heroData, self.resloader)
end

UIFormationQuick.RefreshLevel = function(self, level)
  -- function num : 0_5 , upvalues : _ENV
  if level > 999 then
    warn("level Num is out off MaxSize 999")
  end
  local empty = ""
  if level <= 9 then
    empty = "00"
  else
    if level <= 99 then
      empty = "0"
    end
  end
  ;
  ((self.ui).tex_Level):SetIndex(0, empty, level)
end

UIFormationQuick.ShowSkillDescription = function(self, item, skillData)
  -- function num : 0_6 , upvalues : _ENV, HAType, VAType
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  win:SetTitleAndContext(skillData:GetName(), skillData:GetCurLevelDescribe())
  win:FloatTo(item.transform, HAType.autoCenter, VAType.up)
end

UIFormationQuick.HideSkillDetail = function(self, skillData)
  -- function num : 0_7 , upvalues : _ENV
  UIManager:HideWindow(UIWindowTypeID.FloatingFrame)
end

UIFormationQuick.OnSelectHero = function(self, heroData, heroCardItem)
  -- function num : 0_8 , upvalues : _ENV, CS_MessageCommon
  local heroId = heroData.dataId
  if (self.inFormationDic)[heroId] == nil then
    if self.fmtMaxHeroCount + self.fmtMaxBenchHeroCount <= (table.count)(self.inFormationDic) then
      (CS_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Formation_MaxHeroCount))
      return 
    end
    local isBench = self.fmtMaxHeroCount <= #self.inFmtHeroList
    if isBench then
      (table.insert)(self.inFmtBenchHeroList, heroId)
    else
      (table.insert)(self.inFmtHeroList, heroId)
    end
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self.inFormationDic)[heroId] = isBench
    if heroCardItem ~= nil then
      heroCardItem:SetSelectActive(true, isBench)
    end
    self:RefreshSelectedHero(heroData)
  else
    if (self.inFormationDic)[heroId] then
      (table.removebyvalue)(self.inFmtBenchHeroList, heroId)
    else
      (table.removebyvalue)(self.inFmtHeroList, heroId)
    end
    -- DECOMPILER ERROR at PC70: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self.inFormationDic)[heroId] = nil
    if heroCardItem ~= nil then
      heroCardItem:SetSelectActive(false)
    end
    self:RefreshSelectedHero(nil)
  end
  self:RefreshFmtHeroCount()
  -- DECOMPILER ERROR: 9 unprocessed JMP targets
end

UIFormationQuick.__OnBtnSortItemClick = function(self, sortFunc)
  -- function num : 0_9
  (self.heroSortList):RefreshHeroSortList(nil, sortFunc)
end

UIFormationQuick.OnBtnDetailClick = function(self)
  -- function num : 0_10 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroState, function(windows)
    -- function num : 0_10_0 , upvalues : _ENV, self
    if windows == nil then
      error((LanguageUtil.GetLocaleText)((self.heroData).name) .. "Click can\'t show state")
      return 
    end
    windows:InitHeroState(self.heroData, self.resloader, (self.heroSortList).curHeroList, function()
      -- function num : 0_10_0_0 , upvalues : self
      self:RefreshSelectedHero(self.heroData)
    end
)
    windows:RegistFromeWindowTypeID(UIWindowTypeID.FormationQuick)
  end
)
  self:Hide()
end

UIFormationQuick.OnBtnFilterClick = function(self)
  -- function num : 0_11 , upvalues : UINSiftCondition, HeroFilterEnum, _ENV
  do
    if self.siftCondition == nil then
      local SiftConditionPage = (UINSiftCondition.New)()
      SiftConditionPage:Init((self.ui).sortConditionNode)
      SiftConditionPage:InitSiftCondition(HeroFilterEnum.eKindType, HeroFilterEnum.eKindMaxCount, BindCallback(self, self.OnFilterConfirmAction))
      self.siftCondition = SiftConditionPage
    end
    ;
    (self.siftCondition):Show()
  end
end

UIFormationQuick.OnFilterConfirmAction = function(self, sortKindData)
  -- function num : 0_12 , upvalues : _ENV
  self.sortKindData = sortKindData
  if self.__SiftFunction == nil then
    self.__SiftFunction = BindCallback(self, self.SiftFunction)
  end
  ;
  (self.heroSortList):RefreshHeroSortList(self.__SiftFunction, nil)
end

UIFormationQuick.SiftFunction = function(self, heroData)
  -- function num : 0_13 , upvalues : HeroFilterEnum
  local rareConfig = (self.sortKindData)[(HeroFilterEnum.eKindType).Rare]
  if not rareConfig.nocondition then
    local rankOk = (rareConfig.selectIndexs)[heroData.rare]
  end
  local campConfig = (self.sortKindData)[(HeroFilterEnum.eKindType).Camp]
  if not campConfig.nocondition then
    local campOk = (campConfig.selectIndexs)[heroData.camp]
  end
  local careerConfig = (self.sortKindData)[(HeroFilterEnum.eKindType).Career]
  if not careerConfig.nocondition then
    local careerOk = (careerConfig.selectIndexs)[heroData.career]
  end
  if rankOk and campOk and careerOk then
    return true
  else
    return false
  end
end

UIFormationQuick.OnClickBack = function(self)
  -- function num : 0_14
  (self.fmtCtrl):ExitQuickFormation()
end

UIFormationQuick.OnClickConfirm = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local newFmtHeroData = {}
  for k,heroId in ipairs(self.inFmtHeroList) do
    newFmtHeroData[k] = heroId
  end
  for k,heroId in ipairs(self.inFmtBenchHeroList) do
    newFmtHeroData[k + self.fmtMaxHeroCount] = heroId
  end
  local changed = false
  local oldFmtHeroData = (self.originalFormationData).data
  if (table.count)(oldFmtHeroData) == (table.count)(newFmtHeroData) then
    for k,v in pairs(newFmtHeroData) do
      if oldFmtHeroData[k] ~= v then
        changed = true
        break
      end
    end
  else
    do
      changed = true
      if changed then
        (self.fmtCtrl):ModifyFormation(newFmtHeroData)
      end
      ;
      (self.fmtCtrl):ExitQuickFormation()
    end
  end
end

UIFormationQuick.OnDelete = function(self)
  -- function num : 0_16 , upvalues : base
  (self.skillItemPool):DeleteAll()
  ;
  (self.heroSortList):Delete()
  ;
  (self.sortButtonGroup):Delete()
  if self.siftCondition ~= nil then
    (self.siftCondition):Delete()
  end
  ;
  (self.athNode):Delete()
  ;
  (self.resloader):Put2Pool()
  self.resloader = nil
  ;
  (base.OnDelete)(self)
end

return UIFormationQuick


-- params : ...
-- function num : 0 , upvalues : _ENV
local UIHeroState = class("UIHeroState", UIBaseWindow)
local base = UIBaseWindow
local UINAttrOutlineWindow = require("Game.CommonUI.Hero.Attr.UINAttrOutLineWindow")
local UINHeroScoreItem = require("Game.Hero.NewUI.State.UINHeroScoreItem")
local UINHeroStateSkillItem = require("Game.Hero.NewUI.State.UINHeroStateSkillItem")
local UINHeroTag = require("Game.Hero.NewUI.State.UINHeroTag")
local UINAthHeroInfo = require("Game.Arithmetic.AthHeroInfo.UINAthHeroInfo")
local JumpManager = require("Game.Jump.JumpManager")
local cs_ResLoader = CS.ResLoader
local CS_LeanTouch = ((CS.Lean).Touch).LeanTouch
local CS_Screen = (CS.UnityEngine).Screen
local cs_Shadow = ((CS.UnityEngine).UI).Shadow
local cs_DOTween = ((CS.DG).Tweening).DOTween
local CS_coroutine = require("XLua.Common.cs_coroutine")
UIHeroState.InitAllTween = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.allTweens = (self.transform):GetComponentsInChildren(typeof(((CS.DG).Tweening).DOTweenAnimation))
end

UIHeroState.PlayAllDOTween = function(self)
  -- function num : 0_1
  for i = 0, (self.allTweens).Length - 1 do
    local tween = (self.allTweens)[i]
    tween:DORestart(false)
  end
end

UIHeroState.OnInit = function(self)
  -- function num : 0_2 , upvalues : _ENV, UINHeroTag, UINHeroScoreItem, UINHeroStateSkillItem, UINAthHeroInfo, JumpManager
  self.campPos = (((self.ui).group_img_Camp).transform).localPosition
  self.heroPos = (((self.ui).group_hero).transform).localPosition
  self.resloader = nil
  self.StarList = {}
  self.heroId = nil
  self.heroData = nil
  self.heroDataList = nil
  self.bigImgResloader = nil
  self.levelUpWin = nil
  self.starUpWin = nil
  self.skillUgradeWin = nil
  ;
  (UIUtil.SetTopStatus)(self, self.Return)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_LevelUp, self, self.OnClickLevelUP)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_StarUp, self, self.OnClickStarUP)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Friendship, self, self.OnClickFriendship)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Skill, self, self.OnClickSillUpgrade)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Attri, self, self.OnClickAttribute)
  self.__addAllTouch = BindCallback(self, self.AddAllTouch)
  self.__removeAllTouch = BindCallback(self, self.RemoveAllTouch)
  self.__startTouch = BindCallback(self, self.StartTouch)
  self.__inTouching = BindCallback(self, self.InTouching)
  self.__endTouch = BindCallback(self, self.EndTouch)
  self:InitAllTween()
  self:AddAllTouch()
  self.potentialImgWidth = ((((self.ui).img_Breakthrough).sprite).textureRect).width
  self.__SwitchHeroState = BindCallback(self, self.SwitchHeroState)
  self.__CanClick = BindCallback(self, function()
    -- function num : 0_2_0 , upvalues : self
    return not self.isStartSwipe
  end
)
  ;
  (table.insert)(self.StarList, (self.ui).img_star)
  self.__refresh = BindCallback(self, self.Refresh)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__refresh)
  self.__onItemUpdate = BindCallback(self, self.OnItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onItemUpdate)
  self.__onFriendshipDataUpdate = BindCallback(self, self.OnFriendshipDataUpdate)
  MsgCenter:AddListener(eMsgEventId.OnHeroFriendshipDataChange, self.__onFriendshipDataUpdate)
  self.__onAthDataUpdate = BindCallback(self, self.OnAthDataUpdate)
  MsgCenter:AddListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
  self.tagPool = (UIItemPool.New)(UINHeroTag, (self.ui).obj_tagItem)
  ;
  ((self.ui).obj_tagItem):SetActive(false)
  self.scorePool = (UIItemPool.New)(UINHeroScoreItem, (self.ui).obj_scoreItem)
  ;
  ((self.ui).obj_scoreItem):SetActive(false)
  self.skillPool = (UIItemPool.New)(UINHeroStateSkillItem, (self.ui).obj_skillItem)
  ;
  ((self.ui).obj_skillItem):SetActive(false)
  ;
  ((self.ui).logicPreviewNode):SetActive(false)
  local isStarUpUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroRank)
  self:UnlockStarup(isStarUpUnlock)
  local isFriendshipUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship)
  self:UnlockFriendship(isFriendshipUnlock)
  self.athNode = (UINAthHeroInfo.New)()
  ;
  (self.athNode):Init((self.ui).algorithm)
  JumpManager.couldUseItemJump = true
end

UIHeroState.UnlockStarup = function(self, bool)
  -- function num : 0_3
  (((self.ui).btn_StarUp).gameObject):SetActive(bool)
end

UIHeroState.UnlockFriendship = function(self, bool)
  -- function num : 0_4
  (((self.ui).btn_Friendship).gameObject):SetActive(bool)
end

UIHeroState.InitHeroState = function(self, heroData, heroDataList, returnFunc)
  -- function num : 0_5 , upvalues : cs_ResLoader, _ENV
  self.resloader = (cs_ResLoader.Create)()
  self.heroDataList = heroDataList
  local heroCfg = heroData.heroCfg
  self.heroId = heroData.dataId
  self.heroData = heroData
  self.returnFunc = returnFunc
  self.heroName = (LanguageUtil.GetLocaleText)(heroCfg.name)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = self.heroName
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_ENName).text = heroCfg.name_en
  ;
  ((self.ui).img_Carrer):SetIndex(heroCfg.career - 1)
  local campIcon = (LanguageUtil.GetLocaleText)(((self.heroData):GetCampCfg()).icon)
  ;
  (self.resloader):LoadABAssetAsync(PathConsts:GetCampPicPath(campIcon), function(texture)
    -- function num : 0_5_0 , upvalues : _ENV, self
    if IsNull(self.transform) then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Camp).texture = texture
  end
)
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
  end
  self.bigImgResloader = (cs_ResLoader.Create)()
  ;
  (self.bigImgResloader):LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(heroData:GetResName()), function(prefab)
    -- function num : 0_5_1 , upvalues : _ENV, self
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate((self.ui).heroHolder)
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroList")
    self:UpdateHeroShadow()
  end
)
  ;
  (self.athNode):InitAthHeroInfo(self.heroData, self.resloader)
  ;
  (self.athNode):SetShowAthWindowParam(self.bigImgResloader, self.__addAllTouch, self.__removeAllTouch, self.__SwitchHeroState, self.__CanClick)
  self:InitRedDotEvent()
  self:Refresh()
  if GuideManager:TryTriggerGuide(eGuideCondition.InHeroStateUI) then
  end
end

UIHeroState.Refresh = function(self)
  -- function num : 0_6
  self:UpdateLevelAndExp()
  self:UpdateRareInfo()
  self:UpdateStarNum()
  self:UpdateAbilityScore()
  self:UpdateSkill()
  self:UpdateTagInfo()
  self:UpdateChipCount()
  self:UpdateFriendShipLevel()
  self:UpdateEfficiency()
  self:RefreshRedDot()
  self:UpdateAthData()
  self:UpdateHeroAttri()
  self:UpdatePotential()
end

UIHeroState.InitRedDotEvent = function(self)
  -- function num : 0_7 , upvalues : _ENV
  self:RefreshRedDot()
  self.__onheroCardStarRedDotEvent = function(node)
    -- function num : 0_7_0 , upvalues : self
    if node:GetRedDotCount() <= 0 then
      ((self.ui).obj_RedDot_StarUp):SetActive(self.heroId == nil or self.heroId ~= node:GetParentNodeId())
      -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
  end

  RedDotController:AddListener(RedDotDynPath.HeroCardStartUpPath, self.__onheroCardStarRedDotEvent)
  self.__onheroCardFriendshipRedDotEvent = function(node)
    -- function num : 0_7_1 , upvalues : self
    if node:GetRedDotCount() <= 0 then
      ((self.ui).obj_RedDot_FriendShip):SetActive(self.heroId == nil or self.heroId ~= node:GetParentNodeId())
      -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
  end

  RedDotController:AddListener(RedDotDynPath.HeroCardFriendshipPath, self.__onheroCardFriendshipRedDotEvent)
  self:UpdateBlueDot()
end

UIHeroState.UpdateBlueDot = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self.heroData == nil then
    return 
  end
  local isSkillLevelUpUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SkillUp)
  if isSkillLevelUpUnlock then
    local blueDotUpgradeSkill = (self.heroData):AbleUpgradeSkill()
    ;
    ((self.ui).obj_blueDot_SkillUp):SetActive(blueDotUpgradeSkill)
  else
    do
      ;
      ((self.ui).obj_blueDot_SkillUp):SetActive(false)
      if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential) then
        local buleDotUpPontential = (self.heroData):AblePotential()
      end
      ;
      ((self.ui).herolevle_blueDot):SetActive(buleDotUpPontential)
      local ok, heroFriendshipSkillNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, self.heroId, RedDotStaticTypeId.HeroFriendship)
      if ok and heroFriendshipSkillNode:GetRedDotCount() > 0 then
        ((self.ui).obj_blueDot_FriendShip):SetActive(false)
      else
        ;
        ((self.ui).obj_blueDot_FriendShip):SetActive((PlayerDataCenter.allFriendshipData):GetCouldUpgradeForestLine(self.heroId))
      end
    end
  end
end

UIHeroState.RefreshRedDot = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local ok, heroStarUpNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, self.heroId, RedDotStaticTypeId.HeroStarUp)
  ;
  ((self.ui).obj_RedDot_StarUp):SetActive(not ok or heroStarUpNode:GetRedDotCount() > 0)
  local ok, heroFriendshipSkillNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, self.heroId, RedDotStaticTypeId.HeroFriendship)
  ;
  ((self.ui).obj_RedDot_FriendShip):SetActive(not ok or heroFriendshipSkillNode:GetRedDotCount() > 0)
  self:UpdateBlueDot()
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UIHeroState.RemoveRedDotEvent = function(self)
  -- function num : 0_10 , upvalues : _ENV
  RedDotController:RemoveListener(RedDotDynPath.HeroCardStartUpPath, self.__onheroCardStarRedDotEvent)
  RedDotController:RemoveListener(RedDotDynPath.HeroCardFriendshipPath, self.__onheroCardFriendshipRedDotEvent)
end

UIHeroState.UpdateAbilityScore = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local rank = (self.heroData).rank
  local scoreCfgs = ConfigData.hero_score
  local heroStarCfg = ((ConfigData.hero_star)[self.heroId])[rank]
  ;
  (table.sort)(scoreCfgs, function(a, b)
    -- function num : 0_11_0
    do return a.sortId < b.sortId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  setmetatable(heroStarCfg.atrGrowthDic, {__index = heroStarCfg.atrBaseDic})
  ;
  (self.scorePool):HideAll()
  for index,cfg in ipairs(scoreCfgs) do
    local growthNum = (heroStarCfg.atrGrowthDic)[cfg.attribute_id]
    local scoreItem = (self.scorePool):GetOne(true)
    scoreItem:initScoreItem(cfg, growthNum)
  end
  setmetatable(heroStarCfg.atrGrowthDic, {})
end

UIHeroState.UpdateStarNum = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local num = ((self.heroData).rankCfg).star
  local count = (math.ceil)(num / 2)
  local isHalf = num % 2 == 1
  for _,starGameObject in ipairs(self.StarList) do
    (starGameObject.gameObject):SetActive(false)
  end
  for i = 1, count do
    if (self.StarList)[i] ~= nil then
      (((self.StarList)[i]).gameObject):SetActive(true)
      ;
      ((self.StarList)[i]):SetIndex(0)
    else
      local imgItemInfo = ((((self.ui).img_star).gameObject):Instantiate()):GetComponent(typeof(CS.UiImageItemInfo))
      ;
      (table.insert)(self.StarList, imgItemInfo)
      ;
      (imgItemInfo.gameObject):SetActive(true)
    end
  end
  if isHalf then
    ((self.StarList)[count]):SetIndex(1)
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

UIHeroState.UpdateRareInfo = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local rare = ((self.heroData).rankCfg).rare
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_Quality).color = HeroRareColor[rare]
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Quality).text = HeroRareString[rare]
end

UIHeroState.UpdateTagInfo = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local tags = (self.heroData):GetTag()
  ;
  (self.tagPool):HideAll()
  for index,value in ipairs(tags) do
    local item = (self.tagPool):GetOne(true)
    item:InitTag(value)
  end
end

UIHeroState.UpdateLevelAndExp = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local level = (self.heroData).level
  local curExp = (self.heroData).curExp
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
  ((self.ui).texInfo_Level):SetIndex(0, empty, level)
  ;
  ((self.ui).tex_Level):StartScrambleTypeWriter()
  if (self.heroData):IsFullLevel() then
    ((self.ui).texInfo_Exp):SetIndex(1)
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).img_Process).fillAmount = 1
  else
    local nextLevelExp = ((ConfigData.hero_level)[level]).exp
    ;
    ((self.ui).texInfo_Exp):SetIndex(0, tostring(curExp), tostring(nextLevelExp))
    ;
    ((self.ui).tex_Exp):StartScrambleTypeWriter()
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).img_Process).fillAmount = curExp / nextLevelExp
  end
  do
    local isShake = (not (self.heroData):IsFullPotential() and (self.heroData):IsReachLevelLimit())
    ;
    (((self.ui).tr_Shake).gameObject):SetActive(isShake)
    do
      if isShake then
        local x = self.potentialImgWidth * (self.heroData).potential
        -- DECOMPILER ERROR at PC95: Confused about usage of register: R6 in 'UnsetPending'

        ;
        ((self.ui).tr_Shake).localPosition = Vector3(x, 0, 0)
      end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
end

UIHeroState.UpdateSkill = function(self)
  -- function num : 0_16 , upvalues : _ENV
  (self.skillPool):HideAll()
  for k,skillData in ipairs((self.heroData).skillList) do
    if skillData.type ~= eHeroSkillType.LifeSkill and not skillData:IsCommonAttack() then
      local item = (self.skillPool):GetOne(true)
      item:InitSkillItem(skillData, self.resloader)
    end
  end
end

UIHeroState.OnClickLevelUP = function(self)
  -- function num : 0_17 , upvalues : _ENV
  if self.isStartSwipe then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroLevelUp, function(windows)
    -- function num : 0_17_0 , upvalues : _ENV, self
    if windows == nil then
      error("Can\'t open " .. self.heroId .. "\'s levelUp window")
      return 
    end
    self:RemoveAllTouch()
    windows:InitHeroLevelUp(self.heroData, self.resloader, self.__addAllTouch, self.__SwitchHeroState)
    self.levelUpWin = windows
    windows.closeEvent = BindCallback(self, function()
      -- function num : 0_17_0_0 , upvalues : self
      self:UpdateBlueDot()
      self:UpdateEfficiency()
    end
)
    if not (self.heroData):IsFullLevel() and (self.heroData):IsReachLevelLimit() and not GuideManager.inGuide and FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential) then
      UIManager:ShowWindowAsync(UIWindowTypeID.HeroPotential, function(window)
      -- function num : 0_17_0_1 , upvalues : self
      window:InitPotential(self.heroData)
    end
)
    end
    local parWin = UIManager:GetWindow(UIWindowTypeID.HeroState)
    if parWin ~= nil then
      parWin:Hide()
    end
  end
)
end

UIHeroState.OnClickStarUP = function(self)
  -- function num : 0_18 , upvalues : _ENV
  if self.isStartSwipe then
    return 
  end
  if (self.heroData):IsFullRank() then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroStarUp, function(windows)
    -- function num : 0_18_0 , upvalues : _ENV, self
    if windows == nil then
      error("Can\'t open " .. self.heroId .. "\'s starUP window")
      return 
    end
    self:RemoveAllTouch()
    windows:InitHeroStarUp(self.resloader, function()
      -- function num : 0_18_0_0 , upvalues : self
      self:UpdateEfficiency()
      self:AddAllTouch()
    end
, self.__SwitchHeroState)
    windows:SwitchHero(self.heroData)
    self.starUpWin = windows
    local parWin = UIManager:GetWindow(UIWindowTypeID.HeroState)
    if parWin ~= nil then
      parWin:Hide()
    end
  end
)
end

UIHeroState.OnClickFriendship = function(self)
  -- function num : 0_19 , upvalues : _ENV
  if self.isStartSwipe then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.FriendShip, function(windows)
    -- function num : 0_19_0 , upvalues : _ENV, self
    if windows == nil then
      error("Can\'t open " .. self.heroId .. "\'s FriendShip window")
      return 
    end
    self:RemoveAllTouch()
    windows:InitFriendshipSkillUpgrade(self.heroData, self.resloader, function()
      -- function num : 0_19_0_0 , upvalues : self, _ENV
      self:AddAllTouch()
      self:UpdateEfficiency()
      self:UpdateBlueDot()
      local win = UIManager:GetWindow(UIWindowTypeID.HeroState)
      if win ~= nil and not win.active then
        win.active = true
        ;
        (win.gameObject):SetActive(true)
      end
    end
, self.__SwitchHeroState)
    local parWin = UIManager:GetWindow(UIWindowTypeID.HeroState)
    if parWin ~= nil then
      parWin:Hide()
    end
  end
)
end

UIHeroState.OnClickSillUpgrade = function(self)
  -- function num : 0_20 , upvalues : _ENV
  if self.isStartSwipe then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroSkillUpgrade, function(windows)
    -- function num : 0_20_0 , upvalues : _ENV, self
    if windows == nil then
      error("Can\'t open " .. self.heroId .. "\'s levelUp window")
      return 
    end
    self:RemoveAllTouch()
    windows:InitSkillUpgrade(self.heroData, self.resloader, self.__addAllTouch, self.__SwitchHeroState)
    self.skillUgradeWin = windows
    windows.closeEvent = BindCallback(self, function()
      -- function num : 0_20_0_0 , upvalues : self
      self:UpdateBlueDot()
      self:UpdateSkill()
      self:UpdateEfficiency()
    end
)
    local parWin = UIManager:GetWindow(UIWindowTypeID.HeroState)
    if parWin ~= nil then
      parWin:Hide()
    end
  end
)
end

UIHeroState.OnClickAttribute = function(self)
  -- function num : 0_21
  if self.attrOutLineWindow ~= nil then
    self:RemoveAllTouch()
    ;
    (self.attrOutLineWindow):Show()
  end
end

UIHeroState.OnItemUpdate = function(self)
  -- function num : 0_22
  self:UpdateChipCount()
end

UIHeroState.OnFriendshipDataUpdate = function(self)
  -- function num : 0_23
  self:UpdateFriendShipLevel()
  self:UpdateHeroAttri()
  self:UpdateEfficiency()
end

UIHeroState.OnAthDataUpdate = function(self)
  -- function num : 0_24
  (self.athNode):RefreshAthHeroInfoChart()
  self:UpdateHeroAttri()
  self:UpdateEfficiency()
end

UIHeroState.UpdateChipCount = function(self)
  -- function num : 0_25 , upvalues : _ENV
  local isFullRank = (self.heroData):IsFullRank()
  ;
  (((self.ui).img_Chip).gameObject):SetActive(not isFullRank)
  ;
  (((self.ui).tex_ChipCount).gameObject):SetActive(not isFullRank)
  ;
  (((self.ui).tex_RankMax).gameObject):SetActive(isFullRank)
  if not isFullRank then
    local fragCount = (self.heroData):GetHeroFragCount()
    local needFrag = (self.heroData):StarNeedFrag()
    ;
    ((self.ui).tex_ChipCount):SetIndex(0, tostring(fragCount or 0), tostring(needFrag or 0))
  end
end

UIHeroState.UpdateFriendShipLevel = function(self)
  -- function num : 0_26 , upvalues : _ENV
  local level = (PlayerDataCenter.allFriendshipData):GetLevel(self.heroId)
  if level < 10 then
    ((self.ui).tex_FriendShipLevel):SetIndex(0, tostring(level))
  else
    ;
    ((self.ui).tex_FriendShipLevel):SetIndex(1, tostring(level))
  end
end

UIHeroState.UpdateHeroShadow = function(self)
  -- function num : 0_27 , upvalues : _ENV, cs_Shadow, cs_DOTween
  if self.bigImgGameObject == nil then
    return 
  end
  self.shadow = (self.bigImgGameObject):GetComponent(typeof(cs_Shadow))
  if self.shadow == nil then
    self.shadow = (self.bigImgGameObject):AddComponent(typeof(cs_Shadow))
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.shadow).effectColor = (Color.New)(0, 0, 0, 0.25)
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.shadow).effectDistance = Vector2.zero
  local OverDis = (Vector2.New)(-12, -14)
  self.sdTween = ((cs_DOTween.To)(function()
    -- function num : 0_27_0 , upvalues : self
    return (self.shadow).effectDistance
  end
, function(x)
    -- function num : 0_27_1 , upvalues : self
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

    (self.shadow).effectDistance = x
  end
, OverDis, 1)):SetEase((((CS.DG).Tweening).Ease).OutExpo)
end

UIHeroState.UpdateAthData = function(self)
  -- function num : 0_28
  (self.athNode):InitAthHeroInfo(self.heroData, self.resloader)
  ;
  (self.athNode):SetShowAthWindowParam(self.bigImgResloader, self.__addAllTouch, self.__removeAllTouch, self.__SwitchHeroState, self.__CanClick)
end

UIHeroState.UpdateHeroAttri = function(self)
  -- function num : 0_29 , upvalues : _ENV, UINAttrOutlineWindow
  local attrDataList = {}
  local index = 0
  for _,attrId in ipairs((ConfigData.attribute).baseAttrIds) do
    if index < 10 then
      if ((ConfigData.attribute)[attrId]).merge_attribute == 0 then
        index = index + 1
        local attrName, attrValueStr, attrIcon = ConfigData:GetAttribute(attrId, (self.heroData):GetAttr(attrId))
        attrDataList[index] = {attrId = attrId, name = attrName, attrValue = attrValueStr, icon = attrIcon}
      end
      do
        -- DECOMPILER ERROR at PC31: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC31: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  if self.attrOutLineWindow == nil then
    self.attrOutLineWindow = (UINAttrOutlineWindow.New)()
    ;
    (self.attrOutLineWindow):Init((self.ui).logicPreviewNode)
    ;
    (self.attrOutLineWindow):Hide()
  end
  ;
  (self.attrOutLineWindow):OnUpdateAttrData(self.heroName, attrDataList)
end

UIHeroState.UpdateEfficiency = function(self)
  -- function num : 0_30 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).tex_Efficiency).text = tostring((self.heroData):GetFightingPower())
end

UIHeroState.UpdatePotential = function(self)
  -- function num : 0_31
  local vec = (((self.ui).img_Breakthrough).rectTransform).sizeDelta
  vec.x = self.potentialImgWidth * (self.heroData).potential
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).img_Breakthrough).rectTransform).sizeDelta = vec
end

UIHeroState.StartTouch = function(self, finger)
  -- function num : 0_32 , upvalues : _ENV, CS_coroutine, CS_Screen
  if GuideManager.inGuide or self.isAutoMoving then
    return 
  end
  if self.chageCoroutine ~= nil then
    (CS_coroutine.stop)(self.chageCoroutine)
    self.chageCoroutine = nil
  end
  if self.backCoroutine ~= nil then
    (CS_coroutine.stop)(self.backCoroutine)
    self.backCoroutine = nil
  end
  self.screenWidth = CS_Screen.width * 0.3
  self.touchStartPointX = (finger.ScreenPosition).x
end

UIHeroState.InTouching = function(self, finger)
  -- function num : 0_33 , upvalues : _ENV
  if GuideManager.inGuide or self.isAutoMoving then
    return 
  end
  self.touchCurPointX = (finger.ScreenPosition).x
  if self.touchStartPointX == nil then
    self:StartTouch(finger)
  end
  self.swipeRate = (self.touchCurPointX - self.touchStartPointX) / self.screenWidth
  if (math.abs)(self.swipeRate) > 0 then
    self.isStartSwipe = true
  end
  self:OnSwipe()
end

UIHeroState.EndTouch = function(self, finger)
  -- function num : 0_34 , upvalues : _ENV
  self.isStartSwipe = false
  if GuideManager.inGuide or self.isAutoMoving or self.swipeRate == nil then
    return 
  end
  if (math.abs)(self.swipeRate) < (self.ui).float_SwitchRateThreshold then
    if (self.ui).float_SpeedThreshold < (math.abs)((finger.ScaledDelta).x) then
      self:ChangeHero()
    else
      self:ReturnBack()
    end
  else
    self:ChangeHero()
  end
end

UIHeroState.RemoveAllTouch = function(self)
  -- function num : 0_35 , upvalues : CS_LeanTouch
  (CS_LeanTouch.OnFingerDown)("-", self.__startTouch)
  ;
  (CS_LeanTouch.OnFingerSet)("-", self.__inTouching)
  ;
  (CS_LeanTouch.OnFingerUp)("-", self.__endTouch)
end

UIHeroState.AddAllTouch = function(self)
  -- function num : 0_36 , upvalues : CS_LeanTouch
  self:PlayAllDOTween()
  ;
  (CS_LeanTouch.OnFingerDown)("+", self.__startTouch)
  ;
  (CS_LeanTouch.OnFingerSet)("+", self.__inTouching)
  ;
  (CS_LeanTouch.OnFingerUp)("+", self.__endTouch)
end

UIHeroState.OnSwipe = function(self)
  -- function num : 0_37 , upvalues : _ENV
  local absSwipeRate = (math.abs)(self.swipeRate)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).group_img_Camp).alpha = 1 - absSwipeRate * (self.ui).float_campRate
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).group_hero).alpha = 1 - absSwipeRate * (self.ui).float_HeroRate
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).group_img_Camp).transform).localPosition = (Vector2.New)((self.campPos).x + self.screenWidth * (self.swipeRate * (self.ui).float_campRate), (self.campPos).y)
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).group_hero).transform).localPosition = (Vector2.New)((self.heroPos).x + self.screenWidth * (self.swipeRate * (self.ui).float_HeroRate), (self.heroPos).y)
end

UIHeroState.ReturnBack = function(self)
  -- function num : 0_38 , upvalues : CS_coroutine, _ENV
  self.isAutoMoving = true
  local totalCostTime = (self.ui).float_backTime
  local updateCostTime = 0.005
  local orgAlpha1 = ((self.ui).group_img_Camp).alpha
  local orgAlpha2 = ((self.ui).group_hero).alpha
  local orgPos1 = (((self.ui).group_img_Camp).transform).localPosition
  local orgPos2 = (((self.ui).group_hero).transform).localPosition
  self.backCoroutine = (CS_coroutine.start)(function()
    -- function num : 0_38_0 , upvalues : _ENV, totalCostTime, updateCostTime, self, orgAlpha1, orgAlpha2, orgPos1, orgPos2
    local times = (math.ceil)(totalCostTime / updateCostTime)
    for i = 1, times do
      -- DECOMPILER ERROR at PC18: Confused about usage of register: R5 in 'UnsetPending'

      ((self.ui).group_img_Camp).alpha = orgAlpha1 + (1 - orgAlpha1) / times * i
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).group_hero).alpha = orgAlpha2 + (1 - orgAlpha2) / times * i
      -- DECOMPILER ERROR at PC37: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (((self.ui).group_img_Camp).transform).localPosition = (Vector2.Lerp)(orgPos1, self.campPos, i / times)
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (((self.ui).group_hero).transform).localPosition = (Vector2.Lerp)(orgPos2, self.heroPos, i / times)
      ;
      (coroutine.yield)(((CS.UnityEngine).WaitForSeconds)(updateCostTime))
    end
    self.isAutoMoving = false
  end
)
end

UIHeroState.EaseOutQuint = function(self, start, _end, value)
  -- function num : 0_39
  value = value - 1
  _end = _end - start
  return (_end) * ((value) * (value) * (value) * (value) * (value) + 1) + start
end

UIHeroState.ChangeHero = function(self)
  -- function num : 0_40 , upvalues : CS_coroutine, _ENV
  self.isAutoMoving = true
  local fadeTotalCostTime = (self.ui).float_fadeTime
  local fadeUpdateCostTime = 0.01
  local newTotalCostTime = (self.ui).float_showTime
  local newUpdateCostTime = 0.01
  local orgAlpha1 = ((self.ui).group_img_Camp).alpha
  local orgAlpha2 = ((self.ui).group_hero).alpha
  local orgPos1 = (((self.ui).group_img_Camp).transform).localPosition
  local orgPos2 = (((self.ui).group_hero).transform).localPosition
  self.chageCoroutine = (CS_coroutine.start)(function()
    -- function num : 0_40_0 , upvalues : _ENV, fadeTotalCostTime, fadeUpdateCostTime, self, orgAlpha1, orgAlpha2, orgPos1, orgPos2, newTotalCostTime, newUpdateCostTime
    local times = (math.ceil)(fadeTotalCostTime / fadeUpdateCostTime)
    local flag = 1
    if self.swipeRate > 0 then
      flag = 1
    else
      if self.swipeRate < 0 then
        flag = -1
      end
    end
    for i = 1, times do
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R6 in 'UnsetPending'

      ((self.ui).group_img_Camp).alpha = orgAlpha1 + -orgAlpha1 / times * i
      -- DECOMPILER ERROR at PC37: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).group_hero).alpha = orgAlpha2 + -orgAlpha2 / times * i
      -- DECOMPILER ERROR at PC58: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (((self.ui).group_img_Camp).transform).localPosition = self:EaseOutQuint(orgPos1, (Vector2.New)((self.campPos).x + self.screenWidth * flag * (self.ui).float_campRate, orgPos1.y), i / times)
      -- DECOMPILER ERROR at PC79: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (((self.ui).group_hero).transform).localPosition = self:EaseOutQuint(orgPos2, (Vector2.New)((self.heroPos).x + self.screenWidth * flag * (self.ui).float_HeroRate, orgPos2.y), i / times)
      ;
      (coroutine.yield)(((CS.UnityEngine).WaitForSeconds)(fadeUpdateCostTime))
    end
    self:ChangeHeroData(flag)
    self.isAutoMoving = false
    times = (math.ceil)(newTotalCostTime / newUpdateCostTime)
    for i = 1, times do
      -- DECOMPILER ERROR at PC108: Confused about usage of register: R6 in 'UnsetPending'

      ((self.ui).group_img_Camp).alpha = i / times
      -- DECOMPILER ERROR at PC112: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).group_hero).alpha = i / times
      -- DECOMPILER ERROR at PC137: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (((self.ui).group_img_Camp).transform).localPosition = self:EaseOutQuint((Vector2.New)((self.campPos).x + self.screenWidth * -flag * (self.ui).float_campRate, orgPos1.y), self.campPos, (math.sqrt)(i / times))
      -- DECOMPILER ERROR at PC162: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (((self.ui).group_hero).transform).localPosition = self:EaseOutQuint((Vector2.New)((self.heroPos).x + self.screenWidth * -flag * (self.ui).float_HeroRate, orgPos2.y), self.heroPos, (math.sqrt)(i / times))
      ;
      (coroutine.yield)(((CS.UnityEngine).WaitForSeconds)(newUpdateCostTime))
    end
  end
)
end

UIHeroState.ChangeHeroData = function(self, flag)
  -- function num : 0_41 , upvalues : _ENV, cs_ResLoader
  local index = (table.indexof)(self.heroDataList, self.heroData)
  if flag < 0 then
    index = index + 1
    if #self.heroDataList < index then
      index = 1
    end
  else
    index = index - 1
    if index <= 0 then
      index = #self.heroDataList
    end
  end
  local heroData = (self.heroDataList)[index]
  local heroCfg = heroData.heroCfg
  self.heroId = heroData.dataId
  self.heroData = heroData
  self.heroName = (LanguageUtil.GetLocaleText)(heroCfg.name)
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = self.heroName
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_ENName).text = heroCfg.name_en
  ;
  ((self.ui).img_Carrer):SetIndex(heroCfg.career - 1)
  local vec = (((self.ui).img_Breakthrough).rectTransform).sizeDelta
  vec.x = self.potentialImgWidth * (self.heroData).potential
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (((self.ui).img_Breakthrough).rectTransform).sizeDelta = vec
  local campIcon = (LanguageUtil.GetLocaleText)(((self.heroData):GetCampCfg()).icon)
  ;
  (self.resloader):LoadABAssetAsync(PathConsts:GetCampPicPath(campIcon), function(texture)
    -- function num : 0_41_0 , upvalues : _ENV, self
    if IsNull(self.transform) then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Camp).texture = texture
  end
)
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
  self.bigImgResloader = (cs_ResLoader.Create)()
  DestroyUnityObject(self.bigImgGameObject)
  ;
  (self.bigImgResloader):LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(heroData:GetResName()), function(prefab)
    -- function num : 0_41_1 , upvalues : self, heroData, _ENV
    if self.heroData ~= heroData then
      return 
    end
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate((self.ui).heroHolder)
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroList")
    self:UpdateHeroShadow()
  end
)
  self:Refresh()
end

UIHeroState.SwitchHeroState = function(self, flag)
  -- function num : 0_42
  self:ChangeHeroData(-flag)
  return self.heroData, self.bigImgResloader
end

UIHeroState.OnShow = function(self)
  -- function num : 0_43 , upvalues : base
  (base.OnShow)(self)
end

UIHeroState.RegistFromeWindowTypeID = function(self, UIWindowTypeID)
  -- function num : 0_44
  self.formWindowTypeID = UIWindowTypeID
end

UIHeroState.Return = function(self)
  -- function num : 0_45 , upvalues : JumpManager
  if self.returnFunc ~= nil then
    (self.returnFunc)()
  end
  JumpManager.couldUseItemJump = false
  self:Delete()
end

UIHeroState.Delete = function(self)
  -- function num : 0_46 , upvalues : _ENV, base
  do
    if self.formWindowTypeID ~= nil then
      local win = UIManager:GetWindow(self.formWindowTypeID)
      if win ~= nil and not win.active then
        win.active = true
        ;
        (win.gameObject):SetActive(true)
      end
    end
    ;
    (base.Delete)(self)
  end
end

UIHeroState.OnDelete = function(self)
  -- function num : 0_47 , upvalues : CS_coroutine, _ENV, base
  self:RemoveAllTouch()
  if self.chageCoroutine ~= nil then
    (CS_coroutine.stop)(self.chageCoroutine)
    self.chageCoroutine = nil
  end
  if self.backCoroutine ~= nil then
    (CS_coroutine.stop)(self.backCoroutine)
    self.backCoroutine = nil
  end
  self:RemoveRedDotEvent()
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__refresh)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onItemUpdate)
  MsgCenter:RemoveListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroFriendshipDataChange, self.__onFriendshipDataUpdate)
  if self.levelUpWin ~= nil then
    (self.levelUpWin):Delete()
  end
  if self.skillUgradeWin ~= nil then
    (self.skillUgradeWin):Delete()
  end
  if self.starUpWin ~= nil then
    (self.starUpWin):Delete()
  end
  if self.sdTween ~= nil then
    (self.sdTween):Kill()
  end
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
  if self.attrOutLineWindow ~= nil then
    (self.attrOutLineWindow):Hide()
    ;
    (self.attrOutLineWindow):OnDelete()
  end
  ;
  (self.athNode):Delete()
  ;
  (base.OnDelete)(self)
end

return UIHeroState


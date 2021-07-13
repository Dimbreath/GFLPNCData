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
local ShopEnum = require("Game.Shop.ShopEnum")
local cs_ResLoader = CS.ResLoader
local CS_Input = (CS.UnityEngine).Input
local CS_Screen = (CS.UnityEngine).Screen
local cs_Shadow = ((CS.UnityEngine).UI).Shadow
local cs_tweening = (CS.DG).Tweening
local cs_DOTween = cs_tweening.DOTween
local CS_coroutine = require("XLua.Common.cs_coroutine")
local cs_MessageCommon = CS.MessageCommon
local CS_EventTriggerListener = CS.EventTriggerListener
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
  -- function num : 0_2 , upvalues : _ENV, UINHeroTag, UINHeroScoreItem, UINHeroStateSkillItem, UINAthHeroInfo, JumpManager, CS_Input, CS_EventTriggerListener
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Hero)
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
  (UIUtil.SetTopStatus)(self, self.Return, nil)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_LimitUp, self, self.OnClickLimitUp)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_QuickLevelUp, self, self._OnClickQuickLvUp)
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).btn_QuickLevelUp).responseOnceByPress = false
  ;
  (((self.ui).btn_QuickLevelUp).onPress):AddListener(BindCallback(self, self.OnPressQuickLvUp))
  ;
  (((self.ui).btn_QuickLevelUp).onPressUp):AddListener(BindCallback(self, self.OnPressUpQuickLvUp))
  ;
  (((self.ui).btn_QuickLevelUp).onPressDown):AddListener(BindCallback(self, self.OnPressDownQuickLvUp))
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_StarUp, self, self.OnClickStarUP)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Friendship, self, self.OnClickFriendship)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Skill, self, self.OnClickSillUpgrade)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Attri, self, self.OnClickAttribute)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Skin, self, self.OnClickSkin)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Data, self, self.OnClickHeroInformation)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CharTask, self, self.OnClickHeroTask)
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
    do return (not self.isStartSwipe and not self.couldNotOpenOther) end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
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
  self.__OnSkinChange = BindCallback(self, self.OnSkinChange)
  MsgCenter:AddListener(eMsgEventId.OnHeroSkinChange, self.__OnSkinChange)
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
  local isTrainingPlanUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TrainingPlan)
  self:UnlockHeroTask(isTrainingPlanUnlock)
  local isHeroInfoUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroInformation)
  self:UnlockHeroInfo(isHeroInfoUnlock)
  self.athNode = (UINAthHeroInfo.New)()
  ;
  (self.athNode):Init((self.ui).algorithm)
  self._lastCouldUseItemJump = JumpManager.couldUseItemJump
  JumpManager.couldUseItemJump = true
  CS_Input.multiTouchEnabled = false
  local eventTigger = (CS_EventTriggerListener.Get)((self.ui).dragHand)
  eventTigger:onDrag("+", self.__inTouching)
  eventTigger:onEndDrag("+", self.__endTouch)
  eventTigger:onBeginDrag("+", self.__startTouch)
end

UIHeroState.UnlockStarup = function(self, bool)
  -- function num : 0_3
  (((self.ui).btn_StarUp).gameObject):SetActive(bool)
end

UIHeroState.UnlockFriendship = function(self, bool)
  -- function num : 0_4
  (((self.ui).btn_Friendship).gameObject):SetActive(bool)
end

UIHeroState.UnlockHeroTask = function(self, bool)
  -- function num : 0_5
  (((self.ui).btn_CharTask).gameObject):SetActive(bool)
end

UIHeroState.UnlockHeroInfo = function(self, bool)
  -- function num : 0_6
  (((self.ui).btn_Data).gameObject):SetActive(bool)
end

UIHeroState.InitHeroState = function(self, heroData, heroDataList, returnFunc, isHideSkin)
  -- function num : 0_7 , upvalues : cs_ResLoader, _ENV
  self.resloader = (cs_ResLoader.Create)()
  self.heroDataList = heroDataList
  local heroCfg = heroData.heroCfg
  self.heroId = heroData.dataId
  self.heroData = heroData
  self.returnFunc = returnFunc
  self.heroName = (LanguageUtil.GetLocaleText)(heroCfg.name)
  self:RefreshHeroFixedInfo()
  self:LoadSkin()
  ;
  (self.athNode):InitAthHeroInfo(self.heroData, self.resloader)
  ;
  (self.athNode):SetShowAthWindowParam(self.bigImgResloader, self.__addAllTouch, self.__removeAllTouch, self.__SwitchHeroState, self.__CanClick)
  self:InitRedDotEvent()
  self:Refresh()
  AudioManager:PlayAudioById(1061)
  self.isHideSkin = isHideSkin or false
  self:RefreshSkinBtnState()
  if GuideManager:TryTriggerGuide(eGuideCondition.InHeroStateUI) then
  end
end

UIHeroState.Refresh = function(self)
  -- function num : 0_8
  self:UpdateLevel()
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
  self:_RefreshQuickLvUp()
end

UIHeroState.LoadSkin = function(self)
  -- function num : 0_9 , upvalues : cs_ResLoader, _ENV
  if self.heroData == nil then
    return 
  end
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.l2dBinding = nil
  end
  self.bigImgResloader = (cs_ResLoader.Create)()
  local picName = (self.heroData):GetResPicName()
  local resPath = PathConsts:GetCharacterLive2DPath(picName)
  local showLive2d = (PlayerDataCenter.skinData):GetLive2dSwitchState((self.heroData).dataId, (self.heroData).skinId)
  if ((CS.ResManager).Instance):ContainsAsset(resPath) and showLive2d then
    DestroyUnityObject(self.bigImgGameObject)
    ;
    (self.bigImgResloader):LoadABAssetAsync(resPath, function(l2dModelAsset)
    -- function num : 0_9_0 , upvalues : self, _ENV
    self.bigImgGameObject = l2dModelAsset:Instantiate(((self.ui).heroHolder).transform)
    ;
    ((self.bigImgGameObject).transform):SetLayer(LayerMask.UI)
    self.l2dBinding = {}
    ;
    (UIUtil.LuaUIBindingTable)(self.bigImgGameObject, self.l2dBinding)
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.l2dBinding).renderController).SortingLayer = self:GetWindowSortingLayer()
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.l2dBinding).renderController).InfluencedByUICanvas = true
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.l2dBinding).renderController).uiCanvasGroup = (self.ui).heroHolder
    ;
    ((self.l2dBinding).commonPerpectiveHandle):SetL2DPosType("HeroList", false)
  end
)
  else
    self.l2dBinding = nil
    resPath = PathConsts:GetCharacterBigImgPrefabPath(picName)
    DestroyUnityObject(self.bigImgGameObject)
    ;
    (self.bigImgResloader):LoadABAssetAsync(resPath, function(prefab)
    -- function num : 0_9_1 , upvalues : self, _ENV
    self.bigImgGameObject = prefab:Instantiate(((self.ui).heroHolder).transform)
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroList")
    self:UpdateHeroShadow()
  end
)
  end
end

UIHeroState.InitRedDotEvent = function(self)
  -- function num : 0_10 , upvalues : _ENV
  self:RefreshRedDot()
  self.__onheroCardStarRedDotEvent = function(node)
    -- function num : 0_10_0 , upvalues : self
    if node:GetRedDotCount() <= 0 then
      ((self.ui).obj_RedDot_StarUp):SetActive(self.heroId == nil or self.heroId ~= node:GetParentNodeId())
      -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
  end

  RedDotController:AddListener(RedDotDynPath.HeroCardStartUpPath, self.__onheroCardStarRedDotEvent)
  self.__onheroCardFriendshipRedDotEvent = function(node)
    -- function num : 0_10_1 , upvalues : self
    if node:GetRedDotCount() <= 0 then
      ((self.ui).obj_RedDot_FriendShip):SetActive(self.heroId == nil or self.heroId ~= node:GetParentNodeId())
      -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
  end

  RedDotController:AddListener(RedDotDynPath.HeroCardFriendshipPath, self.__onheroCardFriendshipRedDotEvent)
  self.__onheroCardHeroTaskRedDotEvent = function(node)
    -- function num : 0_10_2 , upvalues : self
    if node:GetRedDotCount() <= 0 then
      ((self.ui).obj_RedDot_CharTask):SetActive(self.heroId == nil or self.heroId ~= node:GetParentNodeId())
      -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
  end

  RedDotController:AddListener(RedDotDynPath.HeroCardHeroTaskPath, self.__onheroCardHeroTaskRedDotEvent)
  self.__onheroCardHeroInfoRedDotEvent = function(node)
    -- function num : 0_10_3 , upvalues : self
    if node:GetRedDotCount() <= 0 then
      ((self.ui).obj_RedDot_HeroInfo):SetActive(self.heroId == nil or self.heroId ~= node:GetParentNodeId())
      -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
  end

  RedDotController:AddListener(RedDotDynPath.HeroCardHeroInfomationPath, self.__onheroCardHeroInfoRedDotEvent)
  self:UpdateBlueDot()
end

UIHeroState.UpdateBlueDot = function(self)
  -- function num : 0_11 , upvalues : _ENV
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
      local limitUpUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential)
      if limitUpUnlock then
        local buleDotUpPontential = (self.heroData):AblePotential()
      end
      ;
      ((self.ui).herolevle_blueDot):SetActive(false)
      ;
      (((self.ui).btn_LimitUp).gameObject):SetActive(limitUpUnlock)
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).img_LimitUpIcon).enabled = not (self.heroData):IsFullPotential()
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
  -- function num : 0_12 , upvalues : _ENV
  local ok, heroStarUpNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, self.heroId, RedDotStaticTypeId.HeroStarUp)
  ;
  ((self.ui).obj_RedDot_StarUp):SetActive(not ok or heroStarUpNode:GetRedDotCount() > 0)
  local ok, heroFriendshipSkillNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, self.heroId, RedDotStaticTypeId.HeroFriendship)
  ;
  ((self.ui).obj_RedDot_FriendShip):SetActive(not ok or heroFriendshipSkillNode:GetRedDotCount() > 0)
  local ok, heroTaskNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, self.heroId, RedDotStaticTypeId.HeroTask)
  ;
  ((self.ui).obj_RedDot_CharTask):SetActive(not ok or heroTaskNode:GetRedDotCount() > 0)
  local ok, heroInfoNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, self.heroId, RedDotStaticTypeId.HeroInfomation)
  ;
  ((self.ui).obj_RedDot_HeroInfo):SetActive(not ok or heroInfoNode:GetRedDotCount() > 0)
  self:UpdateBlueDot()
  -- DECOMPILER ERROR: 8 unprocessed JMP targets
end

UIHeroState.RemoveRedDotEvent = function(self)
  -- function num : 0_13 , upvalues : _ENV
  RedDotController:RemoveListener(RedDotDynPath.HeroCardStartUpPath, self.__onheroCardStarRedDotEvent)
  RedDotController:RemoveListener(RedDotDynPath.HeroCardFriendshipPath, self.__onheroCardFriendshipRedDotEvent)
  RedDotController:RemoveListener(RedDotDynPath.HeroCardHeroTaskPath, self.__onheroCardHeroTaskRedDotEvent)
  RedDotController:RemoveListener(RedDotDynPath.HeroCardHeroInfomationPath, self.__onheroCardHeroInfoRedDotEvent)
end

UIHeroState.UpdateAbilityScore = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local rank = (self.heroData).rank
  local scoreCfgs = ConfigData.hero_score
  local heroStarCfg = ((ConfigData.hero_star)[self.heroId])[rank]
  ;
  (table.sort)(scoreCfgs, function(a, b)
    -- function num : 0_14_0
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
  -- function num : 0_15 , upvalues : _ENV
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
  -- function num : 0_16 , upvalues : _ENV
  local rare = ((self.heroData).rankCfg).rare
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_Quality).color = HeroRareColor[rare]
end

UIHeroState.UpdateTagInfo = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local tags = (self.heroData):GetHeroTag()
  ;
  (self.tagPool):HideAll()
  for index,value in ipairs(tags) do
    local item = (self.tagPool):GetOne(true)
    item:InitTag(value)
  end
end

UIHeroState.UpdateLevel = function(self)
  -- function num : 0_18 , upvalues : _ENV
  local level = (self.heroData).level
  local potentialCfg = (ConfigData.hero_potential)[(self.heroData).dataId]
  local level_max = (potentialCfg[(self.heroData).potential]).level_max
  if level > 999 then
    warn("level Num is out off MaxSize 999")
  end
  ;
  ((self.ui).texInfo_Level):SetIndex(0, tostring(level), tostring(level_max))
  local isShake = (self.heroData):CanHeroUsePotential()
  ;
  ((self.ui).obj_Shake):SetActive(isShake)
end

UIHeroState.UpdateSkill = function(self)
  -- function num : 0_19 , upvalues : _ENV
  (self.skillPool):HideAll()
  for k,skillData in ipairs((self.heroData).skillList) do
    if skillData.type ~= eHeroSkillType.LifeSkill and not skillData:IsCommonAttack() then
      local item = (self.skillPool):GetOne(true)
      item:InitSkillItem(skillData, self.resloader)
    end
  end
end

UIHeroState.OnClickLimitUp = function(self)
  -- function num : 0_20 , upvalues : _ENV, cs_MessageCommon
  if not self:__CanClick() then
    return 
  end
  do
    if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential) then
      local tip = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential)
      ;
      (cs_MessageCommon.ShowMessageTips)(tip)
      return 
    end
    if (self.heroData):IsFullPotential() then
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(172))
      return 
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.HeroPotential, function(window)
    -- function num : 0_20_0 , upvalues : self, _ENV
    if window == nil then
      return 
    end
    window:InitPotential(self.heroData)
    local parWin = UIManager:GetWindow(UIWindowTypeID.HeroState)
    if parWin == nil then
      return 
    end
    window:SetHeroPotentialCloseEvent(function()
      -- function num : 0_20_0_0 , upvalues : parWin
      parWin:AddAllTouch()
    end
)
    parWin:RemoveAllTouch()
    parWin.levelUpWin = window
  end
)
  end
end

UIHeroState.OnClickLevelUP = function(self)
  -- function num : 0_21 , upvalues : _ENV
  if not self:__CanClick() then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroLevelUp, function(windows)
    -- function num : 0_21_0 , upvalues : _ENV, self
    if windows == nil then
      error("Can\'t open " .. self.heroId .. "\'s levelUp window")
      return 
    end
    self:RemoveAllTouch()
    windows:InitHeroLevelUp(self.heroData, self.resloader, self.__addAllTouch, self.__SwitchHeroState)
    if windows.winTween ~= nil then
      (windows.winTween):Complete()
    end
    self.levelUpWin = windows
    windows.closeEvent = BindCallback(self, function()
      -- function num : 0_21_0_0 , upvalues : self
      self:UpdateBlueDot()
      self:UpdateEfficiency()
    end
)
    if not (self.heroData):IsFullLevel() and (self.heroData):IsReachLevelLimit() and not GuideManager.inGuide and FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential) then
      UIManager:ShowWindowAsync(UIWindowTypeID.HeroPotential, function(window)
      -- function num : 0_21_0_1 , upvalues : self
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

UIHeroState._RefreshQuickLvUp = function(self)
  -- function num : 0_22 , upvalues : _ENV
  self._canQuickLvUp = (self.heroData):GenHeroCanQuickLevelUp()
  ;
  (((self.ui).btn_QuickLevelUp).gameObject):SetActive(false)
  ;
  ((self.ui).obj_FullLevel):SetActive(false)
  if (self.heroData):IsFullLevel() then
    ((self.ui).obj_FullLevel):SetActive(true)
    return 
  end
  ;
  (((self.ui).btn_QuickLevelUp).gameObject):SetActive(true)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).btn_QuickLevelUp).enabled = true
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_QuickLevelUp).color = (self.ui).col_LvUpCanClick
  ;
  ((self.ui).obj_showLv):SetActive(false)
  ;
  ((self.ui).obj_showLimit):SetActive(false)
  if (self.heroData):IsReachLevelLimit() then
    ((self.ui).obj_showLimit):SetActive(true)
    -- DECOMPILER ERROR at PC71: Confused about usage of register: R1 in 'UnsetPending'

    if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential) then
      ((self.ui).img_QuickLevelUp).color = (self.ui).col_LvUpUnClick
    else
      -- DECOMPILER ERROR at PC82: Confused about usage of register: R1 in 'UnsetPending'

      if not (self.heroData):AblePotential() then
        ((self.ui).img_QuickLevelUp).color = (self.ui).col_LvUpUnClick
      end
    end
    return 
  end
  ;
  ((self.ui).obj_showLv):SetActive(true)
  local nextLevelExp = ((ConfigData.hero_level)[(self.heroData).level]).exp
  local hasExp = PlayerDataCenter:GetItemCount(ConstGlobalItem.HeroExp)
  local canLv = nextLevelExp <= hasExp
  local hasExpStr = (LanguageUtil.GetNum2UnitStr)(hasExp, 1)
  local nextLevelExpStr = (LanguageUtil.GetNum2UnitStr)(nextLevelExp, 1)
  ;
  ((self.ui).tex_LevelUpExp):SetIndex(canLv == true and 0 or 1, hasExpStr, nextLevelExpStr)
  -- DECOMPILER ERROR at PC133: Confused about usage of register: R6 in 'UnsetPending'

  if not self._canQuickLvUp then
    ((self.ui).img_QuickLevelUp).color = (self.ui).col_LvUpUnClick
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UIHeroState._OnClickQuickLvUp = function(self)
  -- function num : 0_23 , upvalues : _ENV
  if not self._canClickQuickLv then
    return 
  end
  if not self:__CanClick() then
    return 
  end
  if (self.heroData):IsFullLevel() then
    return 
  end
  if self._canQuickLvUp then
    if self._lvUpCompleteFunc == nil then
      self._lvUpCompleteFunc = BindCallback(self, self._QuickLvUpComplete)
    end
    ;
    (self.networkCtrl):CS_HERO_Upgrade(self.heroId, (self.heroData).level + 1, self._lvUpCompleteFunc)
    return 
  end
  if (self.heroData):IsReachLevelLimit() then
    self:OnClickLimitUp()
  else
    self:_OpenUseExpPacket()
  end
end

UIHeroState.OnPressDownQuickLvUp = function(self)
  -- function num : 0_24
  self._addLevel = 0
  self._canClickQuickLv = true
end

UIHeroState.OnPressQuickLvUp = function(self)
  -- function num : 0_25 , upvalues : _ENV, cs_MessageCommon
  if not self:__CanClick() then
    return 
  end
  if (self.heroData):GetLevelLimit() <= (self.heroData).level + self._addLevel then
    return 
  end
  local needExp = (self.heroData):GetExpToTargetLevel((self.heroData).level + self._addLevel)
  local totalExp = PlayerDataCenter:GetItemCount(ConstGlobalItem.HeroExp)
  if totalExp < needExp then
    local selectItemId = nil
    if self._addLevel == 0 then
      self:_OpenUseExpPacket()
    else
      ;
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(44))
    end
  else
    do
      self._addLevel = self._addLevel + 1
      local level = (self.heroData).level + self._addLevel
      do
        local level_max = (self.heroData):GetLevelLimit()
        ;
        ((self.ui).texInfo_Level):SetIndex(0, tostring(level), tostring(level_max))
        self._canClickQuickLv = false
        if (self.heroData).level + self._addLevel < (self.heroData):GetLevelLimit() then
          local nextLevelExp = ((ConfigData.hero_level)[(self.heroData).level + self._addLevel]).exp
          local hasExp = totalExp - needExp
          local canLv = nextLevelExp <= hasExp
          local hasExpStr = (LanguageUtil.GetNum2UnitStr)(hasExp, 1)
          local nextLevelExpStr = (LanguageUtil.GetNum2UnitStr)(nextLevelExp, 1)
          ;
          ((self.ui).tex_LevelUpExp):SetIndex(canLv == true and 0 or 1, hasExpStr, nextLevelExpStr)
        end
        if level_max <= level then
          self:OnPressUpQuickLvUp()
        end
        -- DECOMPILER ERROR: 5 unprocessed JMP targets
      end
    end
  end
end

UIHeroState.OnPressUpQuickLvUp = function(self)
  -- function num : 0_26
  if self._addLevel > 0 then
    (self.networkCtrl):CS_HERO_Upgrade(self.heroId, (self.heroData).level + self._addLevel, self._lvUpCompleteFunc)
    self._addLevel = 0
  end
end

UIHeroState._OpenUseExpPacket = function(self)
  -- function num : 0_27 , upvalues : _ENV
  local selectItemId = nil
  local packetList = ((ConfigData.item).packetMappingDic)[ConstGlobalItem.HeroExp]
  if packetList ~= nil and #packetList > 0 then
    for _,expPacketid in ipairs(packetList) do
      if PlayerDataCenter:GetItemCount(expPacketid) > 0 then
        selectItemId = expPacketid
        break
      end
    end
  end
  do
    if selectItemId == nil then
      UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(window)
    -- function num : 0_27_0 , upvalues : _ENV
    if window == nil then
      return 
    end
    window:InitCommonItemDetail((ConfigData.item)[ConstGlobalItem.HeroExp])
  end
)
    else
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonUseGift, function(window)
    -- function num : 0_27_1 , upvalues : _ENV, selectItemId
    if window == nil then
      return 
    end
    window:InitCommonUseGift((ConfigData.item)[selectItemId])
  end
)
    end
  end
end

UIHeroState._QuickLvUpComplete = function(self, objList)
  -- function num : 0_28 , upvalues : _ENV
  if objList.Count ~= 1 then
    error("objList.Count error" .. tostring(objList.count))
    return 
  end
  local resDic = objList[0]
  local diffData = resDic[self.heroId]
  if diffData == nil then
    return 
  end
  local oldLv = diffData.oldLevel
  local curLv = (self.heroData).level
  local HeroExpDiffData = {oldLevel = oldLv, oldRate = diffData.oldExp / ((ConfigData.hero_level)[oldLv]).exp, level = curLv, rate = (self.heroData).curExp / ((ConfigData.hero_level)[curLv]).exp}
end

UIHeroState.OnClickStarUP = function(self)
  -- function num : 0_29 , upvalues : _ENV
  if not self:__CanClick() then
    return 
  end
  if (self.heroData):IsFullRank() then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroStarUp, function(windows)
    -- function num : 0_29_0 , upvalues : _ENV, self
    if windows == nil then
      error("Can\'t open " .. self.heroId .. "\'s starUP window")
      return 
    end
    self:RemoveAllTouch()
    windows:InitHeroStarUp(self.resloader, function()
      -- function num : 0_29_0_0 , upvalues : self
      self:UpdateEfficiency()
      self:AddAllTouch()
    end
, self.__SwitchHeroState)
    windows:SwitchHero(self.heroData)
    self.starUpWin = windows
  end
)
end

UIHeroState.OnClickFriendship = function(self)
  -- function num : 0_30 , upvalues : _ENV
  if not self:__CanClick() then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.FriendShip, function(windows)
    -- function num : 0_30_0 , upvalues : _ENV, self
    if windows == nil then
      error("Can\'t open " .. self.heroId .. "\'s FriendShip window")
      return 
    end
    self:RemoveAllTouch()
    windows:InitFriendshipSkillUpgrade(self.heroData, self.resloader, function()
      -- function num : 0_30_0_0 , upvalues : self, _ENV
      self:AddAllTouch()
      self:UpdateEfficiency()
      self:UpdateBlueDot()
      local win = UIManager:GetWindow(UIWindowTypeID.HeroState)
      if win ~= nil and not win.active then
        win:Show()
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
  -- function num : 0_31 , upvalues : _ENV
  if not self:__CanClick() then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroSkillUpgrade, function(windows)
    -- function num : 0_31_0 , upvalues : _ENV, self
    if windows == nil then
      error("Can\'t open " .. self.heroId .. "\'s levelUp window")
      return 
    end
    self:RemoveAllTouch()
    windows:InitSkillUpgrade(self.heroData, self.resloader, self.__addAllTouch, self.__SwitchHeroState)
    self.skillUgradeWin = windows
    windows.closeEvent = BindCallback(self, function()
      -- function num : 0_31_0_0 , upvalues : self
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
  -- function num : 0_32
  if self.attrOutLineWindow ~= nil then
    self:RemoveAllTouch()
    ;
    (self.attrOutLineWindow):Show()
  end
end

UIHeroState.OnClickSkin = function(self)
  -- function num : 0_33 , upvalues : _ENV, ShopEnum
  local callbackCount = 0
  local needStoreList = {}
  if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Store) then
    for k,shopId in ipairs((ConfigData.shop).id_sort_list) do
      local shopCfg = (ConfigData.shop)[shopId]
      if shopCfg.shop_type ~= (ShopEnum.eShopType).MonthCard and shopCfg.shop_type ~= (ShopEnum.eShopType).Recommend and shopCfg.shop_type ~= (ShopEnum.eShopType).PayGift and (CheckCondition.CheckLua)(shopCfg.pre_condition, shopCfg.pre_para1, shopCfg.pre_para2) then
        (table.insert)(needStoreList, shopId)
      end
    end
  end
  do
    if #needStoreList > 0 then
      self:ReqShopDetailLoop(callbackCount, needStoreList)
    else
      self:__OpenSkinWin()
    end
  end
end

UIHeroState.ReqShopDetailLoop = function(self, index, idList)
  -- function num : 0_34 , upvalues : _ENV
  local shopCtr = ControllerManager:GetController(ControllerTypeId.Shop)
  local shopId = idList[index + 1]
  shopCtr:GetShopData(shopId, function(shopData)
    -- function num : 0_34_0 , upvalues : index, idList, self
    index = index + 1
    if index == #idList then
      self:__OpenSkinWin()
    else
      self:ReqShopDetailLoop(index, idList)
    end
  end
)
end

UIHeroState.__OpenSkinWin = function(self)
  -- function num : 0_35 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroSkin, function(window)
    -- function num : 0_35_0 , upvalues : self, _ENV
    if window == nil then
      return 
    end
    window:InitSkin((self.heroData).dataId, (self.heroData).skinId, self.__SwitchHeroState, self.heroDataList)
    local parWin = UIManager:GetWindow(UIWindowTypeID.HeroState)
    if parWin ~= nil then
      parWin:Hide()
    end
  end
)
end

UIHeroState.OnClickHeroTask = function(self)
  -- function num : 0_36 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroTask, function(window)
    -- function num : 0_36_0 , upvalues : self
    if window ~= nil then
      self:RemoveAllTouch()
      window:InitHeroTask(self.heroData, self.resloader, self.bigImgResloader, function()
      -- function num : 0_36_0_0 , upvalues : self
      self:AddAllTouch()
    end
)
    end
  end
)
end

UIHeroState.OnClickHeroInformation = function(self)
  -- function num : 0_37 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroInfomation, function(window)
    -- function num : 0_37_0 , upvalues : self, _ENV
    if window ~= nil then
      self:RemoveAllTouch()
      window:InitHeroInformation(self.heroData, function()
      -- function num : 0_37_0_0 , upvalues : self, _ENV
      self:AddAllTouch()
      self:UpdateBlueDot()
      local win = UIManager:GetWindow(UIWindowTypeID.HeroState)
      if win ~= nil and not win.active then
        win:Show()
      end
    end
, false, self.__SwitchHeroState)
      local parWin = UIManager:GetWindow(UIWindowTypeID.HeroState)
      if parWin ~= nil then
        parWin:Hide()
      end
    end
  end
)
end

UIHeroState.OnItemUpdate = function(self)
  -- function num : 0_38
  self:UpdateChipCount()
  self:_RefreshQuickLvUp()
  self:UpdateLevel()
end

UIHeroState.OnFriendshipDataUpdate = function(self)
  -- function num : 0_39
  self:UpdateFriendShipLevel()
  self:UpdateHeroAttri()
  self:UpdateEfficiency()
end

UIHeroState.OnAthDataUpdate = function(self)
  -- function num : 0_40
  (self.athNode):RefreshAthHeroInfoChart()
  self:UpdateHeroAttri()
  self:UpdateEfficiency()
end

UIHeroState.UpdateChipCount = function(self)
  -- function num : 0_41 , upvalues : _ENV
  local isFullRank = (self.heroData):IsFullRank()
  ;
  ((self.ui).starUPNormal):SetActive(not isFullRank)
  ;
  (((self.ui).tex_RankMax).gameObject):SetActive(isFullRank)
  if not isFullRank then
    local fragCount = (self.heroData):GetHeroFragCount()
    local needFrag = (self.heroData):StarNeedFrag()
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_ChipCount).text = tostring(fragCount or 0) .. "/" .. tostring(needFrag or 0)
  end
end

UIHeroState.UpdateFriendShipLevel = function(self)
  -- function num : 0_42 , upvalues : _ENV
  local level = (PlayerDataCenter.allFriendshipData):GetLevel(self.heroId)
  if level < 10 then
    ((self.ui).tex_FriendShipLevel):SetIndex(0, tostring(level))
  else
    ;
    ((self.ui).tex_FriendShipLevel):SetIndex(1, tostring(level))
  end
end

UIHeroState.UpdateHeroShadow = function(self)
  -- function num : 0_43 , upvalues : _ENV, cs_Shadow, cs_DOTween
  if IsNull(self.bigImgGameObject) then
    return 
  end
  self.shadow = (self.bigImgGameObject):GetComponent(typeof(cs_Shadow))
  if self.shadow == nil then
    self.shadow = (self.bigImgGameObject):AddComponent(typeof(cs_Shadow))
  end
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.shadow).effectColor = (Color.New)(0, 0, 0, 0.25)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.shadow).effectDistance = Vector2.zero
  local OverDis = (Vector2.New)(-12, -14)
  self.sdTween = (((cs_DOTween.To)(function()
    -- function num : 0_43_0 , upvalues : self
    return (self.shadow).effectDistance
  end
, function(x)
    -- function num : 0_43_1 , upvalues : self
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

    (self.shadow).effectDistance = x
  end
, OverDis, 1)):SetEase((((CS.DG).Tweening).Ease).OutExpo)):SetLink((self.shadow).gameObject)
end

UIHeroState.UpdateAthData = function(self)
  -- function num : 0_44
  (self.athNode):InitAthHeroInfo(self.heroData, self.resloader)
  ;
  (self.athNode):SetShowAthWindowParam(self.bigImgResloader, self.__addAllTouch, self.__removeAllTouch, self.__SwitchHeroState, self.__CanClick)
end

UIHeroState.UpdateHeroAttri = function(self)
  -- function num : 0_45 , upvalues : _ENV, UINAttrOutlineWindow
  local attrDataList = {}
  local index = 0
  for _,attrId in ipairs((ConfigData.attribute).baseAttrIds) do
    if index < 10 then
      if ((ConfigData.attribute)[attrId]).merge_attribute == 0 then
        index = index + 1
        local attrValue = (self.heroData):GetAttr(attrId)
        local basicAttrValue = (self.heroData):GetAttr(attrId, nil, nil, true)
        local addAttrValue = attrValue - basicAttrValue
        local attrName, attrValueStrs, attrIcon = nil, nil, nil
        if addAttrValue <= 0 then
          attrName = ConfigData:GetAttribute(attrId, {[1] = basicAttrValue})
        else
          -- DECOMPILER ERROR at PC49: Overwrote pending register: R13 in 'AssignReg'

          -- DECOMPILER ERROR at PC50: Overwrote pending register: R12 in 'AssignReg'

          attrName = ConfigData:GetAttribute(attrId, {[1] = basicAttrValue, [2] = attrValue - basicAttrValue})
        end
        attrDataList[index] = {attrId = attrId, name = attrName, attrValueStrs = attrValueStrs, icon = attrIcon}
      end
      do
        -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out IF_STMT

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
  -- function num : 0_46 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).tex_Efficiency).text = tostring((self.heroData):GetFightingPower())
end

UIHeroState.UpdatePotential = function(self)
  -- function num : 0_47
  local vec = (((self.ui).img_Breakthrough).rectTransform).sizeDelta
  vec.x = self.potentialImgWidth * (self.heroData).potential
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).img_Breakthrough).rectTransform).sizeDelta = vec
end

UIHeroState.OnSkinChange = function(self, heroId, skinId)
  -- function num : 0_48
  if heroId == self.heroId then
    if self.active then
      self:LoadSkin()
    else
      self.isChangSkinWhenShow = true
    end
  end
end

UIHeroState.RefreshHeroFixedInfo = function(self)
  -- function num : 0_49 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).tex_Name).text = self.heroName
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_ENName).text = ((self.heroData).heroCfg).name_en
  ;
  ((self.ui).img_Carrer):SetIndex(((self.heroData).heroCfg).career - 1)
  local campIcon = (LanguageUtil.GetLocaleText)(((self.heroData):GetCampCfg()).icon)
  ;
  (self.resloader):LoadABAssetAsync(PathConsts:GetCampPicPath(campIcon), function(texture)
    -- function num : 0_49_0 , upvalues : _ENV, self
    if IsNull(self.transform) then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Camp).texture = texture
  end
)
end

UIHeroState.StartTouch = function(self, go, eventData)
  -- function num : 0_50 , upvalues : _ENV, CS_coroutine, CS_Screen
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
  self.touchStartPointX = (eventData.position).x
  self.touchCurrentPointX = self.touchStartPointX
end

UIHeroState.InTouching = function(self, go, eventData)
  -- function num : 0_51 , upvalues : _ENV
  if self.touchStartPointX == nil then
    return 
  end
  self.touchCurrentPointX = (eventData.position).x
  self.swipeRate = (self.touchCurrentPointX - self.touchStartPointX) / self.screenWidth
  if (math.abs)(self.swipeRate) > 0 then
    self.isStartSwipe = true
  end
  self:OnSwipe()
end

UIHeroState.EndTouch = function(self, go, eventData)
  -- function num : 0_52 , upvalues : _ENV
  if self.touchStartPointX == nil then
    return 
  end
  local lastPointX = self.touchCurrentPointX
  self.isStartSwipe = false
  self.touchStartPointX = nil
  self.touchCurrentPointX = nil
  if self.swipeRate == nil then
    return 
  end
  if (math.abs)(self.swipeRate) < (self.ui).float_SwitchRateThreshold then
    if (self.ui).float_SpeedThreshold < (math.abs)((eventData.position).x - lastPointX) then
      self:ChangeHero()
    else
      self:ReturnBack()
    end
  else
    self:ChangeHero()
    self.swipeRate = 0
  end
end

UIHeroState.RemoveAllTouch = function(self)
  -- function num : 0_53
  self.swipeRate = nil
  self.isStartSwipe = false
end

UIHeroState.AddAllTouch = function(self)
  -- function num : 0_54
  self:PlayAllDOTween()
  self.swipeRate = nil
  self.isStartSwipe = false
end

UIHeroState.OnSwipe = function(self)
  -- function num : 0_55 , upvalues : _ENV
  local absSwipeRate = (math.abs)(self.swipeRate)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  if self.l2dBinding == nil then
    ((self.ui).group_img_Camp).alpha = 1 - absSwipeRate * (self.ui).float_campRate
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).group_hero).alpha = 1 - absSwipeRate * (self.ui).float_HeroRate
  end
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).group_img_Camp).transform).localPosition = (Vector2.New)((self.campPos).x + self.screenWidth * (self.swipeRate * (self.ui).float_campRate), (self.campPos).y)
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).group_hero).transform).localPosition = (Vector2.New)((self.heroPos).x + self.screenWidth * (self.swipeRate * (self.ui).float_HeroRate), (self.heroPos).y)
end

UIHeroState.ReturnBack = function(self)
  -- function num : 0_56 , upvalues : CS_coroutine, _ENV
  self.isAutoMoving = true
  local totalCostTime = (self.ui).float_backTime
  local updateCostTime = 0.005
  local orgAlpha1 = ((self.ui).group_img_Camp).alpha
  local orgAlpha2 = ((self.ui).group_hero).alpha
  local orgPos1 = (((self.ui).group_img_Camp).transform).localPosition
  local orgPos2 = (((self.ui).group_hero).transform).localPosition
  self.backCoroutine = (CS_coroutine.start)(function()
    -- function num : 0_56_0 , upvalues : _ENV, totalCostTime, updateCostTime, self, orgAlpha1, orgAlpha2, orgPos1, orgPos2
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
  -- function num : 0_57
  value = value - 1
  _end = _end - start
  return (_end) * ((value) * (value) * (value) * (value) * (value) + 1) + start
end

UIHeroState.ChangeHero = function(self)
  -- function num : 0_58 , upvalues : _ENV, CS_coroutine
  self.isAutoMoving = true
  self.couldNotOpenOther = true
  AudioManager:PlayAudioById(1063)
  local fadeTotalCostTime = (self.ui).float_fadeTime
  local fadeUpdateCostTime = 0.01
  local newTotalCostTime = (self.ui).float_showTime
  local newUpdateCostTime = 0.01
  local orgAlpha1 = ((self.ui).group_img_Camp).alpha
  local orgAlpha2 = ((self.ui).group_hero).alpha
  local orgPos1 = (((self.ui).group_img_Camp).transform).localPosition
  local orgPos2 = (((self.ui).group_hero).transform).localPosition
  self.chageCoroutine = (CS_coroutine.start)(function()
    -- function num : 0_58_0 , upvalues : _ENV, fadeTotalCostTime, fadeUpdateCostTime, self, orgAlpha1, orgAlpha2, newTotalCostTime, newUpdateCostTime, orgPos1, orgPos2
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
      ;
      (coroutine.yield)(((CS.UnityEngine).WaitForSeconds)(fadeUpdateCostTime))
    end
    self:ChangeHeroData(flag)
    self.isAutoMoving = false
    self.couldNotOpenOther = false
    times = (math.ceil)(newTotalCostTime / newUpdateCostTime)
    for i = 1, times do
      -- DECOMPILER ERROR at PC67: Confused about usage of register: R6 in 'UnsetPending'

      ((self.ui).group_img_Camp).alpha = i / times
      -- DECOMPILER ERROR at PC71: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).group_hero).alpha = i / times
      -- DECOMPILER ERROR at PC96: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (((self.ui).group_img_Camp).transform).localPosition = self:EaseOutQuint((Vector2.New)((self.campPos).x + self.screenWidth * -flag * (self.ui).float_campRate, orgPos1.y), self.campPos, (math.sqrt)(i / times))
      -- DECOMPILER ERROR at PC121: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (((self.ui).group_hero).transform).localPosition = self:EaseOutQuint((Vector2.New)((self.heroPos).x + self.screenWidth * -flag * (self.ui).float_HeroRate, orgPos2.y), self.heroPos, (math.sqrt)(i / times))
      ;
      (coroutine.yield)(((CS.UnityEngine).WaitForSeconds)(newUpdateCostTime))
    end
  end
)
end

UIHeroState.ChangeHeroData = function(self, flag)
  -- function num : 0_59 , upvalues : _ENV
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
  self:ChangeHeroByIndex(index)
end

UIHeroState.ChangeHeroByIndex = function(self, index)
  -- function num : 0_60 , upvalues : _ENV
  local heroData = (self.heroDataList)[index]
  local heroCfg = heroData.heroCfg
  self.heroId = heroData.dataId
  self.heroData = heroData
  self.heroName = (LanguageUtil.GetLocaleText)(heroCfg.name)
  self:RefreshHeroFixedInfo()
  if not self.active then
    self.isRefreshHeroWhenShow = true
    return 
  end
  self:LoadSkin()
  self:Refresh()
end

UIHeroState.SwitchHeroState = function(self, flag)
  -- function num : 0_61
  self:ChangeHeroData(-flag)
  return self.heroData, self.bigImgResloader
end

UIHeroState.OnShow = function(self)
  -- function num : 0_62 , upvalues : base, _ENV
  (base.OnShow)(self)
  if self.isRefreshHeroWhenShow then
    self:Refresh()
    self:LoadSkin()
  else
    if self.isChangSkinWhenShow then
      self:LoadSkin()
    else
      if self.l2dBinding ~= nil then
        local interation = (((self.l2dBinding).renderController).transform):GetComponent(typeof((((((CS.Live2D).Cubism).Samples).OriginalWorkflow).Demo).CubismInterationController))
        if interation ~= nil then
          interation:RestartBodyAnimation()
        end
      end
    end
  end
  do
    self.isRefreshHeroWhenShow = false
    self.isChangSkinWhenShow = false
  end
end

UIHeroState.RegistFromeWindowTypeID = function(self, UIWindowTypeID)
  -- function num : 0_63
  self.formWindowTypeID = UIWindowTypeID
end

UIHeroState.Return = function(self)
  -- function num : 0_64 , upvalues : JumpManager, CS_Input
  if self.returnFunc ~= nil then
    (self.returnFunc)()
  end
  JumpManager.couldUseItemJump = self._lastCouldUseItemJump
  CS_Input.multiTouchEnabled = true
  self:Delete()
end

UIHeroState.RefreshSkinBtnState = function(self)
  -- function num : 0_65 , upvalues : _ENV
  if self.isHideSkin then
    (((self.ui).btn_Skin).gameObject):SetActive(false)
  else
    ;
    (((self.ui).btn_Skin).gameObject):SetActive(FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Skin))
  end
end

UIHeroState.Delete = function(self)
  -- function num : 0_66 , upvalues : _ENV, base
  do
    if self.formWindowTypeID ~= nil then
      local win = UIManager:GetWindow(self.formWindowTypeID)
      if win ~= nil and not win.active then
        win.active = true
        ;
        (win.gameObject):SetActive(true)
      end
    end
    if not IsNull(self.bigImgGameObject) then
      DestroyUnityObject(self.bigImgGameObject)
    end
    ;
    (base.Delete)(self)
  end
end

UIHeroState.OnDelete = function(self)
  -- function num : 0_67 , upvalues : CS_coroutine, _ENV, base
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
  MsgCenter:RemoveListener(eMsgEventId.OnHeroSkinChange, self.__OnSkinChange)
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


-- params : ...
-- function num : 0 , upvalues : _ENV
local UIHome = class("UIHome", UIBaseWindow)
local base = UIBaseWindow
local cs_PlayableDirector = ((CS.UnityEngine).Playables).PlayableDirector
local cs_Time = (CS.UnityEngine).Time
local cs_GameObject = (CS.UnityEngine).GameObject
local CS_OasisCameraController = CS.OasisCameraController
local CS_SystemInfo = (CS.UnityEngine).SystemInfo
local CS_BatteryStatus = (CS.UnityEngine).BatteryStatus
local CS_SystemInfo = (CS.System).DateTime
local cs_ResLoader = CS.ResLoader
local cs_L2DManager = (CS.L2DManager).Instance
local cs_ResManager = (CS.ResManager).Instance
local BannerWidget = require("Game.CommonUI.Container.UI.UICarouselBanner")
local UIBannerData = (require("Game.CommonUI.Container.Model.ContainerData"))
local oasisController = nil
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local LotteryEnum = require("Game.Lottery.LotteryEnum")
local ShopEnum = require("Game.Shop.ShopEnum")
UIHome.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, CS_OasisCameraController, cs_ResLoader, UINResourceGroup, cs_GameObject, oasisController
  AudioManager:PlayAudioById(3002)
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, (eAuSelct.Home).name, (eAuSelct.Home).base)
  self.bind = {}
  ;
  (UIUtil.LuaUIBindingTable)((CS_OasisCameraController.Instance).transform, self.bind)
  self.resloader = (cs_ResLoader.Create)()
  self.SectorTimelineStopped = function(director)
    -- function num : 0_0_0 , upvalues : self
    self:OnSectorTimelineStopped(director)
  end

  self.topStatus = UIManager:ShowWindow(UIWindowTypeID.TopStatus)
  ;
  (self.topStatus):Hide()
  self:InitBannerWidget()
  ;
  ((self.bind).sectorPlayableDirector):stopped("+", self.SectorTimelineStopped)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Lottery, self, self.OnBtnLotteryClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GotoOasis, self, self.OnBtnOasisClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Oasis, self, self.OnBtnOasisClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Exproation, self, self.OnBtnSectorClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_HeroList, self, self.OnHeroListClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Store, self, self.OnShopClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Task, self, self.OnTaskClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Factory, self, self.OnFactoryClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_achievement, self, self.OnAchievementClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ContinueEp, self, self.OnContinueExplorationClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Dorm, self, self.OnDormClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ChatRoom, self, self.OnIntimacyClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_HideUI, self, self.__OnHideMianUIClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ShowMain, self, self.__OnShowMianUIClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SelectBoardHero, self, self.OnBoardHeroClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_tempMail, self, self.OnMailClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_tempSet, self, self.OnSetClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_AddEpPoint, self, self.QickBuyStamina)
  self._BackFromOtherWin = BindCallback(self, self.BackFromOtherWin)
  self._LoadBoardHero = BindCallback(self, self.LoadBoardHero)
  UIManager:ShowWindowAsync(UIWindowTypeID.HomeSide, function(win)
    -- function num : 0_0_1 , upvalues : self
    if win ~= nil then
      self.SideWin = win
      ;
      (self.SideWin):InitSide()
    end
  end
)
  self:InitUnlockFunction()
  self:InitRedDotEvent()
  self.__OnHeroUIClosed = BindCallback(self, self.OnHeroUIClosed)
  MsgCenter:AddListener(eMsgEventId.UIHeroListClosed, self.__OnHeroUIClosed)
  self.__onUpdatePlayerLevel = BindCallback(self, self.__UpdatePlayerLevel)
  MsgCenter:AddListener(eMsgEventId.UpdatePlayerLevel, self.__onUpdatePlayerLevel)
  self.__UIOasisShow = BindCallback(self, self.ShowOasisUI)
  MsgCenter:AddListener(eMsgEventId.UIOasisShow, self.__UIOasisShow)
  self.__onHasUncompletedEp = BindCallback(self, self.UpdateUncompletedEp)
  MsgCenter:AddListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  self.__updateMainTask = BindCallback(self, self.__UpdateMainTask)
  MsgCenter:AddListener(eMsgEventId.TaskSyncFinish, self.__updateMainTask)
  self.resourceGroup = (UINResourceGroup.New)()
  ;
  (self.resourceGroup):Init((self.ui).obj_resourceGroup)
  self.__updateStaminaUI = BindCallback(self, self.__UpdateStaminaUI)
  MsgCenter:AddListener(eMsgEventId.StaminaUpdate, self.__updateStaminaUI)
  self.__OnUpdatePlayerName = BindCallback(self, self.__UpdatePlayerName)
  MsgCenter:AddListener(eMsgEventId.UserNameChanged, self.__OnUpdatePlayerName)
  self.fakeCameraHome = ((cs_GameObject.Find)("FakeCameraHome")):GetComponent("Camera")
  self:AlignToFakeCamera(self.fakeCameraHome)
  if PlayerDataCenter.showGirlId == nil or PlayerDataCenter.showGirlId == 0 then
    local firtBoardHeroID = (ConfigData.game_config).firtBoardHeroID
    if (PlayerDataCenter.heroDic)[firtBoardHeroID] == nil then
      error("default board hero data is nil id " .. firtBoardHeroID)
    else
      self:LoadBoardHero((PlayerDataCenter.heroDic)[firtBoardHeroID])
    end
  else
    do
      self:LoadBoardHero((PlayerDataCenter.heroDic)[PlayerDataCenter.showGirlId])
      oasisController = ControllerManager:GetController(ControllerTypeId.OasisController, true)
      self.inShowState = false
      self:UpdateUncompletedEp()
      self:__UpdatePlayerName()
      self:__UpdatePlayerLevel()
      self:__UpdateMainTask()
      self:__UpdateCurEpStage()
      self:__UpdateStaminaUI()
      self:RefreshBatteryAndTime()
      if isEditorMode and ((CS.GMController).Instance).battleShortcut then
        ExplorationManager:ContinueLastExploration()
      end
      self.__RefreshBatteryAndTime = BindCallback(self, self.RefreshBatteryAndTime)
      self.BatteryTimer = (TimerManager:GetTimer(1, self.__RefreshBatteryAndTime, nil, false, false, true)):Start()
      self:SetMainUIRotate()
      GuideManager:TryTriggerGuide(eGuideCondition.FInHome)
    end
  end
end

UIHome.InitBannerWidget = function(self)
  -- function num : 0_1 , upvalues : BannerWidget, _ENV, UIBannerData
  self.lowerBannerUI = (BannerWidget.New)()
  ;
  (self.lowerBannerUI):Init()
  local bannerCfg = ConfigData.banner
  if bannerCfg == nil then
    return 
  end
  if self.bannerDatas == nil then
    self.bannerDatas = {}
    for _,v in ipairs(bannerCfg) do
      if v ~= nil and v.active then
        local bannerData = (UIBannerData.New)()
        bannerData:Init(v.pic, v.type, v.jump)
        ;
        (table.insert)(self.bannerDatas, bannerData)
      end
    end
  end
  do
    if #self.bannerDatas > 0 then
      (self.lowerBannerUI):InjectSelectObj((self.ui).selectCountTrans, (self.ui).selectTrans, (self.ui).bannerSelectWidth)
      ;
      (self.lowerBannerUI):InitialWithData(self.bannerDatas, (self.ui).advList, (self.ui).advItem, self.resloader, (self.ui).bannerSelectWidth)
    end
  end
end

UIHome.SetMainCameraEnabled = function(self, enabled)
  -- function num : 0_2 , upvalues : CS_OasisCameraController
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((CS_OasisCameraController.Instance).MainCamera).enabled = enabled
end

UIHome.LoadBoardHero = function(self, heroData)
  -- function num : 0_3 , upvalues : _ENV, cs_ResManager
  if self.currHeroData == heroData then
    return 
  end
  self.currHeroData = heroData
  local resName = heroData:GetResName()
  local Live2DPath = PathConsts:GetCharacterLive2DPath(resName)
  local haveLive2D = cs_ResManager:ContainsAsset(Live2DPath)
  if haveLive2D then
    if self.bigImgResloader ~= nil then
      (self.bigImgResloader):Put2Pool()
      self.bigImgResloader = nil
    end
    if self.bigImgGameObject ~= nil then
      DestroyUnityObject(self.bigImgGameObject)
      self.bigImgGameObject = nil
    end
    self:LoadLive2D(Live2DPath)
  else
    if self.Live2DResloader ~= nil then
      (self.Live2DResloader):Put2Pool()
      self.Live2DResloader = nil
    end
    if self.l2dModelIns ~= nil then
      DestroyUnityObject(self.l2dModelIns)
      self.l2dModelIns = nil
    end
    self:LoadHeroPic(resName)
  end
end

UIHome.LoadHeroPic = function(self, resName)
  -- function num : 0_4 , upvalues : cs_ResLoader, _ENV
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
  self.bigImgResloader = (cs_ResLoader.Create)()
  ;
  (self.bigImgResloader):LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(resName), function(prefab)
    -- function num : 0_4_0 , upvalues : _ENV, self
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate((self.ui).heroHolder)
    local comPerspHandle = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    comPerspHandle:SetRenderCamera((self.bind).live2DRoot)
    comPerspHandle:SetL2DPicPosType("Home", true)
  end
)
end

UIHome.LoadLive2D = function(self, Live2DPath)
  -- function num : 0_5 , upvalues : cs_ResLoader, _ENV
  if self.Live2DResloader ~= nil then
    (self.Live2DResloader):Put2Pool()
    self.Live2DResloader = nil
  end
  self.Live2DResloader = (cs_ResLoader.Create)()
  local l2dModelAsset = (self.resloader):LoadABAsset(Live2DPath)
  DestroyUnityObject(self.l2dModelIns)
  self.l2dModelIns = l2dModelAsset:Instantiate(((self.bind).live2DRoot).transform)
  self.l2dBinding = {}
  ;
  (UIUtil.LuaUIBindingTable)(self.l2dModelIns, self.l2dBinding)
  local canvasGroup = (self.bind).canvas_canvasGroup
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R4 in 'UnsetPending'

  if canvasGroup ~= nil then
    ((self.l2dBinding).renderController).uiCanvasGroup = canvasGroup
  end
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.l2dBinding).renderController).InfluencedByUICanvas = true
  ;
  ((self.l2dBinding).commonPerpectiveHandle):SetRenderCamera((self.bind).live2DRoot)
  ;
  ((self.l2dBinding).commonPerpectiveHandle):SetL2DPosType("Home", true)
end

UIHome.SetMainUIRotate = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local rotateWithMian = (self.fakeCameraHome):GetComponentInChildren(typeof(((CS.UnityEngine).Animations).RotationConstraint))
  ;
  (rotateWithMian.transform):SetParent(self.transform, true)
  ;
  (((self.ui).obj_mainUI).transform):SetParent(rotateWithMian.transform, true)
  rotateWithMian.constraintActive = true
end

UIHome.ShowOasisUI = function(self)
  -- function num : 0_7 , upvalues : oasisController
  oasisController:EnterOasis()
end

UIHome.ChangeHomeShowState = function(self, active)
  -- function num : 0_8 , upvalues : _ENV
  self.inShowState = active
  if active then
    GuideManager:TryTriggerGuide(eGuideCondition.InHome)
  end
end

UIHome.SetFrom = function(self, from)
  -- function num : 0_9 , upvalues : _ENV
  if from == AreaConst.Sector and ((self.bind).homeToSectorGo).activeInHierarchy then
    (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
    self:ChangeHomeShowState(false)
    ;
    ((self.bind).homeToSectorGo):SetActive(true)
    ;
    ((self.bind).homeToOasisGo):SetActive(false)
    ;
    ((self.bind).homeToMenuGo):SetActive(false)
    self.__tlSectorCo = (TimelineUtil.Rewind)((self.bind).sectorPlayableDirector, function()
    -- function num : 0_9_0 , upvalues : self, _ENV
    self:ChangeHomeShowState(true)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  end
)
  end
  ;
  ((self.bind).homeToSectorGo):SetActive(false)
  ;
  ((self.bind).homeToOasisGo):SetActive(true)
  ;
  ((self.bind).homeToMenuGo):SetActive(false)
  self:ChangeHomeShowState(true)
end

UIHome.SetTo = function(self, to)
  -- function num : 0_10 , upvalues : _ENV
  self:ChangeHomeShowState(false)
  if to == AreaConst.Sector then
    ((self.bind).homeToSectorGo):SetActive(true)
    ;
    ((self.bind).homeToOasisGo):SetActive(false)
    ;
    ((self.bind).homeToMenuGo):SetActive(false)
  else
    if to == AreaConst.Oasis then
      ((self.bind).homeToSectorGo):SetActive(false)
      ;
      ((self.bind).homeToOasisGo):SetActive(true)
      ;
      ((self.bind).homeToMenuGo):SetActive(false)
    end
  end
end

UIHome.InitUnlockFunction = function(self)
  -- function num : 0_11 , upvalues : _ENV
  (ControllerManager:GetController(ControllerTypeId.FunctionUnlock, true))
  local funcUnLockCrtl = nil
  local unlockDes = nil
  local isTaskUIUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TaskUi)
  self:OnTaskUIUnlock(isTaskUIUnlock)
  local isShopUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Store)
  if not isShopUnlock then
    unlockDes = funcUnLockCrtl:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_Store)
    self:OnShopUnlock(isShopUnlock, unlockDes)
  else
    self:OnShopUnlock(isShopUnlock)
  end
  local isFactoryUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Factory)
  if not isFactoryUnlock then
    unlockDes = funcUnLockCrtl:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_Factory)
    self:OnFactoryUnlock(isFactoryUnlock, unlockDes)
  else
    self:OnFactoryUnlock(isFactoryUnlock)
  end
  local isOasisUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Building)
  self:OnOasisUnlock(isOasisUnlock)
  local isSectorUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration)
  self:OnSectorUnlock(isSectorUnlock)
  local isHeroListUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroGroup)
  if not isHeroListUnlock then
    unlockDes = funcUnLockCrtl:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroGroup)
    self:OnHeroListUnlock(isHeroListUnlock, unlockDes)
  else
    self:OnHeroListUnlock(isHeroListUnlock)
  end
  local isLotteryUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Lottery)
  if not isLotteryUnlock then
    unlockDes = funcUnLockCrtl:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_Lottery)
    self:OnLotteryUnlock(isLotteryUnlock, unlockDes)
  else
    self:OnLotteryUnlock(isLotteryUnlock)
  end
  local isDormUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm)
  if not isDormUnlock then
    unlockDes = funcUnLockCrtl:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm)
    self:OnDormUnlock(isDormUnlock, unlockDes)
  else
    self:OnDormUnlock(isDormUnlock)
  end
  local isUserNameUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_ChangeName)
  self:OnUserNamelock(isUserNameUnlock)
  local isMailUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Mail)
  self:OnMailUnlock(isMailUnlock)
end

UIHome.InitRedDotEvent = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local ok, heroWindowNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow)
  ;
  ((self.ui).obj_HeroRedDot):SetActive(not self.heroListUnlock or heroWindowNode:GetRedDotCount() > 0)
  self.__onRedDotHeroWindowChanged = function(node)
    -- function num : 0_12_0 , upvalues : self
    ((self.ui).obj_HeroRedDot):SetActive(not self.heroListUnlock or node:GetRedDotCount() > 0)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end

  RedDotController:AddListener(heroWindowNode.nodePath, self.__onRedDotHeroWindowChanged)
  local ok, taskWindowNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Task)
  ;
  ((self.ui).obj_TaskRedDot):SetActive(not self.taskUIUnlock or taskWindowNode:GetRedDotCount() > 0)
  self.__onRedDotTaskWindowChanged = function(node)
    -- function num : 0_12_1 , upvalues : self
    ((self.ui).obj_TaskRedDot):SetActive(not self.taskUIUnlock or node:GetRedDotCount() > 0)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end

  RedDotController:AddListener(taskWindowNode.nodePath, self.__onRedDotTaskWindowChanged)
  local ok, lotteryNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Lottery)
  ;
  ((self.ui).obj_LotteryRedDot):SetActive(not self.lotterytUnlock or lotteryNode:GetRedDotCount() > 0)
  self.__onRedDotLotteryChanged = function(node)
    -- function num : 0_12_2 , upvalues : self
    ((self.ui).obj_LotteryRedDot):SetActive(not self.lotterytUnlock or node:GetRedDotCount() > 0)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end

  RedDotController:AddListener(lotteryNode.nodePath, self.__onRedDotLotteryChanged)
  local ok, sectorNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector)
  ;
  ((self.ui).obj_EpRedDot):SetActive(sectorNode:GetRedDotCount() > 0)
  self.__onRedDotSectorChanged = function(node)
    -- function num : 0_12_3 , upvalues : self
    ((self.ui).obj_EpRedDot):SetActive(node:GetRedDotCount() > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

  RedDotController:AddListener(sectorNode.nodePath, self.__onRedDotSectorChanged)
  local ok, shopNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow)
  ;
  ((self.ui).obj_StoreRedDot):SetActive(not self.storeUnlock or shopNode:GetRedDotCount() > 0)
  self.__onRedDotShopChanged = function(node)
    -- function num : 0_12_4 , upvalues : self
    ((self.ui).obj_StoreRedDot):SetActive(not self.storeUnlock or node:GetRedDotCount() > 0)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end

  RedDotController:AddListener(shopNode.nodePath, self.__onRedDotShopChanged)
  local ok, oasisNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Oasis)
  ;
  ((self.ui).obj_OasisRedDot):SetActive(oasisNode:GetRedDotCount() > 0)
  self.__onRedDotOasisChanged = function(node)
    -- function num : 0_12_5 , upvalues : self
    ((self.ui).obj_OasisRedDot):SetActive(node:GetRedDotCount() > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

  RedDotController:AddListener(oasisNode.nodePath, self.__onRedDotOasisChanged)
  local ok, achivLevelNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.AchivLevel)
  ;
  ((self.ui).obj_AchievementRedDot):SetActive(achivLevelNode:GetRedDotCount() > 0)
  self.__onRedDotAchivLevelChanged = function(node)
    -- function num : 0_12_6 , upvalues : self
    ((self.ui).obj_AchievementRedDot):SetActive(node:GetRedDotCount() > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

  RedDotController:AddListener(achivLevelNode.nodePath, self.__onRedDotAchivLevelChanged)
  local ok, mailNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Mail)
  ;
  ((self.ui).obj_tempMailRedDot):SetActive(mailNode:GetRedDotCount() > 0)
  self.__onRedDotMailChanged = function(node)
    -- function num : 0_12_7 , upvalues : self
    ((self.ui).obj_tempMailRedDot):SetActive(node:GetRedDotCount() > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

  RedDotController:AddListener(mailNode.nodePath, self.__onRedDotMailChanged)
  -- DECOMPILER ERROR: 12 unprocessed JMP targets
end

UIHome.RemoveRedDotEvent = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local ok, heroWindowNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow)
  RedDotController:RemoveListener(heroWindowNode.nodePath, self.__onRedDotHeroWindowChanged)
  local ok, taskWindowNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Task)
  RedDotController:RemoveListener(taskWindowNode.nodePath, self.__onRedDotTaskWindowChanged)
  local ok, lotteryNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Lottery)
  RedDotController:RemoveListener(lotteryNode.nodePath, self.__onRedDotLotteryChanged)
  local ok, sectorNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector)
  RedDotController:RemoveListener(sectorNode.nodePath, self.__onRedDotSectorChanged)
  local ok, shopNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow)
  RedDotController:RemoveListener(shopNode.nodePath, self.__onRedDotShopChanged)
  local ok, oasisNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Oasis)
  RedDotController:RemoveListener(oasisNode.nodePath, self.__onRedDotOasisChanged)
  local ok, achivLevelNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.AchivLevel)
  RedDotController:RemoveListener(achivLevelNode.nodePath, self.__onRedDotAchivLevelChanged)
  local ok, mailNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Mail)
  RedDotController:RemoveListener(mailNode.nodePath, self.__onRedDotMailChanged)
end

UIHome.__UpdatePlayerName = function(self)
  -- function num : 0_14 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).tex_UserName).text = PlayerDataCenter.playerName
  ;
  ((self.ui).tex_UserID):SetIndex(0, PlayerDataCenter.strPlayerId)
end

UIHome.__UpdatePlayerLevel = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local level = (PlayerDataCenter.playerLevel).level
  local maxLevel = (ConfigData.game_config).playerMaxLevel
  if level < 10 then
    ((self.ui).tex_Level):SetIndex(0, "0", tostring(level))
  else
    ;
    ((self.ui).tex_Level):SetIndex(0, "", tostring(level))
  end
  if level < maxLevel then
    local expCeiling = (PlayerDataCenter.playerLevel):GetNextLevelExp()
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).img_Exp).fillAmount = (PlayerDataCenter.playerLevel).exp / expCeiling
  else
    do
      -- DECOMPILER ERROR at PC43: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.ui).img_Exp).fillAmount = 1
    end
  end
end

UIHome.OnHeroUIClosed = function(self)
  -- function num : 0_16
  ((self.bind).mainCanvasGruop):DOFade(1, 0.5)
end

UIHome.OnHeroListClicked = function(self)
  -- function num : 0_17 , upvalues : _ENV
  if not self.heroListUnlock then
    return 
  end
  ;
  ((self.bind).mainCanvasGruop):DOFade(0, 0.25)
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroList, function(window)
    -- function num : 0_17_0 , upvalues : self
    if window == nil then
      return 
    end
    self:OpenOtherWin()
    self:SetMainCameraEnabled(false)
  end
)
end

UIHome.OnBtnLotteryClicked = function(self)
  -- function num : 0_18 , upvalues : _ENV, LotteryEnum
  if not self.lotterytUnlock then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.LotteryWindow, function(win)
    -- function num : 0_18_0 , upvalues : self, LotteryEnum
    if win ~= nil then
      self:OpenOtherWin()
      win:EnterLotteryPool((LotteryEnum.eLotteryPoolType).Main)
      self:SetMainCameraEnabled(false)
    end
  end
)
end

UIHome.OnDormClicked = function(self)
  -- function num : 0_19 , upvalues : _ENV
  if not self.dormUnlock then
    return 
  end
  ;
  (ControllerManager:GetController(ControllerTypeId.Dorm, true)):EnterDorm()
end

UIHome.OnIntimacyClicked = function(self)
  -- function num : 0_20 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.FriendShip, function(win)
    -- function num : 0_20_0 , upvalues : self
    if win ~= nil then
      self:OpenOtherWin()
      self:SetMainCameraEnabled(false)
    end
  end
)
end

UIHome.OnMailClicked = function(self)
  -- function num : 0_21 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.Mail, function(win)
    -- function num : 0_21_0 , upvalues : self
    if win ~= nil then
      self:OpenOtherWin(true)
    end
  end
)
end

UIHome.OnSetClicked = function(self)
  -- function num : 0_22 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.Setting, function(win)
    -- function num : 0_22_0 , upvalues : self
    if win ~= nil then
      self:OpenOtherWin(true)
    end
  end
)
end

UIHome.OnBoardHeroClicked = function(self)
  -- function num : 0_23 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.SelectBoardHero, function(win)
    -- function num : 0_23_0 , upvalues : self
    if win ~= nil then
      self:OpenOtherWin()
      win:SetDefaultSelect(self.currHeroData)
      win.changeBoardHeroCallback = self._LoadBoardHero
      self:SetMainCameraEnabled(false)
    end
  end
)
end

UIHome.OnOasisUnlock = function(self, active)
  -- function num : 0_24
  (((self.ui).btn_Oasis).gameObject):SetActive(active)
end

UIHome.OnSectorUnlock = function(self, active)
  -- function num : 0_25
  self.exproationUnlock = active
end

UIHome.OnHeroListUnlock = function(self, active, unlockDes)
  -- function num : 0_26 , upvalues : _ENV
  self.heroListUnlock = active
  ;
  ((self.ui).obj_HeroListLock):SetActive(not active)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  if not active then
    ((self.ui).tex_HeroLock).text = unlockDes
  else
    local ok, heroWindowNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow)
    ;
    ((self.ui).obj_HeroRedDot):SetActive(heroWindowNode:GetRedDotCount() > 0)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIHome.OnLotteryUnlock = function(self, active, unlockDes)
  -- function num : 0_27 , upvalues : _ENV
  self.lotterytUnlock = active
  ;
  ((self.ui).obj_LotteryLock):SetActive(not active)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  if not active then
    ((self.ui).tex_LotteyLock).text = "信噪比过低，暂未开放"
  else
    local ok, lotteryNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Lottery)
    ;
    ((self.ui).obj_LotteryRedDot):SetActive(lotteryNode:GetRedDotCount() > 0)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIHome.OnTaskUIUnlock = function(self, active)
  -- function num : 0_28 , upvalues : _ENV
  self.taskUIUnlock = active
  ;
  (((self.ui).btn_Task).gameObject):SetActive(active)
  do
    if active then
      local ok, taskNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Task)
      ;
      ((self.ui).obj_TaskRedDot):SetActive(not self.taskUIUnlock or taskNode:GetRedDotCount() > 0)
    end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

UIHome.OnShopUnlock = function(self, active, unlockDes)
  -- function num : 0_29 , upvalues : _ENV
  self.storeUnlock = active
  ;
  ((self.ui).obj_StoreLock):SetActive(not active)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  if not active then
    ((self.ui).tex_StoreLock).text = unlockDes
  else
    local ok, shopNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow)
    ;
    ((self.ui).obj_StoreRedDot):SetActive(not self.storeUnlock or shopNode:GetRedDotCount() > 0)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UIHome.OnFactoryUnlock = function(self, active, unlockDes)
  -- function num : 0_30
  self.factoryUnlock = active
  ;
  ((self.ui).obj_FactoryLock):SetActive(not active)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  if not active then
    ((self.ui).tex_FactoryLock).text = "信噪比过低，暂未开放"
  end
end

UIHome.OnDormUnlock = function(self, active, unlockDes)
  -- function num : 0_31
  self.dormUnlock = active
  ;
  ((self.ui).obj_DormLock):SetActive(not active)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  if not active then
    ((self.ui).tex_DormLock).text = "信噪比过低，暂未开放"
  end
end

UIHome.OnUserNamelock = function(self, unlock)
  -- function num : 0_32
  (((self.ui).tex_UserName).gameObject):SetActive(unlock)
end

UIHome.OnMailUnlock = function(self, active)
  -- function num : 0_33
  (((self.ui).btn_tempMail).gameObject):SetActive(active)
end

UIHome.OnShopClicked = function(self)
  -- function num : 0_34 , upvalues : _ENV
  if not self.storeUnlock then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.Shop, function(win)
    -- function num : 0_34_0 , upvalues : self
    if win ~= nil then
      self:OpenOtherWin()
      win:InitShopTogList(nil)
      self:SetMainCameraEnabled(false)
    end
  end
)
end

UIHome.OnTaskClicked = function(self)
  -- function num : 0_35 , upvalues : _ENV
  local taskController = ControllerManager:GetController(ControllerTypeId.Task, false)
  if taskController == nil then
    error("get taskController error")
    return 
  end
  taskController:ShowTaskUI(nil, self._BackFromOtherWin)
  self:OpenOtherWin()
  self:SetMainCameraEnabled(false)
end

UIHome.OnFactoryClicked = function(self)
  -- function num : 0_36 , upvalues : _ENV
  if not self.factoryUnlock then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.Factory, function(win)
    -- function num : 0_36_0 , upvalues : self
    if win ~= nil then
      self:OpenOtherWin()
      self:SetMainCameraEnabled(false)
    end
  end
)
end

UIHome.OnAchievementClicked = function(self)
  -- function num : 0_37 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.Achievement, function(win)
    -- function num : 0_37_0 , upvalues : self
    if win ~= nil then
      self:OpenOtherWin()
      self:SetMainCameraEnabled(false)
    end
  end
)
end

UIHome.OnContinueExplorationClicked = function(self)
  -- function num : 0_38 , upvalues : _ENV
  ExplorationManager:ContinueLastExploration()
  self:OpenOtherWin()
end

UIHome.OnOpenSideClicked = function(self)
  -- function num : 0_39
  if self.SideWin ~= nil then
    (self.SideWin):OpenSide()
  end
end

UIHome.UpdateUncompletedEp = function(self)
  -- function num : 0_40 , upvalues : _ENV
  local hasHasUncompletedEp = ExplorationManager:HasUncompletedEp()
  ;
  (((self.ui).btn_ContinueEp).gameObject):SetActive(hasHasUncompletedEp)
end

UIHome.OnBtnOasisClicked = function(self)
  -- function num : 0_41 , upvalues : _ENV, oasisController
  self:OpenOtherWin()
  self:SetTo(AreaConst.Oasis)
  ;
  ((self.bind).oasisPlayableDirector):Play()
  self.oasisBtnClicked = true
  AudioManager:PlayAudioById(1016)
  local homeClicked = function()
    -- function num : 0_41_0 , upvalues : self, oasisController, _ENV
    ((self.bind).oasisPlayableDirector):Pause()
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((self.bind).oasisPlayableDirector).time = 0
    ;
    ((self.bind).oasisPlayableDirector):Evaluate()
    oasisController:OnExitOasis()
    AudioManager:PlayAudioById(1017)
    self.__tlOasisCo = (TimelineUtil.Rewind)((self.bind).oasisPlayableDirector, function()
      -- function num : 0_41_0_0 , upvalues : _ENV, self
      UIManager:ShowWindow(UIWindowTypeID.Home)
      self:ChangeHomeShowState(true)
      self:BackFromOtherWin()
    end
)
  end

  oasisController.backToHomeEvent = BindCallback(self, homeClicked)
end

UIHome.OnBtnSectorClicked = function(self)
  -- function num : 0_42 , upvalues : _ENV
  if not self.exproationUnlock then
    return 
  end
  self:SetTo(AreaConst.Sector)
  ;
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
  ;
  ((self.bind).sectorPlayableDirector):Play()
  self.sectorBtnClicked = true
  self:OpenOtherWin()
end

UIHome.OnSectorTimelineStopped = function(self, director)
  -- function num : 0_43 , upvalues : _ENV
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  if (self.bind).sectorPlayableDirector == director then
    if not self.sectorBtnClicked then
      ((self.bind).sectorPlayableDirector).initialTime = 0
      return 
    end
    self.sectorBtnClicked = false
    UIManager:DeleteWindow(UIWindowTypeID.Home)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    ;
    ((CS.GSceneManager).Instance):LoadSceneByAB((Consts.SceneName).Sector, function()
    -- function num : 0_43_0 , upvalues : self, _ENV
    if self.enterSectorJumpCallback ~= nil then
      (ControllerManager:GetController(ControllerTypeId.SectorController, true)):SetFrom(AreaConst.Home)
      ;
      (self.enterSectorJumpCallback)()
      self.enterSectorJumpCallback = nil
    else
      if ExplorationManager:HasUncompletedEp() then
        (ControllerManager:GetController(ControllerTypeId.SectorController, true)):SetFrom(AreaConst.Exploration)
      else
        ;
        (ControllerManager:GetController(ControllerTypeId.SectorController, true)):SetFrom(AreaConst.Home)
      end
    end
  end
)
  end
end

UIHome.OnOasisTimelineStopped = function(self, director)
  -- function num : 0_44
  if (self.bind).oasisPlayableDirector == director then
    if not self.oasisBtnClicked then
      return 
    end
    self.oasisBtnClicked = false
  end
end

UIHome.OpenOtherWin = function(self, noCloseSide)
  -- function num : 0_45
  if not noCloseSide then
    noCloseSide = false
  end
  if not noCloseSide then
    (self.SideWin):CloseSide()
    ;
    (self.SideWin):Hide()
  end
  self:ChangeHomeShowState(false)
end

UIHome.BackFromOtherWin = function(self)
  -- function num : 0_46
  if self.SideWin ~= nil then
    (self.SideWin):Show()
  end
  self:ChangeHomeShowState(true)
  self:SetMainCameraEnabled(true)
end

UIHome.__UpdateMainTask = function(self)
  -- function num : 0_47 , upvalues : _ENV
  local taskData = (PlayerDataCenter.allTaskData):GetTaskData4Home()
  for stepIndex,stepData in ipairs(taskData.steps) do
    if stepData.schedule <= stepData.aim then
      local stepCfg = (taskData.taskStepCfg)[stepIndex]
      ;
      ((self.ui).tex_TaskInfo):SetIndex(0, (LanguageUtil.GetLocaleText)(stepCfg.intro))
      ;
      ((self.ui).tex_Progress):SetIndex(0, tostring(stepData.schedule), tostring(stepData.aim))
      return 
    end
  end
end

UIHome.__UpdateCurEpStage = function(self)
  -- function num : 0_48 , upvalues : _ENV
  local sectorId, stageIndex, differIdex = (PlayerDataCenter.sectorStage):GetEpStageCfg4Home()
  local difficult = ((self.ui).tex_LevelName):GetIndex(differIdex)
  ;
  ((self.ui).tex_LevelName):SetIndex(0, tostring(sectorId), tostring(stageIndex), difficult)
end

UIHome.__OnHideMianUIClick = function(self)
  -- function num : 0_49
  (self.SideWin):Hide()
  ;
  ((self.ui).obj_mainUI):SetActive(false)
  ;
  (((self.ui).btn_GotoOasis).gameObject):SetActive(false)
  ;
  (((self.ui).btn_ShowMain).gameObject):SetActive(true)
end

UIHome.__OnShowMianUIClick = function(self)
  -- function num : 0_50
  (self.SideWin):Show()
  ;
  ((self.ui).obj_mainUI):SetActive(true)
  ;
  (((self.ui).btn_GotoOasis).gameObject):SetActive(true)
  ;
  (((self.ui).btn_ShowMain).gameObject):SetActive(false)
end

UIHome.QickBuyStamina = function(self)
  -- function num : 0_51 , upvalues : ShopEnum, _ENV
  local quickBuyData = (ShopEnum.eQuickBuy).stamina
  local shopId = quickBuyData.shopId
  local shelfId = quickBuyData.shelfId
  local goodData = nil
  local ctrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  if not ctrl.isUnlocked then
    ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(TipContent.notUnlockShopCantBuyStamina))
    return 
  end
  ctrl:GetShopData(shopId, function(shopData)
    -- function num : 0_51_0 , upvalues : goodData, shelfId, _ENV, quickBuyData
    goodData = (shopData.shopGoodsDic)[shelfId]
    UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
      -- function num : 0_51_0_0 , upvalues : _ENV, goodData, quickBuyData
      if win == nil then
        error("can\'t open QuickBuy win")
        return 
      end
      win:SlideIn()
      win:InitBuyTarget(goodData, nil, true, quickBuyData.resourceIds)
    end
)
  end
)
end

UIHome.__UpdateStaminaUI = function(self)
  -- function num : 0_52 , upvalues : _ENV
  local ceiling = (PlayerDataCenter.stamina).ceiling
  local stamina, remainSecond = (PlayerDataCenter.stamina):GetCurrentStamina()
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_EpPoint).text = tostring(stamina)
  ;
  ((self.ui).tex_EpPointLimit):SetIndex(0, tostring(ceiling))
end

UIHome.RefreshBatteryAndTime = function(self)
  -- function num : 0_53 , upvalues : CS_SystemInfo, CS_BatteryStatus
  local batteryLevel = CS_SystemInfo.batteryLevel
  local batteryStatus = CS_SystemInfo.batteryStatus
  local time = (CS_SystemInfo.Now):ToShortTimeString()
  if batteryLevel == nil or batteryLevel < 0 then
    batteryLevel = 1
  end
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_CurBattery).fillAmount = batteryLevel
  if batteryStatus == CS_BatteryStatus.Charging then
    ((self.ui).obj_recharge):SetActive(true)
  else
    ;
    ((self.ui).obj_recharge):SetActive(false)
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Clock).text = time
end

UIHome.OnDelete = function(self)
  -- function num : 0_54 , upvalues : _ENV, base
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  self:RemoveRedDotEvent()
  ControllerManager:DeleteController(ControllerTypeId.OasisController)
  MsgCenter:RemoveListener(eMsgEventId.UIHeroListClosed, self.__OnHeroUIClosed)
  MsgCenter:RemoveListener(eMsgEventId.UIOasisShow, self.__UIOasisShow)
  MsgCenter:RemoveListener(eMsgEventId.UpdatePlayerLevel, self.__onUpdatePlayerLevel)
  MsgCenter:RemoveListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  MsgCenter:RemoveListener(eMsgEventId.TaskSyncFinish, self.__updateMainTask)
  MsgCenter:RemoveListener(eMsgEventId.StaminaUpdate, self.__updateStaminaUI)
  MsgCenter:RemoveListener(eMsgEventId.UserNameChanged, self.__OnUpdatePlayerName)
  if self.__tlSectorCo ~= nil then
    (TimelineUtil.StopTlCo)(self.__tlSectorCo)
  end
  if self.__tlMenuCo ~= nil then
    (TimelineUtil.StopTlCo)(self.__tlMenuCo)
  end
  if self.__tlOasisCo ~= nil then
    (TimelineUtil.StopTlCo)(self.__tlOasisCo)
  end
  if self.SideWin ~= nil then
    (self.SideWin):Delete()
    self.SideWin = nil
  end
  if self.BatteryTimer ~= nil then
    (self.BatteryTimer):Stop()
    self.BatteryTimer = nil
  end
  ;
  (self.resourceGroup):Delete()
  ;
  (base.OnDelete)(self)
end

return UIHome


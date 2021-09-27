local UIHeroInformation = class("UIHeroInformation", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local UINHeroInfoAchriveNode = require("Game.Hero.NewUI.HeroInfo.UINHeroInfoAchriveNode")
local UINHeroInfoStrotyNode = require("Game.Hero.NewUI.HeroInfo.UINHeroInfoStrotyNode")
local UINHeroInfoVoiceNode = require("Game.Hero.NewUI.HeroInfo.UINHeroInfoVoiceNode")
local UINHeroInfoFrageState = require("Game.Hero.NewUI.HeroInfo.UINHeroInfoFrageState")
local HeroInfoTextUtil = require("Game.Hero.NewUI.HeroInfo.HeroInfoTextUtil")
local eNodeType = {achrive = 1, story = 2, voice = 3}
local eNodeTypeClass = {[eNodeType.achrive] = UINHeroInfoAchriveNode, [eNodeType.story] = UINHeroInfoStrotyNode, [eNodeType.voice] = UINHeroInfoVoiceNode}
UIHeroInformation.OnInit = function(self)
  -- function num : 0_0 , upvalues : cs_ResLoader, _ENV, eNodeType, eNodeTypeClass
  self.nodeDic = {}
  self.togUI = {}
  self.resloader = (cs_ResLoader.Create)()
  ;
  (UIUtil.SetTopStatus)(self, self.OnClickReturn)
  for _,typeId in pairs(eNodeType) do
    (UIUtil.AddValueChangedListener)(((self.ui).tog_list)[typeId], self, self.__OnClickTog, typeId)
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.togUI)[typeId] = {}
    ;
    (UIUtil.LuaUIBindingTable)((((self.ui).tog_list)[typeId]).transform, (self.togUI)[typeId])
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.nodeDic)[typeId] = ((eNodeTypeClass[typeId]).New)()
    ;
    ((self.nodeDic)[typeId]):Init(((self.ui).nodeGo)[typeId])
  end
  ;
  ((self.ui).boj_heroChipInfo):SetActive(false)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_LeftArrow, self, self._OnLeftBtnClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_RightArrow, self, self._OnRightBtnClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_AVGNoun, self, self.OnClickAvgNoun)
  ;
  (UIUtil.AddButtonListener)((self.ui).Btn_friendShip, self, self._OnfriendShipClick)
end

UIHeroInformation.InitHeroInformation = function(self, heroData, closeCallback, switchHeroFunc)
  -- function num : 0_1
  self.closeCallback = closeCallback
  if self.winTween ~= nil then
    (self.winTween):Complete()
  end
  self:RefreshHeroInformation(heroData, switchHeroFunc)
end

UIHeroInformation.RefreshHeroInformation = function(self, heroData, switchHeroFunc)
  -- function num : 0_2
  self.heroData = heroData
  self.switchHeroFunc = switchHeroFunc
  local active = switchHeroFunc ~= nil
  ;
  (((self.ui).btn_LeftArrow).gameObject):SetActive(active)
  ;
  (((self.ui).btn_RightArrow).gameObject):SetActive(active)
  ;
  ((self.ui).tween_info):DORestart()
  self:SwitchHero(heroData)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIHeroInformation.SwitchHero = function(self, heroData, reUseBigImgResLoader)
  -- function num : 0_3 , upvalues : _ENV, HeroInfoTextUtil, eNodeType
  self.heroData = heroData
  self.isLocked = heroData.isLockedHero or (PlayerDataCenter.heroDic)[heroData.dataId] == nil
  self:RefreshFrageStateNode()
  local cvController = ControllerManager:GetController(ControllerTypeId.Cv, true)
  cvController:RemoveAllCvText()
  cvController:RemoveCvAllCueSheet(true)
  for type,node in pairs(self.nodeDic) do
    node:InitUsefulData(heroData, HeroInfoTextUtil, self.resloader)
    node:InitHeroInfoNode()
    if node.playerRateTimer ~= nil then
      (node.playerRateTimer):Stop()
      node.playerRateTimer = nil
      ;
      (node.playerRateCallback)(1)
    end
  end
  for _,tog in ipairs((self.ui).tog_list) do
    tog.isOn = true
    break
  end
  local hasVoice = (ControllerManager:GetController(ControllerTypeId.Cv, true)):HasCv(heroData.dataId)
  ;
  (((self.ui).Btn_friendShip).gameObject):SetActive(not self.isLocked)
  -- DECOMPILER ERROR at PC83: Confused about usage of register: R5 in 'UnsetPending'

  if self.isLocked or not hasVoice then
    (((self.ui).tog_list)[eNodeType.voice]).interactable = false
    ;
    ((self.ui).obj_img_voiceLock):SetActive(true)
  else
    -- DECOMPILER ERROR at PC94: Confused about usage of register: R5 in 'UnsetPending'

    (((self.ui).tog_list)[eNodeType.voice]).interactable = true
    ;
    ((self.ui).obj_img_voiceLock):SetActive(false)
  end
  self:__RefreshLeftUI()
  self:__ShowHeroSkin(reUseBigImgResLoader)
  ;
  ((self.nodeDic)[eNodeType.story]):StopPlayVoice()
  ;
  ((self.nodeDic)[eNodeType.voice]):StopPlayVoice()
  -- DECOMPILER ERROR: 8 unprocessed JMP targets
end

UIHeroInformation.__PlayAllDOTweenBackwards = function(self)
  -- function num : 0_4
  ((self.ui).tween_heroHolder):DOPlayBackwards()
  ;
  ((self.ui).tween_info):DOPlayBackwards()
end

UIHeroInformation.__RefreshLeftUI = function(self)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).tex_Name).text = (self.heroData):GetName()
  local birthday, model, cv, archives_career = (self.heroData):GetHeroArchiveInfo()
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_CV_Name).text = cv
  local friendShipLevel = (PlayerDataCenter.allFriendshipData):GetLevel((self.heroData).dataId)
  local curLevelExp = (PlayerDataCenter.allFriendshipData):GetExp((self.heroData).dataId)
  local curLevelTotalExp = ((ConfigData.friendship_level)[friendShipLevel]).friendship
  ;
  ((self.ui).tex_FrienshipLevel):SetIndex(0, tostring(friendShipLevel))
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).img_FriendshipBar).fillAmount = curLevelExp / curLevelTotalExp
end

UIHeroInformation.__ShowHeroSkin = function(self, reUseBigImgResLoader)
  -- function num : 0_6 , upvalues : _ENV, cs_ResLoader
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
  if reUseBigImgResLoader ~= nil then
    if not IsNull(self.bigImgGameObject) then
      (self.bigImgGameObject):SetActive(false)
    end
    reUseBigImgResLoader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath((self.heroData):GetResPicName()), function(prefab)
    -- function num : 0_6_0 , upvalues : _ENV, self
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate((self.ui).heroHolder)
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroSkin")
    do
      if self.isLocked then
        local rawImage = (self.bigImgGameObject):FindComponent(eUnityComponentID.RawImage)
        rawImage.material = (((CS.UnityEngine).Object).Instantiate)((self.ui).mat_heroPicPaperCut)
      end
      ;
      ((self.ui).tween_heroHolder):DORestart()
    end
  end
)
  else
    self.bigImgResloader = (cs_ResLoader.Create)()
    if not IsNull(self.bigImgGameObject) then
      (self.bigImgGameObject):SetActive(false)
    end
    ;
    (self.bigImgResloader):LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath((self.heroData):GetResPicName()), function(prefab)
    -- function num : 0_6_1 , upvalues : _ENV, self
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate((self.ui).heroHolder)
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroSkin")
    do
      if self.isLocked then
        local rawImage = (self.bigImgGameObject):FindComponent(eUnityComponentID.RawImage)
        rawImage.material = (((CS.UnityEngine).Object).Instantiate)((self.ui).mat_heroPicPaperCut)
      end
      ;
      ((self.ui).tween_heroHolder):DORestart()
    end
  end
)
  end
end

UIHeroInformation.__OnClickTog = function(self, type, bool)
  -- function num : 0_7
  if not bool then
    if (self.nodeDic)[type] ~= nil then
      ((self.nodeDic)[type]):Hide()
      ;
      ((((self.nodeDic)[type]).ui).fade):DOKill()
    end
    ;
    (((self.togUI)[type]).img_UnSel):SetActive(true)
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (((self.togUI)[type]).tex_pageName).color = (self.ui).colot_unselected
    return 
  end
  ;
  (((self.togUI)[type]).img_UnSel):SetActive(false)
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.togUI)[type]).tex_pageName).color = (self.ui).color_selected
  ;
  ((self.nodeDic)[type]):Show()
  ;
  ((self.nodeDic)[type]):InitHeroInfoNode()
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((((self.nodeDic)[type]).ui).fade).alpha = 1
  ;
  (((((self.nodeDic)[type]).ui).fade):DOFade(0, 0.25)):From()
end

UIHeroInformation.RefreshFrageStateNode = function(self)
  -- function num : 0_8 , upvalues : UINHeroInfoFrageState
  if self.isLocked then
    if self.frageStateNode == nil then
      self.frageStateNode = (UINHeroInfoFrageState.New)()
      ;
      (self.frageStateNode):Init((self.ui).boj_heroChipInfo)
    end
    ;
    (self.frageStateNode):Show()
  else
    if self.frageStateNode ~= nil then
      (self.frageStateNode):Hide()
    end
    return 
  end
  ;
  (self.frageStateNode):RefreshFrageState(self.heroData, self.resloader)
end

UIHeroInformation.__UnloadHeroVoiceAndStory = function(self)
  -- function num : 0_9 , upvalues : _ENV, HeroInfoTextUtil
  local cvController = ControllerManager:GetController(ControllerTypeId.Cv, true)
  cvController:RemoveAllCvText()
  cvController:RemoveCvAllCueSheet(true)
  ;
  (HeroInfoTextUtil.RemoveAllArchiveText)()
end

UIHeroInformation.OnTcpLogout_HeroInfo = function(self)
  -- function num : 0_10 , upvalues : _ENV, eNodeType
  for _,typeId in pairs(eNodeType) do
    ((self.nodeDic)[typeId]):OnTcpLogOut_HeroInfoNode()
  end
end

UIHeroInformation.OnClickReturn = function(self)
  -- function num : 0_11
  if self.closeCallback ~= nil then
    (self.closeCallback)()
  end
  self:__PlayAllDOTweenBackwards()
  self:Delete()
end

UIHeroInformation._OnLeftBtnClick = function(self)
  -- function num : 0_12
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = (self.switchHeroFunc)(-1)
    if newHeroData ~= nil then
      self:SwitchHero(newHeroData, reUseBigImgResloader)
    end
  end
end

UIHeroInformation._OnRightBtnClick = function(self)
  -- function num : 0_13
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = (self.switchHeroFunc)(1)
    if newHeroData ~= nil then
      self:SwitchHero(newHeroData, reUseBigImgResloader)
    end
  end
end

UIHeroInformation._OnfriendShipClick = function(self)
  -- function num : 0_14 , upvalues : _ENV, cs_MessageCommon
  do
    if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship) then
      local des = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship)
      ;
      (cs_MessageCommon.ShowMessageTips)(des)
      return 
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.FriendShip, function(win)
    -- function num : 0_14_0 , upvalues : _ENV
    if win == nil then
      return 
    end
    local go = UIManager:GetWindow(UIWindowTypeID.HeroInfomation)
    if go == nil then
      win:Delete()
      return 
    end
    go:Hide()
    win:InitFriendshipSkillUpgrade(go.heroData, nil, function(heroData, switchFunc)
      -- function num : 0_14_0_0 , upvalues : _ENV
      (UIManager:ShowWindow(UIWindowTypeID.HeroInfomation)):RefreshHeroInformation(heroData, switchFunc)
    end
, go.switchHeroFunc)
  end
)
  end
end

UIHeroInformation.OnClickAvgNoun = function(self)
  -- function num : 0_15 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.AvgNounDes, function(window)
    -- function num : 0_15_0
    if window == nil then
      return 
    end
    window:InitAvgNounDes()
  end
)
end

UIHeroInformation.OnDelete = function(self)
  -- function num : 0_16 , upvalues : _ENV, eNodeType, HeroInfoTextUtil, base
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  for index,tween in ipairs((self.ui).tweenList) do
    tween:DOKill()
  end
  self:__UnloadHeroVoiceAndStory()
  for _,typeId in pairs(eNodeType) do
    ((self.nodeDic)[typeId]):Delete()
  end
  ;
  (HeroInfoTextUtil.Delete)()
  if self.frageStateNode ~= nil then
    (self.frageStateNode):Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UIHeroInformation


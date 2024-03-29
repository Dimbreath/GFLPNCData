local UIHeroSkillUpgrade = class("UIHeroSkillUpgrade", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local cs_DoTween = ((CS.DG).Tweening).DOTween
local cs_MessageCommon = CS.MessageCommon
local cs_Edge = ((CS.UnityEngine).RectTransform).Edge
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UINHeroSkillUpgradeItem = require("Game.Hero.NewUI.UpgradeSkill.UINHeroSkillUpgradeItem")
local HeroSkillUpgradeEnum = require("Game.Hero.NewUI.UpgradeSkill.HeroSkillUpgradeEnum")
local UINHeroSkillUpgradeInfo = require("Game.Hero.NewUI.UpgradeSkill.UINHeroSkillUpgradeInfo")
local UIMultiSwitchTogItem = require("Game.Setting.UI.UIMultiSwitchTogItem")
UIHeroSkillUpgrade.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroSkillUpgradeInfo, UINHeroSkillUpgradeItem
  self.isClosing = false
  self.isHeroRefresh = false
  self.isItemRefresh = false
  self.__CloseInfoNode = BindCallback(self, self.CloseInfoNode)
  self.__CloseSelf = BindCallback(self, self.CloseSelf)
  self.upgradeInfo = (UINHeroSkillUpgradeInfo.New)()
  ;
  (self.upgradeInfo):Init((self.ui).obj_infoNode)
  self.__onInfoCancelClick = BindCallback(self, self.__OnInfoCancelClick)
  ;
  (self.upgradeInfo):SetBtnCancelAction(self.__onInfoCancelClick)
  self.__onShowIntroClick = BindCallback(self, self.__OnShowIntroClick)
  self.__IsShowSkillDetail = BindCallback(self, self.IsShowSkillDetail)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_LeftArrow, self, self.__OnClickLeftArrow)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_RightArrow, self, self.__OnClickRightArrow)
  self.skillItemList = {}
  local skillGoList = {}
  ;
  (table.insert)(skillGoList, (self.ui).obj_skillItem)
  for i = 1, 2 do
    local go = ((self.ui).obj_skillItem):Instantiate()
    ;
    (table.insert)(skillGoList, go)
  end
  for index,go in ipairs(skillGoList) do
    go.name = "obj_skillItem" .. tostring(index)
  end
  self.battelSkill1 = (UINHeroSkillUpgradeItem.New)()
  ;
  (self.battelSkill1):Init(skillGoList[1])
  ;
  (table.insert)(self.skillItemList, self.battelSkill1)
  self.battelSkill2 = (UINHeroSkillUpgradeItem.New)()
  ;
  (self.battelSkill2):Init(skillGoList[2])
  ;
  (table.insert)(self.skillItemList, self.battelSkill2)
  self.uniqueSkill = (UINHeroSkillUpgradeItem.New)()
  ;
  (self.uniqueSkill):Init(skillGoList[3])
  ;
  (table.insert)(self.skillItemList, self.uniqueSkill)
  self.__ItemRefresh = BindCallback(self, self.ItemRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__ItemRefresh)
  self.onDescribeSettingChange = BindCallback(self, self._OnDescribeSettingChange)
  MsgCenter:AddListener(eMsgEventId.DescribeSettingChange, self.onDescribeSettingChange)
  self.__hideStartCDtipAction = BindCallback(self, self.__OnHideStartCdTimeTip)
  self.__OpenInfoNode = BindCallback(self, self.OpenInfoNode)
  self:InitTweens()
  self.closeEvent = nil
  self:SwitchShowSkillDetail()
end

UIHeroSkillUpgrade.InitSkillUpgrade = function(self, heroData, resloader, hideCallBack, switchHeroFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.isClosing = false
  self.resloader = resloader
  self.heroData = heroData
  self.heroId = heroData.dataId
  self.hideCallBack = hideCallBack
  self.switchHeroFunc = switchHeroFunc
  ;
  (UIUtil.SetTopStatus)(self, self.CloseSelf, nil)
  self:RefreshHeroStaticInfo()
  self:PlayAllStartTween()
  self:Refresh()
  if self.winTween ~= nil then
    (self.winTween):Complete()
  end
end

UIHeroSkillUpgrade.SwitchHero = function(self, heroData, reUseBigImgResloader)
  -- function num : 0_2 , upvalues : _ENV
  self.heroData = heroData
  self.heroId = heroData.dataId
  self:RefreshHeroStaticInfo(reUseBigImgResloader)
  ;
  (self.openInfoSequence):Pause()
  ;
  (self.closeInfoSequence):Pause()
  self:PlayAllStartTween()
  self:Refresh()
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).skillNode).interactable = true
  ;
  ((self.ui).obj_skillNode):SetActive(true)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).infoNode).interactable = false
  ;
  ((self.ui).obj_infoNode):SetActive(false)
  ;
  ((self.ui).tog_DisplayGroup):SetActive(true)
  ;
  (UIUtil.RefreshTopResId)(nil)
end

UIHeroSkillUpgrade.ItemRefresh = function(self)
  -- function num : 0_3
  self:Refresh()
end

UIHeroSkillUpgrade.Refresh = function(self)
  -- function num : 0_4 , upvalues : _ENV, HeroSkillUpgradeEnum
  self.isHeroRefresh = false
  local isBattelSkill1Empty = true
  local isBattelSkill2Empty = true
  for _,item in ipairs(self.skillItemList) do
    item.isInited = false
  end
  for k,skillData in ipairs((self.heroData).skillList) do
    if skillData.type ~= eHeroSkillType.LifeSkill then
      if skillData:IsUniqueSkill() then
        (self.uniqueSkill):InitSkillItem(skillData, self.resloader, (HeroSkillUpgradeEnum.SkillType).uSkill, self.__OpenInfoNode, self.__IsShowSkillDetail)
        ;
        (self.uniqueSkill):SetIntroClickAction(self.__onShowIntroClick)
      else
        if not skillData:IsCommonAttack() then
          if not skillData:IsPassiveSkill() then
            if isBattelSkill2Empty then
              (self.battelSkill2):InjectLongPressFunc(BindCallback(self, self.__OnShowStartCdTimeTip, self.battelSkill2), self.__hideStartCDtipAction)
              ;
              (self.battelSkill2):InitSkillItem(skillData, self.resloader, (HeroSkillUpgradeEnum.SkillType).active, self.__OpenInfoNode, self.__IsShowSkillDetail)
              ;
              (self.battelSkill2):SetIntroClickAction(self.__onShowIntroClick)
              isBattelSkill2Empty = false
            else
              ;
              (self.battelSkill1):InjectLongPressFunc(BindCallback(self, self.__OnShowStartCdTimeTip, self.battelSkill1), self.__hideStartCDtipAction)
              ;
              (self.battelSkill1):InitSkillItem(skillData, self.resloader, (HeroSkillUpgradeEnum.SkillType).active, self.__OpenInfoNode, self.__IsShowSkillDetail)
              ;
              (self.battelSkill1):SetIntroClickAction(self.__onShowIntroClick)
            end
          else
            if isBattelSkill1Empty then
              (self.battelSkill1):InitSkillItem(skillData, self.resloader, (HeroSkillUpgradeEnum.SkillType).passive, self.__OpenInfoNode, self.__IsShowSkillDetail)
              ;
              (self.battelSkill1):SetIntroClickAction(self.__onShowIntroClick)
              isBattelSkill1Empty = false
            else
              ;
              (self.battelSkill2):InitSkillItem(skillData, self.resloader, (HeroSkillUpgradeEnum.SkillType).passive, self.__OpenInfoNode, self.__IsShowSkillDetail)
              ;
              (self.battelSkill2):SetIntroClickAction(self.__onShowIntroClick)
            end
          end
        end
      end
    end
  end
  for _,item in ipairs(self.skillItemList) do
    if not item.isInited then
      item:InitSkillItem(nil)
    end
  end
end

UIHeroSkillUpgrade.RefreshHeroStaticInfo = function(self, reUseBigImgResloader)
  -- function num : 0_5 , upvalues : _ENV, cs_ResLoader
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
  if reUseBigImgResloader ~= nil then
    (self.bigImgGameObject):SetActive(false)
    reUseBigImgResloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath((self.heroData):GetResPicName()), function(prefab)
    -- function num : 0_5_1 , upvalues : _ENV, self
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate((self.ui).heroHolder)
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroList")
    ;
    ((self.ui).tween_heroHolder):DORestart()
  end
)
  else
    if self.bigImgResloader ~= nil then
      (self.bigImgResloader):Put2Pool()
    end
    self.bigImgResloader = (cs_ResLoader.Create)()
    ;
    (self.bigImgResloader):LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath((self.heroData):GetResPicName()), function(prefab)
    -- function num : 0_5_2 , upvalues : _ENV, self
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate((self.ui).heroHolder)
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroList")
    ;
    ((self.ui).tween_heroHolder):DORestart()
  end
)
  end
end

UIHeroSkillUpgrade.InitTweens = function(self)
  -- function num : 0_6 , upvalues : _ENV, cs_DoTween
  local openMove = (Vector3.New)(200, 0, 0)
  local closeMove = (Vector3.New)(-200, 0, 0)
  self.openInfoSequence = ((((((((((cs_DoTween.Sequence)()):AppendCallback(function()
    -- function num : 0_6_0 , upvalues : self, _ENV, openMove
    ((self.ui).obj_infoNode):SetActive(true)
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((self.ui).skillNode).interactable = false
    ;
    ((self.ui).tog_DisplayGroup):SetActive(false)
    for _,tween in ipairs((self.ui).AllStartTweens) do
      tween:DOComplete(false)
    end
    self:__SetTweenGoPos((self.ui).skillNode, openMove)
    self:__SetTweenGoPos((self.ui).levelNode, openMove)
    self:__SetTweenGoPos((self.ui).skillDetailNode, openMove)
  end
)):Append(((((self.ui).skillNode).transform):DOLocalMove(openMove, 0.25)):SetRelative(true))):Join(((self.ui).skillNode):DOFade(0, 0.25))):Join(((self.ui).infoNode):DOFade(1, 0.25))):Join(((((self.ui).levelNode):DOLocalMove(openMove, 0.25)):From(true)):SetRelative(true))):Join((((((self.ui).skillDetailNode):DOLocalMove(openMove, 0.25)):SetDelay(0.05)):From(true)):SetRelative(true))):AppendCallback(function()
    -- function num : 0_6_1 , upvalues : self
    ((self.ui).obj_skillNode):SetActive(false)
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((self.ui).infoNode).interactable = true
  end
)):Pause()):SetAutoKill(false)
  self.closeInfoSequence = ((((((((((cs_DoTween.Sequence)()):AppendCallback(function()
    -- function num : 0_6_2 , upvalues : self
    ((self.ui).obj_skillNode):SetActive(true)
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((self.ui).infoNode).interactable = false
    ;
    ((self.ui).tog_DisplayGroup):SetActive(true)
  end
)):Append(((((self.ui).skillNode).transform):DOLocalMove(closeMove, 0.25)):SetRelative(true))):Join(((self.ui).skillNode):DOFade(1, 0.25))):Join(((self.ui).infoNode):DOFade(0, 0.25))):Join(((((self.ui).levelNode):DOLocalMove(closeMove, 0.25)):From(true)):SetRelative(true))):Join((((((self.ui).skillDetailNode):DOLocalMove(closeMove, 0.25)):SetDelay(0.05)):From(true)):SetRelative(true))):AppendCallback(function()
    -- function num : 0_6_3 , upvalues : self
    ((self.ui).obj_infoNode):SetActive(false)
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((self.ui).skillNode).interactable = true
  end
)):Pause()):SetAutoKill(false)
end

UIHeroSkillUpgrade.__SetTweenGoPos = function(self, go, movePos)
  -- function num : 0_7
  local localPos = (go.transform).localPosition
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (go.transform).localPosition = localPos + movePos
end

UIHeroSkillUpgrade.KillAllTweens = function(self)
  -- function num : 0_8
  (self.openInfoSequence):Kill()
  self.openInfoSequence = nil
  ;
  (self.closeInfoSequence):Kill()
  self.closeInfoSequence = nil
end

UIHeroSkillUpgrade.PlayAllStartTween = function(self)
  -- function num : 0_9 , upvalues : _ENV
  for _,tween in ipairs((self.ui).AllStartTweens) do
    tween:DORestart(false)
  end
end

UIHeroSkillUpgrade.BackwardsAllStartTween = function(self)
  -- function num : 0_10 , upvalues : _ENV
  for _,tween in ipairs((self.ui).AllStartTweens) do
    tween:DOPlayBackwards()
  end
end

UIHeroSkillUpgrade.OpenInfoNode = function(self, skillData)
  -- function num : 0_11 , upvalues : cs_MessageCommon, _ENV
  if not skillData:IsUniqueSkill() then
    (self.upgradeInfo):InitInfoNode(skillData, self.resloader, self.__CloseInfoNode)
    ;
    (self.openInfoSequence):Restart()
  else
    ;
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.ultimateSkillUpgrade))
  end
end

UIHeroSkillUpgrade.CloseInfoNode = function(self)
  -- function num : 0_12
  (self.closeInfoSequence):Restart()
  self:Refresh()
end

UIHeroSkillUpgrade.CloseSelf = function(self)
  -- function num : 0_13 , upvalues : _ENV
  if not self.isClosing then
    self.isClosing = true
  else
    return 
  end
  if self.hideCallBack ~= nil then
    (self.hideCallBack)()
  end
  if self.closeEvent ~= nil then
    (self.closeEvent)()
    self.closeEvent = nil
  end
  local win = UIManager:GetWindow(UIWindowTypeID.HeroState)
  if win ~= nil and not win.active then
    win:Show()
  end
  self:BackwardsAllStartTween()
  self:Delete()
end

UIHeroSkillUpgrade.__OnInfoCancelClick = function(self)
  -- function num : 0_14
  self:CloseInfoNode()
end

UIHeroSkillUpgrade.__OnClickLeftArrow = function(self)
  -- function num : 0_15
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = (self.switchHeroFunc)(-1)
    self:SwitchHero(newHeroData, reUseBigImgResloader)
  end
end

UIHeroSkillUpgrade.__OnClickRightArrow = function(self)
  -- function num : 0_16
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = (self.switchHeroFunc)(1)
    self:SwitchHero(newHeroData, reUseBigImgResloader)
  end
end

UIHeroSkillUpgrade.OnHide = function(self)
  -- function num : 0_17
end

UIHeroSkillUpgrade.__OnShowIntroClick = function(self, skillData)
  -- function num : 0_18 , upvalues : _ENV, cs_Edge
  UIManager:ShowWindowAsync(UIWindowTypeID.RichIntro, function(win)
    -- function num : 0_18_0 , upvalues : self, skillData, cs_Edge
    if win ~= nil then
      win:ShowIntroBySkillData((self.ui).richIntroHolder, skillData)
      win:SetIntroListPosition(cs_Edge.Right, cs_Edge.Top)
    end
  end
)
end

UIHeroSkillUpgrade.__OnShowStartCdTimeTip = function(self, upgradeItem)
  -- function num : 0_19 , upvalues : _ENV, HAType, VAType
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  win:SetTitleAndContext(ConfigData:GetTipContent(617), ConfigData:GetTipContent(616))
  win:FloatTo(upgradeItem.transform, HAType.left, VAType.up)
end

UIHeroSkillUpgrade.__OnHideStartCdTimeTip = function(self)
  -- function num : 0_20 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
    win:Clean3DModifier()
  end
end

UIHeroSkillUpgrade.SwitchShowSkillDetail = function(self)
  -- function num : 0_21 , upvalues : _ENV, UIMultiSwitchTogItem
  local systemSaveData = PersistentManager:GetDataModel((PersistentConfig.ePackage).SystemData)
  local currentSkillDescCallback = BindCallback(systemSaveData, systemSaveData.GetIsShowDetailDescribeValue, eGameSetDescType.skill)
  local resolutionOptionName = ((ConfigData.game_set_describe)[eGameSetDescType.skill]).option_group_name
  local skillDescCallback = BindCallback(self, self.OnToogleCallback, eGameSetDescType.skill)
  self.multiSwitchTogItem = (UIMultiSwitchTogItem.New)()
  ;
  (self.multiSwitchTogItem):Init((self.ui).tog_DisplayGroup)
  ;
  (self.multiSwitchTogItem):InitUIMultiSwitchTogItem(currentSkillDescCallback, resolutionOptionName, nil, skillDescCallback, self)
end

UIHeroSkillUpgrade.OnToogleCallback = function(self, eGameSetDescType, value, togItem)
  -- function num : 0_22 , upvalues : _ENV
  local isDetail = false
  if togItem.index == 0 and value then
    isDetail = false
  end
  if togItem.index == 1 and value then
    isDetail = true
  end
  self.isDetail = isDetail
  do
    if not self.__NotNeedSavingDescribeSetting then
      local systemSaveData = PersistentManager:GetDataModel((PersistentConfig.ePackage).SystemData)
      systemSaveData:SetDescribeSetting(eGameSetDescType, isDetail)
    end
    self:RefreshAllSkillDes()
  end
end

UIHeroSkillUpgrade.RefreshAllSkillDes = function(self)
  -- function num : 0_23
  (self.battelSkill1):UpdateSkillDescription()
  ;
  (self.battelSkill2):UpdateSkillDescription()
  ;
  (self.uniqueSkill):UpdateSkillDescription()
end

UIHeroSkillUpgrade.IsShowSkillDetail = function(self)
  -- function num : 0_24 , upvalues : _ENV
  if self.isDetail == nil then
    return (CommonUtil.GetDetailDescribeSetting)(eGameSetDescType.skill)
  else
    return self.isDetail
  end
end

UIHeroSkillUpgrade._OnDescribeSettingChange = function(self, eDescTypeId)
  -- function num : 0_25 , upvalues : _ENV
  if eDescTypeId ~= eGameSetDescType.skill then
    return 
  end
  self.__NotNeedSavingDescribeSetting = true
  ;
  (self.multiSwitchTogItem):SelectCurrentValue()
  self.__NotNeedSavingDescribeSetting = false
end

UIHeroSkillUpgrade.OnDelete = function(self)
  -- function num : 0_26 , upvalues : _ENV, base
  self:KillAllTweens()
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
  end
  ;
  (self.upgradeInfo):Delete()
  ;
  (self.battelSkill1):Delete()
  ;
  (self.battelSkill2):Delete()
  ;
  (self.uniqueSkill):Delete()
  MsgCenter:RemoveListener(eMsgEventId.DescribeSettingChange, self.onDescribeSettingChange)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__ItemRefresh)
  ;
  (base.OnDelete)(self)
end

return UIHeroSkillUpgrade


-- params : ...
-- function num : 0 , upvalues : _ENV
local UIHeroSkillUpgrade = class("UIHeroSkillUpgrade", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local cs_DoTween = ((CS.DG).Tweening).DOTween
local cs_MessageCommon = CS.MessageCommon
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UINHeroSkillUpgradeItem = require("Game.Hero.NewUI.UpgradeSkill.UINHeroSkillUpgradeItem")
local HeroSkillUpgradeEnum = require("Game.Hero.NewUI.UpgradeSkill.HeroSkillUpgradeEnum")
local UINHeroSkillUpgradeInfo = require("Game.Hero.NewUI.UpgradeSkill.UINHeroSkillUpgradeInfo")
UIHeroSkillUpgrade.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINResourceGroup, UINHeroSkillUpgradeInfo, UINHeroSkillUpgradeItem
  self.isClosing = false
  self.isHeroRefresh = false
  self.isItemRefresh = false
  self.__CloseInfoNode = BindCallback(self, self.CloseInfoNode)
  self.__CloseSelf = BindCallback(self, self.CloseSelf)
  self.topBtn = (UIUtil.CreateTopBtnGroup)((self.ui).obj_topButtonGroup, self, self.CloseSelf, true)
  self.resourceGroup = (UINResourceGroup.New)()
  ;
  (self.resourceGroup):Init((self.ui).obj_gameResourceGroup)
  self.upgradeInfo = (UINHeroSkillUpgradeInfo.New)()
  ;
  (self.upgradeInfo):Init((self.ui).obj_infoNode)
  self.__onInfoCancelClick = BindCallback(self, self.__OnInfoCancelClick)
  ;
  (self.upgradeInfo):SetBtnCancelAction(self.__onInfoCancelClick)
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
  self.__HeroRefresh = BindCallback(self, self.HeroRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__HeroRefresh)
  self.__ItemRefresh = BindCallback(self, self.ItemRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__ItemRefresh)
  self.__OpenInfoNode = BindCallback(self, self.OpenInfoNode)
  self:InitTweens()
  self.closeEvent = nil
end

UIHeroSkillUpgrade.InitSkillUpgrade = function(self, heroData, resloader, hideCallBack, switchHeroFunc)
  -- function num : 0_1 , upvalues : _ENV
  (UIUtil.Push2BackStack)(self.__CloseSelf)
  self.isClosing = false
  self.resloader = resloader
  self.heroData = heroData
  self.heroId = heroData.dataId
  self.hideCallBack = hideCallBack
  self.switchHeroFunc = switchHeroFunc
  self:RefreshHeroStaticInfo()
  self:PlayAllStartTween()
  self:Refresh()
end

UIHeroSkillUpgrade.SwitchHero = function(self, heroData, reUseBigImgResloader)
  -- function num : 0_2
  self.heroData = heroData
  self.heroId = heroData.dataId
  self:RefreshHeroStaticInfo(reUseBigImgResloader)
  self:PlayAllStartTween()
  self:Refresh()
  ;
  ((self.ui).obj_skillNode):SetActive(true)
  ;
  ((self.ui).obj_infoNode):SetActive(false)
end

UIHeroSkillUpgrade.HeroRefresh = function(self)
  -- function num : 0_3
  self.isHeroRefresh = true
end

UIHeroSkillUpgrade.ItemRefresh = function(self)
  -- function num : 0_4
  if self.isHeroRefresh then
    self:Refresh()
  end
end

UIHeroSkillUpgrade.Refresh = function(self)
  -- function num : 0_5 , upvalues : _ENV, HeroSkillUpgradeEnum
  self.isHeroRefresh = false
  local isBattelSkill1Empty = true
  local isBattelSkill2Empty = true
  for _,item in ipairs(self.skillItemList) do
    item.isInited = false
  end
  for k,skillData in ipairs((self.heroData).skillList) do
    if skillData.type ~= eHeroSkillType.LifeSkill then
      if skillData:IsUniqueSkill() then
        (self.uniqueSkill):InitSkillItem(skillData, self.resloader, (HeroSkillUpgradeEnum.SkillType).uSkill, self.__OpenInfoNode)
      else
        if not skillData:IsCommonAttack() then
          if not skillData:IsPassiveSkill() then
            if isBattelSkill2Empty then
              (self.battelSkill2):InitSkillItem(skillData, self.resloader, (HeroSkillUpgradeEnum.SkillType).active, self.__OpenInfoNode)
              isBattelSkill2Empty = false
            else
              ;
              (self.battelSkill1):InitSkillItem(skillData, self.resloader, (HeroSkillUpgradeEnum.SkillType).active, self.__OpenInfoNode)
            end
          else
            if isBattelSkill1Empty then
              (self.battelSkill1):InitSkillItem(skillData, self.resloader, (HeroSkillUpgradeEnum.SkillType).passive, self.__OpenInfoNode)
              isBattelSkill1Empty = false
            else
              ;
              (self.battelSkill2):InitSkillItem(skillData, self.resloader, (HeroSkillUpgradeEnum.SkillType).passive, self.__OpenInfoNode)
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
  -- function num : 0_6 , upvalues : _ENV, cs_ResLoader
  local campIcon = (LanguageUtil.GetLocaleText)(((self.heroData):GetCampCfg()).icon)
  ;
  (self.resloader):LoadABAssetAsync(PathConsts:GetCampPicPath(campIcon), function(texture)
    -- function num : 0_6_0 , upvalues : _ENV, self
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
    reUseBigImgResloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath((self.heroData):GetResName()), function(prefab)
    -- function num : 0_6_1 , upvalues : _ENV, self
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate((self.ui).heroHolder)
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroList")
  end
)
  else
    if self.bigImgResloader ~= nil then
      (self.bigImgResloader):Put2Pool()
    end
    self.bigImgResloader = (cs_ResLoader.Create)()
    ;
    (self.bigImgResloader):LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath((self.heroData):GetResName()), function(prefab)
    -- function num : 0_6_2 , upvalues : _ENV, self
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate((self.ui).heroHolder)
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroList")
  end
)
  end
end

UIHeroSkillUpgrade.InitTweens = function(self)
  -- function num : 0_7 , upvalues : _ENV, cs_DoTween
  local openMove = (Vector3.New)(200, 0, 0)
  local closeMove = (Vector3.New)(-200, 0, 0)
  self.openInfoSequence = ((((((((((cs_DoTween.Sequence)()):AppendCallback(function()
    -- function num : 0_7_0 , upvalues : self, _ENV
    ((self.ui).obj_infoNode):SetActive(true)
    for _,tween in ipairs((self.ui).AllStartTweens) do
      tween:DOComplete(false)
    end
  end
)):Append(((((self.ui).skillNode).transform):DOLocalMove(openMove, 0.25)):SetRelative(true))):Join(((self.ui).skillNode):DOFade(0, 0.25))):Join(((self.ui).infoNode):DOFade(1, 0.25))):Join((((self.ui).levelNode):DOLocalMove(openMove, 0.25)):From(true))):Join(((((self.ui).skillDetailNode):DOLocalMove(openMove, 0.25)):SetDelay(0.05)):From(true))):AppendCallback(function()
    -- function num : 0_7_1 , upvalues : self
    ((self.ui).obj_skillNode):SetActive(false)
  end
)):Pause()):SetAutoKill(false)
  self.closeInfoSequence = ((((((((((cs_DoTween.Sequence)()):AppendCallback(function()
    -- function num : 0_7_2 , upvalues : self
    ((self.ui).obj_skillNode):SetActive(true)
    ;
    (self.showSkillListSequence):Restart()
  end
)):Append(((((self.ui).skillNode).transform):DOLocalMove(closeMove, 0.25)):SetRelative(true))):Join(((self.ui).skillNode):DOFade(1, 0.25))):Join(((self.ui).infoNode):DOFade(0, 0.25))):Join((((self.ui).levelNode):DOLocalMove(closeMove, 0.25)):From(true))):Join(((((self.ui).skillDetailNode):DOLocalMove(closeMove, 0.25)):SetDelay(0.05)):From(true))):AppendCallback(function()
    -- function num : 0_7_3 , upvalues : self
    ((self.ui).obj_infoNode):SetActive(false)
  end
)):Pause()):SetAutoKill(false)
  self.showSkillListSequence = (cs_DoTween.Sequence)()
  for index,item in ipairs(self.skillItemList) do
    if index == 1 then
      (self.showSkillListSequence):Append(((((item.ui).skillUpgradeItem):DOLocalMove(openMove, 0.25)):SetDelay(0.05)):From(true))
    else
      ;
      (self.showSkillListSequence):Join(((((item.ui).skillUpgradeItem):DOLocalMove(openMove, 0.25)):SetDelay(0.05)):From(true))
    end
  end
  ;
  ((self.showSkillListSequence):Pause()):SetAutoKill(false)
end

UIHeroSkillUpgrade.KillAllTweens = function(self)
  -- function num : 0_8
  (self.openInfoSequence):Kill()
  self.openInfoSequence = nil
  ;
  (self.closeInfoSequence):Kill()
  self.closeInfoSequence = nil
  ;
  (self.showSkillListSequence):Kill()
  self.showSkillListSequence = nil
end

UIHeroSkillUpgrade.PlayAllStartTween = function(self)
  -- function num : 0_9 , upvalues : _ENV
  (self.showSkillListSequence):Restart(false)
  for _,tween in ipairs((self.ui).AllStartTweens) do
    tween:DORestart(false)
  end
end

UIHeroSkillUpgrade.BackwardsAllStartTween = function(self, callback)
  -- function num : 0_10 , upvalues : _ENV
  local longestDuration = 0
  for _,tween in ipairs((self.ui).AllStartTweens) do
    if longestDuration < tween.duration then
      longestDuration = tween.duration
    end
    tween:DOPlayBackwards()
  end
  if callback ~= nil then
    (TimerManager:GetTimer(longestDuration, callback, nil, true)):Start()
  end
end

UIHeroSkillUpgrade.OpenInfoNode = function(self, skillData)
  -- function num : 0_11 , upvalues : cs_MessageCommon, _ENV
  if not skillData:IsUniqueSkill() then
    (self.upgradeInfo):InitInfoNode(skillData, self.resloader, self.__CloseInfoNode)
    ;
    (self.openInfoSequence):Restart()
    ;
    (self.topBtn):SetBackClickAction(self.__CloseInfoNode)
  else
    ;
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.ultimateSkillUpgrade))
  end
end

UIHeroSkillUpgrade.CloseInfoNode = function(self)
  -- function num : 0_12
  (self.closeInfoSequence):Restart()
  ;
  (self.topBtn):SetBackClickAction(self.__CloseSelf)
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
  UIManager:ShowWindow(UIWindowTypeID.HeroState)
  self:Hide()
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
  ((self.ui).obj_skillNode):SetActive(true)
  ;
  ((self.ui).obj_infoNode):SetActive(false)
  if self.closeEvent ~= nil then
    (self.closeEvent)()
    self.closeEvent = nil
  end
end

UIHeroSkillUpgrade.OnDelete = function(self)
  -- function num : 0_18 , upvalues : _ENV, base
  self:KillAllTweens()
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
  end
  ;
  (self.resourceGroup):Delete()
  ;
  (self.upgradeInfo):Delete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__HeroRefresh)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__ItemRefresh)
  ;
  (base.OnDelete)(self)
end

return UIHeroSkillUpgrade

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIHeroSkillUpgrade = class("UIHeroSkillUpgrade", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local cs_DoTween = ((CS.DG).Tweening).DOTween
local cs_MessageCommon = CS.MessageCommon
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UINHeroSkillUpgradeItem = require(
                                    "Game.Hero.NewUI.UpgradeSkill.UINHeroSkillUpgradeItem")
local HeroSkillUpgradeEnum = require(
                                 "Game.Hero.NewUI.UpgradeSkill.HeroSkillUpgradeEnum")
local UINHeroSkillUpgradeInfo = require(
                                    "Game.Hero.NewUI.UpgradeSkill.UINHeroSkillUpgradeInfo")
UIHeroSkillUpgrade.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINResourceGroup, UINHeroSkillUpgradeInfo, UINHeroSkillUpgradeItem
    self.isClosing = false
    self.isHeroRefresh = false
    self.isItemRefresh = false
    self.__CloseInfoNode = BindCallback(self, self.CloseInfoNode)
    self.__CloseSelf = BindCallback(self, self.CloseSelf)
    self.topBtn = (UIUtil.CreateTopBtnGroup)((self.ui).obj_topButtonGroup, self,
                                             self.CloseSelf, true)
    self.resourceGroup = (UINResourceGroup.New)();
    (self.resourceGroup):Init((self.ui).obj_gameResourceGroup)
    self.upgradeInfo = (UINHeroSkillUpgradeInfo.New)();
    (self.upgradeInfo):Init((self.ui).obj_infoNode)
    self.__onInfoCancelClick = BindCallback(self, self.__OnInfoCancelClick);
    (self.upgradeInfo):SetBtnCancelAction(self.__onInfoCancelClick);
    (UIUtil.AddButtonListener)((self.ui).btn_LeftArrow, self,
                               self.__OnClickLeftArrow);
    (UIUtil.AddButtonListener)((self.ui).btn_RightArrow, self,
                               self.__OnClickRightArrow)
    self.skillItemList = {}
    local skillGoList = {};
    (table.insert)(skillGoList, (self.ui).obj_skillItem)
    for i = 1, 2 do
        local go = ((self.ui).obj_skillItem):Instantiate();
        (table.insert)(skillGoList, go)
    end
    for index, go in ipairs(skillGoList) do
        go.name = "obj_skillItem" .. tostring(index)
    end
    self.battelSkill1 = (UINHeroSkillUpgradeItem.New)();
    (self.battelSkill1):Init(skillGoList[1]);
    (table.insert)(self.skillItemList, self.battelSkill1)
    self.battelSkill2 = (UINHeroSkillUpgradeItem.New)();
    (self.battelSkill2):Init(skillGoList[2]);
    (table.insert)(self.skillItemList, self.battelSkill2)
    self.uniqueSkill = (UINHeroSkillUpgradeItem.New)();
    (self.uniqueSkill):Init(skillGoList[3]);
    (table.insert)(self.skillItemList, self.uniqueSkill)
    self.__HeroRefresh = BindCallback(self, self.HeroRefresh)
    MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__HeroRefresh)
    self.__ItemRefresh = BindCallback(self, self.ItemRefresh)
    MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__ItemRefresh)
    self.__OpenInfoNode = BindCallback(self, self.OpenInfoNode)
    self:InitTweens()
    self.closeEvent = nil
end

UIHeroSkillUpgrade.InitSkillUpgrade = function(self, heroData, resloader,
                                               hideCallBack, switchHeroFunc)
    -- function num : 0_1 , upvalues : _ENV
    (UIUtil.Push2BackStack)(self.__CloseSelf)
    self.isClosing = false
    self.resloader = resloader
    self.heroData = heroData
    self.heroId = heroData.dataId
    self.hideCallBack = hideCallBack
    self.switchHeroFunc = switchHeroFunc
    self:RefreshHeroStaticInfo()
    self:PlayAllStartTween()
    self:Refresh()
end

UIHeroSkillUpgrade.SwitchHero = function(self, heroData, reUseBigImgResloader)
    -- function num : 0_2
    self.heroData = heroData
    self.heroId = heroData.dataId
    self:RefreshHeroStaticInfo(reUseBigImgResloader)
    self:PlayAllStartTween()
    self:Refresh();
    ((self.ui).obj_skillNode):SetActive(true);
    ((self.ui).obj_infoNode):SetActive(false)
end

UIHeroSkillUpgrade.HeroRefresh = function(self)
    -- function num : 0_3
    self.isHeroRefresh = true
end

UIHeroSkillUpgrade.ItemRefresh = function(self)
    -- function num : 0_4
    if self.isHeroRefresh then self:Refresh() end
end

UIHeroSkillUpgrade.Refresh = function(self)
    -- function num : 0_5 , upvalues : _ENV, HeroSkillUpgradeEnum
    self.isHeroRefresh = false
    local isBattelSkill1Empty = true
    local isBattelSkill2Empty = true
    for _, item in ipairs(self.skillItemList) do item.isInited = false end
    for k, skillData in ipairs((self.heroData).skillList) do
        if skillData.type ~= eHeroSkillType.LifeSkill then
            if skillData:IsUniqueSkill() then
                (self.uniqueSkill):InitSkillItem(skillData, self.resloader,
                                                 (HeroSkillUpgradeEnum.SkillType).uSkill,
                                                 self.__OpenInfoNode)
            else
                if not skillData:IsCommonAttack() then
                    if not skillData:IsPassiveSkill() then
                        if isBattelSkill2Empty then
                            (self.battelSkill2):InitSkillItem(skillData,
                                                              self.resloader,
                                                              (HeroSkillUpgradeEnum.SkillType).active,
                                                              self.__OpenInfoNode)
                            isBattelSkill2Empty = false
                        else

                            (self.battelSkill1):InitSkillItem(skillData,
                                                              self.resloader,
                                                              (HeroSkillUpgradeEnum.SkillType).active,
                                                              self.__OpenInfoNode)
                        end
                    else
                        if isBattelSkill1Empty then
                            (self.battelSkill1):InitSkillItem(skillData,
                                                              self.resloader,
                                                              (HeroSkillUpgradeEnum.SkillType).passive,
                                                              self.__OpenInfoNode)
                            isBattelSkill1Empty = false
                        else

                            (self.battelSkill2):InitSkillItem(skillData,
                                                              self.resloader,
                                                              (HeroSkillUpgradeEnum.SkillType).passive,
                                                              self.__OpenInfoNode)
                        end
                    end
                end
            end
        end
    end
    for _, item in ipairs(self.skillItemList) do
        if not item.isInited then item:InitSkillItem(nil) end
    end
end

UIHeroSkillUpgrade.RefreshHeroStaticInfo =
    function(self, reUseBigImgResloader)
        -- function num : 0_6 , upvalues : _ENV, cs_ResLoader
        local campIcon = (LanguageUtil.GetLocaleText)(
                             ((self.heroData):GetCampCfg()).icon);
        (self.resloader):LoadABAssetAsync(PathConsts:GetCampPicPath(campIcon),
                                          function(texture)
            -- function num : 0_6_0 , upvalues : _ENV, self
            if IsNull(self.transform) then return end -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'
            
            ((self.ui).img_Camp).texture = texture
        end)
        if reUseBigImgResloader ~= nil then
            (self.bigImgGameObject):SetActive(false)
            reUseBigImgResloader:LoadABAssetAsync(
                PathConsts:GetCharacterBigImgPrefabPath(
                    (self.heroData):GetResName()), function(prefab)
                    -- function num : 0_6_1 , upvalues : _ENV, self
                    DestroyUnityObject(self.bigImgGameObject)
                    self.bigImgGameObject =
                        prefab:Instantiate((self.ui).heroHolder)
                    local commonPicCtrl =
                        (self.bigImgGameObject):FindComponent(
                            eUnityComponentID.CommonPicController)
                    commonPicCtrl:SetPosType("HeroList")
                end)
        else
            if self.bigImgResloader ~= nil then
                (self.bigImgResloader):Put2Pool()
            end
            self.bigImgResloader = (cs_ResLoader.Create)();
            (self.bigImgResloader):LoadABAssetAsync(
                PathConsts:GetCharacterBigImgPrefabPath(
                    (self.heroData):GetResName()), function(prefab)
                    -- function num : 0_6_2 , upvalues : _ENV, self
                    DestroyUnityObject(self.bigImgGameObject)
                    self.bigImgGameObject =
                        prefab:Instantiate((self.ui).heroHolder)
                    local commonPicCtrl =
                        (self.bigImgGameObject):FindComponent(
                            eUnityComponentID.CommonPicController)
                    commonPicCtrl:SetPosType("HeroList")
                end)
        end
    end

UIHeroSkillUpgrade.InitTweens = function(self)
    -- function num : 0_7 , upvalues : _ENV, cs_DoTween
    local openMove = (Vector3.New)(200, 0, 0)
    local closeMove = (Vector3.New)(-200, 0, 0)
    self.openInfoSequence = ((((((((((cs_DoTween.Sequence)()):AppendCallback(
                                function()
            -- function num : 0_7_0 , upvalues : self, _ENV
            ((self.ui).obj_infoNode):SetActive(true)
            for _, tween in ipairs((self.ui).AllStartTweens) do
                tween:DOComplete(false)
            end
        end)):Append(((((self.ui).skillNode).transform):DOLocalMove(openMove,
                                                                    0.25)):SetRelative(
                         true))):Join(((self.ui).skillNode):DOFade(0, 0.25))):Join(
                                ((self.ui).infoNode):DOFade(1, 0.25))):Join(
                                (((self.ui).levelNode):DOLocalMove(openMove,
                                                                   0.25)):From(
                                    true))):Join(
                                ((((self.ui).skillDetailNode):DOLocalMove(
                                    openMove, 0.25)):SetDelay(0.05)):From(true))):AppendCallback(
                                function()
            -- function num : 0_7_1 , upvalues : self
            ((self.ui).obj_skillNode):SetActive(false)
        end)):Pause()):SetAutoKill(false)
    self.closeInfoSequence = ((((((((((cs_DoTween.Sequence)()):AppendCallback(
                                 function()
            -- function num : 0_7_2 , upvalues : self
            ((self.ui).obj_skillNode):SetActive(true);
            (self.showSkillListSequence):Restart()
        end)):Append(((((self.ui).skillNode).transform):DOLocalMove(closeMove,
                                                                    0.25)):SetRelative(
                         true))):Join(((self.ui).skillNode):DOFade(1, 0.25))):Join(
                                 ((self.ui).infoNode):DOFade(0, 0.25))):Join(
                                 (((self.ui).levelNode):DOLocalMove(closeMove,
                                                                    0.25)):From(
                                     true))):Join(
                                 ((((self.ui).skillDetailNode):DOLocalMove(
                                     closeMove, 0.25)):SetDelay(0.05)):From(true))):AppendCallback(
                                 function()
            -- function num : 0_7_3 , upvalues : self
            ((self.ui).obj_infoNode):SetActive(false)
        end)):Pause()):SetAutoKill(false)
    self.showSkillListSequence = (cs_DoTween.Sequence)()
    for index, item in ipairs(self.skillItemList) do
        if index == 1 then
            (self.showSkillListSequence):Append(
                ((((item.ui).skillUpgradeItem):DOLocalMove(openMove, 0.25)):SetDelay(
                    0.05)):From(true))
        else

            (self.showSkillListSequence):Join(
                ((((item.ui).skillUpgradeItem):DOLocalMove(openMove, 0.25)):SetDelay(
                    0.05)):From(true))
        end
    end
    ((self.showSkillListSequence):Pause()):SetAutoKill(false)
end

UIHeroSkillUpgrade.KillAllTweens = function(self)
    -- function num : 0_8
    (self.openInfoSequence):Kill()
    self.openInfoSequence = nil;
    (self.closeInfoSequence):Kill()
    self.closeInfoSequence = nil;
    (self.showSkillListSequence):Kill()
    self.showSkillListSequence = nil
end

UIHeroSkillUpgrade.PlayAllStartTween = function(self)
    -- function num : 0_9 , upvalues : _ENV
    (self.showSkillListSequence):Restart(false)
    for _, tween in ipairs((self.ui).AllStartTweens) do
        tween:DORestart(false)
    end
end

UIHeroSkillUpgrade.BackwardsAllStartTween =
    function(self, callback)
        -- function num : 0_10 , upvalues : _ENV
        local longestDuration = 0
        for _, tween in ipairs((self.ui).AllStartTweens) do
            if longestDuration < tween.duration then
                longestDuration = tween.duration
            end
            tween:DOPlayBackwards()
        end
        if callback ~= nil then
            (TimerManager:GetTimer(longestDuration, callback, nil, true)):Start()
        end
    end

UIHeroSkillUpgrade.OpenInfoNode = function(self, skillData)
    -- function num : 0_11 , upvalues : cs_MessageCommon, _ENV
    if not skillData:IsUniqueSkill() then
        (self.upgradeInfo):InitInfoNode(skillData, self.resloader,
                                        self.__CloseInfoNode);
        (self.openInfoSequence):Restart();
        (self.topBtn):SetBackClickAction(self.__CloseInfoNode)
    else

        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.ultimateSkillUpgrade))
    end
end

UIHeroSkillUpgrade.CloseInfoNode = function(self)
    -- function num : 0_12
    (self.closeInfoSequence):Restart();
    (self.topBtn):SetBackClickAction(self.__CloseSelf)
end

UIHeroSkillUpgrade.CloseSelf = function(self)
    -- function num : 0_13 , upvalues : _ENV
    if not self.isClosing then
        self.isClosing = true
    else
        return
    end
    if self.hideCallBack ~= nil then (self.hideCallBack)() end
    UIManager:ShowWindow(UIWindowTypeID.HeroState)
    self:Hide()
end

UIHeroSkillUpgrade.__OnInfoCancelClick =
    function(self)
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

UIHeroSkillUpgrade.__OnClickRightArrow =
    function(self)
        -- function num : 0_16
        if self.switchHeroFunc ~= nil then
            local newHeroData, reUseBigImgResloader = (self.switchHeroFunc)(1)
            self:SwitchHero(newHeroData, reUseBigImgResloader)
        end
    end

UIHeroSkillUpgrade.OnHide = function(self)
    -- function num : 0_17
    ((self.ui).obj_skillNode):SetActive(true);
    ((self.ui).obj_infoNode):SetActive(false)
    if self.closeEvent ~= nil then
        (self.closeEvent)()
        self.closeEvent = nil
    end
end

UIHeroSkillUpgrade.OnDelete = function(self)
    -- function num : 0_18 , upvalues : _ENV, base
    self:KillAllTweens()
    if self.bigImgResloader ~= nil then (self.bigImgResloader):Put2Pool() end
    (self.resourceGroup):Delete();
    (self.upgradeInfo):Delete()
    MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__HeroRefresh)
    MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__ItemRefresh);
    (base.OnDelete)(self)
end

return UIHeroSkillUpgrade


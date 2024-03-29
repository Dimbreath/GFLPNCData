local UIHeroLevelUp = class("UIHeroLevelUp", UIBaseWindow)
local base = UIBaseWindow
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UINHeroLevelUpItem = require("Game.Hero.NewUI.UpgradeLevel.UINHeroLevelUpItem")
local UINStarUpAttrItem = require("Game.Hero.NewUI.UpgradeStar.UINStarUpAttrItem")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UIHeroTweenUtil = require("Game.CommonUI.Tween.UINTweenUtil")
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local cs_Tweening = (CS.DG).Tweening
UIHeroLevelUp.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroLevelUpItem, UINStarUpAttrItem, UINBaseItemWithCount
  self.isClosing = false
  self.growupItemNums = {}
  self.growupItemList = {}
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Hero)
  self.growupItemPool = (UIItemPool.New)(UINHeroLevelUpItem, (self.ui).upgradeItem)
  ;
  ((self.ui).upgradeItem):SetActive(false)
  self.attrItemPool = (UIItemPool.New)(UINStarUpAttrItem, (self.ui).attriItem)
  ;
  ((self.ui).attriItem):SetActive(false)
  self.upgradeItemPool = (UIItemPool.New)(UINBaseItemWithCount, (self.ui).upgrade_chipItemWithCount)
  ;
  ((self.ui).upgrade_chipItemWithCount):SetActive(false)
  self.potentialImgWidth = ((((self.ui).img_LimitUp).sprite).textureRect).width
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_StarUp, self, self.OnClickLevelUp)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ClearSelect, self, self.OnClickClean)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_LeftArrow, self, self.__OnClickLeftArrow)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_RightArrow, self, self.__OnClickRightArrow)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_LimitUp, self, self.__OnClickPotentialPreview)
  self.__refreshItem = BindCallback(self, self.RefreshItem)
  self.__refresh = BindCallback(self, self.Refresh)
  self:InitAllTween()
  ;
  ((self.ui).obj_potentialEft):SetActive(false)
  self.oriTexTweenCol = (Color.New)(1, 1, 1, 0.6)
end

UIHeroLevelUp.InitAllTween = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self.allTweens = (self.transform):GetComponentsInChildren(typeof(((CS.DG).Tweening).DOTweenAnimation))
  for i = 0, (self.allTweens).Length - 1 do
    local tween = (self.allTweens)[i]
  end
end

UIHeroLevelUp.InitHeroLevelUp = function(self, heroData, resloader, hideCallBack, switchHeroFunc)
  -- function num : 0_2 , upvalues : _ENV
  (UIUtil.SetTopStatus)(self, self.OnClickBack, {})
  self:PlayAllDOTween()
  self.heroData = heroData
  self.resloader = resloader
  self.hideCallBack = hideCallBack
  self.switchHeroFunc = switchHeroFunc
  self.heroId = heroData.dataId
  self.level = heroData.level
  self.curExp = heroData.curExp
  self.isClosing = false
  self:RefreshHeroStaticInfo()
  self:RefreshCurrency()
  self:RefreshLevelUpItems()
  self:CalAndShowExpBar()
  self:UpdatePotential()
  self:RefreshBlutDot()
  ;
  ((self.ui).obj_potentialEft):SetActive(false)
end

UIHeroLevelUp.SwitchHero = function(self, heroData, reUseBigImgResloader)
  -- function num : 0_3
  self:PlayAllDOTween()
  self.heroData = heroData
  self.heroId = heroData.dataId
  self.level = heroData.level
  self.curExp = heroData.curExp
  self.isClosing = false
  if self.lvUpSeq ~= nil then
    (self.lvUpSeq):Kill(true)
    self.lvUpSeq = nil
    ;
    ((self.ui).tex_LevelTween):DOKill()
  else
    self:CalAndShowExpBar()
  end
  self:OnClickClean()
  self:RefreshHeroStaticInfo(reUseBigImgResloader)
  self:RefreshCurrency()
  self:UpdatePotential()
  self:RefreshBlutDot()
end

UIHeroLevelUp.RefreshItem = function(self)
  -- function num : 0_4
  self:RefreshLevelUpItems()
  self:CalAndShowExpBar()
  self:RefreshConfirmBtn()
  self:UpdatePotential()
end

UIHeroLevelUp.Refresh = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local heroData = (PlayerDataCenter.heroDic)[self.heroId]
  self.level = heroData.level
  self.curExp = heroData.curExp
  self:OnClickClean()
  self:CalAndShowExpBar()
  self:UpdatePotential()
  self:RefreshBlutDot()
end

UIHeroLevelUp.RefreshHeroStaticInfo = function(self, reUseBigImgResloader)
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
    reUseBigImgResloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath((self.heroData):GetResPicName()), function(prefab)
    -- function num : 0_6_1 , upvalues : _ENV, self
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
    -- function num : 0_6_2 , upvalues : _ENV, self
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate((self.ui).heroHolder)
    if self.ui == nil or (self.ui).heroHolder == nil then
      return 
    end
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroList")
    ;
    ((self.ui).tween_heroHolder):DORestart()
  end
)
  end
end

UIHeroLevelUp.RefreshCurrency = function(self, isFullLevel)
  -- function num : 0_7 , upvalues : _ENV
  local topStatusWin = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  if isFullLevel then
    topStatusWin:SetResourceGroupActive(false)
    ;
    ((self.ui).obj_CurrencyCost):SetActive(false)
    return 
  else
    topStatusWin:SetResourceGroupActive(true)
    ;
    ((self.ui).obj_CurrencyCost):SetActive(true)
  end
  if self.currencyId ~= nil then
    topStatusWin:SetTopStatusResIds({self.currencyId})
    ;
    ((self.ui).obj_CurrencyCost):SetActive(true)
    local itemCfg = (ConfigData.item)[self.currencyId]
    if itemCfg == nil then
      error("itemCfg read error id=" .. self.currencyId)
    else
      -- DECOMPILER ERROR at PC56: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).img_CurrencyItem).sprite = CRH:GetSpriteByItemConfig(itemCfg)
    end
    ;
    ((self.ui).tex_CurrencyCost):SetIndex(0, tostring(self.needCurrencyNum))
  else
    do
      topStatusWin:SetResourceGroupActive(false)
      ;
      ((self.ui).obj_CurrencyCost):SetActive(false)
    end
  end
end

UIHeroLevelUp._RefreshQuickLevelUp = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local canQuickLvUp = true
  for itemData,num in pairs(self.growupItemNums) do
    if num ~= 0 then
      canQuickLvUp = false
      break
    end
  end
  do
    if canQuickLvUp then
      canQuickLvUp = (self.heroData):GenHeroCanQuickLevelUp()
    end
    self._canQuickLvUp = canQuickLvUp
    ;
    ((self.ui).text_upgrade):SetIndex(canQuickLvUp and 2 or 0)
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R2 in 'UnsetPending'

    if canQuickLvUp then
      ((self.ui).img_StarUp).color = (self.ui).color_orange
      -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).btn_StarUp).interactable = true
    end
  end
end

UIHeroLevelUp.UpdateAttr = function(self, newLevel)
  -- function num : 0_9 , upvalues : _ENV
  (self.attrItemPool):HideAll()
  local changeList = (self.heroData):GetDifferAttrWhenRankUp(nil, newLevel)
  if #changeList >= 10 then
    for index,data in ipairs(changeList) do
      if index <= 10 then
        do
          local item = (self.attrItemPool):GetOne()
          item:InitAttrItem(data.oldAttr, data.newAttr, data.attrId)
          -- DECOMPILER ERROR at PC25: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC25: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  else
    if #changeList < 10 then
      local showedIds = {}
      local num = #changeList
      for index,data in ipairs(changeList) do
        (table.insert)(showedIds, data.attrId)
      end
      for _,attrId in ipairs((ConfigData.attribute).baseAttrIds) do
        -- DECOMPILER ERROR at PC65: Unhandled construct in 'MakeBoolean' P1

        if ((ConfigData.attribute)[attrId]).merge_attribute == 0 and num < 10 then
          do
            if not (table.contain)(showedIds, attrId) then
              num = num + 1
              ;
              (table.insert)(changeList, {attrId = attrId, property = ((ConfigData.attribute)[attrId]).attribute_priority, oldAttr = (self.heroData):GetAttr(attrId, nil, true), newAttr = nil})
            end
            -- DECOMPILER ERROR at PC85: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC85: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
      ;
      (table.sort)(changeList, function(a, b)
    -- function num : 0_9_0
    if a.attrId >= b.attrId then
      do return a.property ~= b.property end
      do return a.property < b.property end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
      for index,data in ipairs(changeList) do
        local item = (self.attrItemPool):GetOne()
        item:InitAttrItem(data.oldAttr, data.newAttr, data.attrId)
      end
    end
  end
end

UIHeroLevelUp.RefreshLevelUpItems = function(self)
  -- function num : 0_10 , upvalues : _ENV
  (self.growupItemPool):HideAll()
  self.growupItemNums = {}
  local id = ConstGlobalItem.HeroExp
  if (PlayerDataCenter.itemDic)[id] ~= nil then
    local itemData = (PlayerDataCenter.itemDic)[id]
    do
      local item = (self.growupItemPool):GetOne(true)
      -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (item.gameObject).name = tostring(id)
      item:InitExpItem(itemData, function(num)
    -- function num : 0_10_0 , upvalues : self, itemData
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

    (self.growupItemNums)[itemData] = num
    if self.isInLvSeq and self.lvUpSeq ~= nil then
      (self.lvUpSeq):Kill(true)
      self.lvUpSeq = nil
    else
      self:CalAndShowExpBar()
    end
  end
, function(isShowTip)
    -- function num : 0_10_1 , upvalues : self
    return self:CheckItemUse(isShowTip)
  end
)
      ;
      (table.insert)(self.growupItemList, item)
    end
  else
    do
      local item = (self.growupItemPool):GetOne(true)
      item:InitEmptyExpItem(id)
    end
  end
end

UIHeroLevelUp.CheckItemUse = function(self, isShowTip)
  -- function num : 0_11 , upvalues : _ENV
  local heroMaxLevel = (ConfigData.game_config).heroMaxLevel
  if heroMaxLevel <= self.level or heroMaxLevel <= self.nextlevel then
    if isShowTip then
      ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.hero_level_Full))
    end
    return false
  end
  heroMaxLevel = (self.heroData):GetLevelLimit()
  if heroMaxLevel <= self.level or heroMaxLevel <= self.nextlevel then
    if isShowTip then
      ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.LevelUp_Limit))
    end
    return false
  end
  return true
end

UIHeroLevelUp.UpdateLevel = function(self, level)
  -- function num : 0_12 , upvalues : _ENV
  self:UpdateAttr(level)
  local isFullLevel = (self.heroData):IsFullLevel()
  ;
  (((self.ui).tex_NextLv).gameObject):SetActive(not isFullLevel)
  ;
  ((self.ui).obj_MaxLevel):SetActive(isFullLevel)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

  if not isFullLevel then
    if level <= 9 then
      ((self.ui).tex_NextLv).text = "0" .. tostring(level)
    else
      -- DECOMPILER ERROR at PC35: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.ui).tex_NextLv).text = tostring(level)
    end
    ;
    ((self.ui).tex_NextLv):StartScrambleTypeWriter()
  end
end

UIHeroLevelUp.UpdatePotential = function(self, showLevel)
  -- function num : 0_13 , upvalues : _ENV
  if showLevel == nil or not showLevel then
    showLevel = (self.heroData).potential
  end
  if (self.heroData):GetMaxPotential() < showLevel then
    showLevel = (self.heroData):GetMaxPotential()
  end
  local vec = (((self.ui).img_LimitUp).rectTransform).sizeDelta
  vec.x = self.potentialImgWidth * showLevel
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.ui).img_LimitUp).rectTransform).sizeDelta = vec
  local isRechLimit = (self.heroData):IsReachLevelLimit()
  ;
  ((self.ui).cannotUpgrade):SetActive(isRechLimit)
  if isRechLimit then
    (self.upgradeItemPool):HideAll()
    if (self.heroData):IsFullLevel() then
      ((self.ui).text_cannotUpgrade):SetIndex(1)
    else
      ;
      ((self.ui).text_cannotUpgrade):SetIndex(0)
      local potentialCfg = ((ConfigData.hero_potential)[(self.heroData).dataId])[(self.heroData).potential]
      for itemId,needCount in pairs(potentialCfg.cost) do
        local item = (self.upgradeItemPool):GetOne()
        local itemCfg = (ConfigData.item)[itemId]
        local wareHouseNum = PlayerDataCenter:GetItemCount(itemId)
        item:InitItemWithCount(itemCfg, needCount, nil, wareHouseNum)
      end
      ;
      (((self.ui).obj_upgradTips).transform):SetAsLastSibling()
    end
  end
end

UIHeroLevelUp.CalAndShowExpBar = function(self, level, curExp, addExp)
  -- function num : 0_14 , upvalues : _ENV
  self:RefreshConfirmBtn()
  if self.isInLvSeq then
    return 
  end
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'

  if self.level <= 9 then
    ((self.ui).tex_curLv).text = "0" .. tostring(self.level)
  else
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_curLv).text = tostring(self.level)
  end
  ;
  ((self.ui).tex_curLv):StartScrambleTypeWriter()
  level = level or self.level or 1
  curExp = curExp or self.curExp or 0
  addExp = addExp or self:_CalAddExp() or 0
  local requireExp = ((ConfigData.hero_level)[level]).exp
  local heroMaxLevel = (self.heroData):GetLevelLimit()
  local maxAddExp = -(curExp)
  for i = level, heroMaxLevel - 1 do
    maxAddExp = maxAddExp + ((ConfigData.hero_level)[i]).exp
  end
  self:SetAddExpLimt(maxAddExp, addExp)
  ;
  ((self.ui).tex_Exp):SetIndex(0, tostring(curExp), tostring(requireExp))
  ;
  ((self.ui).tex_AddExp):SetIndex(0, tostring(addExp))
  local remainEXP = (curExp) + (addExp)
  local requireExp = ((ConfigData.hero_level)[level]).exp
  while (self.heroData).curExp < remainEXP and requireExp <= remainEXP and heroMaxLevel > level do
    level = (level) + 1
    remainEXP = remainEXP - requireExp
    requireExp = ((ConfigData.hero_level)[level]).exp
  end
  self.nextlevel = level
  -- DECOMPILER ERROR at PC116: Confused about usage of register: R9 in 'UnsetPending'

  if (self.heroData):IsFullLevel() then
    ((self.ui).img_Exp).fillAmount = 1
    ;
    ((self.ui).tex_Exp):SetIndex(1)
  else
    -- DECOMPILER ERROR at PC126: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((self.ui).img_Exp).fillAmount = (remainEXP) / requireExp
    ;
    ((self.ui).tex_Exp):SetIndex(0, tostring(remainEXP), tostring(requireExp))
  end
  self:UpdateLevel(level)
end

UIHeroLevelUp._CalAddExp = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local totalExp = 0
  for itemData,num in pairs(self.growupItemNums) do
    totalExp = totalExp + itemData:GetActionArg(1) * num
  end
  return totalExp
end

UIHeroLevelUp.SetAddExpLimt = function(self, maxAddExp, addExp)
  -- function num : 0_16 , upvalues : _ENV
  for _,item in ipairs(self.growupItemList) do
    item:SetAddExpLimt(maxAddExp, addExp)
  end
end

UIHeroLevelUp.RefreshConfirmBtn = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local potentialUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential)
  if (self.heroData):IsReachLevelLimit() and not (self.heroData):IsFullLevel() then
    (((self.ui).btn_StarUp).gameObject):SetActive(false)
    ;
    (((self.ui).img_ClearSelect).gameObject):SetActive(false)
    ;
    (((self.ui).btn_LimitUp).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R2 in 'UnsetPending'

    if not potentialUnlock or not (self.ui).color_orange then
      ((self.ui).img_BtnLimitUp).color = (self.ui).color_gray
      -- DECOMPILER ERROR at PC49: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (((self.ui).img_BtnLimitUp).transform).localPosition = (self.ui).pos_canPotential
      -- DECOMPILER ERROR at PC55: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (((self.ui).img_BtnLimitUp).rectTransform).sizeDelta = (self.ui).size_canPotential
      do return  end
      local isSelect = false
      if (table.count)(self.growupItemNums) ~= 0 then
        for itemId,num in pairs(self.growupItemNums) do
          if num > 0 then
            isSelect = true
          end
        end
      end
      do
        ;
        (((self.ui).img_ClearSelect).gameObject):SetActive(isSelect)
        if potentialUnlock then
          (((self.ui).btn_LimitUp).gameObject):SetActive(not isSelect)
          -- DECOMPILER ERROR at PC91: Confused about usage of register: R3 in 'UnsetPending'

          ;
          ((self.ui).img_BtnLimitUp).color = (self.ui).color_gray
          -- DECOMPILER ERROR at PC97: Confused about usage of register: R3 in 'UnsetPending'

          ;
          (((self.ui).img_BtnLimitUp).transform).localPosition = (self.ui).pos_notPotential
          -- DECOMPILER ERROR at PC103: Confused about usage of register: R3 in 'UnsetPending'

          ;
          (((self.ui).img_BtnLimitUp).rectTransform).sizeDelta = (self.ui).size_notPotential
          ;
          (((self.ui).btn_StarUp).gameObject):SetActive(true)
          -- DECOMPILER ERROR at PC116: Confused about usage of register: R3 in 'UnsetPending'

          if isSelect then
            ((self.ui).img_StarUp).color = (self.ui).color_orange
            -- DECOMPILER ERROR at PC119: Confused about usage of register: R3 in 'UnsetPending'

            ;
            ((self.ui).btn_StarUp).interactable = true
          else
            -- DECOMPILER ERROR at PC125: Confused about usage of register: R3 in 'UnsetPending'

            ;
            ((self.ui).img_StarUp).color = (self.ui).color_gray
            -- DECOMPILER ERROR at PC128: Confused about usage of register: R3 in 'UnsetPending'

            ;
            ((self.ui).btn_StarUp).interactable = false
          end
          self:_RefreshQuickLevelUp()
        end
      end
    end
  end
end

UIHeroLevelUp.OnClickLevelUp = function(self)
  -- function num : 0_18 , upvalues : _ENV, cs_MessageCommon
  if (self.heroData):IsReachLevelLimit() then
    if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential) then
      UIManager:ShowWindowAsync(UIWindowTypeID.HeroPotential, function(window)
    -- function num : 0_18_0 , upvalues : self
    window:InitPotential(self.heroData)
  end
)
    else
      local msg = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential)
      ;
      (cs_MessageCommon.ShowMessageTips)(msg)
    end
    do
      do return  end
      self.isInLvSeq = true
      if self._lvUpCompleteFunc == nil then
        self._lvUpCompleteFunc = BindCallback(self, self._LvUpComplete)
      end
      if self._canQuickLvUp then
        (self.networkCtrl):CS_HERO_Upgrade(self.heroId, (self.heroData).level + 1, self._lvUpCompleteFunc)
        return 
      end
      local itemTab = {}
      for itemData,num in pairs(self.growupItemNums) do
        itemTab[itemData.dataId] = num
      end
      if (table.count)(itemTab) == 0 then
        return 
      end
      if self.networkCtrl ~= nil then
        local canLevelUp = (self.heroData):GenHeroCanQuickLevelUp()
        if canLevelUp then
          (self.networkCtrl):CS_HERO_Upgrade(self.heroId, (self.heroData).level + 1, self._lvUpCompleteFunc)
        end
      end
    end
  end
end

UIHeroLevelUp._LvUpComplete = function(self, objList)
  -- function num : 0_19 , upvalues : _ENV, UIHeroTweenUtil
  self:_KillLvUpSeq(false)
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
  if self._onExpSeqStart == nil then
    self._onExpSeqStart = BindCallback(self, self._OnExpSeqStart)
  end
  if self._onExpSeqAppendCallback == nil then
    self._onExpSeqAppendCallback = BindCallback(self, self._OnExpSeqAppendCallback)
  end
  if self._onExpSeqComplete == nil then
    self._onExpSeqComplete = BindCallback(self, self._OnExpSeqComplete)
  end
  self.lvUpSeq = (UIHeroTweenUtil.CreateExpBarSequence)((self.ui).img_Exp, HeroExpDiffData, self._onExpSeqStart, self._onExpSeqComplete, self._onExpSeqAppendCallback)
end

UIHeroLevelUp._OnExpSeqStart = function(self)
  -- function num : 0_20
  (((self.ui).tex_Exp).gameObject):SetActive(false)
  ;
  (((self.ui).tex_LevelTween).gameObject):SetActive(true)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_LevelTween).text = ""
end

UIHeroLevelUp._OnExpSeqAppendCallback = function(self, tempLevel, duration)
  -- function num : 0_21 , upvalues : _ENV, cs_Tweening
  ((self.ui).tex_LevelTween):DOKill(true)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_Exp).fillAmount = 0
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_LevelTween).color = self.oriTexTweenCol
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.ui).tex_LevelTween).transform).localScale = Vector3.one
  local empty = ""
  if tempLevel <= 9 then
    empty = "0"
  end
  local strLv = tostring(empty) .. tostring(tempLevel)
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_LevelTween).text = strLv
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_NextLv).text = strLv
  ;
  ((((self.ui).tex_LevelTween):DOFade(0, duration)):From()):SetLoops(2, (cs_Tweening.LoopType).Yoyo)
  ;
  (((self.ui).tex_LevelTween).transform):DOScale((Vector3.New)(1.25, 1.25, 1), duration)
end

UIHeroLevelUp._OnExpSeqComplete = function(self)
  -- function num : 0_22
  (((self.ui).tex_Exp).gameObject):SetActive(true)
  ;
  (((self.ui).tex_LevelTween).gameObject):SetActive(false)
  self.isInLvSeq = false
  self:CalAndShowExpBar()
end

UIHeroLevelUp._KillLvUpSeq = function(self, needComplete)
  -- function num : 0_23
  if self.lvUpSeq ~= nil then
    (self.lvUpSeq):Kill(needComplete)
    self.lvUpSeq = nil
  end
  ;
  ((self.ui).tex_LevelTween):DOKill()
end

UIHeroLevelUp.OnClickClean = function(self, isForbidUpdateData)
  -- function num : 0_24 , upvalues : _ENV
  for _,item in ipairs(self.growupItemList) do
    item:CleanAll(isForbidUpdateData)
  end
  for itemData,_ in pairs(self.growupItemNums) do
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R7 in 'UnsetPending'

    (self.growupItemNums)[itemData] = 0
  end
end

UIHeroLevelUp.OnClickBack = function(self)
  -- function num : 0_25 , upvalues : _ENV
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
    win.active = true
    ;
    (win.gameObject):SetActive(true)
  end
  self:PlayAllDOTweenBackwards()
  self:Delete()
end

UIHeroLevelUp.__OnClickLeftArrow = function(self)
  -- function num : 0_26
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = (self.switchHeroFunc)(-1)
    self:SwitchHero(newHeroData, reUseBigImgResloader)
  end
end

UIHeroLevelUp.__OnClickRightArrow = function(self)
  -- function num : 0_27
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = (self.switchHeroFunc)(1)
    self:SwitchHero(newHeroData, reUseBigImgResloader)
  end
end

UIHeroLevelUp.__OnClickPotentialPreview = function(self)
  -- function num : 0_28 , upvalues : _ENV, cs_MessageCommon
  if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential) then
    UIManager:ShowWindowAsync(UIWindowTypeID.HeroPotential, function(window)
    -- function num : 0_28_0 , upvalues : self
    window:InitPotential(self.heroData)
  end
)
  else
    local msg = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential)
    ;
    (cs_MessageCommon.ShowMessageTips)(msg)
  end
end

UIHeroLevelUp.PlayAllDOTween = function(self)
  -- function num : 0_29
  for i = 0, (self.allTweens).Length - 1 do
    local tween = (self.allTweens)[i]
    tween:DORestart(false)
  end
end

UIHeroLevelUp.PlayAllDOTweenBackwards = function(self)
  -- function num : 0_30
  for i = 0, (self.allTweens).Length - 1 do
    local tween = (self.allTweens)[i]
    tween:DOPlayBackwards()
  end
end

UIHeroLevelUp.BackwardsAllDOTween = function(self, callback)
  -- function num : 0_31 , upvalues : _ENV
  local longestDuration = 0
  for i = 0, (self.allTweens).Length - 1 do
    local tween = (self.allTweens)[i]
    if longestDuration < tween.duration then
      longestDuration = tween.duration + tween.delay
    end
    tween:DOPlayBackwards()
  end
  if callback ~= nil then
    TimerManager:StartTimer(longestDuration, callback, nil, true)
  end
end

UIHeroLevelUp.RefreshBlutDot = function(self)
  -- function num : 0_32 , upvalues : _ENV
  if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential) then
    ((self.ui).blueDot_pontential):SetActive((self.heroData):AblePotential())
  end
end

UIHeroLevelUp.OnShow = function(self)
  -- function num : 0_33 , upvalues : _ENV, base
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__refreshItem)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__refresh)
  ;
  (base.OnShow)(self)
end

UIHeroLevelUp.PotentialAniPlay = function(self)
  -- function num : 0_34 , upvalues : _ENV
  if self.potentialTimerId ~= nil then
    TimerManager:StopTimer(self.potentialTimerId)
    self.potentialTimerId = nil
  end
  self:UpdatePotential((self.heroData).potential - 1)
  local vec = (((self.ui).obj_potentialEft).transform).localPosition
  vec.x = ((self.heroData).potential - 1) * self.potentialImgWidth
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).obj_potentialEft).transform).localPosition = vec
  ;
  ((self.ui).obj_potentialEft):SetActive(false)
  ;
  ((self.ui).obj_potentialEft):SetActive(true)
  self.potentialTimerId = TimerManager:StartTimer(1, function()
    -- function num : 0_34_0 , upvalues : self
    self.potentialTimerId = nil
    self:UpdatePotential()
  end
, self, true, false, true)
end

UIHeroLevelUp.OnHide = function(self)
  -- function num : 0_35 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__refresh)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__refreshItem)
  ;
  (base.OnHide)(self)
end

UIHeroLevelUp.OnDelete = function(self)
  -- function num : 0_36 , upvalues : _ENV
  (self.growupItemPool):DeleteAll()
  if self.potentialTimerId ~= nil then
    TimerManager:StopTimer(self.potentialTimerId)
    self.potentialTimerId = nil
  end
  self:_KillLvUpSeq(false)
end

return UIHeroLevelUp


-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthEfficiency = class("UIAthEfficiency", UIBaseWindow)
local base = UIBaseWindow
local UINAthList = require("Game.Arithmetic.AthList.UINAthList")
local UINAthEfccQuickSelect = require("Game.Arithmetic.AthEfficiency.UINAthEfccQuickSelect")
local AthEnum = require("Game.Arithmetic.ArthmeticEnum")
local cs_MessageCommon = CS.MessageCommon
UIAthEfficiency.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINAthList, UINAthEfccQuickSelect
  (UIUtil.SetTopStatus)(self, self.__OnClickBack)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.__OnClickUpgrade)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Switch, self, self.__OnClickAutoSelect)
  self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
  self.athListNode = (UINAthList.New)()
  ;
  (self.athListNode):Init((self.ui).aTHListNode)
  self.quickSelectNode = (UINAthEfccQuickSelect.New)(self)
  ;
  (self.quickSelectNode):Init((self.ui).quickSwitchNode)
  self._quickSelectFunc = BindCallback(self, self.OnAthEfccQuickSelect)
  ;
  (self.quickSelectNode):InitAthEfccQuickSelect(self._quickSelectFunc)
  ;
  (self.quickSelectNode):Hide()
  self.athSelectedDic = {}
  self.athExpAdd = 0
  self.curEfcc = 0
end

UIAthEfficiency.InitAthAthEfcc = function(self, heroData, resLoader, heroResLoader, switchHeroFunc)
  -- function num : 0_1
  self.switchHeroFunc = switchHeroFunc
  self.resLoader = resLoader
  self:__SelectHero(heroData, heroResLoader)
end

UIAthEfficiency.__SelectHero = function(self, heroData, heroResLoader)
  -- function num : 0_2 , upvalues : _ENV
  self.heroData = heroData
  DestroyUnityObject(self.bigImgGameObject)
  heroResLoader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(heroData:GetResName()), function(prefab)
    -- function num : 0_2_0 , upvalues : _ENV, self
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate((self.ui).heroHolder)
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroList")
  end
)
  ;
  ((self.ui).tween_Hero):DORestart()
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_HeroName).text = heroData:GetName()
  self.athSelectedDic = {}
  ;
  ((self.athListNode).athListArea):SetAthListAreaMultSeletedUidDic(self.athSelectedDic)
  ;
  (self.athListNode):InitAthListNode(heroData, self.resLoader, true, BindCallback(self, self.__OnClickAthItem))
  ;
  (self.athListNode):ShowAthListDecomposeBtn(false)
  self.athMatUpNode = (((self.athListNode).athListArea).athScrollList):GetAthScrollListMatUpNode()
  ;
  (self.athMatUpNode):SetRefreshAthSlotAddExpFunc(BindCallback(self, self.RefreshAthSlotAddExp))
  self:RefreshCurAthEfficency()
end

UIAthEfficiency.RefreshCurAthEfficency = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local curLevel, curExp = (PlayerDataCenter.allAthData):GetHeroAthSlotInfo((self.heroData).dataId)
  self.curLevel = curLevel
  self.curExp = curExp
  self.athSelectedDic = {}
  self.athExpAdd = 0
  ;
  ((self.athListNode).athListArea):SetAthListAreaMultSeletedUidDic(self.athSelectedDic)
  ;
  (self.athMatUpNode):CleanAllAthUpMat()
  ;
  (self.athMatUpNode):InitAthMatUp(BindCallback(self, self.__OnMatExpAdd), ((ConfigData.item).growUpIds)[eItemActionType.AthAreaExp])
  local maxLevel = (ConfigData.ath_efficiency).maxLevel
  if maxLevel <= curLevel then
    ((self.ui).tex_IsMax):SetActive(true)
    ;
    ((self.ui).unMax):SetActive(false)
    local maxLvCfg = (ConfigData.ath_efficiency)[maxLevel]
    local efcc = maxLvCfg.attribute_promote / 1000
    self.curEfcc = efcc
    self.curEfccStr = (string.format)("%.1f", efcc)
    ;
    ((self.ui).tex_CurValue):SetIndex(0, self.curEfccStr)
  else
    do
      ;
      ((self.ui).tex_IsMax):SetActive(false)
      ;
      ((self.ui).unMax):SetActive(true)
      local lvCfg = (ConfigData.ath_efficiency)[curLevel]
      if lvCfg == nil then
        error("Can\'t get ath_efficiency cfg, level = " .. tostring(curLevel))
        return 
      end
      do
        local curEfcc = lvCfg.attribute_promote / 1000
        self.curEfcc = curEfcc
        self.curEfccStr = (string.format)("%.1f", curEfcc)
        ;
        ((self.ui).tex_CurValue):SetIndex(0, self.curEfccStr)
        self:RefreshAthSlotAddExp()
      end
    end
  end
end

UIAthEfficiency.RefreshAthSlotAddExp = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local addExp = self:__GetAddExp()
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).btn_Confirm).interactable = addExp > 0
  ;
  ((self.ui).tex_AddEXP):SetIndex(0, tostring(addExp))
  local testLevel, nextExp, nextTotalExp = (PlayerDataCenter.allAthData):TryAddAthAreaExp(addExp, self.curLevel, self.curExp)
  local toMaxLevelExp = -self.curExp
  for i = self.curLevel, (ConfigData.ath_efficiency).maxLevel - 1 do
    local levelCfg = (PlayerDataCenter.allAthData):GetAthEfficiencyCfg(i)
    toMaxLevelExp = toMaxLevelExp + levelCfg.shard
  end
  self.ableAddExp = toMaxLevelExp - addExp
  ;
  (self.athMatUpNode):SetAthAddExpLimt(toMaxLevelExp, addExp)
  local targetLvCfg = (PlayerDataCenter.allAthData):GetAthEfficiencyCfg(testLevel)
  local targetEfcc = targetLvCfg.attribute_promote / 1000
  ;
  ((self.ui).tex_NextValue):SetIndex(0, (string.format)("%.1f", targetEfcc))
  if (ConfigData.ath_efficiency).maxLevel == testLevel then
    ((self.ui).tex_EXP):SetIndex(1)
  else
    ((self.ui).tex_EXP):SetIndex(0, tostring(nextExp), tostring(nextTotalExp))
  end
  -- DECOMPILER ERROR at PC90: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).img_Add).fillAmount = nextExp / nextTotalExp
  ;
  (((self.ui).tex_NextValue).gameObject):SetActive(false)
  if self.curLevel < testLevel then
    (((self.ui).tex_NextValue).gameObject):SetActive(true)
    local addValue = (targetEfcc - self.curEfcc) * 100
    addValue = (string.format)("%.0f", addValue)
    ;
    ((self.ui).tex_Ratio):SetIndex(0, tostring((math.floor)(self.curEfcc * 100)), tostring(addValue))
  else
    ((self.ui).tex_Ratio):SetIndex(1, tostring((math.floor)(self.curEfcc * 100)))
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

UIAthEfficiency.__OnMatExpAdd = function(self, addExp)
  -- function num : 0_5
  self.matExpAdd = addExp
  self:RefreshAthSlotAddExp()
end

UIAthEfficiency.__OnAthExpAdd = function(self, addExp)
  -- function num : 0_6 , upvalues : _ENV
  self.athExpAdd = (math.max)(self.athExpAdd + addExp, 0)
  self:RefreshAthSlotAddExp()
end

UIAthEfficiency.__GetAddExp = function(self)
  -- function num : 0_7
  return (self.matExpAdd or 0) + (self.athExpAdd or 0)
end

UIAthEfficiency.__OnClickAutoSelect = function(self)
  -- function num : 0_8
  (self.quickSelectNode):Show()
end

UIAthEfficiency.OnAthEfccQuickSelect = function(self, quickSelectEnum)
  -- function num : 0_9 , upvalues : AthEnum, _ENV
  self:RefreshCurAthEfficency()
  if quickSelectEnum ~= nil and quickSelectEnum < (AthEnum.AthEfccQuickSelectEnum).Material then
    local quality = quickSelectEnum + 2
    if self.ableAddExp > 0 then
      local tempList = (((self.athListNode).athListArea).athScrollList):GetAthScrollListCurAthList()
      local athList = {}
      for k,athData in ipairs(tempList) do
        if not athData.lockUnlock then
          local athQualityId = athData:GetAthQuality()
          local qualityOk = quality == athQualityId
          if qualityOk then
            (table.insert)(athList, athData)
          end
        end
      end
      ;
      (table.sort)(athList, function(a, b)
    -- function num : 0_9_0
    local qualityA = a:GetAthQuality()
    local qualityB = b:GetAthQuality()
    if a.uid >= b.uid then
      do return qualityA ~= qualityB end
      do return qualityA < qualityB end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
      for k,athData in ipairs(athList) do
        if self.ableAddExp > 0 then
          local exp = (athData.athCfg).shard
          -- DECOMPILER ERROR at PC56: Confused about usage of register: R11 in 'UnsetPending'

          ;
          (self.athSelectedDic)[athData.uid] = true
          self:__OnAthExpAdd(exp)
        else
          break
        end
      end
    end
  elseif quickSelectEnum == (AthEnum.AthEfccQuickSelectEnum).Material then
    local matList = {}
    local matItemList = (self.athMatUpNode):GetAthMatItemList()
    for k,v in pairs(matItemList) do
      local matItemId = v:GetHeroLvUpItemId()
      local itemData = (PlayerDataCenter.itemDic)[matItemId]
      if itemData ~= nil then
        (table.insert)(matList, {itemId = matItemId, exp = itemData:GetActionArg(1), count = itemData:GetCount(), matItem = v})
      end
    end
    ;
    (table.sort)(matList, function(a, b)
    -- function num : 0_9_1
    do return b.exp < a.exp end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    for k,data in ipairs(matList) do
      for i = 1, data.count do
        if self.ableAddExp > 0 then
          (data.matItem):AddOne()
        else
          break
        end
      end
    end
  end
  ;
  ((self.athListNode).athListArea):SetAthListAreaMultSeletedUidDic(self.athSelectedDic)
  ;
  (self.athListNode):RefillCurAthSortList(true)
  -- DECOMPILER ERROR: 8 unprocessed JMP targets
end

UIAthEfficiency.__OnClickAthItem = function(self, athItem)
  -- function num : 0_10 , upvalues : cs_MessageCommon, _ENV
  local athData = athItem:GetAthItemData()
  if athData.lockUnlock then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Ath_CantSelectLockAth))
    return 
  end
  local exp = (athData.athCfg).shard
  if (self.athSelectedDic)[athData.uid] == nil then
    if self.ableAddExp <= 0 then
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Ath_AreaUpExpIsFull))
      return 
    end
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self.athSelectedDic)[athData.uid] = true
    self:__OnAthExpAdd(exp)
    athItem:SetAthItemSelect(true, true)
    UIManager:ShowWindowAsync(UIWindowTypeID.AthItemDetailFloat, function(window)
    -- function num : 0_10_0 , upvalues : athData
    if window == nil then
      return 
    end
    window:InitAthDetailFloat(athData)
  end
)
  else
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self.athSelectedDic)[athData.uid] = nil
    self:__OnAthExpAdd(-exp)
    athItem:SetAthItemSelect(false)
  end
  ;
  ((self.athListNode).athListArea):SetAthListAreaMultSeletedUidDic(self.athSelectedDic)
end

UIAthEfficiency.__OnClickUpgrade = function(self)
  -- function num : 0_11 , upvalues : _ENV, cs_MessageCommon
  if self:__GetAddExp() <= 0 then
    return 
  end
  local itemDic = (self.athMatUpNode):GetAthMatExpAddItemDic()
  local athDic = self.athSelectedDic
  self.oldHeroPower = (self.heroData):GetFightingPower()
  if self.__onUpComplete == nil then
    self.__onUpComplete = BindCallback(self, self.OnAthAreaUpgradeComplete)
  end
  self.oldEfccStr = self.curEfccStr
  local hasOrangeAth = false
  for uid,v in pairs(athDic) do
    local athData = ((PlayerDataCenter.allAthData).athDic)[uid]
    if athData:GetAthQuality() == eItemQualityType.Orange then
      hasOrangeAth = true
    end
  end
  local requestFunc = function()
    -- function num : 0_11_0 , upvalues : self, itemDic, athDic
    (self.athNetwork):CS_ATH_SlotUpgrade((self.heroData).dataId, itemDic, athDic, self.__onUpComplete)
  end

  if hasOrangeAth then
    (cs_MessageCommon.ShowMessageBox)(ConfigData:GetTipContent(TipContent.Ath_EfficiencyUpContainOrangeAth), requestFunc, nil)
  else
    requestFunc()
  end
end

UIAthEfficiency.OnAthAreaUpgradeComplete = function(self)
  -- function num : 0_12 , upvalues : _ENV
  self:RefreshCurAthEfficency()
  if self.oldEfccStr ~= self.curEfccStr then
    UIManager:ShowWindowAsync(UIWindowTypeID.AthEfficiencyUpSuccess, function(window)
    -- function num : 0_12_0 , upvalues : self, _ENV
    if window == nil then
      return 
    end
    window:InitAthEffiUpSuccess(self.oldEfccStr, self.curEfccStr)
    local newHeroPower = (self.heroData):GetFightingPower()
    window:SetBackClickAction(BindCallback(self, self.__ShowHeroPowerUpSuccess, newHeroPower))
  end
)
  end
end

UIAthEfficiency.__ShowHeroPowerUpSuccess = function(self, newPower)
  -- function num : 0_13 , upvalues : _ENV
  if newPower ~= self.oldHeroPower then
    UIManager:ShowWindowAsync(UIWindowTypeID.HeroPowerUpSuccess, function(win)
    -- function num : 0_13_0 , upvalues : self, newPower
    if win ~= nil then
      win:InitHeroPowerUpSuccess(self.oldHeroPower, newPower)
    end
  end
)
  end
end

UIAthEfficiency.__OnClickBack = function(self)
  -- function num : 0_14
  self:Delete()
end

UIAthEfficiency.__OnClickLeftArrow = function(self)
  -- function num : 0_15
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = (self.switchHeroFunc)(-1)
    self:__SelectHero(newHeroData, reUseBigImgResloader)
  end
end

UIAthEfficiency.__OnClickRightArrow = function(self)
  -- function num : 0_16
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = (self.switchHeroFunc)(1)
    self:__SelectHero(newHeroData, reUseBigImgResloader)
  end
end

UIAthEfficiency.OnDelete = function(self)
  -- function num : 0_17 , upvalues : _ENV, base
  (self.athListNode):Delete()
  ;
  (self.quickSelectNode):Delete()
  UIManager:HideWindow(UIWindowTypeID.AthItemDetailFloat)
  if self.siftCondition ~= nil then
    (self.siftCondition):Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UIAthEfficiency


-- params : ...
-- function num : 0 , upvalues : _ENV
local UIATH = class("UIATH", UIBaseWindow)
local base = UIBaseWindow
local UINAthAreaBtn = require("Game.Arithmetic.AthMain.UINAthAreaBtn")
local UINAthSuitItem = require("Game.Arithmetic.AthMain.UINAthSuitItem")
local UINAthChart = require("Game.Arithmetic.AthMain.Chart.UINAthChart")
local UINAthTable = require("Game.Arithmetic.AthMain.Table.UINAthTable")
local UINAthSortList = require("Game.Arithmetic.AthSortList.UINAthSortList")
local UINAthSuitDetail = require("Game.Arithmetic.AthSuitDetail.UINAthSuitDetail")
local UINAthMainAtrrItem = require("Game.Arithmetic.AthMain.UINAthMainAtrrItem")
local AthFilterEnum = require("Game.Arithmetic.AthSortList.AthFilterEnum")
local UINAthListItem = require("Game.Arithmetic.AthSortList.UINAthListItem")
local cs_MessageCommon = CS.MessageCommon
local CS_LeanTouch = ((CS.Lean).Touch).LeanTouch
local CS_Input = (CS.UnityEngine).Input
UIATH.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, CS_LeanTouch, CS_Input, UINAthAreaBtn, UINAthSuitItem, UINAthMainAtrrItem, UINAthChart, UINAthTable, UINAthSortList, UINAthSuitDetail
  (UIUtil.CreateTopBtnGroup)((self.ui).topButtonGroup, self, self.__OnClickBack)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Efficiency, self, self.__OnClickEfficiency)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_EfficiencyAttr, self, self.__OnClickAfficiencyAttr)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_OneKeyInstall, self, self.__OnClickOneKeyInstall)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_OneKeyUninstall, self, self.__OnClickOneKeyUninstall)
  ;
  (((self.ui).btn_OneKeyInstall).gameObject):SetActive(false)
  ;
  (((self.ui).btn_OneKeyUninstall).gameObject):SetActive(false)
  self.__OnClickAthItem = BindCallback(self, self.OnClickAthItem)
  self.__OnClickSuit = BindCallback(self, self.OnClickSuit)
  self.__InstallAth = BindCallback(self, self.InstallAth)
  self.__UnInstallAth = BindCallback(self, self.UnInstallAth)
  self.__ReplaceAth = BindCallback(self, self.ReplaceAth)
  self.__OnDragStart = BindCallback(self, self.OnDragAthItemStart)
  self.__onAthDataUpdate = BindCallback(self, self.OnAthDataUpdate)
  self.__getAthItemFromList = BindCallback(self, self.GetAthItemFromListMain)
  self.__onFingerSet = BindCallback(self, self.OnFingerSet)
  self.__onFingerUp = BindCallback(self, self.OnFingerUp)
  ;
  (CS_LeanTouch.OnFingerSet)("+", self.__onFingerSet)
  ;
  (CS_LeanTouch.OnFingerUp)("+", self.__onFingerUp)
  CS_Input.multiTouchEnabled = false
  ;
  ((self.ui).areaItem):SetActive(false)
  self.areaBtnPool = (UIItemPool.New)(UINAthAreaBtn, (self.ui).areaItem)
  ;
  ((self.ui).suitItem):SetActive(false)
  self.suitItemPool = (UIItemPool.New)(UINAthSuitItem, (self.ui).suitItem)
  ;
  ((self.ui).attriItem):SetActive(false)
  self.attrItemPool = (UIItemPool.New)(UINAthMainAtrrItem, (self.ui).attriItem)
  self.chartNode = (UINAthChart.New)()
  ;
  (self.chartNode):Init((self.ui).chartNode)
  ;
  (self.chartNode):Show()
  self.areaTableNode = (UINAthTable.New)(self, self.__OnDragStart)
  ;
  (self.areaTableNode):Init((self.ui).tableNode)
  ;
  (self.areaTableNode):Hide()
  self.sortListNode = (UINAthSortList.New)()
  ;
  (self.sortListNode):Init((self.ui).aTHListNode)
  ;
  (self.sortListNode):SetAthItemStartDragFunc(self.__OnDragStart)
  ;
  (self.sortListNode):Hide()
  self.suitDetailNode = (UINAthSuitDetail.New)()
  ;
  (self.suitDetailNode):Init((self.ui).suitDetailNode)
  ;
  (self.suitDetailNode):Hide()
  self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
  MsgCenter:AddListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
  self._isEfficencyAttr = true
  self:__RefreshAfficiencyAttr()
  self:InitATHTween()
end

UIATH.InitAth = function(self, heroData, resLader, heroResLoader, addAllTouchFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.heroData = heroData
  self.resLoader = resLader
  self.heroResLoader = heroResLoader
  self.addAllTouchFunc = addAllTouchFunc
  ;
  (self.heroResLoader):LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(heroData:GetResName()), function(prefab)
    -- function num : 0_1_0 , upvalues : self, _ENV
    self.bigImgGameObject = prefab:Instantiate((self.ui).heroHolder)
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroList")
  end
)
  self.__OnClickAreaBtn = BindCallback(self, self.OnClickAreaBtn)
  local athAreaMaxSpaceList = (self.heroData):GetAthSlotList(true)
  do
    for k,maxSpace in ipairs(athAreaMaxSpaceList) do
      local btnItem = (self.areaBtnPool):GetOne()
      btnItem:InitAthAreaBtn(k, (self.heroData).dataId, self.__OnClickAreaBtn)
    end
  end
  self:RefreshAllAthInfo(true)
  self:__RefreshBlueDot()
  self:PlayATHTween()
  if (PlayerDataCenter.allAthData).athReconsitutionData ~= nil then
    local athData = ((PlayerDataCenter.allAthData).athDic)[((PlayerDataCenter.allAthData).athReconsitutionData).uid]
    UIManager:ShowWindowAsync(UIWindowTypeID.AthStrengthen, function(window)
    -- function num : 0_1_1 , upvalues : athData, self
    if window == nil then
      return 
    end
    window:InitAthStrengthen(athData, self.heroData)
  end
)
  end
end

UIATH.__RefreshBlueDot = function(self)
  -- function num : 0_2 , upvalues : _ENV
  for slotIndex,btnItem in ipairs((self.areaBtnPool).listItem) do
    btnItem:ShowAthAreaBtnBlueDot((PlayerDataCenter.allAthData):GetHeroCanLoadedSlot(self.heroData, slotIndex))
  end
end

UIATH.RefreshAllAthInfo = function(self, changeAttrSort)
  -- function num : 0_3 , upvalues : _ENV
  local areaLevel = (PlayerDataCenter.allAthData):GetHeroAthSlotInfo((self.heroData).dataId)
  local areaEfcc = (PlayerDataCenter.allAthData):GetAthEfficiency(areaLevel)
  self.areaEfficiency = areaEfcc
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_EffNum).text = (string.format)("%.1f", areaEfcc / 1000)
  local athAreaMaxSpaceList = (self.heroData):GetAthSlotList(true)
  self.athAreaMaxSpaceList = athAreaMaxSpaceList
  local athAreaCurSpaceList = (self.heroData):GetAthSlotList()
  self.athAreaCurSpaceList = athAreaCurSpaceList
  ;
  (self.chartNode):InitAthChart((self.heroData).dataId, athAreaCurSpaceList, athAreaMaxSpaceList)
  for k,v in ipairs((self.areaBtnPool).listItem) do
    local curSpace = athAreaCurSpaceList[k]
    v:RefreshAthAreaBtn(curSpace)
  end
  self:RefreshAthAttr(athAreaCurSpaceList, self.curSlotId, changeAttrSort)
end

UIATH.RefreshAthAttr = function(self, athSlotList, curSlotId, changeSort)
  -- function num : 0_4 , upvalues : _ENV, AthFilterEnum
  local allAttrDic, slotAttrTab, suitDic, allAttrDicNoEfcc, slotAttrTabNoEfcc = (PlayerDataCenter.allAthData):GetHeroAthAttr((self.heroData).dataId)
  local fightPower = (PlayerDataCenter.allAthData):GetAthFightPower(allAttrDic)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R10 in 'UnsetPending'

  ;
  ((self.ui).tex_Power).text = tostring(fightPower)
  local isAllAttr = slotAttrTab[curSlotId] == nil
  self.attrValueDic = self:__MergeAttr(allAttrDic, isAllAttr, slotAttrTab, curSlotId)
  self.attrValueNoEfccDic = self:__MergeAttr(allAttrDicNoEfcc, isAllAttr, slotAttrTabNoEfcc, curSlotId)
  local maxShowCount = (self.ui).maxAttrCount
  if self.attrIdSortList == nil or changeSort then
    local idSortList = {}
    self.attrIdSortList = {}
    local count = 1
    for k,attrId in ipairs((ConfigData.attribute).baseAttrIds) do
      -- DECOMPILER ERROR at PC65: Unhandled construct in 'MakeBoolean' P1

      if ((ConfigData.attribute)[attrId]).merge_attribute == 0 and maxShowCount >= count then
        do
          (table.insert)(idSortList, attrId)
          ;
          (table.insert)(self.attrIdSortList, attrId)
          count = count + 1
          -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    ;
    (AthFilterEnum.SetEAttribute)(idSortList)
    for k,attrId in ipairs(idSortList) do
      local value = (self.attrValueDic)[attrId]
      if value == 0 then
        (table.removebyvalue)(self.attrIdSortList, attrId)
        ;
        (table.insert)(self.attrIdSortList, attrId)
      end
    end
  end
  ;
  (self.attrItemPool):HideAll()
  local isEmpty = true
  for k,attrId in ipairs(self.attrIdSortList) do
    local value = (self.attrValueDic)[attrId]
    local attrItem = (self.attrItemPool):GetOne()
    if value ~= nil and value ~= 0 then
      attrItem:InitAthMainAtrrItem(attrId, value)
      isEmpty = false
    else
      (attrItem.gameObject):SetActive(false)
    end
  end
  ;
  ((self.ui).obj_Attribute):SetActive(not isEmpty)
  ;
  ((self.ui).obj_EmptyAttri):SetActive(isEmpty)
  ;
  (((self.ui).btn_EfficiencyAttr).gameObject):SetActive(not isEmpty)
  self.heroSuitDic = {}
  local suitIdList = {}
  for suitId,suitData in pairs(suitDic) do
    (table.insert)(suitIdList, suitId)
    -- DECOMPILER ERROR at PC160: Confused about usage of register: R19 in 'UnsetPending'

    ;
    (self.heroSuitDic)[suitId] = {suitCount = suitData.curCount, athDataDic = suitData.suitAthDic}
  end
  ;
  (table.sort)(suitIdList)
  ;
  (self.suitItemPool):HideAll()
  for k,suitId in ipairs(suitIdList) do
    local suitData = suitDic[suitId]
    local suitItem = (self.suitItemPool):GetOne()
    suitItem:InitAthSuitItem(suitData, self.resLoader, self.__OnClickSuit)
  end
  ;
  ((self.ui).emptySuit):SetActive(#suitIdList == 0)
  -- DECOMPILER ERROR: 11 unprocessed JMP targets
end

UIATH.__MergeAttr = function(self, allAttrDic, isAllAttr, slotAttrTab, curSlotId)
  -- function num : 0_5 , upvalues : _ENV
  local valueDic = (table.GetDefaulValueTable)(0)
  local allAttrIdList = {}
  for k,v in pairs(allAttrDic) do
    (table.insert)(allAttrIdList, k)
  end
  for k,attrId in ipairs(allAttrIdList) do
    local attrConfig = (ConfigData.attribute)[attrId]
    if attrConfig.merge_attribute ~= 0 then
      local mergeID = attrConfig.merge_attribute
      if attrConfig.num_type == 2 then
        if isAllAttr then
          valueDic[mergeID] = valueDic[mergeID] + allAttrDic[attrId] * (self.heroData):GetAttr(mergeID, true) // 1000
        else
          valueDic[mergeID] = valueDic[mergeID] + ((slotAttrTab[curSlotId])[attrId] or 0) * (self.heroData):GetAttr(mergeID, true) // 1000
        end
      else
        if isAllAttr then
          valueDic[mergeID] = valueDic[mergeID] + allAttrDic[attrId]
        else
          valueDic[mergeID] = valueDic[mergeID] + ((slotAttrTab[curSlotId])[attrId] or 0)
        end
      end
    else
      do
        do
          if attrConfig.num_type == 2 then
            if attrId > 17 then
              if isAllAttr then
                valueDic[attrId] = allAttrDic[attrId]
              else
                valueDic[attrId] = (slotAttrTab[curSlotId])[attrId] or 0
              end
            else
              if isAllAttr then
                valueDic[attrId] = valueDic[attrId] + allAttrDic[attrId]
              else
                valueDic[attrId] = valueDic[attrId] + ((slotAttrTab[curSlotId])[attrId] or 0)
              end
            end
          else
            if isAllAttr then
              valueDic[attrId] = valueDic[attrId] + allAttrDic[attrId]
            else
              valueDic[attrId] = valueDic[attrId] + ((slotAttrTab[curSlotId])[attrId] or 0)
            end
          end
          -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  return valueDic
end

UIATH.__OnClickAfficiencyAttr = function(self)
  -- function num : 0_6
  self._isEfficencyAttr = not self._isEfficencyAttr
  self:__RefreshAfficiencyAttr()
end

UIATH.__OnClickOneKeyInstall = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self.curSlotId == nil then
    return 
  end
  local athList = (PlayerDataCenter.allAthData):GetAllAthSlotList(self.curSlotId, nil, true, (self.heroData).dataId)
  ;
  (table.sort)(athList, function(a, b)
    -- function num : 0_7_0
    local qualityA = a:GetAthQuality()
    local qualityB = b:GetAthQuality()
    local spaceA = a:GetAthSize()
    local spaceB = b:GetAthSize()
    local powerA = a:GetAthFightPower()
    local powerB = b:GetAthFightPower()
    if spaceA == spaceB then
      if spaceB >= spaceA then
        do return qualityA ~= qualityB end
        do return powerB < powerA end
        do return qualityB < qualityA end
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
      end
    end
  end
)
  ;
  (self.areaTableNode):OneKeyInstallAthTable(athList)
end

UIATH.__OnClickOneKeyUninstall = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self.curSlotId == nil then
    return 
  end
  local installedDic = (self.areaTableNode):RecordAthInstalledDic()
  if (table.count)(installedDic) == 0 then
    return 
  end
  ;
  (self.athNetwork):CS_ATH_OneKeyUninstall((self.heroData).dataId, self.curSlotId, function()
    -- function num : 0_8_0 , upvalues : _ENV, self
    AudioManager:PlayAudioById(1032)
    ;
    (self.areaTableNode):OnOneKeyUninstallComplete()
  end
)
end

UIATH.__RefreshAfficiencyAttr = function(self)
  -- function num : 0_9 , upvalues : _ENV
  ;
  ((self.ui).tex_EfficiencyAttr):SetIndex(self._isEfficencyAttr and 0 or 1)
  if self.attrValueDic == nil then
    return 
  end
  for k,attrId in ipairs(self.attrIdSortList) do
    local value = nil
    if self._isEfficencyAttr then
      value = (self.attrValueDic)[attrId]
    else
      value = (self.attrValueNoEfccDic)[attrId]
    end
    local attrItem = ((self.attrItemPool).listItem)[k]
    attrItem:InitAthMainAtrrItem(attrId, value)
  end
end

UIATH.__OnClickEfficiency = function(self)
  -- function num : 0_10 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.AthEfficiency, function(window)
    -- function num : 0_10_0 , upvalues : self
    if window == nil then
      return 
    end
    window:InitAthAthEfcc(self.heroData, self.heroResLoader)
  end
)
end

UIATH.__OnClickBack = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if (self.areaTableNode).active then
    (self.areaTableNode):Hide()
    ;
    (self.sortListNode):Hide()
    ;
    (self.chartNode):Show()
    ;
    (((self.ui).heroHolder).gameObject):SetActive(true)
    self.curSlotId = nil
    for k,areaBtnItem in ipairs((self.areaBtnPool).listItem) do
      areaBtnItem:ResetAthAreaBtnSelect()
    end
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).efficiency_cg).alpha = 1
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).efficiency_cg).blocksRaycasts = true
    ;
    (((self.ui).btn_OneKeyInstall).gameObject):SetActive(false)
    ;
    (((self.ui).btn_OneKeyUninstall).gameObject):SetActive(false)
    self:RefreshAllAthInfo(true)
    return false
  else
    UIManager:ShowWindow(UIWindowTypeID.HeroState)
    self:Delete()
  end
end

UIATH.OnClickAreaBtn = function(self, index)
  -- function num : 0_12 , upvalues : _ENV
  (self.chartNode):Hide()
  ;
  (((self.ui).heroHolder).gameObject):SetActive(false)
  self.curSlotId = index
  for k,areaBtnItem in ipairs((self.areaBtnPool).listItem) do
    if k == index then
      areaBtnItem:AthAreaBtnSelect(true)
      local maxSpace = (self.athAreaMaxSpaceList)[index]
      local space = (self.athAreaCurSpaceList)[index]
      ;
      (self.areaTableNode):Show()
      ;
      (self.areaTableNode):InitAthTable(self.heroData, index, space, maxSpace, self.resLoader)
      ;
      (self.sortListNode):Show()
      ;
      (self.sortListNode):SetAthListInstallSortFuncSet()
      ;
      (self.sortListNode):InitAthSortListNode(self.heroData, false, self.__OnClickAthItem, index)
    else
      do
        do
          areaBtnItem:AthAreaBtnSelect(false)
          -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).efficiency_cg).alpha = 0.1
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).efficiency_cg).blocksRaycasts = false
  ;
  (((self.ui).btn_OneKeyInstall).gameObject):SetActive(true)
  ;
  (((self.ui).btn_OneKeyUninstall).gameObject):SetActive(true)
  self:RefreshAllAthInfo(true)
end

UIATH.RefreshCurAthArea = function(self)
  -- function num : 0_13
  if self.curSlotId ~= nil then
    local maxSpace = (self.athAreaMaxSpaceList)[self.curSlotId]
    local space = (self.athAreaCurSpaceList)[self.curSlotId]
    ;
    (self.areaTableNode):InitAthTable(self.heroData, self.curSlotId, space, maxSpace, self.resLoader)
  end
end

UIATH.OnClickAthItem = function(self, athItem, inAthTable)
  -- function num : 0_14
  self:TryInstallAth(athItem, inAthTable)
end

UIATH.OnClickSuit = function(self, suitId)
  -- function num : 0_15
  (self.suitDetailNode):Show()
  ;
  (self.suitDetailNode):InitAthSuitDetail(self.resLoader, self.heroSuitDic, suitId)
end

UIATH.TryInstallAth = function(self, athItem, inAthTable)
  -- function num : 0_16 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.AthItemDetail, function(window)
    -- function num : 0_16_0 , upvalues : athItem, _ENV, self, inAthTable
    if window == nil then
      return 
    end
    local athData = athItem:GetAthItemData()
    if (PlayerDataCenter.allAthData):HeroContainAthByUid((self.heroData).dataId, athData.uid) then
      athItem = (self.areaTableNode):GetAthTableItemByUid(athData.uid)
    end
    window:SetAthItemDetailFunc(self.__InstallAth, self.__UnInstallAth, self.__ReplaceAth)
    window:InitAthItemDetail(self.heroData, athData, nil)
    if inAthTable then
      window:ChangeAthItemParent(athItem, nil)
    else
      window:ChangeAthItemParent(athItem, self.__getAthItemFromList)
    end
  end
)
end

UIATH.TryReplaceAth = function(self, athItem, replacedAthData)
  -- function num : 0_17 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.AthItemDetail, function(window)
    -- function num : 0_17_0 , upvalues : athItem, self, replacedAthData
    if window == nil then
      return 
    end
    local athData = athItem:GetAthItemData()
    window:SetAthItemDetailFunc(self.__InstallAth, self.__UnInstallAth, self.__ReplaceAth)
    window:InitAthItemDetail(self.heroData, athData, replacedAthData)
    window:ChangeAthItemParent(athItem, self.__getAthItemFromList)
  end
)
end

UIATH.InstallAth = function(self, athData)
  -- function num : 0_18 , upvalues : _ENV
  self:RefillAth(athData, nil, nil, nil, proto_csmsg_AthRefillOperator.AthRefillOperatorInstall)
end

UIATH.RefillAth = function(self, athData, gridId, resortAthDic, athInstalledDic, refillOp)
  -- function num : 0_19 , upvalues : _ENV, cs_MessageCommon
  if self.curSlotId == nil then
    return 
  end
  local athDataList = (PlayerDataCenter.allAthData):GetHeroAthList((self.heroData).dataId, self.curSlotId)
  for k,v in ipairs(athDataList) do
    if refillOp == proto_csmsg_AthRefillOperator.AthRefillOperatorInstall and v.id == athData.id then
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.arithmetic_RepeatedATH))
      return 
    end
    if refillOp == proto_csmsg_AthRefillOperator.AthRefillOperatorReplace and (v.uid == athData.uid or v.id ~= athData.id or (v.bindInfo).grid ~= gridId) then
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.arithmetic_RepeatedATH))
      return 
    end
  end
  if gridId == nil then
    gridId = (self.areaTableNode):GetAthInstallableGrid(athData)
    if gridId == nil then
      local canInstall = false
      do
        do
          if (self.areaTableNode):CheckAthAreaSpaceOk(athData) then
            local athInstallDic, installedDic = (self.areaTableNode):ReSortAthTable(athData)
            if athInstallDic ~= nil then
              gridId = athInstallDic[athData.uid]
              resortAthDic = athInstallDic
              athInstalledDic = installedDic
              canInstall = true
            end
          end
          if not canInstall then
            (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Ath_CantInstall))
            return 
          end
          if self.__onInstallComplete == nil then
            self.__onInstallComplete = BindCallback(self, self.OnInstallAthComplete)
          end
          local installFunc = function()
    -- function num : 0_19_0 , upvalues : self, athData, resortAthDic, athInstalledDic, _ENV, gridId, refillOp
    self.__insallAthData = athData
    self.__resortAthDic = resortAthDic
    self.__athInstalledDic = athInstalledDic
    local oldMoveDic = nil
    if resortAthDic ~= nil then
      oldMoveDic = {}
      for uid,gridId in pairs(resortAthDic) do
        if uid ~= athData.uid then
          oldMoveDic[uid] = gridId
        end
      end
    end
    do
      ;
      (self.athNetwork):CS_ATH_AthRefillOp((self.heroData).dataId, self.curSlotId, athData.uid, gridId, oldMoveDic, refillOp, self.__onInstallComplete)
    end
  end

          if athData.bindInfo ~= nil and (athData.bindInfo).id ~= (self.heroData).id then
            UIManager:ShowWindowAsync(UIWindowTypeID.AthReplaceHero, function(window)
    -- function num : 0_19_1 , upvalues : self, athData, installFunc
    if window == nil then
      return 
    end
    window:InitAthReplaceHero((self.heroData).dataId, (athData.bindInfo).id, installFunc, self.resLoader)
  end
)
          else
            installFunc()
          end
        end
      end
    end
  end
end

UIATH.OnInstallAthComplete = function(self)
  -- function num : 0_20 , upvalues : _ENV
  AudioManager:PlayAudioById(1030)
  if self.__resortAthDic == nil then
    (self.areaTableNode):OnInstallAthItem(self.__insallAthData)
  else
    ;
    (self.areaTableNode):OnReinstallAllAthTable(self.__resortAthDic, self.__athInstalledDic)
  end
  UIManager:HideWindow(UIWindowTypeID.AthItemDetail)
  self:RefreshAllAthInfo()
end

UIATH.UnInstallAth = function(self, athData)
  -- function num : 0_21 , upvalues : _ENV
  if self.__unInstallAthComplete == nil then
    self.__unInstallAthComplete = BindCallback(self, self.OnUnInstallAthComplete)
  end
  self.__uninsallAthData = athData
  self.__uninstallAthGrid = (athData.bindInfo).grid
  ;
  (self.athNetwork):CS_ATH_AthUninstall(athData.uid, self.__unInstallAthComplete)
end

UIATH.OnUnInstallAthComplete = function(self)
  -- function num : 0_22 , upvalues : _ENV
  AudioManager:PlayAudioById(1032)
  ;
  (self.areaTableNode):OnUnInstallAthItem((self.__uninsallAthData).uid, self.__uninstallAthGrid)
  UIManager:HideWindow(UIWindowTypeID.AthItemDetail)
  self:RefreshAllAthInfo()
end

UIATH.ReplaceAth = function(self, oldAthData, newAthData)
  -- function num : 0_23 , upvalues : _ENV
  local athInstallDic, athInstalledDic = (self.areaTableNode):GetTryReplaceAthDic(newAthData, oldAthData)
  if athInstallDic == nil then
    return 
  end
  local replaceGrid = nil
  for k,v in pairs(athInstallDic) do
    if newAthData.uid == k then
      replaceGrid = v
      break
    end
  end
  do
    if replaceGrid == nil then
      error("replaceGrid == nil")
      return 
    end
    self:RefillAth(newAthData, replaceGrid, athInstallDic, athInstalledDic, proto_csmsg_AthRefillOperator.AthRefillOperatorReplace)
  end
end

UIATH.MoveAth = function(self, athData, newGridPos)
  -- function num : 0_24 , upvalues : _ENV
  if self.__OnMoveAthComplete == nil then
    self.__OnMoveAthComplete = BindCallback(self, self.OnMoveAthComplete)
  end
  self.__moveAthData = athData
  self.__moveAthGrid = (athData.bindInfo).grid
  ;
  (self.athNetwork):CS_ATH_Move(athData.uid, newGridPos, self.__OnMoveAthComplete)
end

UIATH.OnMoveAthComplete = function(self)
  -- function num : 0_25
  (self.areaTableNode):OnUnInstallAthItem((self.__moveAthData).uid, self.__moveAthGrid, true)
  ;
  (self.areaTableNode):OnInstallAthItem(self.__moveAthData, true)
end

UIATH.OneKeyInstall = function(self, slotId, athGroupDic, callBack)
  -- function num : 0_26
  (self.athNetwork):CS_ATH_OneKeyInstall((self.heroData).dataId, slotId, athGroupDic, callBack)
end

UIATH.GetAthItemGameObject = function(self, space)
  -- function num : 0_27
  return (self.sortListNode):GetAthItemGo(space)
end

UIATH.OnFingerSet = function(self, finger)
  -- function num : 0_28
  self:OnDragAthItem(finger)
end

UIATH.OnFingerUp = function(self, finger)
  -- function num : 0_29
  self:OnDragAthItemEnd(finger)
end

UIATH.OnDragAthItemStart = function(self, athItem, isInTable)
  -- function num : 0_30 , upvalues : CS_LeanTouch, _ENV
  if self._dragItem ~= nil then
    return 
  end
  self._dragFromTable = isInTable
  local finger = (CS_LeanTouch.Fingers)[0]
  self._lastAthPos = athItem:GetAthItemRootPos()
  local newPos = UIManager:Screen2WorldPosition(finger.ScreenPosition, athItem:GetAthItemRoot())
  self._dragOffset = self._lastAthPos - newPos
  athItem:SetAthItemRootParent(self.transform)
  if not isInTable then
    local athData = athItem:GetAthItemData()
    local transparentItem = self:__GetTransparentAthItem(athData:GetAthSize())
    transparentItem:SetAsTransparentAthItem(athItem.transform, athData, self.resLoader)
    self._curTransparentItem = transparentItem
    local callBack = function()
    -- function num : 0_30_0 , upvalues : self
    if self._curTransparentItem ~= nil then
      self:__ReturnTransparentAthItem(self._curTransparentItem)
      self._curTransparentItem = nil
    end
  end

    athItem:SetAthItemRootParentResetFunc(callBack)
  end
  do
    self._dragItem = athItem
  end
end

UIATH.OnDragAthItem = function(self, finger)
  -- function num : 0_31 , upvalues : _ENV
  if self._dragItem == nil then
    return 
  end
  local newPos = UIManager:Screen2WorldPosition(finger.ScreenPosition, (self._dragItem):GetAthItemRoot())
  newPos = newPos + self._dragOffset
  ;
  (self._dragItem):SetAthItemPos(newPos)
end

UIATH.OnDragAthItemEnd = function(self, finger)
  -- function num : 0_32 , upvalues : _ENV
  if self._dragItem == nil then
    return 
  end
  local athData = (self._dragItem):GetAthItemData()
  local worldPos = ((self._dragItem):GetAthItemRoot()).position
  if (self.sortListNode):DragInAthSortList(worldPos) then
    if self._dragFromTable then
      self:UnInstallAth(athData)
      ;
      (self._dragItem):SetAthItemRootParent(nil, true)
      ;
      (self._dragItem):Hide()
    else
      ;
      (self._dragItem):DragEndTweenAthItem(self._lastAthPos)
    end
  else
    local gridId = (self.areaTableNode):GetAthGridIdByScreenPos(worldPos, athData)
    if gridId ~= nil then
      if self._dragFromTable then
        local canMove = (self.areaTableNode):CheckAthInstallable(athData, gridId, athData.uid)
        if canMove and gridId ~= (athData.bindInfo).grid then
          self:MoveAth(athData, gridId)
          local anchorPos = (self.areaTableNode):GetAthTableItemPos(athData, gridId)
          ;
          (self._dragItem):AthMoveTweenWithRootParent(anchorPos)
        else
          do
            do
              ;
              (self._dragItem):DragEndTweenAthItem(self._lastAthPos)
              local canInstall = (self.areaTableNode):CheckAthInstallable(athData, gridId)
              if canInstall then
                (self._dragItem):SetAthItemRootParent(nil, true)
                self:RefillAth(athData, gridId, nil, nil, proto_csmsg_AthRefillOperator.AthRefillOperatorInstall)
              else
                local replacedAthData, oneReplaceMore = (self.areaTableNode):CheckAthReplaceable(athData, gridId, true)
                if replacedAthData ~= nil then
                  (self._dragItem):SetAthItemRootParent(nil, true)
                  self:TryReplaceAth(self._dragItem, replacedAthData)
                else
                  if (self.areaTableNode):CheckAthAreaSpaceOk(athData) and not oneReplaceMore then
                    local athInstallDic, athInstalledDic = (self.areaTableNode):ReSortAthTable(athData)
                    if athInstallDic ~= nil then
                      local gridPos = athInstallDic[athData.uid]
                      ;
                      (self._dragItem):SetAthItemRootParent(nil, true)
                      self:RefillAth(athData, gridPos, athInstallDic, athInstalledDic, proto_csmsg_AthRefillOperator.AthRefillOperatorInstall)
                    else
                      do
                        do
                          do
                            do
                              ;
                              (self._dragItem):DragEndTweenAthItem(self._lastAthPos)
                              ;
                              (self._dragItem):DragEndTweenAthItem(self._lastAthPos)
                              ;
                              (self._dragItem):DragEndTweenAthItem(self._lastAthPos)
                              ;
                              (self._dragItem):OnAthItemDragEnd()
                              self._dragItem = nil
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

UIATH.__GetTransparentAthItem = function(self, space)
  -- function num : 0_33 , upvalues : UINAthListItem
  if self.__transparentAthItemDic == nil then
    self.__transparentAthItemDic = {}
  end
  local athItem = (self.__transparentAthItemDic)[space]
  if athItem == nil then
    local prefab = self:GetAthItemGameObject(space)
    local go = prefab:Instantiate()
    athItem = (UINAthListItem.New)()
    athItem:Init(go)
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self.__transparentAthItemDic)[space] = athItem
  end
  do
    return athItem
  end
end

UIATH.__ReturnTransparentAthItem = function(self, athItem)
  -- function num : 0_34 , upvalues : _ENV
  do
    if self.__transparentAthItemRoot == nil then
      local go = ((CS.UnityEngine).GameObject)("TransparentAthItemRoot")
      go:SetActive(false)
      self.__transparentAthItemRoot = go.transform
      ;
      (self.__transparentAthItemRoot):SetParent(self.transform)
    end
    for k,v in pairs(self.__transparentAthItemDic) do
      if v == athItem then
        (athItem.transform):SetParent(self.__transparentAthItemRoot)
        break
      end
    end
  end
end

UIATH.OnAthDataUpdate = function(self, updateAth, heroSlot)
  -- function num : 0_35 , upvalues : _ENV
  local refreshAllInfoOk = false
  for uid,v in pairs(updateAth) do
    local athData = ((PlayerDataCenter.allAthData).athDic)[uid]
    if athData.bindInfo ~= nil and (athData.bindInfo).id == (self.heroData).dataId then
      refreshAllInfoOk = true
      self:RefreshAllAthInfo()
      break
    end
  end
  do
    if heroSlot[(self.heroData).dataId] ~= nil then
      if not refreshAllInfoOk then
        self:RefreshAllAthInfo()
      end
      self:RefreshCurAthArea()
    end
    self:__RefreshBlueDot()
  end
end

UIATH.GetFixedAttrIdList = function(self)
  -- function num : 0_36
  return self.fixedAttrIdList
end

UIATH.InitATHTween = function(self)
  -- function num : 0_37 , upvalues : _ENV
  self.ATHTweenDic = (self.transform):GetComponentsInChildren(typeof(((CS.DG).Tweening).DOTweenAnimation))
end

UIATH.PlayATHTween = function(self)
  -- function num : 0_38
  for i = 0, (self.ATHTweenDic).Length - 1 do
    local tween = (self.ATHTweenDic)[i]
    tween:DORestart(false)
  end
end

UIATH.GetAthItemFromListMain = function(self, uid)
  -- function num : 0_39
  return (self.sortListNode):GetAthItemFromList(uid)
end

UIATH.OnDelete = function(self)
  -- function num : 0_40 , upvalues : _ENV, CS_LeanTouch, CS_Input, base
  (self.areaBtnPool):DeleteAll()
  ;
  (self.suitItemPool):DeleteAll()
  ;
  (self.attrItemPool):DeleteAll()
  ;
  (self.chartNode):Delete()
  ;
  (self.areaTableNode):Delete()
  ;
  (self.sortListNode):Delete()
  ;
  (self.suitDetailNode):Delete()
  UIManager:DeleteWindow(UIWindowTypeID.AthItemDetail)
  if self.addAllTouchFunc ~= nil then
    (self.addAllTouchFunc)()
  end
  ;
  (CS_LeanTouch.OnFingerSet)("-", self.__onFingerSet)
  ;
  (CS_LeanTouch.OnFingerUp)("-", self.__onFingerUp)
  if self._dragItem ~= nil then
    (self._dragItem):Delete()
  end
  if self.__transparentAthItemDic ~= nil then
    for k,athItem in pairs(self.__transparentAthItemDic) do
      athItem:Delete()
    end
  end
  do
    CS_Input.multiTouchEnabled = true
    MsgCenter:RemoveListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
    ;
    (base.OnDelete)(self)
  end
end

return UIATH

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIATH = class("UIATH", UIBaseWindow)
local base = UIBaseWindow
local UINAthAreaBtn = require("Game.Arithmetic.AthMain.UINAthAreaBtn")
local UINAthSuitItem = require("Game.Arithmetic.AthMain.UINAthSuitItem")
local UINAthChart = require("Game.Arithmetic.AthMain.Chart.UINAthChart")
local UINAthTable = require("Game.Arithmetic.AthMain.Table.UINAthTable")
local UINAthSortList = require("Game.Arithmetic.AthSortList.UINAthSortList")
local UINAthSuitDetail = require(
                             "Game.Arithmetic.AthSuitDetail.UINAthSuitDetail")
local UINAthMainAtrrItem = require("Game.Arithmetic.AthMain.UINAthMainAtrrItem")
local AthFilterEnum = require("Game.Arithmetic.AthSortList.AthFilterEnum")
local UINAthListItem = require("Game.Arithmetic.AthSortList.UINAthListItem")
local cs_MessageCommon = CS.MessageCommon
local CS_LeanTouch = ((CS.Lean).Touch).LeanTouch
local CS_Input = (CS.UnityEngine).Input
UIATH.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, CS_LeanTouch, CS_Input, UINAthAreaBtn, UINAthSuitItem, UINAthMainAtrrItem, UINAthChart, UINAthTable, UINAthSortList, UINAthSuitDetail
    (UIUtil.CreateTopBtnGroup)((self.ui).topButtonGroup, self,
                               self.__OnClickBack);
    (UIUtil.AddButtonListener)((self.ui).btn_Efficiency, self,
                               self.__OnClickEfficiency);
    (UIUtil.AddButtonListener)((self.ui).btn_EfficiencyAttr, self,
                               self.__OnClickAfficiencyAttr);
    (UIUtil.AddButtonListener)((self.ui).btn_OneKeyInstall, self,
                               self.__OnClickOneKeyInstall);
    (UIUtil.AddButtonListener)((self.ui).btn_OneKeyUninstall, self,
                               self.__OnClickOneKeyUninstall);
    (((self.ui).btn_OneKeyInstall).gameObject):SetActive(false);
    (((self.ui).btn_OneKeyUninstall).gameObject):SetActive(false)
    self.__OnClickAthItem = BindCallback(self, self.OnClickAthItem)
    self.__OnClickSuit = BindCallback(self, self.OnClickSuit)
    self.__InstallAth = BindCallback(self, self.InstallAth)
    self.__UnInstallAth = BindCallback(self, self.UnInstallAth)
    self.__ReplaceAth = BindCallback(self, self.ReplaceAth)
    self.__OnDragStart = BindCallback(self, self.OnDragAthItemStart)
    self.__onAthDataUpdate = BindCallback(self, self.OnAthDataUpdate)
    self.__getAthItemFromList = BindCallback(self, self.GetAthItemFromListMain)
    self.__onFingerSet = BindCallback(self, self.OnFingerSet)
    self.__onFingerUp = BindCallback(self, self.OnFingerUp);
    (CS_LeanTouch.OnFingerSet)("+", self.__onFingerSet);
    (CS_LeanTouch.OnFingerUp)("+", self.__onFingerUp)
    CS_Input.multiTouchEnabled = false;
    ((self.ui).areaItem):SetActive(false)
    self.areaBtnPool = (UIItemPool.New)(UINAthAreaBtn, (self.ui).areaItem);
    ((self.ui).suitItem):SetActive(false)
    self.suitItemPool = (UIItemPool.New)(UINAthSuitItem, (self.ui).suitItem);
    ((self.ui).attriItem):SetActive(false)
    self.attrItemPool =
        (UIItemPool.New)(UINAthMainAtrrItem, (self.ui).attriItem)
    self.chartNode = (UINAthChart.New)();
    (self.chartNode):Init((self.ui).chartNode);
    (self.chartNode):Show()
    self.areaTableNode = (UINAthTable.New)(self, self.__OnDragStart);
    (self.areaTableNode):Init((self.ui).tableNode);
    (self.areaTableNode):Hide()
    self.sortListNode = (UINAthSortList.New)();
    (self.sortListNode):Init((self.ui).aTHListNode);
    (self.sortListNode):SetAthItemStartDragFunc(self.__OnDragStart);
    (self.sortListNode):Hide()
    self.suitDetailNode = (UINAthSuitDetail.New)();
    (self.suitDetailNode):Init((self.ui).suitDetailNode);
    (self.suitDetailNode):Hide()
    self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
    MsgCenter:AddListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
    self._isEfficencyAttr = true
    self:__RefreshAfficiencyAttr()
    self:InitATHTween()
end

UIATH.InitAth = function(self, heroData, resLader, heroResLoader,
                         addAllTouchFunc)
    -- function num : 0_1 , upvalues : _ENV
    self.heroData = heroData
    self.resLoader = resLader
    self.heroResLoader = heroResLoader
    self.addAllTouchFunc = addAllTouchFunc;
    (self.heroResLoader):LoadABAssetAsync(
        PathConsts:GetCharacterBigImgPrefabPath(heroData:GetResName()),
        function(prefab)
            -- function num : 0_1_0 , upvalues : self, _ENV
            self.bigImgGameObject = prefab:Instantiate((self.ui).heroHolder)
            local commonPicCtrl = (self.bigImgGameObject):FindComponent(
                                      eUnityComponentID.CommonPicController)
            commonPicCtrl:SetPosType("HeroList")
        end)
    self.__OnClickAreaBtn = BindCallback(self, self.OnClickAreaBtn)
    local athAreaMaxSpaceList = (self.heroData):GetAthSlotList(true)
    do
        for k, maxSpace in ipairs(athAreaMaxSpaceList) do
            local btnItem = (self.areaBtnPool):GetOne()
            btnItem:InitAthAreaBtn(k, (self.heroData).dataId,
                                   self.__OnClickAreaBtn)
        end
    end
    self:RefreshAllAthInfo(true)
    self:__RefreshBlueDot()
    self:PlayATHTween()
    if (PlayerDataCenter.allAthData).athReconsitutionData ~= nil then
        local athData =
            ((PlayerDataCenter.allAthData).athDic)[((PlayerDataCenter.allAthData).athReconsitutionData).uid]
        UIManager:ShowWindowAsync(UIWindowTypeID.AthStrengthen, function(window)
            -- function num : 0_1_1 , upvalues : athData, self
            if window == nil then return end
            window:InitAthStrengthen(athData, self.heroData)
        end)
    end
end

UIATH.__RefreshBlueDot = function(self)
    -- function num : 0_2 , upvalues : _ENV
    for slotIndex, btnItem in ipairs((self.areaBtnPool).listItem) do
        btnItem:ShowAthAreaBtnBlueDot(
            (PlayerDataCenter.allAthData):GetHeroCanLoadedSlot(self.heroData,
                                                               slotIndex))
    end
end

UIATH.RefreshAllAthInfo = function(self, changeAttrSort)
    -- function num : 0_3 , upvalues : _ENV
    local areaLevel = (PlayerDataCenter.allAthData):GetHeroAthSlotInfo(
                          (self.heroData).dataId)
    local areaEfcc = (PlayerDataCenter.allAthData):GetAthEfficiency(areaLevel)
    self.areaEfficiency = areaEfcc -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'
    ;
    ((self.ui).tex_EffNum).text = (string.format)("%.1f", areaEfcc / 1000)
    local athAreaMaxSpaceList = (self.heroData):GetAthSlotList(true)
    self.athAreaMaxSpaceList = athAreaMaxSpaceList
    local athAreaCurSpaceList = (self.heroData):GetAthSlotList()
    self.athAreaCurSpaceList = athAreaCurSpaceList;
    (self.chartNode):InitAthChart((self.heroData).dataId, athAreaCurSpaceList,
                                  athAreaMaxSpaceList)
    for k, v in ipairs((self.areaBtnPool).listItem) do
        local curSpace = athAreaCurSpaceList[k]
        v:RefreshAthAreaBtn(curSpace)
    end
    self:RefreshAthAttr(athAreaCurSpaceList, self.curSlotId, changeAttrSort)
end

UIATH.RefreshAthAttr = function(self, athSlotList, curSlotId, changeSort)
    -- function num : 0_4 , upvalues : _ENV, AthFilterEnum
    local allAttrDic, slotAttrTab, suitDic, allAttrDicNoEfcc, slotAttrTabNoEfcc =
        (PlayerDataCenter.allAthData):GetHeroAthAttr((self.heroData).dataId)
    local fightPower =
        (PlayerDataCenter.allAthData):GetAthFightPower(allAttrDic) -- DECOMPILER ERROR at PC16: Confused about usage of register: R10 in 'UnsetPending'
    ;
    ((self.ui).tex_Power).text = tostring(fightPower)
    local isAllAttr = slotAttrTab[curSlotId] == nil
    self.attrValueDic = self:__MergeAttr(allAttrDic, isAllAttr, slotAttrTab,
                                         curSlotId)
    self.attrValueNoEfccDic = self:__MergeAttr(allAttrDicNoEfcc, isAllAttr,
                                               slotAttrTabNoEfcc, curSlotId)
    local maxShowCount = (self.ui).maxAttrCount
    if self.attrIdSortList == nil or changeSort then
        local idSortList = {}
        self.attrIdSortList = {}
        local count = 1
        for k, attrId in ipairs((ConfigData.attribute).baseAttrIds) do
            -- DECOMPILER ERROR at PC65: Unhandled construct in 'MakeBoolean' P1

            if ((ConfigData.attribute)[attrId]).merge_attribute == 0 and
                maxShowCount >= count then
                do
                    (table.insert)(idSortList, attrId);
                    (table.insert)(self.attrIdSortList, attrId)
                    count = count + 1
                    -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_STMT

                end
            end
        end
        (AthFilterEnum.SetEAttribute)(idSortList)
        for k, attrId in ipairs(idSortList) do
            local value = (self.attrValueDic)[attrId]
            if value == 0 then
                (table.removebyvalue)(self.attrIdSortList, attrId);
                (table.insert)(self.attrIdSortList, attrId)
            end
        end
    end
    (self.attrItemPool):HideAll()
    local isEmpty = true
    for k, attrId in ipairs(self.attrIdSortList) do
        local value = (self.attrValueDic)[attrId]
        local attrItem = (self.attrItemPool):GetOne()
        if value ~= nil and value ~= 0 then
            attrItem:InitAthMainAtrrItem(attrId, value)
            isEmpty = false
        else
            (attrItem.gameObject):SetActive(false)
        end
    end
    ((self.ui).obj_Attribute):SetActive(not isEmpty);
    ((self.ui).obj_EmptyAttri):SetActive(isEmpty);
    (((self.ui).btn_EfficiencyAttr).gameObject):SetActive(not isEmpty)
    self.heroSuitDic = {}
    local suitIdList = {}
    for suitId, suitData in pairs(suitDic) do
        (table.insert)(suitIdList, suitId) -- DECOMPILER ERROR at PC160: Confused about usage of register: R19 in 'UnsetPending'
        ;
        (self.heroSuitDic)[suitId] = {
            suitCount = suitData.curCount,
            athDataDic = suitData.suitAthDic
        }
    end
    (table.sort)(suitIdList);
    (self.suitItemPool):HideAll()
    for k, suitId in ipairs(suitIdList) do
        local suitData = suitDic[suitId]
        local suitItem = (self.suitItemPool):GetOne()
        suitItem:InitAthSuitItem(suitData, self.resLoader, self.__OnClickSuit)
    end
    ((self.ui).emptySuit):SetActive(#suitIdList == 0)
    -- DECOMPILER ERROR: 11 unprocessed JMP targets
end

UIATH.__MergeAttr =
    function(self, allAttrDic, isAllAttr, slotAttrTab, curSlotId)
        -- function num : 0_5 , upvalues : _ENV
        local valueDic = (table.GetDefaulValueTable)(0)
        local allAttrIdList = {}
        for k, v in pairs(allAttrDic) do (table.insert)(allAttrIdList, k) end
        for k, attrId in ipairs(allAttrIdList) do
            local attrConfig = (ConfigData.attribute)[attrId]
            if attrConfig.merge_attribute ~= 0 then
                local mergeID = attrConfig.merge_attribute
                if attrConfig.num_type == 2 then
                    if isAllAttr then
                        valueDic[mergeID] =
                            valueDic[mergeID] + allAttrDic[attrId] *
                                (self.heroData):GetAttr(mergeID, true) // 1000
                    else
                        valueDic[mergeID] =
                            valueDic[mergeID] +
                                ((slotAttrTab[curSlotId])[attrId] or 0) *
                                (self.heroData):GetAttr(mergeID, true) // 1000
                    end
                else
                    if isAllAttr then
                        valueDic[mergeID] =
                            valueDic[mergeID] + allAttrDic[attrId]
                    else
                        valueDic[mergeID] =
                            valueDic[mergeID] +
                                ((slotAttrTab[curSlotId])[attrId] or 0)
                    end
                end
            else
                do
                    do
                        if attrConfig.num_type == 2 then
                            if attrId > 17 then
                                if isAllAttr then
                                    valueDic[attrId] = allAttrDic[attrId]
                                else
                                    valueDic[attrId] =
                                        (slotAttrTab[curSlotId])[attrId] or 0
                                end
                            else
                                if isAllAttr then
                                    valueDic[attrId] =
                                        valueDic[attrId] + allAttrDic[attrId]
                                else
                                    valueDic[attrId] =
                                        valueDic[attrId] +
                                            ((slotAttrTab[curSlotId])[attrId] or
                                                0)
                                end
                            end
                        else
                            if isAllAttr then
                                valueDic[attrId] =
                                    valueDic[attrId] + allAttrDic[attrId]
                            else
                                valueDic[attrId] =
                                    valueDic[attrId] +
                                        ((slotAttrTab[curSlotId])[attrId] or 0)
                            end
                        end
                        -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                        -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_STMT

                    end
                end
            end
        end
        return valueDic
    end

UIATH.__OnClickAfficiencyAttr = function(self)
    -- function num : 0_6
    self._isEfficencyAttr = not self._isEfficencyAttr
    self:__RefreshAfficiencyAttr()
end

UIATH.__OnClickOneKeyInstall = function(self)
    -- function num : 0_7 , upvalues : _ENV
    if self.curSlotId == nil then return end
    local athList = (PlayerDataCenter.allAthData):GetAllAthSlotList(
                        self.curSlotId, nil, true, (self.heroData).dataId);
    (table.sort)(athList, function(a, b)
        -- function num : 0_7_0
        local qualityA = a:GetAthQuality()
        local qualityB = b:GetAthQuality()
        local spaceA = a:GetAthSize()
        local spaceB = b:GetAthSize()
        local powerA = a:GetAthFightPower()
        local powerB = b:GetAthFightPower()
        if spaceA == spaceB then
            if spaceB >= spaceA then
                do return qualityA ~= qualityB end
                do return powerB < powerA end
                do return qualityB < qualityA end
                -- DECOMPILER ERROR: 6 unprocessed JMP targets
            end
        end
    end);
    (self.areaTableNode):OneKeyInstallAthTable(athList)
end

UIATH.__OnClickOneKeyUninstall = function(self)
    -- function num : 0_8 , upvalues : _ENV
    if self.curSlotId == nil then return end
    local installedDic = (self.areaTableNode):RecordAthInstalledDic()
    if (table.count)(installedDic) == 0 then return end
    (self.athNetwork):CS_ATH_OneKeyUninstall((self.heroData).dataId,
                                             self.curSlotId, function()
        -- function num : 0_8_0 , upvalues : _ENV, self
        AudioManager:PlayAudioById(1032);
        (self.areaTableNode):OnOneKeyUninstallComplete()
    end)
end

UIATH.__RefreshAfficiencyAttr = function(self)
    -- function num : 0_9 , upvalues : _ENV

    ((self.ui).tex_EfficiencyAttr):SetIndex(self._isEfficencyAttr and 0 or 1)
    if self.attrValueDic == nil then return end
    for k, attrId in ipairs(self.attrIdSortList) do
        local value = nil
        if self._isEfficencyAttr then
            value = (self.attrValueDic)[attrId]
        else
            value = (self.attrValueNoEfccDic)[attrId]
        end
        local attrItem = ((self.attrItemPool).listItem)[k]
        attrItem:InitAthMainAtrrItem(attrId, value)
    end
end

UIATH.__OnClickEfficiency = function(self)
    -- function num : 0_10 , upvalues : _ENV
    UIManager:ShowWindowAsync(UIWindowTypeID.AthEfficiency, function(window)
        -- function num : 0_10_0 , upvalues : self
        if window == nil then return end
        window:InitAthAthEfcc(self.heroData, self.heroResLoader)
    end)
end

UIATH.__OnClickBack = function(self)
    -- function num : 0_11 , upvalues : _ENV
    if (self.areaTableNode).active then
        (self.areaTableNode):Hide();
        (self.sortListNode):Hide();
        (self.chartNode):Show();
        (((self.ui).heroHolder).gameObject):SetActive(true)
        self.curSlotId = nil
        for k, areaBtnItem in ipairs((self.areaBtnPool).listItem) do
            areaBtnItem:ResetAthAreaBtnSelect()
        end -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'
        
        ((self.ui).efficiency_cg).alpha = 1 -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'
        ;
        ((self.ui).efficiency_cg).blocksRaycasts = true;
        (((self.ui).btn_OneKeyInstall).gameObject):SetActive(false);
        (((self.ui).btn_OneKeyUninstall).gameObject):SetActive(false)
        self:RefreshAllAthInfo(true)
        return false
    else
        UIManager:ShowWindow(UIWindowTypeID.HeroState)
        self:Delete()
    end
end

UIATH.OnClickAreaBtn = function(self, index)
    -- function num : 0_12 , upvalues : _ENV
    (self.chartNode):Hide();
    (((self.ui).heroHolder).gameObject):SetActive(false)
    self.curSlotId = index
    for k, areaBtnItem in ipairs((self.areaBtnPool).listItem) do
        if k == index then
            areaBtnItem:AthAreaBtnSelect(true)
            local maxSpace = (self.athAreaMaxSpaceList)[index]
            local space = (self.athAreaCurSpaceList)[index];
            (self.areaTableNode):Show();
            (self.areaTableNode):InitAthTable(self.heroData, index, space,
                                              maxSpace, self.resLoader);
            (self.sortListNode):Show();
            (self.sortListNode):SetAthListInstallSortFuncSet();
            (self.sortListNode):InitAthSortListNode(self.heroData, false,
                                                    self.__OnClickAthItem, index)
        else
            do
                do
                    areaBtnItem:AthAreaBtnSelect(false)
                    -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                    -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_STMT

                end
            end
        end
    end -- DECOMPILER ERROR at PC56: Confused about usage of register: R2 in 'UnsetPending'
    
    ((self.ui).efficiency_cg).alpha = 0.1 -- DECOMPILER ERROR at PC59: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).efficiency_cg).blocksRaycasts = false;
    (((self.ui).btn_OneKeyInstall).gameObject):SetActive(true);
    (((self.ui).btn_OneKeyUninstall).gameObject):SetActive(true)
    self:RefreshAllAthInfo(true)
end

UIATH.RefreshCurAthArea = function(self)
    -- function num : 0_13
    if self.curSlotId ~= nil then
        local maxSpace = (self.athAreaMaxSpaceList)[self.curSlotId]
        local space = (self.athAreaCurSpaceList)[self.curSlotId];
        (self.areaTableNode):InitAthTable(self.heroData, self.curSlotId, space,
                                          maxSpace, self.resLoader)
    end
end

UIATH.OnClickAthItem = function(self, athItem, inAthTable)
    -- function num : 0_14
    self:TryInstallAth(athItem, inAthTable)
end

UIATH.OnClickSuit = function(self, suitId)
    -- function num : 0_15
    (self.suitDetailNode):Show();
    (self.suitDetailNode):InitAthSuitDetail(self.resLoader, self.heroSuitDic,
                                            suitId)
end

UIATH.TryInstallAth = function(self, athItem, inAthTable)
    -- function num : 0_16 , upvalues : _ENV
    UIManager:ShowWindowAsync(UIWindowTypeID.AthItemDetail, function(window)
        -- function num : 0_16_0 , upvalues : athItem, _ENV, self, inAthTable
        if window == nil then return end
        local athData = athItem:GetAthItemData()
        if (PlayerDataCenter.allAthData):HeroContainAthByUid(
            (self.heroData).dataId, athData.uid) then
            athItem = (self.areaTableNode):GetAthTableItemByUid(athData.uid)
        end
        window:SetAthItemDetailFunc(self.__InstallAth, self.__UnInstallAth,
                                    self.__ReplaceAth)
        window:InitAthItemDetail(self.heroData, athData, nil)
        if inAthTable then
            window:ChangeAthItemParent(athItem, nil)
        else
            window:ChangeAthItemParent(athItem, self.__getAthItemFromList)
        end
    end)
end

UIATH.TryReplaceAth = function(self, athItem, replacedAthData)
    -- function num : 0_17 , upvalues : _ENV
    UIManager:ShowWindowAsync(UIWindowTypeID.AthItemDetail, function(window)
        -- function num : 0_17_0 , upvalues : athItem, self, replacedAthData
        if window == nil then return end
        local athData = athItem:GetAthItemData()
        window:SetAthItemDetailFunc(self.__InstallAth, self.__UnInstallAth,
                                    self.__ReplaceAth)
        window:InitAthItemDetail(self.heroData, athData, replacedAthData)
        window:ChangeAthItemParent(athItem, self.__getAthItemFromList)
    end)
end

UIATH.InstallAth = function(self, athData)
    -- function num : 0_18 , upvalues : _ENV
    self:RefillAth(athData, nil, nil, nil,
                   proto_csmsg_AthRefillOperator.AthRefillOperatorInstall)
end

UIATH.RefillAth = function(self, athData, gridId, resortAthDic, athInstalledDic,
                           refillOp)
    -- function num : 0_19 , upvalues : _ENV, cs_MessageCommon
    if self.curSlotId == nil then return end
    local athDataList = (PlayerDataCenter.allAthData):GetHeroAthList(
                            (self.heroData).dataId, self.curSlotId)
    for k, v in ipairs(athDataList) do
        if refillOp == proto_csmsg_AthRefillOperator.AthRefillOperatorInstall and
            v.id == athData.id then
            (cs_MessageCommon.ShowMessageTips)(
                ConfigData:GetTipContent(TipContent.arithmetic_RepeatedATH))
            return
        end
        if refillOp == proto_csmsg_AthRefillOperator.AthRefillOperatorReplace and
            (v.uid == athData.uid or v.id ~= athData.id or (v.bindInfo).grid ~=
                gridId) then
            (cs_MessageCommon.ShowMessageTips)(
                ConfigData:GetTipContent(TipContent.arithmetic_RepeatedATH))
            return
        end
    end
    if gridId == nil then
        gridId = (self.areaTableNode):GetAthInstallableGrid(athData)
        if gridId == nil then
            local canInstall = false
            do
                do
                    if (self.areaTableNode):CheckAthAreaSpaceOk(athData) then
                        local athInstallDic, installedDic =
                            (self.areaTableNode):ReSortAthTable(athData)
                        if athInstallDic ~= nil then
                            gridId = athInstallDic[athData.uid]
                            resortAthDic = athInstallDic
                            athInstalledDic = installedDic
                            canInstall = true
                        end
                    end
                    if not canInstall then
                        (cs_MessageCommon.ShowMessageTips)(
                            ConfigData:GetTipContent(TipContent.Ath_CantInstall))
                        return
                    end
                    if self.__onInstallComplete == nil then
                        self.__onInstallComplete =
                            BindCallback(self, self.OnInstallAthComplete)
                    end
                    local installFunc = function()
                        -- function num : 0_19_0 , upvalues : self, athData, resortAthDic, athInstalledDic, _ENV, gridId, refillOp
                        self.__insallAthData = athData
                        self.__resortAthDic = resortAthDic
                        self.__athInstalledDic = athInstalledDic
                        local oldMoveDic = nil
                        if resortAthDic ~= nil then
                            oldMoveDic = {}
                            for uid, gridId in pairs(resortAthDic) do
                                if uid ~= athData.uid then
                                    oldMoveDic[uid] = gridId
                                end
                            end
                        end
                        do

                            (self.athNetwork):CS_ATH_AthRefillOp(
                                (self.heroData).dataId, self.curSlotId,
                                athData.uid, gridId, oldMoveDic, refillOp,
                                self.__onInstallComplete)
                        end
                    end

                    if athData.bindInfo ~= nil and (athData.bindInfo).id ~=
                        (self.heroData).id then
                        UIManager:ShowWindowAsync(UIWindowTypeID.AthReplaceHero,
                                                  function(window)
                            -- function num : 0_19_1 , upvalues : self, athData, installFunc
                            if window == nil then
                                return
                            end
                            window:InitAthReplaceHero((self.heroData).dataId,
                                                      (athData.bindInfo).id,
                                                      installFunc,
                                                      self.resLoader)
                        end)
                    else
                        installFunc()
                    end
                end
            end
        end
    end
end

UIATH.OnInstallAthComplete = function(self)
    -- function num : 0_20 , upvalues : _ENV
    AudioManager:PlayAudioById(1030)
    if self.__resortAthDic == nil then
        (self.areaTableNode):OnInstallAthItem(self.__insallAthData)
    else

        (self.areaTableNode):OnReinstallAllAthTable(self.__resortAthDic,
                                                    self.__athInstalledDic)
    end
    UIManager:HideWindow(UIWindowTypeID.AthItemDetail)
    self:RefreshAllAthInfo()
end

UIATH.UnInstallAth = function(self, athData)
    -- function num : 0_21 , upvalues : _ENV
    if self.__unInstallAthComplete == nil then
        self.__unInstallAthComplete = BindCallback(self,
                                                   self.OnUnInstallAthComplete)
    end
    self.__uninsallAthData = athData
    self.__uninstallAthGrid = (athData.bindInfo).grid;
    (self.athNetwork):CS_ATH_AthUninstall(athData.uid,
                                          self.__unInstallAthComplete)
end

UIATH.OnUnInstallAthComplete = function(self)
    -- function num : 0_22 , upvalues : _ENV
    AudioManager:PlayAudioById(1032);
    (self.areaTableNode):OnUnInstallAthItem((self.__uninsallAthData).uid,
                                            self.__uninstallAthGrid)
    UIManager:HideWindow(UIWindowTypeID.AthItemDetail)
    self:RefreshAllAthInfo()
end

UIATH.ReplaceAth = function(self, oldAthData, newAthData)
    -- function num : 0_23 , upvalues : _ENV
    local athInstallDic, athInstalledDic =
        (self.areaTableNode):GetTryReplaceAthDic(newAthData, oldAthData)
    if athInstallDic == nil then return end
    local replaceGrid = nil
    for k, v in pairs(athInstallDic) do
        if newAthData.uid == k then
            replaceGrid = v
            break
        end
    end
    do
        if replaceGrid == nil then
            error("replaceGrid == nil")
            return
        end
        self:RefillAth(newAthData, replaceGrid, athInstallDic, athInstalledDic,
                       proto_csmsg_AthRefillOperator.AthRefillOperatorReplace)
    end
end

UIATH.MoveAth = function(self, athData, newGridPos)
    -- function num : 0_24 , upvalues : _ENV
    if self.__OnMoveAthComplete == nil then
        self.__OnMoveAthComplete = BindCallback(self, self.OnMoveAthComplete)
    end
    self.__moveAthData = athData
    self.__moveAthGrid = (athData.bindInfo).grid;
    (self.athNetwork):CS_ATH_Move(athData.uid, newGridPos,
                                  self.__OnMoveAthComplete)
end

UIATH.OnMoveAthComplete = function(self)
    -- function num : 0_25
    (self.areaTableNode):OnUnInstallAthItem((self.__moveAthData).uid,
                                            self.__moveAthGrid, true);
    (self.areaTableNode):OnInstallAthItem(self.__moveAthData, true)
end

UIATH.OneKeyInstall = function(self, slotId, athGroupDic, callBack)
    -- function num : 0_26
    (self.athNetwork):CS_ATH_OneKeyInstall((self.heroData).dataId, slotId,
                                           athGroupDic, callBack)
end

UIATH.GetAthItemGameObject = function(self, space)
    -- function num : 0_27
    return (self.sortListNode):GetAthItemGo(space)
end

UIATH.OnFingerSet = function(self, finger)
    -- function num : 0_28
    self:OnDragAthItem(finger)
end

UIATH.OnFingerUp = function(self, finger)
    -- function num : 0_29
    self:OnDragAthItemEnd(finger)
end

UIATH.OnDragAthItemStart = function(self, athItem, isInTable)
    -- function num : 0_30 , upvalues : CS_LeanTouch, _ENV
    if self._dragItem ~= nil then return end
    self._dragFromTable = isInTable
    local finger = (CS_LeanTouch.Fingers)[0]
    self._lastAthPos = athItem:GetAthItemRootPos()
    local newPos = UIManager:Screen2WorldPosition(finger.ScreenPosition,
                                                  athItem:GetAthItemRoot())
    self._dragOffset = self._lastAthPos - newPos
    athItem:SetAthItemRootParent(self.transform)
    if not isInTable then
        local athData = athItem:GetAthItemData()
        local transparentItem = self:__GetTransparentAthItem(
                                    athData:GetAthSize())
        transparentItem:SetAsTransparentAthItem(athItem.transform, athData,
                                                self.resLoader)
        self._curTransparentItem = transparentItem
        local callBack = function()
            -- function num : 0_30_0 , upvalues : self
            if self._curTransparentItem ~= nil then
                self:__ReturnTransparentAthItem(self._curTransparentItem)
                self._curTransparentItem = nil
            end
        end

        athItem:SetAthItemRootParentResetFunc(callBack)
    end
    do self._dragItem = athItem end
end

UIATH.OnDragAthItem = function(self, finger)
    -- function num : 0_31 , upvalues : _ENV
    if self._dragItem == nil then return end
    local newPos = UIManager:Screen2WorldPosition(finger.ScreenPosition,
                                                  (self._dragItem):GetAthItemRoot())
    newPos = newPos + self._dragOffset;
    (self._dragItem):SetAthItemPos(newPos)
end

UIATH.OnDragAthItemEnd = function(self, finger)
    -- function num : 0_32 , upvalues : _ENV
    if self._dragItem == nil then return end
    local athData = (self._dragItem):GetAthItemData()
    local worldPos = ((self._dragItem):GetAthItemRoot()).position
    if (self.sortListNode):DragInAthSortList(worldPos) then
        if self._dragFromTable then
            self:UnInstallAth(athData);
            (self._dragItem):SetAthItemRootParent(nil, true);
            (self._dragItem):Hide()
        else

            (self._dragItem):DragEndTweenAthItem(self._lastAthPos)
        end
    else
        local gridId = (self.areaTableNode):GetAthGridIdByScreenPos(worldPos,
                                                                    athData)
        if gridId ~= nil then
            if self._dragFromTable then
                local canMove = (self.areaTableNode):CheckAthInstallable(
                                    athData, gridId, athData.uid)
                if canMove and gridId ~= (athData.bindInfo).grid then
                    self:MoveAth(athData, gridId)
                    local anchorPos = (self.areaTableNode):GetAthTableItemPos(
                                          athData, gridId);
                    (self._dragItem):AthMoveTweenWithRootParent(anchorPos)
                else
                    do
                        do

                            (self._dragItem):DragEndTweenAthItem(
                                self._lastAthPos)
                            local canInstall =
                                (self.areaTableNode):CheckAthInstallable(
                                    athData, gridId)
                            if canInstall then
                                (self._dragItem):SetAthItemRootParent(nil, true)
                                self:RefillAth(athData, gridId, nil, nil,
                                               proto_csmsg_AthRefillOperator.AthRefillOperatorInstall)
                            else
                                local replacedAthData, oneReplaceMore =
                                    (self.areaTableNode):CheckAthReplaceable(
                                        athData, gridId, true)
                                if replacedAthData ~= nil then
                                    (self._dragItem):SetAthItemRootParent(nil,
                                                                          true)
                                    self:TryReplaceAth(self._dragItem,
                                                       replacedAthData)
                                else
                                    if (self.areaTableNode):CheckAthAreaSpaceOk(
                                        athData) and not oneReplaceMore then
                                        local athInstallDic, athInstalledDic =
                                            (self.areaTableNode):ReSortAthTable(
                                                athData)
                                        if athInstallDic ~= nil then
                                            local gridPos =
                                                athInstallDic[athData.uid];
                                            (self._dragItem):SetAthItemRootParent(
                                                nil, true)
                                            self:RefillAth(athData, gridPos,
                                                           athInstallDic,
                                                           athInstalledDic,
                                                           proto_csmsg_AthRefillOperator.AthRefillOperatorInstall)
                                        else
                                            do
                                                do
                                                    do
                                                        do

                                                            (self._dragItem):DragEndTweenAthItem(
                                                                self._lastAthPos);
                                                            (self._dragItem):DragEndTweenAthItem(
                                                                self._lastAthPos);
                                                            (self._dragItem):DragEndTweenAthItem(
                                                                self._lastAthPos);
                                                            (self._dragItem):OnAthItemDragEnd()
                                                            self._dragItem = nil
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

UIATH.__GetTransparentAthItem = function(self, space)
    -- function num : 0_33 , upvalues : UINAthListItem
    if self.__transparentAthItemDic == nil then
        self.__transparentAthItemDic = {}
    end
    local athItem = (self.__transparentAthItemDic)[space]
    if athItem == nil then
        local prefab = self:GetAthItemGameObject(space)
        local go = prefab:Instantiate()
        athItem = (UINAthListItem.New)()
        athItem:Init(go) -- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'
        ;
        (self.__transparentAthItemDic)[space] = athItem
    end
    do return athItem end
end

UIATH.__ReturnTransparentAthItem = function(self, athItem)
    -- function num : 0_34 , upvalues : _ENV
    do
        if self.__transparentAthItemRoot == nil then
            local go = ((CS.UnityEngine).GameObject)("TransparentAthItemRoot")
            go:SetActive(false)
            self.__transparentAthItemRoot = go.transform;
            (self.__transparentAthItemRoot):SetParent(self.transform)
        end
        for k, v in pairs(self.__transparentAthItemDic) do
            if v == athItem then
                (athItem.transform):SetParent(self.__transparentAthItemRoot)
                break
            end
        end
    end
end

UIATH.OnAthDataUpdate = function(self, updateAth, heroSlot)
    -- function num : 0_35 , upvalues : _ENV
    local refreshAllInfoOk = false
    for uid, v in pairs(updateAth) do
        local athData = ((PlayerDataCenter.allAthData).athDic)[uid]
        if athData.bindInfo ~= nil and (athData.bindInfo).id ==
            (self.heroData).dataId then
            refreshAllInfoOk = true
            self:RefreshAllAthInfo()
            break
        end
    end
    do
        if heroSlot[(self.heroData).dataId] ~= nil then
            if not refreshAllInfoOk then self:RefreshAllAthInfo() end
            self:RefreshCurAthArea()
        end
        self:__RefreshBlueDot()
    end
end

UIATH.GetFixedAttrIdList = function(self)
    -- function num : 0_36
    return self.fixedAttrIdList
end

UIATH.InitATHTween = function(self)
    -- function num : 0_37 , upvalues : _ENV
    self.ATHTweenDic = (self.transform):GetComponentsInChildren(
                           typeof(((CS.DG).Tweening).DOTweenAnimation))
end

UIATH.PlayATHTween = function(self)
    -- function num : 0_38
    for i = 0, (self.ATHTweenDic).Length - 1 do
        local tween = (self.ATHTweenDic)[i]
        tween:DORestart(false)
    end
end

UIATH.GetAthItemFromListMain = function(self, uid)
    -- function num : 0_39
    return (self.sortListNode):GetAthItemFromList(uid)
end

UIATH.OnDelete = function(self)
    -- function num : 0_40 , upvalues : _ENV, CS_LeanTouch, CS_Input, base
    (self.areaBtnPool):DeleteAll();
    (self.suitItemPool):DeleteAll();
    (self.attrItemPool):DeleteAll();
    (self.chartNode):Delete();
    (self.areaTableNode):Delete();
    (self.sortListNode):Delete();
    (self.suitDetailNode):Delete()
    UIManager:DeleteWindow(UIWindowTypeID.AthItemDetail)
    if self.addAllTouchFunc ~= nil then (self.addAllTouchFunc)() end
    (CS_LeanTouch.OnFingerSet)("-", self.__onFingerSet);
    (CS_LeanTouch.OnFingerUp)("-", self.__onFingerUp)
    if self._dragItem ~= nil then (self._dragItem):Delete() end
    if self.__transparentAthItemDic ~= nil then
        for k, athItem in pairs(self.__transparentAthItemDic) do
            athItem:Delete()
        end
    end
    do
        CS_Input.multiTouchEnabled = true
        MsgCenter:RemoveListener(eMsgEventId.OnAthDataUpdate,
                                 self.__onAthDataUpdate);
        (base.OnDelete)(self)
    end
end

return UIATH


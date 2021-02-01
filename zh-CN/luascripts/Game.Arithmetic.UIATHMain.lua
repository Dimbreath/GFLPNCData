-- params : ...
-- function num : 0 , upvalues : _ENV
local UIATHMain = class("UIATHMain", UIBaseWindow)
local base = UIBaseWindow
local UINAthList = require("Game.Arithmetic.AthList.UINAthList")
local UINAthAreaItem = require("Game.Arithmetic.AthArea.UINAthAreaItem")
local UINAthItem = require("Game.Arithmetic.AthList.Area.UINAthItem")
local AthFilterEnum = require("Game.Arithmetic.AthSortList.AthFilterEnum")
local UINAthMainAtrrItem = require("Game.Arithmetic.AthMain.UINAthMainAtrrItem")
local UINAthSuitMainItem = require("Game.Arithmetic.AthMain.UINAthSuitMainItem")
local UINAthSuitDetail = require("Game.Arithmetic.AthSuitDetail.UINAthSuitDetail")
local UINAthInfoTogItem = require("Game.Arithmetic.AthMain.UINAthInfoTogItem")
local AthUtil = require("Game.Arithmetic.AthUtil")
local AthAreaGridData = require("Game.Arithmetic.Data.AthAreaGridData")
local cs_MessageCommon = CS.MessageCommon
local CS_LeanTouch = ((CS.Lean).Touch).LeanTouch
local CS_Input = (CS.UnityEngine).Input
local athInfoState = {BaseAttr = 1, AdditionAttr = 2, Suit = 3}
local oneKeyUninstallSlotList = {}
for i = 1, (ConfigData.game_config).athSlotCount do
  (table.insert)(oneKeyUninstallSlotList, i)
end
UIATHMain.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, CS_LeanTouch, CS_Input, UINAthList, UINAthSuitDetail, UINAthAreaItem, UINAthMainAtrrItem, UINAthSuitMainItem, UINAthInfoTogItem
  (UIUtil.SetTopStatus)(self, self.__OnClickBack)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Efficiency, self, self.__OnClickEfficiency)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Install, self, self.OneKeyInstall)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Uninstall, self, self.OneKeyUninstall)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_LeftArrow, self, self.__OnClickLeftArrow)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_RightArrow, self, self.__OnClickRightArrow)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Deploy, self, self.__OnClickDeploy)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Suit, self, self.OnClickSuit)
  self.__OnSelectListAreaFunc = BindCallback(self, self.__OnSelectListArea)
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
  self.__selectInfoTogFunc = BindCallback(self, self.SelectInfoTogItem)
  ;
  (CS_LeanTouch.OnFingerSet)("+", self.__onFingerSet)
  ;
  (CS_LeanTouch.OnFingerUp)("+", self.__onFingerUp)
  CS_Input.multiTouchEnabled = false
  self.ATHTweenDic = (self.transform):GetComponentsInChildren(typeof(((CS.DG).Tweening).DOTweenAnimation))
  self.athListNode = (UINAthList.New)()
  ;
  (self.athListNode):Init((self.ui).aTHListNode)
  ;
  (self.athListNode):SetAthItemStartDragFunc(self.__OnDragStart)
  ;
  (self.athListNode):Hide()
  self.suitDetailNode = (UINAthSuitDetail.New)()
  ;
  (self.suitDetailNode):Init((self.ui).suitDetailNode)
  ;
  (self.suitDetailNode):Hide()
  ;
  ((self.ui).areaItem):SetActive(false)
  self.athAreaPool = (UIItemPool.New)(UINAthAreaItem, (self.ui).areaItem)
  for i = 1, (ConfigData.game_config).athSlotCount do
    local areaItem = (self.athAreaPool):GetOne()
    areaItem:InitAthAreaItem(R8_PC184, self, self.__OnDragStart)
    -- DECOMPILER ERROR at PC189: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (areaItem.gameObject).name = tostring(R8_PC184)
  end
  ;
  ((self.ui).attriItem):SetActive(false)
  self.attrItemPool = (UIItemPool.New)(UINAthMainAtrrItem, (self.ui).attriItem)
  ;
  ((self.ui).suitItem):SetActive(false)
  self.suitItemPool = (UIItemPool.New)(UINAthSuitMainItem, (self.ui).suitItem)
  self.infoTogItemList = {}
  for k,go in ipairs((self.ui).infoTogList) do
    local infoTogItem = (UINAthInfoTogItem.New)()
    -- DECOMPILER ERROR at PC224: Overwrote pending register: R8 in 'AssignReg'

    infoTogItem:Init(go)
    -- DECOMPILER ERROR at PC227: Overwrote pending register: R8 in 'AssignReg'

    infoTogItem:InitAthInfoTogItem(R9_PC230, self.__selectInfoTogFunc)
    -- DECOMPILER ERROR at PC233: Overwrote pending register: R8 in 'AssignReg'

    ;
    (table.insert)(R8_PC184, R9_PC230)
  end
  MsgCenter:AddListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
  self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
end

UIATHMain.InitATHMain = function(self, heroData, resLader, heroResLoader, addAllTouchFunc, switchHeroFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.resLoader = resLader
  self.addAllTouchFunc = addAllTouchFunc
  self.switchHeroFunc = switchHeroFunc
  self:__SelectHero(heroData, heroResLoader)
  if (PlayerDataCenter.allAthData).athReconsitutionData ~= nil then
    local athData = ((PlayerDataCenter.allAthData).athDic)[((PlayerDataCenter.allAthData).athReconsitutionData).uid]
    do
      UIManager:ShowWindowAsync(UIWindowTypeID.AthStrengthen, function(window)
    -- function num : 0_1_0 , upvalues : athData, self
    if window == nil then
      return 
    end
    window:InitAthStrengthen(athData, self.heroData)
    window:ShowAthRefactor()
  end
)
    end
  end
end

UIATHMain.__SelectHero = function(self, heroData, heroResLoader)
  -- function num : 0_2 , upvalues : _ENV
  self.heroData = heroData
  self.heroResLoader = heroResLoader
  DestroyUnityObject(self.bigImgGameObject)
  ;
  (self.heroResLoader):LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(heroData:GetResName()), function(prefab)
    -- function num : 0_2_0 , upvalues : _ENV, self
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate((self.ui).heroHolder)
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroList")
  end
)
  self:RefreshAllAthInfo(true)
  self:RefreshAllAthArea()
  ;
  ((self.infoTogItemList)[1]):SetAthInfoTogOn()
  self:__RefreshBlueDot()
  self:PlayATHTween()
end

UIATHMain.__RefreshBlueDot = function(self)
  -- function num : 0_3 , upvalues : _ENV
  for k,areaItem in ipairs((self.athAreaPool).listItem) do
    areaItem:RefreshAthAreaItemBlueDot()
  end
end

UIATHMain.PlayATHTween = function(self)
  -- function num : 0_4
  for i = 0, (self.ATHTweenDic).Length - 1 do
    local tween = (self.ATHTweenDic)[i]
    tween:DORestart(false)
  end
end

UIATHMain.RefreshAllAthInfo = function(self, changeAttrSort)
  -- function num : 0_5 , upvalues : _ENV
  local athAreaMaxSpaceList = (self.heroData):GetAthSlotList(true)
  self.athAreaMaxSpaceList = athAreaMaxSpaceList
  local athAreaCurSpaceList = (self.heroData):GetAthSlotList()
  self.athAreaCurSpaceList = athAreaCurSpaceList
  local areaLevel = (PlayerDataCenter.allAthData):GetHeroAthSlotInfo((self.heroData).dataId)
  local areaEfcc = (PlayerDataCenter.allAthData):GetAthEfficiency(areaLevel)
  self.areaEfficiency = areaEfcc
  ;
  ((self.ui).tex_EffNum):SetIndex(0, (string.format)("%.1f", areaEfcc / 1000))
  self:RefreshAthAttr(athAreaCurSpaceList, self.curAreaId, changeAttrSort)
end

UIATHMain.RefreshAthAttr = function(self, athSlotList, curSlotId, changeSort)
  -- function num : 0_6 , upvalues : _ENV, AthFilterEnum
  local allAttrDic, slotAttrTab, suitDic, allAttrDicNoEfcc, slotAttrTabNoEfcc = (PlayerDataCenter.allAthData):GetHeroAthAttr((self.heroData).dataId)
  local isAllAttr = slotAttrTab[curSlotId] == nil
  local fightPower = (PlayerDataCenter.allAthData):GetAthFightPower(allAttrDic)
  if isAllAttr then
    ((self.ui).tex_Efficiency):SetIndex(1, tostring(fightPower))
  else
    local curSlotAttrDic = slotAttrTab[curSlotId]
    local curSlotFightPower = (PlayerDataCenter.allAthData):GetAthFightPower(curSlotAttrDic)
    ;
    ((self.ui).tex_Efficiency):SetIndex(0, tostring(curSlotFightPower), tostring(fightPower))
  end
  self.attrValueDic = self:__MergeAttr(allAttrDic, isAllAttr, slotAttrTab, curSlotId)
  self.attrValueNoEfccDic = self:__MergeAttr(allAttrDicNoEfcc, isAllAttr, slotAttrTabNoEfcc, curSlotId)
  if self.attrIdSortList == nil or changeSort then
    local idSortList = {}
    self.attrIdSortList = {}
    local count = 1
    for k,attrId in ipairs((ConfigData.attribute).baseAttrIds) do
      if ((ConfigData.attribute)[attrId]).merge_attribute == 0 then
        (table.insert)(idSortList, attrId)
        ;
        (table.insert)(self.attrIdSortList, attrId)
        count = count + 1
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
  -- DECOMPILER ERROR at PC120: Confused about usage of register: R11 in 'UnsetPending'

  ;
  ((self.ui).scroll_attriPage).verticalNormalizedPosition = 1
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
  ((self.ui).obj_NoAttr):SetActive(isEmpty)
  self.heroSuitDic = {}
  local suitIdList = {}
  for suitId,suitData in pairs(suitDic) do
    (table.insert)(suitIdList, suitId)
    -- DECOMPILER ERROR at PC170: Confused about usage of register: R18 in 'UnsetPending'

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
    suitItem:InitAthSuitMainItem(suitData, self.resLoader, self.__OnClickSuit)
  end
  ;
  ((self.ui).obj_NoSuit):SetActive(#suitIdList == 0)
  -- DECOMPILER ERROR: 12 unprocessed JMP targets
end

UIATHMain.__MergeAttr = function(self, allAttrDic, isAllAttr, slotAttrTab, curSlotId)
  -- function num : 0_7 , upvalues : _ENV
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

UIATHMain.__RefreshAfficiencyAttr = function(self, isEfficencyAttr)
  -- function num : 0_8 , upvalues : _ENV
  if self.attrValueDic == nil then
    return 
  end
  for k,attrId in ipairs(self.attrIdSortList) do
    local value = nil
    if isEfficencyAttr then
      value = (self.attrValueDic)[attrId]
    else
      value = (self.attrValueNoEfccDic)[attrId]
    end
    local attrItem = ((self.attrItemPool).listItem)[k]
    attrItem:InitAthMainAtrrItem(attrId, value)
  end
end

UIATHMain.RefreshAllAthArea = function(self)
  -- function num : 0_9 , upvalues : _ENV
  for areaId,areaItem in ipairs((self.athAreaPool).listItem) do
    local space = (self.athAreaCurSpaceList)[areaId]
    local maxSpace = (self.athAreaMaxSpaceList)[areaId]
    areaItem:RefreshAthAreaItem(self.heroData, self.resLoader, space, maxSpace)
  end
end

UIATHMain.ShowAthMainMask = function(self, show)
  -- function num : 0_10
  ((self.ui).img_winMask):SetActive(show)
end

UIATHMain.GetInstalledAthItem = function(self, athData)
  -- function num : 0_11
  local athItem = nil
  local areaId = athData:GetAthAreaType()
  local areaItem = ((self.athAreaPool).listItem)[areaId]
  athItem = areaItem:GetAthTableItemByUid(athData.uid)
  return athItem
end

UIATHMain.GetCurAthAreaItem = function(self, areaId)
  -- function num : 0_12
  if not areaId then
    local areaItem = ((self.athAreaPool).listItem)[self.curAreaId]
    return areaItem
  end
end

UIATHMain.TryInstallAth = function(self, athItem, inAthTable)
  -- function num : 0_13 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.AthItemDetail, function(window)
    -- function num : 0_13_0 , upvalues : athItem, _ENV, self, inAthTable
    if window == nil then
      return 
    end
    local athData = athItem:GetAthItemData()
    if (PlayerDataCenter.allAthData):HeroContainAthByUid((self.heroData).dataId, athData.uid) then
      athItem = self:GetInstalledAthItem(athData)
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

UIATHMain.TryReplaceAth = function(self, athItem, replacedAthData)
  -- function num : 0_14 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.AthItemDetail, function(window)
    -- function num : 0_14_0 , upvalues : athItem, self, replacedAthData
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

UIATHMain.ShowHeroPowerSide = function(self, power)
  -- function num : 0_15 , upvalues : _ENV
  if power == 0 then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageSide, function(win)
    -- function num : 0_15_0 , upvalues : power, _ENV
    if win ~= nil then
      win:ShowTips(power, 1, eMessageSideType.efficiency)
    end
  end
)
end

UIATHMain.OnFingerSet = function(self, finger)
  -- function num : 0_16
  self:OnDragAthItem(finger)
end

UIATHMain.OnFingerUp = function(self, finger)
  -- function num : 0_17
  self:OnDragAthItemEnd(finger)
end

UIATHMain.OnDragAthItemStart = function(self, athItem, isInTable)
  -- function num : 0_18 , upvalues : CS_LeanTouch, _ENV
  if self._dragItem ~= nil then
    return 
  end
  local athData = athItem:GetAthItemData()
  self:ShowAthMainMask(true)
  local areaId = athData:GetAthAreaType()
  self:__RefreshAllAreaMask(areaId)
  self:__RefreshAllAreaTogUI(areaId)
  self._dragFromTable = isInTable
  local finger = (CS_LeanTouch.Fingers)[0]
  self._lastAthPos = athItem:GetAthItemRootPos()
  local newPos = UIManager:Screen2WorldPosition(finger.ScreenPosition, athItem:GetAthItemRoot())
  self._dragOffset = self._lastAthPos - newPos
  athItem:SetAthItemRootParent(self.transform)
  if not isInTable then
    local transparentItem = self:__GetTransparentAthItem(athData:GetAthSize())
    transparentItem:SetAsTransparentAthItem(athItem.transform, athData, self.resLoader)
    self._curTransparentItem = transparentItem
    local callBack = function()
    -- function num : 0_18_0 , upvalues : self
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

UIATHMain.OnDragAthItem = function(self, finger)
  -- function num : 0_19 , upvalues : _ENV
  if self._dragItem == nil then
    return 
  end
  local newPos = UIManager:Screen2WorldPosition(finger.ScreenPosition, (self._dragItem):GetAthItemRoot())
  newPos = newPos + self._dragOffset
  ;
  (self._dragItem):SetAthItemPos(newPos)
end

UIATHMain.OnDragAthItemEnd = function(self, finger)
  -- function num : 0_20 , upvalues : _ENV
  if self._dragItem == nil then
    return 
  end
  local athData = (self._dragItem):GetAthItemData()
  local worldPos = ((self._dragItem):GetAthItemRoot()).position
  if (self.athListNode):DragInAthSortList(worldPos) then
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
    local curAreaItem = self:GetCurAthAreaItem(athData:GetAthAreaType())
    local gridId = curAreaItem:GetAthGridIdByScreenPos(worldPos, athData)
    if gridId ~= nil then
      if self._dragFromTable then
        local canMove = (curAreaItem.areaGridData):CheckAthInstallable(athData, gridId, athData.uid)
        if canMove and gridId ~= (athData.bindInfo).grid then
          self:MoveAth(athData, gridId)
          local anchorPos = curAreaItem:GetAthTableItemPos(athData, gridId)
          ;
          (self._dragItem):AthMoveTweenWithRootParent(anchorPos)
        else
          do
            do
              ;
              (self._dragItem):DragEndTweenAthItem(self._lastAthPos)
              local canInstall = (curAreaItem.areaGridData):CheckAthInstallable(athData, gridId)
              if canInstall then
                (self._dragItem):SetAthItemRootParent(nil, true)
                self:RefillAth(athData, gridId, nil, nil, proto_csmsg_AthRefillOperator.AthRefillOperatorInstall)
              else
                local replacedAthData, oneReplaceMore = (curAreaItem.areaGridData):CheckAthReplaceable(athData, gridId, true)
                if replacedAthData ~= nil then
                  (self._dragItem):SetAthItemRootParent(nil, true)
                  self:TryReplaceAth(self._dragItem, replacedAthData)
                else
                  if (curAreaItem.areaGridData):CheckAthAreaSpaceOk(athData) and not oneReplaceMore then
                    local athInstallDic, athInstalledDic = (curAreaItem.areaGridData):ReSortAthTable(athData)
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
                              if self.curAreaId == nil then
                                self:ShowAthMainMask(false)
                              end
                              self:__RefreshAllAreaMask(self.curAreaId)
                              self:__RefreshAllAreaTogUI(self.curAreaId)
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

UIATHMain.__GetTransparentAthItem = function(self, space)
  -- function num : 0_21 , upvalues : UINAthItem
  if self.__transparentAthItemDic == nil then
    self.__transparentAthItemDic = {}
  end
  local athItem = (self.__transparentAthItemDic)[space]
  if athItem == nil then
    local prefab = self:GetAthItemGameObject(space)
    local go = prefab:Instantiate()
    athItem = (UINAthItem.New)()
    athItem:Init(go)
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self.__transparentAthItemDic)[space] = athItem
  end
  do
    return athItem
  end
end

UIATHMain.__ReturnTransparentAthItem = function(self, athItem)
  -- function num : 0_22 , upvalues : _ENV
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

UIATHMain.__OnClickEfficiency = function(self)
  -- function num : 0_23 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.AthEfficiency, function(window)
    -- function num : 0_23_0 , upvalues : self
    if window == nil then
      return 
    end
    window:InitAthAthEfcc(self.heroData, self.resLoader, self.heroResLoader, function(value)
      -- function num : 0_23_0_0 , upvalues : self
      local newHeroData, reUseBigImgResloader = (self.switchHeroFunc)(value)
      self:__SelectHero(newHeroData, reUseBigImgResloader)
      return newHeroData, reUseBigImgResloader
    end
)
  end
)
end

UIATHMain.__OnClickLeftArrow = function(self)
  -- function num : 0_24
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = (self.switchHeroFunc)(-1)
    self:__SelectHero(newHeroData, reUseBigImgResloader)
  end
end

UIATHMain.__OnClickRightArrow = function(self)
  -- function num : 0_25
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = (self.switchHeroFunc)(1)
    self:__SelectHero(newHeroData, reUseBigImgResloader)
  end
end

UIATHMain.__ShowAthList = function(self, areaId)
  -- function num : 0_26 , upvalues : _ENV
  if not (self.athListNode).active then
    (self.athListNode):Show()
    ;
    (((self.ui).btn_Deploy).gameObject):SetActive(false)
    ;
    (UIUtil.SetTopStatus)(self, self.__OnHideAthList)
  end
  self.curAreaId = areaId
  ;
  (self.athListNode):InitAthListNode(self.heroData, self.resLoader, false, self.__OnClickAthItem, areaId, nil, self.__OnSelectListAreaFunc)
end

UIATHMain.__OnHideAthList = function(self)
  -- function num : 0_27
  (self.athListNode):Hide()
  ;
  (((self.ui).btn_Deploy).gameObject):SetActive(true)
  self:__OnSelectListArea(nil)
end

UIATHMain.__OnClickDeploy = function(self)
  -- function num : 0_28
  self:__ShowAthList(nil)
end

UIATHMain.OnSelectAthAreaItem = function(self, areaId)
  -- function num : 0_29
  self:__ShowAthList(areaId)
  self:ShowAthMainMask(true)
  self:__RefreshAllAreaMask(areaId)
end

UIATHMain.__OnSelectListArea = function(self, areaId)
  -- function num : 0_30
  if areaId == nil then
    self:ShowAthMainMask(false)
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

    if self.curAreaId ~= nil then
      ((self.ui).areaListTogGroup).allowSwitchOff = true
      local areaItem = ((self.athAreaPool).listItem)[self.curAreaId]
      areaItem:SetAthAreaItemToggleOn(false)
      -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.ui).areaListTogGroup).allowSwitchOff = false
    end
    do
      self:__RefreshAllAreaMask()
      do
        local areaItem = ((self.athAreaPool).listItem)[areaId]
        areaItem:SetAthAreaItemToggleOn(true)
        self.curAreaId = areaId
        self:RefreshAllAthInfo(true)
      end
    end
  end
end

UIATHMain.__RefreshAllAreaMask = function(self, areaId)
  -- function num : 0_31 , upvalues : _ENV
  for k,areaItem in ipairs((self.athAreaPool).listItem) do
    local show = nil
    if areaId == nil then
      show = false
    else
      show = areaItem.areaId ~= areaId
    end
    areaItem:ShowAthAreaItemMask(show)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UIATHMain.__RefreshAllAreaTogUI = function(self, areaId)
  -- function num : 0_32 , upvalues : _ENV
  for k,areaItem in ipairs((self.athAreaPool).listItem) do
    local isOn = nil
    if areaId == nil then
      isOn = false
    else
      isOn = areaItem.areaId == areaId
    end
    areaItem:SetAthAreaItemToggleOnUI(isOn)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UIATHMain.__OnClickBack = function(self)
  -- function num : 0_33 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.HeroState)
  if win ~= nil and not win.active then
    win.active = true
    ;
    (win.gameObject):SetActive(true)
  end
  self:Delete()
end

UIATHMain.OnClickAthItem = function(self, athItem, inAthTable)
  -- function num : 0_34
  self:TryInstallAth(athItem, inAthTable)
end

UIATHMain.OnClickSuit = function(self, suitId)
  -- function num : 0_35
  (self.suitDetailNode):Show()
  ;
  (self.suitDetailNode):InitAthSuitDetail(self.resLoader, self.heroSuitDic, suitId)
end

UIATHMain.SelectInfoTogItem = function(self, infoState)
  -- function num : 0_36 , upvalues : athInfoState
  self.infoState = infoState
  ;
  ((self.ui).attriPage):SetActive(false)
  ;
  ((self.ui).suitPage):SetActive(false)
  if infoState == athInfoState.BaseAttr then
    ((self.ui).attriPage):SetActive(true)
    self:__RefreshAfficiencyAttr(false)
  else
    if infoState == athInfoState.AdditionAttr then
      ((self.ui).attriPage):SetActive(true)
      self:__RefreshAfficiencyAttr(true)
    else
      if infoState == athInfoState.Suit then
        ((self.ui).suitPage):SetActive(true)
      end
    end
  end
end

UIATHMain.InstallAth = function(self, athData)
  -- function num : 0_37 , upvalues : _ENV
  self:RefillAth(athData, nil, nil, nil, proto_csmsg_AthRefillOperator.AthRefillOperatorInstall)
end

UIATHMain.RefillAth = function(self, athData, gridId, resortAthDic, athInstalledDic, refillOp)
  -- function num : 0_38 , upvalues : _ENV, cs_MessageCommon
  local curAreaId = athData:GetAthAreaType()
  local athDataList = (PlayerDataCenter.allAthData):GetHeroAthList((self.heroData).dataId, curAreaId)
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
  local curAreaItem = self:GetCurAthAreaItem(curAreaId)
  self._curAreaItem = curAreaItem
  if gridId == nil then
    gridId = (curAreaItem.areaGridData):GetAthInstallableGrid(athData)
    if gridId == nil then
      local canInstall = false
      do
        do
          if (curAreaItem.areaGridData):CheckAthAreaSpaceOk(athData) then
            local athInstallDic, installedDic = (curAreaItem.areaGridData):ReSortAthTable(athData)
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
          self.oldHeroPower = (self.heroData):GetFightingPower()
          if self.__onInstallComplete == nil then
            self.__onInstallComplete = BindCallback(self, self.OnInstallAthComplete)
          end
          local installFunc = function()
    -- function num : 0_38_0 , upvalues : self, athData, resortAthDic, athInstalledDic, _ENV, curAreaId, gridId, refillOp
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
      (self.athNetwork):CS_ATH_AthRefillOp((self.heroData).dataId, curAreaId, athData.uid, gridId, oldMoveDic, refillOp, self.__onInstallComplete)
    end
  end

          if athData.bindInfo ~= nil and (athData.bindInfo).id ~= (self.heroData).id then
            UIManager:ShowWindowAsync(UIWindowTypeID.AthReplaceHero, function(window)
    -- function num : 0_38_1 , upvalues : self, athData, installFunc
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

UIATHMain.OnInstallAthComplete = function(self)
  -- function num : 0_39 , upvalues : _ENV
  AudioManager:PlayAudioById(1030)
  local curAreaItem = self._curAreaItem
  if self.__resortAthDic == nil then
    curAreaItem:OnInstallAthItem(self.__insallAthData)
  else
    curAreaItem:OnReinstallAllAthTable(self.__resortAthDic, self.__athInstalledDic)
  end
  UIManager:HideWindow(UIWindowTypeID.AthItemDetail)
  local newHeroPower = (self.heroData):GetFightingPower()
  self:ShowHeroPowerSide(newHeroPower - self.oldHeroPower)
  self:RefreshAllAthInfo()
end

UIATHMain.UnInstallAth = function(self, athData)
  -- function num : 0_40 , upvalues : _ENV
  self.oldHeroPower = (self.heroData):GetFightingPower()
  if self.__unInstallAthComplete == nil then
    self.__unInstallAthComplete = BindCallback(self, self.OnUnInstallAthComplete)
  end
  self.__uninsallAthData = athData
  self.__uninstallAthGrid = (athData.bindInfo).grid
  ;
  (self.athNetwork):CS_ATH_AthUninstall(athData.uid, self.__unInstallAthComplete)
end

UIATHMain.OnUnInstallAthComplete = function(self)
  -- function num : 0_41 , upvalues : _ENV
  AudioManager:PlayAudioById(1032)
  local curAreaItem = self:GetCurAthAreaItem((self.__uninsallAthData):GetAthAreaType())
  curAreaItem:OnUnInstallAthItem((self.__uninsallAthData).uid, self.__uninstallAthGrid)
  UIManager:HideWindow(UIWindowTypeID.AthItemDetail)
  local newHeroPower = (self.heroData):GetFightingPower()
  self:ShowHeroPowerSide(newHeroPower - self.oldHeroPower)
  self:RefreshAllAthInfo()
end

UIATHMain.ReplaceAth = function(self, oldAthData, newAthData)
  -- function num : 0_42 , upvalues : _ENV
  local curAreaItem = self:GetCurAthAreaItem(oldAthData:GetAthAreaType())
  local athInstallDic, athInstalledDic = (curAreaItem.areaGridData):GetTryReplaceAthDic(newAthData, oldAthData)
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

UIATHMain.MoveAth = function(self, athData, newGridPos)
  -- function num : 0_43 , upvalues : _ENV
  if self.__OnMoveAthComplete == nil then
    self.__OnMoveAthComplete = BindCallback(self, self.OnMoveAthComplete)
  end
  self.__moveAthData = athData
  self.__moveAthGrid = (athData.bindInfo).grid
  ;
  (self.athNetwork):CS_ATH_Move(athData.uid, newGridPos, self.__OnMoveAthComplete)
end

UIATHMain.OnMoveAthComplete = function(self)
  -- function num : 0_44
  local curAreaItem = self:GetCurAthAreaItem((self.__moveAthData):GetAthAreaType())
  ;
  (curAreaItem.areaGridData):UninstallAthGridData(self.__moveAthData, self.__moveAthGrid)
  ;
  (curAreaItem.areaGridData):InstallAthGridData(self.__moveAthData)
end

UIATHMain.OnAthDataUpdate = function(self, updateAth, heroSlot)
  -- function num : 0_45 , upvalues : _ENV
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
      self:RefreshAllAthArea()
    end
    self:__RefreshBlueDot()
  end
end

UIATHMain.OneKeyInstall = function(self)
  -- function num : 0_46 , upvalues : _ENV, AthAreaGridData, AthUtil
  local slots = {}
  for areaId = 1, (ConfigData.game_config).athSlotCount do
    local space = (self.athAreaCurSpaceList)[areaId]
    local maxSpace = (self.athAreaMaxSpaceList)[areaId]
    local areaGridData = (AthAreaGridData.New)(areaId)
    local athInstallDic = (AthUtil.OnekeyInstallAthArea)(self.heroData, areaId, space, maxSpace, areaGridData)
    if athInstallDic ~= nil and (table.count)(athInstallDic) > 0 then
      local slot = {slotId = areaId, athGroup = athInstallDic}
      ;
      (table.insert)(slots, slot)
    end
  end
  if (table.count)(slots) == 0 then
    return 
  end
  self.oldHeroPower = (self.heroData):GetFightingPower()
  if self._OnOneKeyInstallComplete == nil then
    self._OnOneKeyInstallComplete = BindCallback(self, self.OnOneKeyInstallComplete)
  end
  ;
  (self.athNetwork):CS_ATH_OneKeyInstall((self.heroData).dataId, slots, self._OnOneKeyInstallComplete)
end

UIATHMain.OnOneKeyInstallComplete = function(self)
  -- function num : 0_47 , upvalues : _ENV
  AudioManager:PlayAudioById(1030)
  self:RefreshAllAthInfo()
  self:RefreshAllAthArea()
  local newHeroPower = (self.heroData):GetFightingPower()
  self:ShowHeroPowerSide(newHeroPower - self.oldHeroPower)
end

UIATHMain.OneKeyUninstall = function(self)
  -- function num : 0_48 , upvalues : _ENV, oneKeyUninstallSlotList
  local hasAth = false
  for k,areaId in ipairs(oneKeyUninstallSlotList) do
    local athDataList, athDic = (PlayerDataCenter.allAthData):GetHeroAthList((self.heroData).dataId, areaId)
    if #athDataList > 0 then
      hasAth = true
      break
    end
  end
  do
    if not hasAth then
      return 
    end
    self.oldHeroPower = (self.heroData):GetFightingPower()
    if self._OneKeyUninstallCompleteFunc == nil then
      self._OneKeyUninstallCompleteFunc = BindCallback(self, self.OnOneKeyUninstallComplete)
    end
    ;
    (self.athNetwork):CS_ATH_OneKeyUninstall((self.heroData).dataId, oneKeyUninstallSlotList, self._OneKeyUninstallCompleteFunc)
  end
end

UIATHMain.OnOneKeyUninstallComplete = function(self)
  -- function num : 0_49 , upvalues : _ENV
  AudioManager:PlayAudioById(1032)
  self:RefreshAllAthArea()
  local newHeroPower = (self.heroData):GetFightingPower()
  self:ShowHeroPowerSide(newHeroPower - self.oldHeroPower)
  self:RefreshAllAthInfo()
end

UIATHMain.GetAthItemGameObject = function(self, space)
  -- function num : 0_50
  return (self.athListNode):GetAthItemGo(space)
end

UIATHMain.GetAthItemFromListMain = function(self, uid)
  -- function num : 0_51
  return (self.athListNode):GetAthItemFromList(uid)
end

UIATHMain.OnDelete = function(self)
  -- function num : 0_52 , upvalues : _ENV, CS_LeanTouch, CS_Input, base
  (self.athListNode):Delete()
  ;
  (self.suitDetailNode):Delete()
  ;
  (self.suitItemPool):DeleteAll()
  ;
  (self.attrItemPool):DeleteAll()
  ;
  (self.athAreaPool):DeleteAll()
  for k,v in ipairs(self.infoTogItemList) do
    v:Delete()
  end
  if self.addAllTouchFunc ~= nil then
    (self.addAllTouchFunc)()
  end
  UIManager:DeleteWindow(UIWindowTypeID.AthItemDetail)
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

return UIATHMain


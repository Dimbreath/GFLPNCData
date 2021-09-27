local UIAthRefactor = class("UIAthRefactor", UIBaseWindow)
local base = UIBaseWindow
local UINAthScrollList = require("Game.Arithmetic.AthList.Area.UINAthScrollList")
local ArthmeticEnum = require("Game.Arithmetic.ArthmeticEnum")
local UINAthRefactorDetail = require("Game.Arithmetic.Refactor.UINAthRefactorDetail")
local AthSortEnum = require("Game.Arithmetic.AthList.Sort.AthSortEnum")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
UIAthRefactor.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, cs_ResLoader, UINAthScrollList, UINAthRefactorDetail
  (UIUtil.AddButtonListener)((self.ui).btn_Bg, self, self._OnClickClose)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self._OnClickClose)
  self.resLoader = (cs_ResLoader.Create)()
  self.athRefactorList = (UINAthScrollList.New)()
  ;
  (self.athRefactorList):Init((self.ui).scroll)
  ;
  (self.athRefactorList):SetAthScrollListGroupGridSize((Vector2.New)(5, 2))
  self.athDetailNode = (UINAthRefactorDetail.New)(self)
  ;
  (self.athDetailNode):Init((self.ui).aTHDetailItem)
  self.__OnClickAthItemFunc = BindCallback(self, self._OnClickAthItem)
  self.__OnMatExpAddFunc = BindCallback(self, self.__OnMatExpAdd)
  self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
end

UIAthRefactor.InitAthRefactor = function(self, athData, heroData)
  -- function num : 0_1 , upvalues : AthSortEnum, _ENV, ArthmeticEnum
  self.athData = athData
  self.heroData = heroData
  ;
  (self.athRefactorList):SetAthScrollListSiftFunc(function(athDataS)
    -- function num : 0_1_0 , upvalues : self
    do return athDataS.id == (self.athData).id and athDataS.uid ~= (self.athData).uid and athDataS.bindInfo == nil end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self.athRefactorList):SetAthScrollListSortFunc((AthSortEnum.eSortFunc)[(AthSortEnum.eKindType).Quality])
  ;
  (self.athRefactorList):SetAthScrollListClickItemWithScroll(false)
  local areaId = athData:GetAthAreaType()
  ;
  (self.athRefactorList):SetAthScrollListMultSeletedUidDic(table.emptytable)
  ;
  (self.athRefactorList):InitAthScrollList(heroData, areaId, ArthmeticEnum.StrengthenQuality, self.__OnClickAthItemFunc, nil, self.resLoader, true)
  ;
  (self.athRefactorList):RefreshAthScrollListData()
  ;
  (self.athRefactorList):RefillAthScrollList()
  self.athMatUpNode = (self.athRefactorList):GetAthScrollListMatUpNode()
  ;
  (self.athMatUpNode):SetRefreshAthSlotAddExpFunc(BindCallback(self, self._RefreshMatAdd))
  ;
  (self.athMatUpNode):InitAthMatUp(self.__OnMatExpAddFunc, (ConfigData.game_config).athRefactorTokenIdList)
  ;
  (self.athMatUpNode):SetAthAddExpLimt(1, 0)
  ;
  (self.athDetailNode):InitAthRefactorDetail(athData)
  GuideManager:TryTriggerGuide(eGuideCondition.InATHRefactor)
end

UIAthRefactor._RefreshMatAdd = function(self)
  -- function num : 0_2
  if self.selectMat then
    (self.athMatUpNode):SetAthAddExpLimt(1, 1)
  else
    ;
    (self.athMatUpNode):SetAthAddExpLimt(1, 0)
  end
end

UIAthRefactor._OnClickAthItem = function(self, athItem)
  -- function num : 0_3 , upvalues : cs_MessageCommon, _ENV
  local athData = athItem:GetAthItemData()
  if athData.lockUnlock then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Ath_CantSelectLockAth))
    return 
  end
  if self.selectedAthData == nil or (self.selectedAthData).uid ~= athData then
    self.selectedAthData = athData
    ;
    (self.athRefactorList):SetAthScrollListMultSeletedUidDic({[athData.uid] = true})
    ;
    (self.athRefactorList):RefillAthScrollList(nil, nil, true)
    UIManager:ShowWindowAsync(UIWindowTypeID.AthItemDetailFloat, function(window)
    -- function num : 0_3_0 , upvalues : athData
    if window == nil then
      return 
    end
    window:InitAthDetailFloat(athData)
  end
)
  end
  ;
  (self.athMatUpNode):CleanAllAthUpMat()
  ;
  (self.athMatUpNode):SetAthAddExpLimt(1, 0)
  self.selectMat = false
  ;
  (self.athDetailNode):RefreshCanRefactorBtn()
end

UIAthRefactor.__OnMatExpAdd = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local itemDic = (self.athMatUpNode):GetAthMatExpAddItemDic()
  local hasMat = false
  for itemId,num in pairs(itemDic) do
    local needNum = ((ConfigData.game_config).athRefactorTokenDic)[itemId]
    if needNum <= num then
      hasMat = true
    end
  end
  if hasMat then
    self.selectMat = true
    self.selectedAthData = nil
    ;
    (self.athMatUpNode):SetAthAddExpLimt(1, 1)
    ;
    (self.athRefactorList):SetAthScrollListMultSeletedUidDic(table.emptytable)
    ;
    (self.athRefactorList):RefreshAthScrollListData()
    ;
    (self.athRefactorList):RefillAthScrollList(nil, nil, true)
  else
    self.selectMat = false
    ;
    (self.athMatUpNode):SetAthAddExpLimt(1, 0)
  end
  ;
  (self.athDetailNode):RefreshCanRefactorBtn()
end

UIAthRefactor._OnClickClose = function(self)
  -- function num : 0_5
  self:Delete()
end

UIAthRefactor.CanAthRefactor = function(self, withTips)
  -- function num : 0_6 , upvalues : _ENV, cs_MessageCommon
  local allLock = true
  for k,affixElem in ipairs((self.athData).affixList) do
    if not affixElem.lock then
      allLock = false
    end
  end
  if allLock then
    if withTips then
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(4003))
    end
    return false
  end
  if self.selectedAthData == nil and not self.selectMat then
    if withTips then
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(4002))
    end
    return false
  end
  for k,itemId in ipairs((ConfigData.game_config).athRefactorConsumeItemId) do
    local consumeNum = ((ConfigData.game_config).athRefactorConsumeItemNum)[k]
    local itemCfg = (ConfigData.item)[itemId]
    local consumeItemCount = PlayerDataCenter:GetItemCount(itemId)
    if consumeItemCount < consumeNum then
      do
        do
          if withTips then
            local name = (LanguageUtil.GetLocaleText)(itemCfg.name)
            ;
            (cs_MessageCommon.ShowMessageTipsWithErrorSound)(name .. ConfigData:GetTipContent(TipContent.arithmetic_optimal_ItemInsufficient))
          end
          do return false end
          -- DECOMPILER ERROR at PC76: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC76: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC76: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  return true
end

UIAthRefactor.SendAthRefactor = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if not self:CanAthRefactor(true) then
    return 
  end
  if self.__OnRefactorComplete == nil then
    self.__OnRefactorComplete = BindCallback(self, self._OnRefactorComplete)
  end
  local selectedUid = nil
  if self.selectedAthData ~= nil then
    selectedUid = (self.selectedAthData).uid
  end
  ;
  (self.athNetwork):CS_ATH_ReconsitutionExec((self.athData).uid, selectedUid, self.__OnRefactorComplete)
end

UIAthRefactor._OnRefactorComplete = function(self)
  -- function num : 0_8 , upvalues : _ENV
  self.selectedAthData = nil
  ;
  (self.athRefactorList):SetAthScrollListMultSeletedUidDic(table.emptytable)
  ;
  (self.athRefactorList):RefreshAthScrollListData()
  ;
  (self.athRefactorList):RefillAthScrollList(nil, nil, true)
  ;
  (self.athDetailNode):RefreshCanRefactorBtn()
  ;
  (self.athMatUpNode):CleanAllAthUpMat()
  ;
  (self.athMatUpNode):InitAthMatUp(self.__OnMatExpAddFunc, (ConfigData.game_config).athRefactorTokenIdList)
  ;
  (self.athMatUpNode):SetAthAddExpLimt(1, 0)
  self.selectMat = false
  UIManager:ShowWindowAsync(UIWindowTypeID.AthRefactorSuccess, function(window)
    -- function num : 0_8_0 , upvalues : self
    if window == nil then
      return 
    end
    window:InitAthRefactorSuccess(self.athData, self.heroData)
  end
)
end

UIAthRefactor.SendAthAffixLock = function(self, affixIdx)
  -- function num : 0_9 , upvalues : _ENV
  if self.__OnAffixLockComplete == nil then
    self.__OnAffixLockComplete = BindCallback(self, self._OnAffixLockComplete)
  end
  self._lockAffxIndex = affixIdx
  ;
  (self.athNetwork):CS_ATH_AffixLockUnlock((self.athData).uid, affixIdx - 1, self.__OnAffixLockComplete)
end

UIAthRefactor._OnAffixLockComplete = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local affixElem = ((self.athData).affixList)[self._lockAffxIndex]
  if affixElem == nil then
    error("Cant get affixElem, index = " .. tostring(self._lockAffxIndex))
    return 
  end
  ;
  (self.athDetailNode):RefreshAthAffixLock(self._lockAffxIndex, affixElem.lock)
  ;
  (self.athDetailNode):RefreshCanRefactorBtn()
end

UIAthRefactor.ResetAthRefactor = function(self)
  -- function num : 0_11
  (self.athDetailNode):RefreshRfctDetailSubAttr()
end

UIAthRefactor.OnDelete = function(self)
  -- function num : 0_12 , upvalues : _ENV, base
  UIManager:DeleteWindow(UIWindowTypeID.AthRefactorSuccess)
  UIManager:HideWindow(UIWindowTypeID.AthItemDetailFloat)
  ;
  (self.athRefactorList):Delete()
  ;
  (self.athDetailNode):Delete()
  if self.resLoader ~= nil then
    (self.resLoader):Put2Pool()
    self.resLoader = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIAthRefactor


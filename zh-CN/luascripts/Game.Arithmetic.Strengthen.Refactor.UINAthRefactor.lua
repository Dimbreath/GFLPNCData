-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthRefactor = class("UINAthRefactor", UIBaseNode)
local base = UIBaseNode
local UINAthStrItem = require("Game.Arithmetic.Strengthen.UINAthStrItem")
local UINAthRfctAffixItem = require("Game.Arithmetic.Strengthen.Refactor.UINAthRfctAffixItem")
local UINAthEmptyAffix = require("Game.Arithmetic.Strengthen.UINAthEmptyAffix")
local UINItemWithCost = require("Game.Arithmetic.Strengthen.UINItemWithCost")
local cs_MessageCommon = CS.MessageCommon
local cs_DoTween = ((CS.DG).Tweening).DOTween
UINAthRefactor.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINAthStrItem, UINAthRfctAffixItem, UINAthEmptyAffix, UINItemWithCost
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Refactor, self, self._OnClickRefactor)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Save, self, self._OnClickSave)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Recovery, self, self._OnClickCancel)
  self.__OnClickAthItemFunc = BindCallback(self, self._OnClickAthItem)
  self.__OnClickAffixMain = BindCallback(self, self._OnAffixLock)
  self.__onUpdateItemEvent = BindCallback(self, self.OnItemUpdateEvent)
  self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
  self.mainAthStrItem = (UINAthStrItem.New)()
  ;
  (self.mainAthStrItem):Init((self.ui).aTHItem)
  ;
  ((self.ui).affixItem):SetActive(false)
  self.mainAffixItemPool = (UIItemPool.New)(UINAthRfctAffixItem, (self.ui).affixItem)
  self.subAffixItemPool = (UIItemPool.New)(UINAthRfctAffixItem, (self.ui).affixItem)
  ;
  ((self.ui).emptyAffixItem):SetActive(false)
  self.mainEmptyAffixPool = (UIItemPool.New)(UINAthEmptyAffix, (self.ui).emptyAffixItem)
  self.subEmptyAffixPool = (UIItemPool.New)(UINAthEmptyAffix, (self.ui).emptyAffixItem)
  ;
  ((self.ui).itemWithCount):SetActive(false)
  self.consumeItemPool = (UIItemPool.New)(UINItemWithCost, (self.ui).itemWithCount)
  self.selectedAthItemCost = (UINItemWithCost.New)()
  ;
  (self.selectedAthItemCost):Init((self.ui).selectAth)
end

UINAthRefactor.InitAthRefactor = function(self, sortListNode, athData, resLoader)
  -- function num : 0_1 , upvalues : _ENV
  self.selectedAthData = nil
  self.reconsitutionData = (PlayerDataCenter.allAthData).athReconsitutionData
  if self.reconsitutionData ~= nil then
    athData = ((PlayerDataCenter.allAthData).athDic)[(self.reconsitutionData).uid]
  end
  self.athData = athData
  ;
  (self.mainAthStrItem):InitAthStrItem(athData, resLoader)
  self:_ResetSelectAthCost()
  self.sortListNode = sortListNode
  ;
  (self.sortListNode):SetAthListRefactorSortFunc()
  ;
  (self.sortListNode):SetCustomSiftFunc(function(athDataS)
    -- function num : 0_1_0 , upvalues : self
    do return athDataS.id == (self.athData).id and athDataS.uid ~= (self.athData).uid and athDataS.bindInfo == nil end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self.sortListNode):SetAthListMultSeletedUidDic(table.emptytable)
  ;
  (self.sortListNode):InitAthSortListNode(nil, false, self.__OnClickAthItemFunc)
  self:_RefreshCurState()
  self:_RefreshAffixMain()
  self:_RefreshAffixSub()
  self:__UpdateConsumeItem()
end

UINAthRefactor._RefreshAffixMain = function(self)
  -- function num : 0_2
  (self.mainAffixItemPool):HideAll()
  ;
  (self.mainEmptyAffixPool):HideAll()
  for i = 1, 4 do
    local affixElem = ((self.athData).affixList)[i]
    if affixElem ~= nil then
      local affixItem = (self.mainAffixItemPool):GetOne()
      affixItem:InitAthRfctAffix(i, affixElem, self.__OnClickAffixMain, (self.ui).affixList_Befor)
    else
      do
        do
          local emptyItem = (self.mainEmptyAffixPool):GetOne()
          emptyItem:InitAthEmptyAffix((self.ui).affixList_Befor)
          -- DECOMPILER ERROR at PC33: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC33: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC33: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

UINAthRefactor._RefreshAffixSub = function(self, DoTween)
  -- function num : 0_3 , upvalues : _ENV, cs_DoTween
  (self.subAffixItemPool):HideAll()
  ;
  (self.subEmptyAffixPool):HideAll()
  local tweenAffixList = {}
  local lockNum = 0
  for k,affixElem in ipairs((self.athData).affixList) do
    if affixElem.lock then
      lockNum = lockNum + 1
    end
  end
  local reconsitutionCfg = (ConfigData.ath_reconsitution)[lockNum]
  if reconsitutionCfg == nil then
    error("Cant get reconsitutionCfg, lockNum = " .. tostring(lockNum))
    return 
  end
  local totalWeight = 0
  local orangeWeight = nil
  for k,qlt in ipairs(reconsitutionCfg.quality) do
    local weight = (reconsitutionCfg.quality_weight)[k]
    totalWeight = totalWeight + weight
    if qlt == eItemQualityType.Orange then
      orangeWeight = weight
    end
  end
  if orangeWeight == nil then
    error("Cant get orange weight form reconsitutionCfg,lockNum = " .. tostring(lockNum))
    return 
  end
  local orangeRatio = orangeWeight / (totalWeight)
  for i = 1, 4 do
    local affixElem = ((self.athData).affixList)[i]
    if affixElem ~= nil then
      if affixElem.lock then
        local affixItem = (self.subAffixItemPool):GetOne()
        affixItem:InitAthRfctAffix(i, affixElem, nil, (self.ui).affixList_After)
      else
        do
          if self.reconsitutionData == nil then
            local emptyItem = (self.subEmptyAffixPool):GetOne()
            emptyItem:InitAthEmptyAffix((self.ui).affixList_After, orangeRatio)
          else
            do
              local elem = ((self.reconsitutionData).reco)[i - 1]
              local newAffixElem = DeepCopy(affixElem)
              newAffixElem.id = elem.id
              newAffixElem.quality = elem.quality
              newAffixElem.value = (PlayerDataCenter.allAthData):GenAthAffixValue(newAffixElem.id, newAffixElem.quality, newAffixElem.level)
              do
                local affixItem = (self.subAffixItemPool):GetOne()
                affixItem:InitAthRfctAffix(i, newAffixElem, nil, (self.ui).affixList_After, true)
                if DoTween then
                  (table.insert)(tweenAffixList, affixItem)
                end
                do
                  local emptyItem = (self.subEmptyAffixPool):GetOne()
                  emptyItem:InitAthEmptyAffix((self.ui).affixList_After)
                  -- DECOMPILER ERROR at PC139: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC139: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC139: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                  -- DECOMPILER ERROR at PC139: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC139: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC139: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                  -- DECOMPILER ERROR at PC139: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC139: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC139: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
        end
      end
    end
  end
  if #tweenAffixList > 0 then
    if self.pageSequence ~= nil then
      (self.pageSequence):Pause()
      ;
      (self.pageSequence):Restart()
    else
      self.pageSequence = (cs_DoTween.Sequence)()
      local moveX = 20
      for index,affixItem in ipairs(tweenAffixList) do
        local pageLocalPos = (affixItem:GetAffixAnimaNode()).localPosition
        pageLocalPos = (Vector3.New)(pageLocalPos.x - moveX, pageLocalPos.y, pageLocalPos.z)
        ;
        (affixItem:GetAffixAnimaNode()).localPosition = pageLocalPos
        ;
        (affixItem:GetAffixCanvasGroup()).alpha = 0
        ;
        (self.pageSequence):Append(((affixItem:GetAffixAnimaNode()):DOLocalMoveX(moveX, 0.2)):SetRelative(true))
        ;
        (self.pageSequence):Join((affixItem:GetAffixCanvasGroup()):DOFade(1, 0.2))
      end
      ;
      (self.pageSequence):SetAutoKill(false)
    end
  end
end

UINAthRefactor.__UpdateConsumeItem = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (self.consumeItemPool):HideAll()
  for k,itemId in ipairs((ConfigData.game_config).athRefactorConsumeItemId) do
    local consumeNum = ((ConfigData.game_config).athRefactorConsumeItemNum)[k]
    local itemCfg = (ConfigData.item)[itemId]
    if itemCfg == nil then
      error("Can\'t find itemCfg, id = " .. tostring(itemId))
    else
      local consumeItem = (self.consumeItemPool):GetOne()
      consumeItem:InitItemWithCost(itemCfg, consumeNum)
    end
  end
end

UINAthRefactor.OnItemUpdateEvent = function(self, itemUpdate)
  -- function num : 0_5 , upvalues : _ENV
  for k,itemId in ipairs((ConfigData.game_config).athRefactorConsumeItemId) do
    if itemUpdate[itemId] ~= nil then
      local consumeItem = ((self.consumeItemPool).listItem)[k]
      consumeItem:RefreshItemWithCost()
    end
  end
end

UINAthRefactor._OnClickAthItem = function(self, athItem)
  -- function num : 0_6 , upvalues : cs_MessageCommon, _ENV
  local athData = athItem:GetAthItemData()
  if athData.lockUnlock then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Ath_CantSelectLockAth))
    return 
  end
  if self.selectedAthData == nil or (self.selectedAthData).uid ~= athData then
    self.selectedAthData = athData
    ;
    (self.sortListNode):SetAthListMultSeletedUidDic({[athData.uid] = true})
    ;
    (self.sortListNode):RefillCurAthSortList(true)
    ;
    (self.selectedAthItemCost):InitItemWithCost(athData.itemCfg, 1, 1, function()
    -- function num : 0_6_0
  end
)
    ;
    ((self.ui).img_SelectAth):SetActive(false)
  end
end

UINAthRefactor._OnClickRefactor = function(self)
  -- function num : 0_7 , upvalues : _ENV, cs_MessageCommon
  local allLock = true
  for k,affixElem in ipairs((self.athData).affixList) do
    if not affixElem.lock then
      allLock = false
    end
  end
  if allLock then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(4003))
    return 
  end
  if self.selectedAthData == nil then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(4002))
    return 
  end
  for k,itemId in ipairs((ConfigData.game_config).athRefactorConsumeItemId) do
    local consumeNum = ((ConfigData.game_config).athRefactorConsumeItemNum)[k]
    local itemCfg = (ConfigData.item)[itemId]
    local consumeItemCount = PlayerDataCenter:GetItemCount(itemId)
    if consumeItemCount < consumeNum then
      local name = (LanguageUtil.GetLocaleText)(itemCfg.name)
      ;
      (cs_MessageCommon.ShowMessageTips)(name .. ConfigData:GetTipContent(TipContent.arithmetic_optimal_ItemInsufficient))
      return 
    end
  end
  if self.__OnRefactorComplete == nil then
    self.__OnRefactorComplete = BindCallback(self, self._OnRefactorComplete)
  end
  ;
  (self.athNetwork):CS_ATH_ReconsitutionExec((self.athData).uid, (self.selectedAthData).uid, self.__OnRefactorComplete)
end

UINAthRefactor._OnRefactorComplete = function(self)
  -- function num : 0_8 , upvalues : _ENV
  self.selectedAthData = nil
  self.reconsitutionData = (PlayerDataCenter.allAthData).athReconsitutionData
  self:_ResetSelectAthCost()
  self:_RefreshAffixSub(true)
  self:_RefreshCurState()
end

UINAthRefactor._OnClickSave = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if self.__OnSaveComplete == nil then
    self.__OnSaveComplete = BindCallback(self, self._OnSaveComplete)
  end
  ;
  (self.athNetwork):CS_ATH_ReconsitutionSave(self.__OnSaveComplete)
end

UINAthRefactor._OnSaveComplete = function(self)
  -- function num : 0_10 , upvalues : _ENV
  self.reconsitutionData = (PlayerDataCenter.allAthData).athReconsitutionData
  self:_RefreshAffixMain()
  self:_RefreshAffixSub()
  self:_RefreshCurState()
end

UINAthRefactor._OnClickCancel = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if self.__OnCancelComplete == nil then
    self.__OnCancelComplete = BindCallback(self, self._OnCancelComplete)
  end
  ;
  (self.athNetwork):CS_ATH_ReconsitutionDrop(self.__OnCancelComplete)
end

UINAthRefactor._OnCancelComplete = function(self)
  -- function num : 0_12 , upvalues : _ENV
  self.reconsitutionData = (PlayerDataCenter.allAthData).athReconsitutionData
  self:_RefreshAffixMain()
  self:_RefreshAffixSub()
  self:_RefreshCurState()
end

UINAthRefactor._OnAffixLock = function(self, affixIdx)
  -- function num : 0_13 , upvalues : _ENV
  if self.__OnAffixLockComplete == nil then
    self.__OnAffixLockComplete = BindCallback(self, self._OnAffixLockComplete)
  end
  self._lockAffxIndex = affixIdx
  ;
  (self.athNetwork):CS_ATH_AffixLockUnlock((self.athData).uid, affixIdx - 1, self.__OnAffixLockComplete)
end

UINAthRefactor._OnAffixLockComplete = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local affixElem = ((self.athData).affixList)[self._lockAffxIndex]
  if affixElem == nil then
    error("Cant get affixElem, index = " .. tostring(self._lockAffxIndex))
    return 
  end
  local affixItem = ((self.mainAffixItemPool).listItem)[self._lockAffxIndex]
  affixItem:RefreshAthRfctAffixItem(affixElem)
  self:_RefreshAffixSub()
end

UINAthRefactor._ResetSelectAthCost = function(self)
  -- function num : 0_15
  (self.selectedAthItemCost):InitItemWithCost((self.athData).itemCfg, 1, 0, function()
    -- function num : 0_15_0
  end
)
  ;
  ((self.ui).img_SelectAth):SetActive(true)
end

UINAthRefactor._RefreshCurState = function(self)
  -- function num : 0_16
  (((self.ui).btn_Refactor).gameObject):SetActive(self.reconsitutionData == nil)
  ;
  (((self.ui).btn_Save).gameObject):SetActive(self.reconsitutionData ~= nil)
  ;
  (((self.ui).btn_Recovery).gameObject):SetActive(self.reconsitutionData ~= nil)
  if self.reconsitutionData == nil then
    ((self.ui).tex_RefactorType):SetIndex(0)
    ;
    ((self.ui).tex_RefactorTypeEn):SetIndex(0)
  else
    ((self.ui).tex_RefactorType):SetIndex(1)
    ;
    ((self.ui).tex_RefactorTypeEn):SetIndex(1)
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

UINAthRefactor.OnShow = function(self)
  -- function num : 0_17 , upvalues : _ENV
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onUpdateItemEvent)
end

UINAthRefactor.OnHide = function(self)
  -- function num : 0_18 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onUpdateItemEvent)
end

UINAthRefactor.OnDelete = function(self)
  -- function num : 0_19 , upvalues : base
  if self.pageSequence ~= nil then
    (self.pageSequence):Kill()
    self.pageSequence = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINAthRefactor

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthRefactor = class("UINAthRefactor", UIBaseNode)
local base = UIBaseNode
local UINAthStrItem = require("Game.Arithmetic.Strengthen.UINAthStrItem")
local UINAthRfctAffixItem = require(
                                "Game.Arithmetic.Strengthen.Refactor.UINAthRfctAffixItem")
local UINAthEmptyAffix = require("Game.Arithmetic.Strengthen.UINAthEmptyAffix")
local UINItemWithCost = require("Game.Arithmetic.Strengthen.UINItemWithCost")
local cs_MessageCommon = CS.MessageCommon
local cs_DoTween = ((CS.DG).Tweening).DOTween
UINAthRefactor.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINAthStrItem, UINAthRfctAffixItem, UINAthEmptyAffix, UINItemWithCost
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_Refactor, self,
                               self._OnClickRefactor);
    (UIUtil.AddButtonListener)((self.ui).btn_Save, self, self._OnClickSave);
    (UIUtil.AddButtonListener)((self.ui).btn_Recovery, self, self._OnClickCancel)
    self.__OnClickAthItemFunc = BindCallback(self, self._OnClickAthItem)
    self.__OnClickAffixMain = BindCallback(self, self._OnAffixLock)
    self.__onUpdateItemEvent = BindCallback(self, self.OnItemUpdateEvent)
    self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
    self.mainAthStrItem = (UINAthStrItem.New)();
    (self.mainAthStrItem):Init((self.ui).aTHItem);
    ((self.ui).affixItem):SetActive(false)
    self.mainAffixItemPool = (UIItemPool.New)(UINAthRfctAffixItem,
                                              (self.ui).affixItem)
    self.subAffixItemPool = (UIItemPool.New)(UINAthRfctAffixItem,
                                             (self.ui).affixItem);
    ((self.ui).emptyAffixItem):SetActive(false)
    self.mainEmptyAffixPool = (UIItemPool.New)(UINAthEmptyAffix,
                                               (self.ui).emptyAffixItem)
    self.subEmptyAffixPool = (UIItemPool.New)(UINAthEmptyAffix,
                                              (self.ui).emptyAffixItem);
    ((self.ui).itemWithCount):SetActive(false)
    self.consumeItemPool = (UIItemPool.New)(UINItemWithCost,
                                            (self.ui).itemWithCount)
    self.selectedAthItemCost = (UINItemWithCost.New)();
    (self.selectedAthItemCost):Init((self.ui).selectAth)
end

UINAthRefactor.InitAthRefactor =
    function(self, sortListNode, athData, resLoader)
        -- function num : 0_1 , upvalues : _ENV
        self.selectedAthData = nil
        self.reconsitutionData =
            (PlayerDataCenter.allAthData).athReconsitutionData
        if self.reconsitutionData ~= nil then
            athData =
                ((PlayerDataCenter.allAthData).athDic)[(self.reconsitutionData).uid]
        end
        self.athData = athData;
        (self.mainAthStrItem):InitAthStrItem(athData, resLoader)
        self:_ResetSelectAthCost()
        self.sortListNode = sortListNode;
        (self.sortListNode):SetAthListRefactorSortFunc();
        (self.sortListNode):SetCustomSiftFunc(
            function(athDataS)
                -- function num : 0_1_0 , upvalues : self
                do
                    return athDataS.id == (self.athData).id and athDataS.uid ~=
                               (self.athData).uid and athDataS.bindInfo == nil
                end
                -- DECOMPILER ERROR: 1 unprocessed JMP targets
            end);
        (self.sortListNode):SetAthListMultSeletedUidDic(table.emptytable);
        (self.sortListNode):InitAthSortListNode(nil, false,
                                                self.__OnClickAthItemFunc)
        self:_RefreshCurState()
        self:_RefreshAffixMain()
        self:_RefreshAffixSub()
        self:__UpdateConsumeItem()
    end

UINAthRefactor._RefreshAffixMain = function(self)
    -- function num : 0_2
    (self.mainAffixItemPool):HideAll();
    (self.mainEmptyAffixPool):HideAll()
    for i = 1, 4 do
        local affixElem = ((self.athData).affixList)[i]
        if affixElem ~= nil then
            local affixItem = (self.mainAffixItemPool):GetOne()
            affixItem:InitAthRfctAffix(i, affixElem, self.__OnClickAffixMain,
                                       (self.ui).affixList_Befor)
        else
            do
                do
                    local emptyItem = (self.mainEmptyAffixPool):GetOne()
                    emptyItem:InitAthEmptyAffix((self.ui).affixList_Befor)
                    -- DECOMPILER ERROR at PC33: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC33: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                    -- DECOMPILER ERROR at PC33: LeaveBlock: unexpected jumping out IF_STMT

                end
            end
        end
    end
end

UINAthRefactor._RefreshAffixSub = function(self, DoTween)
    -- function num : 0_3 , upvalues : _ENV, cs_DoTween
    (self.subAffixItemPool):HideAll();
    (self.subEmptyAffixPool):HideAll()
    local tweenAffixList = {}
    local lockNum = 0
    for k, affixElem in ipairs((self.athData).affixList) do
        if affixElem.lock then lockNum = lockNum + 1 end
    end
    local reconsitutionCfg = (ConfigData.ath_reconsitution)[lockNum]
    if reconsitutionCfg == nil then
        error("Cant get reconsitutionCfg, lockNum = " .. tostring(lockNum))
        return
    end
    local totalWeight = 0
    local orangeWeight = nil
    for k, qlt in ipairs(reconsitutionCfg.quality) do
        local weight = (reconsitutionCfg.quality_weight)[k]
        totalWeight = totalWeight + weight
        if qlt == eItemQualityType.Orange then orangeWeight = weight end
    end
    if orangeWeight == nil then
        error("Cant get orange weight form reconsitutionCfg,lockNum = " ..
                  tostring(lockNum))
        return
    end
    local orangeRatio = orangeWeight / (totalWeight)
    for i = 1, 4 do
        local affixElem = ((self.athData).affixList)[i]
        if affixElem ~= nil then
            if affixElem.lock then
                local affixItem = (self.subAffixItemPool):GetOne()
                affixItem:InitAthRfctAffix(i, affixElem, nil,
                                           (self.ui).affixList_After)
            else
                do
                    if self.reconsitutionData == nil then
                        local emptyItem = (self.subEmptyAffixPool):GetOne()
                        emptyItem:InitAthEmptyAffix((self.ui).affixList_After,
                                                    orangeRatio)
                    else
                        do
                            local elem = ((self.reconsitutionData).reco)[i - 1]
                            local newAffixElem = DeepCopy(affixElem)
                            newAffixElem.id = elem.id
                            newAffixElem.quality = elem.quality
                            newAffixElem.value =
                                (PlayerDataCenter.allAthData):GenAthAffixValue(
                                    newAffixElem.id, newAffixElem.quality,
                                    newAffixElem.level)
                            do
                                local affixItem =
                                    (self.subAffixItemPool):GetOne()
                                affixItem:InitAthRfctAffix(i, newAffixElem, nil,
                                                           (self.ui).affixList_After,
                                                           true)
                                if DoTween then
                                    (table.insert)(tweenAffixList, affixItem)
                                end
                                do
                                    local emptyItem =
                                        (self.subEmptyAffixPool):GetOne()
                                    emptyItem:InitAthEmptyAffix(
                                        (self.ui).affixList_After)
                                    -- DECOMPILER ERROR at PC139: LeaveBlock: unexpected jumping out DO_STMT

                                    -- DECOMPILER ERROR at PC139: LeaveBlock: unexpected jumping out DO_STMT

                                    -- DECOMPILER ERROR at PC139: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                    -- DECOMPILER ERROR at PC139: LeaveBlock: unexpected jumping out IF_STMT

                                    -- DECOMPILER ERROR at PC139: LeaveBlock: unexpected jumping out DO_STMT

                                    -- DECOMPILER ERROR at PC139: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                    -- DECOMPILER ERROR at PC139: LeaveBlock: unexpected jumping out IF_STMT

                                    -- DECOMPILER ERROR at PC139: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                    -- DECOMPILER ERROR at PC139: LeaveBlock: unexpected jumping out IF_STMT

                                end
                            end
                        end
                    end
                end
            end
        end
    end
    if #tweenAffixList > 0 then
        if self.pageSequence ~= nil then
            (self.pageSequence):Pause();
            (self.pageSequence):Restart()
        else
            self.pageSequence = (cs_DoTween.Sequence)()
            local moveX = 20
            for index, affixItem in ipairs(tweenAffixList) do
                local pageLocalPos =
                    (affixItem:GetAffixAnimaNode()).localPosition
                pageLocalPos = (Vector3.New)(pageLocalPos.x - moveX,
                                             pageLocalPos.y, pageLocalPos.z);
                (affixItem:GetAffixAnimaNode()).localPosition = pageLocalPos;
                (affixItem:GetAffixCanvasGroup()).alpha = 0;
                (self.pageSequence):Append(
                    ((affixItem:GetAffixAnimaNode()):DOLocalMoveX(moveX, 0.2)):SetRelative(
                        true));
                (self.pageSequence):Join(
                    (affixItem:GetAffixCanvasGroup()):DOFade(1, 0.2))
            end
            (self.pageSequence):SetAutoKill(false)
        end
    end
end

UINAthRefactor.__UpdateConsumeItem = function(self)
    -- function num : 0_4 , upvalues : _ENV
    (self.consumeItemPool):HideAll()
    for k, itemId in ipairs((ConfigData.game_config).athRefactorConsumeItemId) do
        local consumeNum =
            ((ConfigData.game_config).athRefactorConsumeItemNum)[k]
        local itemCfg = (ConfigData.item)[itemId]
        if itemCfg == nil then
            error("Can\'t find itemCfg, id = " .. tostring(itemId))
        else
            local consumeItem = (self.consumeItemPool):GetOne()
            consumeItem:InitItemWithCost(itemCfg, consumeNum)
        end
    end
end

UINAthRefactor.OnItemUpdateEvent = function(self, itemUpdate)
    -- function num : 0_5 , upvalues : _ENV
    for k, itemId in ipairs((ConfigData.game_config).athRefactorConsumeItemId) do
        if itemUpdate[itemId] ~= nil then
            local consumeItem = ((self.consumeItemPool).listItem)[k]
            consumeItem:RefreshItemWithCost()
        end
    end
end

UINAthRefactor._OnClickAthItem = function(self, athItem)
    -- function num : 0_6 , upvalues : cs_MessageCommon, _ENV
    local athData = athItem:GetAthItemData()
    if athData.lockUnlock then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.Ath_CantSelectLockAth))
        return
    end
    if self.selectedAthData == nil or (self.selectedAthData).uid ~= athData then
        self.selectedAthData = athData;
        (self.sortListNode):SetAthListMultSeletedUidDic({[athData.uid] = true});
        (self.sortListNode):RefillCurAthSortList(true);
        (self.selectedAthItemCost):InitItemWithCost(athData.itemCfg, 1, 1,
                                                    function()
            -- function num : 0_6_0
        end);
        ((self.ui).img_SelectAth):SetActive(false)
    end
end

UINAthRefactor._OnClickRefactor = function(self)
    -- function num : 0_7 , upvalues : _ENV, cs_MessageCommon
    local allLock = true
    for k, affixElem in ipairs((self.athData).affixList) do
        if not affixElem.lock then allLock = false end
    end
    if allLock then
        (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(4003))
        return
    end
    if self.selectedAthData == nil then
        (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(4002))
        return
    end
    for k, itemId in ipairs((ConfigData.game_config).athRefactorConsumeItemId) do
        local consumeNum =
            ((ConfigData.game_config).athRefactorConsumeItemNum)[k]
        local itemCfg = (ConfigData.item)[itemId]
        local consumeItemCount = PlayerDataCenter:GetItemCount(itemId)
        if consumeItemCount < consumeNum then
            local name = (LanguageUtil.GetLocaleText)(itemCfg.name);
            (cs_MessageCommon.ShowMessageTips)(
                name ..
                    ConfigData:GetTipContent(
                        TipContent.arithmetic_optimal_ItemInsufficient))
            return
        end
    end
    if self.__OnRefactorComplete == nil then
        self.__OnRefactorComplete = BindCallback(self, self._OnRefactorComplete)
    end
    (self.athNetwork):CS_ATH_ReconsitutionExec((self.athData).uid,
                                               (self.selectedAthData).uid,
                                               self.__OnRefactorComplete)
end

UINAthRefactor._OnRefactorComplete = function(self)
    -- function num : 0_8 , upvalues : _ENV
    self.selectedAthData = nil
    self.reconsitutionData = (PlayerDataCenter.allAthData).athReconsitutionData
    self:_ResetSelectAthCost()
    self:_RefreshAffixSub(true)
    self:_RefreshCurState()
end

UINAthRefactor._OnClickSave = function(self)
    -- function num : 0_9 , upvalues : _ENV
    if self.__OnSaveComplete == nil then
        self.__OnSaveComplete = BindCallback(self, self._OnSaveComplete)
    end
    (self.athNetwork):CS_ATH_ReconsitutionSave(self.__OnSaveComplete)
end

UINAthRefactor._OnSaveComplete = function(self)
    -- function num : 0_10 , upvalues : _ENV
    self.reconsitutionData = (PlayerDataCenter.allAthData).athReconsitutionData
    self:_RefreshAffixMain()
    self:_RefreshAffixSub()
    self:_RefreshCurState()
end

UINAthRefactor._OnClickCancel = function(self)
    -- function num : 0_11 , upvalues : _ENV
    if self.__OnCancelComplete == nil then
        self.__OnCancelComplete = BindCallback(self, self._OnCancelComplete)
    end
    (self.athNetwork):CS_ATH_ReconsitutionDrop(self.__OnCancelComplete)
end

UINAthRefactor._OnCancelComplete = function(self)
    -- function num : 0_12 , upvalues : _ENV
    self.reconsitutionData = (PlayerDataCenter.allAthData).athReconsitutionData
    self:_RefreshAffixMain()
    self:_RefreshAffixSub()
    self:_RefreshCurState()
end

UINAthRefactor._OnAffixLock = function(self, affixIdx)
    -- function num : 0_13 , upvalues : _ENV
    if self.__OnAffixLockComplete == nil then
        self.__OnAffixLockComplete = BindCallback(self,
                                                  self._OnAffixLockComplete)
    end
    self._lockAffxIndex = affixIdx;
    (self.athNetwork):CS_ATH_AffixLockUnlock((self.athData).uid, affixIdx - 1,
                                             self.__OnAffixLockComplete)
end

UINAthRefactor._OnAffixLockComplete = function(self)
    -- function num : 0_14 , upvalues : _ENV
    local affixElem = ((self.athData).affixList)[self._lockAffxIndex]
    if affixElem == nil then
        error("Cant get affixElem, index = " .. tostring(self._lockAffxIndex))
        return
    end
    local affixItem = ((self.mainAffixItemPool).listItem)[self._lockAffxIndex]
    affixItem:RefreshAthRfctAffixItem(affixElem)
    self:_RefreshAffixSub()
end

UINAthRefactor._ResetSelectAthCost = function(self)
    -- function num : 0_15
    (self.selectedAthItemCost):InitItemWithCost((self.athData).itemCfg, 1, 0,
                                                function()
        -- function num : 0_15_0
    end);
    ((self.ui).img_SelectAth):SetActive(true)
end

UINAthRefactor._RefreshCurState = function(self)
    -- function num : 0_16
    (((self.ui).btn_Refactor).gameObject):SetActive(
        self.reconsitutionData == nil);
    (((self.ui).btn_Save).gameObject):SetActive(self.reconsitutionData ~= nil);
    (((self.ui).btn_Recovery).gameObject):SetActive(
        self.reconsitutionData ~= nil)
    if self.reconsitutionData == nil then
        ((self.ui).tex_RefactorType):SetIndex(0);
        ((self.ui).tex_RefactorTypeEn):SetIndex(0)
    else
        ((self.ui).tex_RefactorType):SetIndex(1);
        ((self.ui).tex_RefactorTypeEn):SetIndex(1)
    end
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

UINAthRefactor.OnShow = function(self)
    -- function num : 0_17 , upvalues : _ENV
    MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onUpdateItemEvent)
end

UINAthRefactor.OnHide = function(self)
    -- function num : 0_18 , upvalues : _ENV
    MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onUpdateItemEvent)
end

UINAthRefactor.OnDelete = function(self)
    -- function num : 0_19 , upvalues : base
    if self.pageSequence ~= nil then
        (self.pageSequence):Kill()
        self.pageSequence = nil
    end
    (base.OnDelete)(self)
end

return UINAthRefactor


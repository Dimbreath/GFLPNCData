-- params : ...
-- function num : 0 , upvalues : _ENV
local UIOasisBuildingItemDetail = class("UIOasisBuildingItemDetail", UIBaseNode)
local base = UIBaseNode
local BuildingItem = require("Game.Oasis.UI.OasisSidle.UIOasisBuildingItem")
local InfoItem = require("Game.Oasis.UI.OasisSidle.UIOasisBuffInfoItem")
local CostMatInfo = require("Game.Oasis.UI.OasisSidle.UIOasisCostMatInfo")
local JumpManager = require("Game.Jump.JumpManager")
local costItemDispLimit = 3
local bonusItemLimit = 3
UIOasisBuildingItemDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, CostMatInfo, InfoItem
  self.__resloader = resLoader
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Upgrade, self, self.__OnClickUpdrage)
  self.costMatPool = (UIItemPool.New)(CostMatInfo, (self.ui).costItem)
  self.buffInfoPool = (UIItemPool.New)(InfoItem, (self.ui).currentLevelInfo)
  self.effectBonusPool = (UIItemPool.New)(InfoItem, (self.ui).effectUpItem)
  self.predictionPool = (UIItemPool.New)(InfoItem, (self.ui).predictionItem)
end

UIOasisBuildingItemDetail.InjectResloader = function(self, resLoader)
  -- function num : 0_1
  self.resLoader = resLoader
end

UIOasisBuildingItemDetail.UpdateWithItemData = function(self, buildingItem)
  -- function num : 0_2 , upvalues : _ENV
  self.buildingItem = buildingItem
  self.buildingData = buildingItem.buildingData
  self.id = (self.buildingData).id
  self.UISidle = buildingItem.UISidle
  self.buffDict = buildingItem.buffDict
  self.isBuild = (self.buildingData).isBuild
  local upgradeTextIndex = self.isBuild and 1 or 0
  ;
  ((self.ui).btn_Upgrade_Text):SetIndex(upgradeTextIndex)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_Pic).texture = buildingItem.uiIcon
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_BulidName).text = (self.buildingData).name
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_EnName).text = (self.buildingData).nameEn
  ;
  (((self.ui).tex_BulidLevel).gameObject):SetActive(buildingItem.isShowLevel)
  ;
  ((self.ui).tex_BulidLevel):SetIndex(0, tostring((self.buildingData).level))
  self:UpdateState()
end

UIOasisBuildingItemDetail.UpdateState = function(self)
  -- function num : 0_3 , upvalues : BuildingItem
  self.ConfirmOverEvent = (self.UISidle).ConfirmOverEvent
  if self.isBuild then
    self.doCompletedEvent = (self.UISidle).UpdrageEvent
  else
    self.doCompletedEvent = (self.UISidle).ConstructEvent
  end
  ;
  ((self.ui).stateItem):SetActive(false)
  ;
  ((self.ui).upgraded):SetActive(true)
  if (self.buildingItem).currentRemainSecond ~= nil and (self.buildingItem).currentRemainSecond > 0 then
    do
      local needTimestamp = (self.buildingData):GetNextLevelNeedTime()
      self.remainSecond = needTimestamp
      if self.remainSecond == nil or self.remainSecond > 0 then
        local state = (self.buildingItem).state
        if state == (BuildingItem.itemState).disnormal then
          return 
        else
          if state == (BuildingItem.itemState).normal then
            local isHideBtn = self:CheckConditionAndDispBtn()
            if not isHideBtn then
              self:UpdateCostItems()
            end
            ;
            (((self.ui).btn_Upgrade).gameObject):SetActive(not isHideBtn)
            ;
            (((self.ui).btn_BuildAcc).gameObject):SetActive(false)
          else
            do
              ;
              (((self.ui).btn_Upgrade).gameObject):SetActive(false)
              ;
              (((self.ui).btn_BuildAcc).gameObject):SetActive(true)
              self:UpdateLogic()
              -- DECOMPILER ERROR at PC96: Confused about usage of register: R2 in 'UnsetPending'

              if (self.buildingItem).waitForConfirm and not (self.buildingItem).alreadySendConfirm then
                (self.buildingItem).alreadySendConfirm = true
                ;
                (self.UISidle):SendConfirmCompleted(self.id)
              end
            end
          end
        end
      end
    end
  end
end

UIOasisBuildingItemDetail.CheckConditionAndDispBtn = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (self.predictionPool):HideAll()
  local canDoNext = false
  local dispCompBtn = false
  if self.isBuild then
    canDoNext = (self.buildingData):CanUpgrade()
  else
    canDoNext = ((self.buildingData).dynData):CanBuild()
  end
  if not canDoNext then
    if (self.buildingData):IsMaxLevel() then
      ((self.ui).upgraded):SetActive(false)
      ;
      ((self.ui).stateItem):SetActive(true)
      ;
      ((self.ui).maxItem):SetActive(true)
      ;
      ((self.ui).tex_Content):SetIndex(0)
      return true
    else
      local preDictionTable = (self.buildingData):GetPreBuildingLevelInfo()
      if preDictionTable ~= nil then
        local result = false
        for k,v in pairs(preDictionTable) do
          if v ~= nil and v.currentLevel < v.needLevel then
            local predictionItem = (self.predictionPool):GetOne()
            predictionItem:SetInfoItemTextIndex(1, k, v.needLevel)
            result = true
          end
        end
        if result then
          ((self.ui).upgraded):SetActive(false)
          ;
          ((self.ui).stateItem):SetActive(true)
          ;
          ((self.ui).maxItem):SetActive(false)
        end
        return result
      end
    end
  end
  do
    return false
  end
end

UIOasisBuildingItemDetail.UpdateAccCostItem = function(self, accItemList)
  -- function num : 0_5 , upvalues : _ENV
  (self.costMatPool):HideAll()
  for index,data in pairs(accItemList) do
    if data.num ~= 0 then
      local item = (self.costMatPool):GetOne(true)
      item:UpdateUI(data.id, data.needNum, data.num)
    else
      do
        do
          local item = (self.costMatPool):GetOne(true)
          item:UpdateUI(data.id, data.needNum, 0)
          -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

UIOasisBuildingItemDetail.UpdateLogic = function(self)
  -- function num : 0_6
  self:UpdateJumpLogic()
  self:UpdateBuffInfo()
  self:UpdateUpgradeBonusInfo()
end

UIOasisBuildingItemDetail.UpdateUpgradeBonusInfo = function(self)
  -- function num : 0_7 , upvalues : _ENV, bonusItemLimit
  if self.effectBonusPool == nil then
    return 
  end
  ;
  (self.effectBonusPool):HideAll()
  local currentCount = 1
  if self.buffDict ~= nil then
    for k,v in pairs(self.buffDict) do
      if bonusItemLimit >= currentCount then
        do
          if v ~= nil then
            local item = (self.effectBonusPool):GetOne()
            if v.nextInfoValue ~= nil then
              item:SetInfoItemTextIndex(0, v.currentInfo, v.nextInfoValue)
            else
              item:SetInfoItemTextIndex(1, v.currentInfo)
            end
            currentCount = currentCount + 1
          end
          -- DECOMPILER ERROR at PC37: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC37: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

UIOasisBuildingItemDetail.UpdateBuffInfo = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self.buffInfoPool == nil then
    return 
  end
  ;
  (self.buffInfoPool):HideAll()
  if self.buffDict ~= nil then
    for k,v in pairs(self.buffDict) do
      if v ~= nil then
        local item = (self.buffInfoPool):GetOne()
        item:SetInfoItemText(v.currentInfo)
      end
    end
  end
end

UIOasisBuildingItemDetail.UpdateCostItems = function(self)
  -- function num : 0_9 , upvalues : _ENV, costItemDispLimit
  if self.costMatPool == nil then
    return 
  end
  ;
  (self.costMatPool):HideAll()
  local needItemsInfo = (self.buildingData):GetNextLevelCostItem()
  ;
  (table.sort)(needItemsInfo, function(a, b)
    -- function num : 0_9_0
    do return a.resId < b.resId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local index = 1
  for i = 1, #needItemsInfo do
    if (needItemsInfo[i]).resCount > 0 then
      local costItem = (self.costMatPool):GetOne()
      costItem:UpdateUI((needItemsInfo[i]).resId, (needItemsInfo[i]).resCount, (needItemsInfo[i]).count)
      index = index + 1
    end
  end
  do
    if costItemDispLimit >= index then
      local emptyCount = costItemDispLimit - #needItemsInfo
      if emptyCount > 0 then
        for i = 1, emptyCount do
          local costItem = (self.costMatPool):GetOne()
          costItem:UpdateWithEmpty()
        end
      end
    end
  end
end

UIOasisBuildingItemDetail.UpdateJumpLogic = function(self)
  -- function num : 0_10
end

UIOasisBuildingItemDetail.UpdateLogicItems = function(self, itemPool, levelCfg, limit)
  -- function num : 0_11
end

UIOasisBuildingItemDetail.__UpdateTrainingSlots = function(self)
  -- function num : 0_12
end

UIOasisBuildingItemDetail.__OnClickUpdrage = function(self)
  -- function num : 0_13
  if self.doCompletedEvent ~= nil then
    (self.doCompletedEvent)()
  end
end

UIOasisBuildingItemDetail.Update = function(self, timestamp, isSecond)
  -- function num : 0_14
  if self.__forceUpdateProcess then
    self.__forceUpdateProcess = false
    self:__ForceUpdateProcess(timestamp)
  end
end

UIOasisBuildingItemDetail.__ForceUpdateProcess = function(self, timestamp)
  -- function num : 0_15 , upvalues : _ENV
  local progress, remainSecond = (self.buildingData):GetProcess(timestamp)
  local remainTimeText = TimestampToTime(remainSecond)
  self:UpdateProcessEvent(progress, remainTimeText, remainSecond)
end

UIOasisBuildingItemDetail.UpdateProcessEvent = function(self, progress, remainTimeText, second)
  -- function num : 0_16
  self.remainSecond = second
end

UIOasisBuildingItemDetail.WhenCreateFinlish = function(self)
  -- function num : 0_17
end

UIOasisBuildingItemDetail.OnShowInRect = function(self, rowRoot)
  -- function num : 0_18 , upvalues : base
  (self.transform):SetParent(rowRoot)
  ;
  (base.Show)(self)
end

UIOasisBuildingItemDetail.ResetQuestState = function(self)
  -- function num : 0_19
  self.isSendComplete = false
end

UIOasisBuildingItemDetail.OnDelete = function(self)
  -- function num : 0_20 , upvalues : base
  (base.OnDelete)(self)
end

return UIOasisBuildingItemDetail

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIOasisBuildingItemDetail = class("UIOasisBuildingItemDetail", UIBaseNode)
local base = UIBaseNode
local BuildingItem = require("Game.Oasis.UI.OasisSidle.UIOasisBuildingItem")
local InfoItem = require("Game.Oasis.UI.OasisSidle.UIOasisBuffInfoItem")
local CostMatInfo = require("Game.Oasis.UI.OasisSidle.UIOasisCostMatInfo")
local JumpManager = require("Game.Jump.JumpManager")
local costItemDispLimit = 3
local bonusItemLimit = 3
UIOasisBuildingItemDetail.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, CostMatInfo, InfoItem
    self.__resloader = resLoader;
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_Upgrade, self,
                               self.__OnClickUpdrage)
    self.costMatPool = (UIItemPool.New)(CostMatInfo, (self.ui).costItem)
    self.buffInfoPool = (UIItemPool.New)(InfoItem, (self.ui).currentLevelInfo)
    self.effectBonusPool = (UIItemPool.New)(InfoItem, (self.ui).effectUpItem)
    self.predictionPool = (UIItemPool.New)(InfoItem, (self.ui).predictionItem)
end

UIOasisBuildingItemDetail.InjectResloader =
    function(self, resLoader)
        -- function num : 0_1
        self.resLoader = resLoader
    end

UIOasisBuildingItemDetail.UpdateWithItemData =
    function(self, buildingItem)
        -- function num : 0_2 , upvalues : _ENV
        self.buildingItem = buildingItem
        self.buildingData = buildingItem.buildingData
        self.id = (self.buildingData).id
        self.UISidle = buildingItem.UISidle
        self.buffDict = buildingItem.buffDict
        self.isBuild = (self.buildingData).isBuild
        local upgradeTextIndex = self.isBuild and 1 or 0;
        ((self.ui).btn_Upgrade_Text):SetIndex(upgradeTextIndex) -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).img_Pic).texture = buildingItem.uiIcon -- DECOMPILER ERROR at PC33: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).tex_BulidName).text = (self.buildingData).name -- DECOMPILER ERROR at PC38: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).tex_EnName).text = (self.buildingData).nameEn;
        (((self.ui).tex_BulidLevel).gameObject):SetActive(
            buildingItem.isShowLevel);
        ((self.ui).tex_BulidLevel):SetIndex(0,
                                            tostring((self.buildingData).level))
        self:UpdateState()
    end

UIOasisBuildingItemDetail.UpdateState = function(self)
    -- function num : 0_3 , upvalues : BuildingItem
    self.ConfirmOverEvent = (self.UISidle).ConfirmOverEvent
    if self.isBuild then
        self.doCompletedEvent = (self.UISidle).UpdrageEvent
    else
        self.doCompletedEvent = (self.UISidle).ConstructEvent
    end
    ((self.ui).stateItem):SetActive(false);
    ((self.ui).upgraded):SetActive(true)
    if (self.buildingItem).currentRemainSecond ~= nil and
        (self.buildingItem).currentRemainSecond > 0 then
        do
            local needTimestamp = (self.buildingData):GetNextLevelNeedTime()
            self.remainSecond = needTimestamp
            if self.remainSecond == nil or self.remainSecond > 0 then
                local state = (self.buildingItem).state
                if state == (BuildingItem.itemState).disnormal then
                    return
                else
                    if state == (BuildingItem.itemState).normal then
                        local isHideBtn = self:CheckConditionAndDispBtn()
                        if not isHideBtn then
                            self:UpdateCostItems()
                        end
                        (((self.ui).btn_Upgrade).gameObject):SetActive(
                            not isHideBtn);
                        (((self.ui).btn_BuildAcc).gameObject):SetActive(false)
                    else
                        do

                            (((self.ui).btn_Upgrade).gameObject):SetActive(false);
                            (((self.ui).btn_BuildAcc).gameObject):SetActive(true)
                            self:UpdateLogic()
                            -- DECOMPILER ERROR at PC96: Confused about usage of register: R2 in 'UnsetPending'

                            if (self.buildingItem).waitForConfirm and
                                not (self.buildingItem).alreadySendConfirm then
                                (self.buildingItem).alreadySendConfirm = true;
                                (self.UISidle):SendConfirmCompleted(self.id)
                            end
                        end
                    end
                end
            end
        end
    end
end

UIOasisBuildingItemDetail.CheckConditionAndDispBtn =
    function(self)
        -- function num : 0_4 , upvalues : _ENV
        (self.predictionPool):HideAll()
        local canDoNext = false
        local dispCompBtn = false
        if self.isBuild then
            canDoNext = (self.buildingData):CanUpgrade()
        else
            canDoNext = ((self.buildingData).dynData):CanBuild()
        end
        if not canDoNext then
            if (self.buildingData):IsMaxLevel() then
                ((self.ui).upgraded):SetActive(false);
                ((self.ui).stateItem):SetActive(true);
                ((self.ui).maxItem):SetActive(true);
                ((self.ui).tex_Content):SetIndex(0)
                return true
            else
                local preDictionTable =
                    (self.buildingData):GetPreBuildingLevelInfo()
                if preDictionTable ~= nil then
                    local result = false
                    for k, v in pairs(preDictionTable) do
                        if v ~= nil and v.currentLevel < v.needLevel then
                            local predictionItem =
                                (self.predictionPool):GetOne()
                            predictionItem:SetInfoItemTextIndex(1, k,
                                                                v.needLevel)
                            result = true
                        end
                    end
                    if result then
                        ((self.ui).upgraded):SetActive(false);
                        ((self.ui).stateItem):SetActive(true);
                        ((self.ui).maxItem):SetActive(false)
                    end
                    return result
                end
            end
        end
        do return false end
    end

UIOasisBuildingItemDetail.UpdateAccCostItem =
    function(self, accItemList)
        -- function num : 0_5 , upvalues : _ENV
        (self.costMatPool):HideAll()
        for index, data in pairs(accItemList) do
            if data.num ~= 0 then
                local item = (self.costMatPool):GetOne(true)
                item:UpdateUI(data.id, data.needNum, data.num)
            else
                do
                    do
                        local item = (self.costMatPool):GetOne(true)
                        item:UpdateUI(data.id, data.needNum, 0)
                        -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out DO_STMT

                        -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                        -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out IF_STMT

                    end
                end
            end
        end
    end

UIOasisBuildingItemDetail.UpdateLogic = function(self)
    -- function num : 0_6
    self:UpdateJumpLogic()
    self:UpdateBuffInfo()
    self:UpdateUpgradeBonusInfo()
end

UIOasisBuildingItemDetail.UpdateUpgradeBonusInfo =
    function(self)
        -- function num : 0_7 , upvalues : _ENV, bonusItemLimit
        if self.effectBonusPool == nil then return end
        (self.effectBonusPool):HideAll()
        local currentCount = 1
        if self.buffDict ~= nil then
            for k, v in pairs(self.buffDict) do
                if bonusItemLimit >= currentCount then
                    do
                        if v ~= nil then
                            local item = (self.effectBonusPool):GetOne()
                            if v.nextInfoValue ~= nil then
                                item:SetInfoItemTextIndex(0, v.currentInfo,
                                                          v.nextInfoValue)
                            else
                                item:SetInfoItemTextIndex(1, v.currentInfo)
                            end
                            currentCount = currentCount + 1
                        end
                        -- DECOMPILER ERROR at PC37: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC37: LeaveBlock: unexpected jumping out IF_STMT

                    end
                end
            end
        end
    end

UIOasisBuildingItemDetail.UpdateBuffInfo =
    function(self)
        -- function num : 0_8 , upvalues : _ENV
        if self.buffInfoPool == nil then return end
        (self.buffInfoPool):HideAll()
        if self.buffDict ~= nil then
            for k, v in pairs(self.buffDict) do
                if v ~= nil then
                    local item = (self.buffInfoPool):GetOne()
                    item:SetInfoItemText(v.currentInfo)
                end
            end
        end
    end

UIOasisBuildingItemDetail.UpdateCostItems =
    function(self)
        -- function num : 0_9 , upvalues : _ENV, costItemDispLimit
        if self.costMatPool == nil then return end
        (self.costMatPool):HideAll()
        local needItemsInfo = (self.buildingData):GetNextLevelCostItem();
        (table.sort)(needItemsInfo, function(a, b)
            -- function num : 0_9_0
            do return a.resId < b.resId end
            -- DECOMPILER ERROR: 1 unprocessed JMP targets
        end)
        local index = 1
        for i = 1, #needItemsInfo do
            if (needItemsInfo[i]).resCount > 0 then
                local costItem = (self.costMatPool):GetOne()
                costItem:UpdateUI((needItemsInfo[i]).resId,
                                  (needItemsInfo[i]).resCount,
                                  (needItemsInfo[i]).count)
                index = index + 1
            end
        end
        do
            if costItemDispLimit >= index then
                local emptyCount = costItemDispLimit - #needItemsInfo
                if emptyCount > 0 then
                    for i = 1, emptyCount do
                        local costItem = (self.costMatPool):GetOne()
                        costItem:UpdateWithEmpty()
                    end
                end
            end
        end
    end

UIOasisBuildingItemDetail.UpdateJumpLogic =
    function(self)
        -- function num : 0_10
    end

UIOasisBuildingItemDetail.UpdateLogicItems =
    function(self, itemPool, levelCfg, limit)
        -- function num : 0_11
    end

UIOasisBuildingItemDetail.__UpdateTrainingSlots =
    function(self)
        -- function num : 0_12
    end

UIOasisBuildingItemDetail.__OnClickUpdrage =
    function(self)
        -- function num : 0_13
        if self.doCompletedEvent ~= nil then (self.doCompletedEvent)() end
    end

UIOasisBuildingItemDetail.Update = function(self, timestamp, isSecond)
    -- function num : 0_14
    if self.__forceUpdateProcess then
        self.__forceUpdateProcess = false
        self:__ForceUpdateProcess(timestamp)
    end
end

UIOasisBuildingItemDetail.__ForceUpdateProcess =
    function(self, timestamp)
        -- function num : 0_15 , upvalues : _ENV
        local progress, remainSecond = (self.buildingData):GetProcess(timestamp)
        local remainTimeText = TimestampToTime(remainSecond)
        self:UpdateProcessEvent(progress, remainTimeText, remainSecond)
    end

UIOasisBuildingItemDetail.UpdateProcessEvent =
    function(self, progress, remainTimeText, second)
        -- function num : 0_16
        self.remainSecond = second
    end

UIOasisBuildingItemDetail.WhenCreateFinlish =
    function(self)
        -- function num : 0_17
    end

UIOasisBuildingItemDetail.OnShowInRect =
    function(self, rowRoot)
        -- function num : 0_18 , upvalues : base
        (self.transform):SetParent(rowRoot);
        (base.Show)(self)
    end

UIOasisBuildingItemDetail.ResetQuestState =
    function(self)
        -- function num : 0_19
        self.isSendComplete = false
    end

UIOasisBuildingItemDetail.OnDelete = function(self)
    -- function num : 0_20 , upvalues : base
    (base.OnDelete)(self)
end

return UIOasisBuildingItemDetail


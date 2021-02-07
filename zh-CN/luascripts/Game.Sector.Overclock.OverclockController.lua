-- params : ...
-- function num : 0 , upvalues : _ENV
local OverclockController = class("OverclockController", ControllerBase)
local cs_MessageCommon = CS.MessageCommon
local eFmtFromModule = require("Game.Formation.Enum.eFmtFromModule")
local PeridicChallengeEnum = require("Game.PeriodicChallenge.PeridicChallengeEnum")
OverclockController.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.needRefresh = true
  self.allOverclockItem = {}
  self.selectedOverclockOptionList = {}
  self.tempSelectedOverclockOptionList = {}
  self.__curAssembleNum = 0
  self.__maxAssembleNum = (ConfigData.game_config).OverclockLimtNum
  self.advanceGNum = 0
  self.changeGCallBackList = {}
  self.showChipNodeCallback = nil
  self.changeChipCallbackList = {}
  self.notSelectCallbackList = {}
  self.unlockChipSetTable = {}
  self.chipDic = {}
  self.freeTimesDic = {}
  self.maxFreeNum = 0
  self.selectChangEvent = nil
  self.levelId = 1101
  self.__getUnlokChipSet = BindCallback(self, self.GetUnlokChipSet)
  MsgCenter:AddListener(eMsgEventId.SectorChipSet, self.__getUnlokChipSet)
  self.__onChangeGCallBack = BindCallback(self, self.__ChangeGCallBack)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onChangeGCallBack)
  self.networkContrl = NetworkManager:GetNetwork(NetworkTypeID.Sector)
  ;
  (self.networkContrl):SendChipSet()
  self:__GetStageAllChips()
end

OverclockController.RefreshData = function(self, callback)
  -- function num : 0_1
  (self.networkContrl):SendChipSet()
  self.allOverclockItem = {}
  self.maxFreeNum = self:ReadMaxFreeNum()
  if self.needRefresh then
    (self.networkContrl):CS_EXPLORATION_OVERCLOCK_Detail(callback)
  else
    if callback ~= nil then
      callback()
    end
  end
  self.needRefresh = false
end

OverclockController.GetOverClockOptionDatas = function(self, needfresh)
  -- function num : 0_2 , upvalues : _ENV
  if not needfresh and self.OCDatas ~= nil then
    return self.OCDatas
  end
  local OCDatas = {}
  for overclockId,cfgs in pairs(ConfigData.overclock) do
    local lv1Cfg = cfgs[1]
    local data = {}
    data.overclockId = overclockId
    data.isUnlock = (CheckCondition.CheckLua)(lv1Cfg.pre_condition, lv1Cfg.pre_para1, lv1Cfg.pre_para2)
    if data.isUnlock then
      data.overclockLevel = (PlayerDataCenter.playerBonus):GetOverClock(overclockId)
      if data.overclockLevel <= 0 then
        error("overclock option level blow 0, pls check common logic init.")
      end
    else
      data.unlockDes = (CheckCondition.GetUnlockInfoLua)(lv1Cfg.pre_condition, lv1Cfg.pre_para1, lv1Cfg.pre_para2)
    end
    ;
    (table.insert)(OCDatas, data)
  end
  self.OCDatas = OCDatas
  return self.OCDatas
end

OverclockController.SetOverclockDetail = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV
  local overclock = msg.data
  if overclock == nil then
    self.freeTimesDic = {}
  else
    local data = overclock.data
    if data == nil then
      self.freeTimesDic = {}
    else
      local timeStamp = PlayerDataCenter.timestamp
      for key,value in pairs(data) do
        -- DECOMPILER ERROR at PC21: Confused about usage of register: R10 in 'UnsetPending'

        (self.freeTimesDic)[value.id] = value.curFreeCnt
      end
    end
  end
  do
    for key,value in pairs(self.allOverclockItem) do
      value:__RefreshInfo()
    end
  end
end

OverclockController.GetDailyFreeNum = function(self, overclockId)
  -- function num : 0_4
  local freeNum = self.maxFreeNum
  if (self.freeTimesDic)[overclockId] == nil then
    return freeNum
  else
    return freeNum - (self.freeTimesDic)[overclockId]
  end
end

OverclockController.ReadMaxFreeNum = function(self)
  -- function num : 0_5 , upvalues : _ENV
  return (PlayerDataCenter.playerBonus):GetOverClockFreeNum()
end

OverclockController.GetIsHaveFree = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local OCDatas = self:GetOverClockOptionDatas(true)
  for _,OCData in pairs(OCDatas) do
    local num = self:GetDailyFreeNum(OCData.overclockId)
    if num > 0 then
      return true
    end
  end
end

OverclockController.SetStageId = function(self, id, fromModule)
  -- function num : 0_7
  self.levelId = id
  self:__GetStageAllChips(fromModule)
end

OverclockController.__GetStageAllChips = function(self, fromModule)
  -- function num : 0_8 , upvalues : eFmtFromModule, _ENV, PeridicChallengeEnum
  if fromModule == eFmtFromModule.SectorLevel then
    local sectorStageCfg = (ConfigData.sector_stage)[self.levelId]
    if sectorStageCfg == nil then
      return 
    end
    self.chipDic = {}
    for _,epId in pairs(sectorStageCfg.exploration_list) do
      local epCfg = (ConfigData.exploration)[epId]
      if epCfg ~= nil then
        for _,poolId in pairs(epCfg.chip_pool) do
          local funcPoolCfg = (ConfigData.ep_function_pool)[poolId]
          if funcPoolCfg ~= nil then
            for _,chipId in pairs(funcPoolCfg.function_pool) do
              -- DECOMPILER ERROR at PC35: Confused about usage of register: R20 in 'UnsetPending'

              (self.chipDic)[chipId] = true
            end
          end
        end
      end
    end
  else
    do
      if fromModule == eFmtFromModule.Infinity then
        self.chipDic = {}
        local endlessLevel = ((ConfigData.endless).levelDic)[self.levelId]
        if endlessLevel == nil then
          return 
        end
        local endlessCfg = ((ConfigData.endless)[endlessLevel.sectorId])[endlessLevel.index]
        if endlessCfg == nil then
          return 
        end
        local chips = endlessCfg.chip
        if chips == nil then
          return 
        end
        for _,chipId in ipairs(chips) do
          -- DECOMPILER ERROR at PC74: Confused about usage of register: R10 in 'UnsetPending'

          (self.chipDic)[chipId] = true
        end
      else
        do
          if fromModule == eFmtFromModule.PeriodicChallenge then
            self.chipDic = {}
            local chipList = (PlayerDataCenter.periodicChallengeData):GetDailyChallengeChipList((PeridicChallengeEnum.eChallengeType).daliy)
            if chipList == nil then
              return 
            end
            for _,chipId in pairs(chipList) do
              -- DECOMPILER ERROR at PC97: Confused about usage of register: R8 in 'UnsetPending'

              (self.chipDic)[chipId] = true
            end
          end
        end
      end
    end
  end
end

OverclockController.GetUnlokChipSet = function(self, chipSetTab)
  -- function num : 0_9
  self.unlockChipSetTable = chipSetTab
end

OverclockController.IsChipUnlock = function(self, chipId)
  -- function num : 0_10
  do return (self.unlockChipSetTable)[chipId] ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

OverclockController.IsAllChipsLocked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  for chipId,chipData in pairs(self.chipDic) do
    if self:IsChipUnlock(chipId) then
      return false
    end
  end
  return true
end

OverclockController.GetRandomChipId = function(self)
  -- function num : 0_12 , upvalues : _ENV, cs_MessageCommon
  local intersection = {}
  for chipId,_ in pairs(self.chipDic) do
    if self:IsChipUnlock(chipId) then
      (table.insert)(intersection, chipId)
    end
  end
  local bestQualityChipList = {}
  local bestQuality = eItemQualityType.White
  for _,chipId in ipairs(intersection) do
    local itemCfg = (ConfigData.item)[chipId]
    if itemCfg == nil then
      error("itemCfg is null,id:" .. tostring(chipId))
    else
      if bestQuality < itemCfg.quality then
        bestQualityChipList = {}
        bestQuality = itemCfg.quality
        ;
        (table.insert)(bestQualityChipList, chipId)
      else
        if bestQuality == itemCfg.quality then
          (table.insert)(bestQualityChipList, chipId)
        end
      end
    end
  end
  if #bestQualityChipList > 0 then
    local randomIndex = (math.random)(1, #bestQualityChipList)
    return bestQualityChipList[randomIndex]
  else
    do
      ;
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Overclock_DonorHaveUnlockChip))
      do return nil end
    end
  end
end

OverclockController.AddOverClockOption = function(self, id, level)
  -- function num : 0_13
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  if (self.tempSelectedOverclockOptionList)[id] == nil then
    (self.tempSelectedOverclockOptionList)[id] = {id = id, level = level}
  end
end

OverclockController.RemoveOverClockOption = function(self, id)
  -- function num : 0_14
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.tempSelectedOverclockOptionList)[id] = nil
  self:ChangeChip(id, nil)
end

OverclockController.SetChip2OverClockOption = function(self, id, chipId)
  -- function num : 0_15
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self.tempSelectedOverclockOptionList)[id]).param = chipId
  self:ChangeChip(id, chipId)
  if chipId == nil then
    self:NotSelect(id)
  end
end

OverclockController.GetChip2OverClockOption = function(self, id)
  -- function num : 0_16
  if (self.tempSelectedOverclockOptionList)[id] == nil then
    return nil
  end
  return ((self.tempSelectedOverclockOptionList)[id]).param
end

OverclockController.OnConfirm = function(self)
  -- function num : 0_17 , upvalues : _ENV
  self.selectedOverclockOptionList = {}
  for key,value in pairs(self.tempSelectedOverclockOptionList) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

    (self.selectedOverclockOptionList)[key] = value
  end
  if self.selectChangEvent ~= nil then
    (self.selectChangEvent)()
  end
end

OverclockController.whenInitCopyData = function(self)
  -- function num : 0_18 , upvalues : _ENV
  self.tempSelectedOverclockOptionList = {}
  for key,value in pairs(self.selectedOverclockOptionList) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

    (self.tempSelectedOverclockOptionList)[key] = value
  end
end

OverclockController.CleanData = function(self)
  -- function num : 0_19
  self.selectedOverclockOptionList = {}
end

OverclockController.UseOverClock = function(self)
  -- function num : 0_20 , upvalues : _ENV
  for _,data in pairs(self.selectedOverclockOptionList) do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R6 in 'UnsetPending'

    if not (self.freeTimesDic)[data.id] then
      do
        (self.freeTimesDic)[data.id] = (self:GetDailyFreeNum(data.id) <= 0 or 0) + 1
        -- DECOMPILER ERROR at PC19: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC19: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  return self.selectedOverclockOptionList
end

OverclockController.ShowOverclockUI = function(self)
  -- function num : 0_21 , upvalues : _ENV
  self:whenInitCopyData()
  UIManager:ShowWindowAsync(UIWindowTypeID.OverClock)
end

OverclockController.CloseOverclockUI = function(self)
  -- function num : 0_22 , upvalues : _ENV
  for key,item in ipairs(self.allOverclockItem) do
    item:SetNotSelect(item.overclockId)
  end
  self.showChipNodeCallback = nil
  UIManager:DeleteWindow(UIWindowTypeID.OverClock)
end

OverclockController.SetOverClockItem = function(self, item)
  -- function num : 0_23 , upvalues : _ENV
  (table.insert)(self.allOverclockItem, item)
end

OverclockController.ChangeChip = function(self, overclockId, chipId)
  -- function num : 0_24 , upvalues : _ENV
  if self.changeChipCallbackList ~= nil then
    for _,callback in ipairs(self.changeChipCallbackList) do
      callback(overclockId, chipId)
    end
  end
end

OverclockController.SetChangeChipCallback = function(self, callback)
  -- function num : 0_25 , upvalues : _ENV
  (table.insert)(self.changeChipCallbackList, callback)
end

OverclockController.NotSelect = function(self, overclockId)
  -- function num : 0_26 , upvalues : _ENV
  if self.notSelectCallbackList ~= nil then
    for _,callback in ipairs(self.notSelectCallbackList) do
      callback(overclockId)
    end
  end
end

OverclockController.SetNotSelectCallback = function(self, callback)
  -- function num : 0_27 , upvalues : _ENV
  (table.insert)(self.notSelectCallbackList, callback)
end

OverclockController.ShowChipSelectNode = function(self, overclockId)
  -- function num : 0_28
  if self.showChipNodeCallback ~= nil then
    (self.showChipNodeCallback)(overclockId)
  end
end

OverclockController.SetShowChipSelectNode = function(self, callback)
  -- function num : 0_29
  self.showChipNodeCallback = callback
end

OverclockController.AddChangeGCallBack = function(self, callback)
  -- function num : 0_30 , upvalues : _ENV
  (table.insert)(self.changeGCallBackList, callback)
  self:__ChangeGCallBack()
end

OverclockController.RemoveChangeGCallBack = function(self, callback)
  -- function num : 0_31 , upvalues : _ENV
  (table.removebyvalue)(self.changeGCallBackList, callback)
end

OverclockController.__ChangeGCallBack = function(self)
  -- function num : 0_32 , upvalues : _ENV
  local gNum = PlayerDataCenter:GetItemCount(ConstGlobalItem.NormalGold)
  for _,callback in ipairs(self.changeGCallBackList) do
    callback(gNum - self.advanceGNum, self.advanceGNum)
  end
end

OverclockController.AddAdvancedGNum = function(self, num)
  -- function num : 0_33 , upvalues : _ENV, cs_MessageCommon
  if PlayerDataCenter:GetItemCount(ConstGlobalItem.NormalGold) < self.advanceGNum + num then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Overclock_GInsufficient))
    return false
  end
  self.advanceGNum = self.advanceGNum + num
  self:__ChangeGCallBack()
  return true
end

OverclockController.MinAdvancedGNum = function(self, num)
  -- function num : 0_34
  if self.advanceGNum < num then
    return false
  end
  self.advanceGNum = self.advanceGNum - num
  self:__ChangeGCallBack()
  return true
end

OverclockController.AddAssembleNum = function(self)
  -- function num : 0_35 , upvalues : cs_MessageCommon, _ENV
  if self.__maxAssembleNum < self.__curAssembleNum + 1 then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Overclock_AssembleNumLimit))
    return false
  end
  self.__curAssembleNum = self.__curAssembleNum + 1
  return true
end

OverclockController.MinAssembleNum = function(self)
  -- function num : 0_36 , upvalues : _ENV
  if self.__curAssembleNum - 1 < 0 then
    error("overclock error: assemble num less than 0")
    return false
  end
  self.__curAssembleNum = self.__curAssembleNum - 1
  return true
end

OverclockController.GetAssembleNum = function(self)
  -- function num : 0_37
  return self.__curAssembleNum, self.__maxAssembleNum
end

OverclockController.CleanCallback = function(self)
  -- function num : 0_38
  self.changeChipCallbackList = {}
  self.notSelectCallbackList = {}
end

OverclockController.OnDelete = function(self)
  -- function num : 0_39 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.SectorChipSet, self.__getUnlokChipSet)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__ChangeGCallBack)
end

return OverclockController


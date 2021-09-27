local CacheSaveData = class("CacheSaveData")
CacheSaveData.ctor = function(self)
  -- function num : 0_0
end

CacheSaveData.GetEnableLotteryPaidExecuteConfirm = function(self)
  -- function num : 0_1
  if self.enableLotteryPaidExecuteConfirm == nil then
    self.enableLotteryPaidExecuteConfirm = true
  end
  return self.enableLotteryPaidExecuteConfirm
end

CacheSaveData.SetEnableLotteryPaidExecuteConfirm = function(self, enable)
  -- function num : 0_2
  self.enableLotteryPaidExecuteConfirm = enable
end

CacheSaveData.GetEnableEpRewardBagExitConfirm = function(self)
  -- function num : 0_3
  if self.enableEpRewardBagExitConfirm == nil then
    self.enableEpRewardBagExitConfirm = true
  end
  return self.enableEpRewardBagExitConfirm
end

CacheSaveData.SetEnableEpRewardBagExitConfirm = function(self, enable)
  -- function num : 0_4
  self.enableEpRewardBagExitConfirm = enable
end

CacheSaveData.SetSpecificHeroListSort = function(self, fid, eSortMannerType, isAsceSort)
  -- function num : 0_5
  if self.specificHeroListSort == nil then
    self.specificHeroListSort = {}
  end
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.specificHeroListSort)[fid] = {eSortMannerType = eSortMannerType, isAsceSort = isAsceSort}
end

CacheSaveData.GetSpecificHeroListSort = function(self, fid)
  -- function num : 0_6
  if self.specificHeroListSort == nil or (self.specificHeroListSort)[fid] == nil then
    return nil
  end
  local pecificHeroListSortData = (self.specificHeroListSort)[fid]
  return pecificHeroListSortData.eSortMannerType, pecificHeroListSortData.isAsceSort
end

CacheSaveData.GetOasisSkyHourOffset = function(self)
  -- function num : 0_7
  return self.oasisSkyHour or 0
end

CacheSaveData.SetOasisSkyHourOffset = function(self, value)
  -- function num : 0_8
  if self.oasisSkyHour ~= value then
    self.oasisSkyHour = value
  end
end

CacheSaveData.GetOasisSkyMonthOffset = function(self)
  -- function num : 0_9
  return self.oasisSkyMonth or 0
end

CacheSaveData.SetOasisSkyMonthOffset = function(self, value)
  -- function num : 0_10
  if self.oasisSkyMonth ~= value then
    self.oasisSkyMonth = value
  end
end

return CacheSaveData


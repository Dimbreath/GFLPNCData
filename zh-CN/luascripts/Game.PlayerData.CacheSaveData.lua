-- params : ...
-- function num : 0 , upvalues : _ENV
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

return CacheSaveData


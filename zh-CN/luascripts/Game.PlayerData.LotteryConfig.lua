-- params : ...
-- function num : 0 , upvalues : _ENV
local LotteryConfig = class("LotteryConfig")
LotteryConfig.ctor = function(self)
  -- function num : 0_0
  self.NextFreeTime = 0
end

return LotteryConfig


-- params : ...
-- function num : 0 , upvalues : _ENV
local AllLtrPoolData = class("AllLtrPoolData")
local LotteryPoolData = require("Game.Lottery.Data.LotteryPoolData")
AllLtrPoolData.ctor = function(self)
  -- function num : 0_0
  self:InitAllLtrPoolData()
end

AllLtrPoolData.InitAllLtrPoolData = function(self)
  -- function num : 0_1 , upvalues : _ENV, LotteryPoolData
  self.ltrDataList = {}
  self.ltrDataDic = {}
  for ltrId,v in pairs(ConfigData.lottery_para) do
    local ltrData = (LotteryPoolData.New)(ltrId)
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self.ltrDataDic)[ltrId] = ltrData
    ;
    (table.insert)(self.ltrDataList, ltrData)
  end
end

AllLtrPoolData.UpdAllLtrPoolData = function(self, detail)
  -- function num : 0_2 , upvalues : _ENV
  for ltrId,v in pairs(detail) do
    local ltrData = (self.ltrDataDic)[ltrId]
    if ltrData ~= nil then
      ltrData:UpdLtrPoolData(v)
    end
  end
end

AllLtrPoolData.GetOpeningLtrPoolDataList = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local ltrDataList = {}
  for ltrId,ltrData in pairs(self.ltrDataDic) do
    if ltrData:IsLtrPoolOpen() then
      (table.insert)(ltrDataList, ltrData)
    end
  end
  ;
  (table.sort)(ltrDataList, function(a, b)
    -- function num : 0_3_0 , upvalues : _ENV
    do return ((ConfigData.lottery_para)[a.poolId]).line < ((ConfigData.lottery_para)[b.poolId]).line end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return ltrDataList
end

AllLtrPoolData.GetIsSpecificPoolOpen = function(self, ltrId)
  -- function num : 0_4
  local ltrData = (self.ltrDataDic)[ltrId]
  if ltrData == nil then
    return false
  end
  return ltrData:IsLtrPoolOpen()
end

return AllLtrPoolData


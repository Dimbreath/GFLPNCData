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
  self.ltrRecords = {}
  self.ltrSpecial = {}
  self.__maxRecords = 20
  for ltrId,v in pairs(ConfigData.lottery_para) do
    local ltrData = (LotteryPoolData.New)(ltrId)
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self.ltrDataDic)[ltrId] = ltrData
    ;
    (table.insert)(self.ltrDataList, ltrData)
  end
end

AllLtrPoolData.UpdSpecialAndRecordsData = function(self, specialMissFix, records)
  -- function num : 0_2 , upvalues : _ENV
  if specialMissFix ~= nil then
    for k,v in pairs(specialMissFix) do
      -- DECOMPILER ERROR at PC9: Confused about usage of register: R8 in 'UnsetPending'

      (self.ltrSpecial)[v.id] = v.miss
    end
  end
  do
    if #records > 0 then
      local ltrRecords = {}
      for k,v in ipairs(records) do
        (table.insert)(ltrRecords, 1, v)
      end
      self.ltrRecords = ltrRecords
    end
  end
end

AllLtrPoolData.UpdAllLtrPoolData = function(self, detail)
  -- function num : 0_3 , upvalues : _ENV
  for ltrId,v in pairs(detail) do
    local ltrData = (self.ltrDataDic)[ltrId]
    if ltrData ~= nil then
      ltrData:UpdLtrPoolData(v)
    end
  end
end

AllLtrPoolData.SetDrawHeroRankCount = function(self, drawHeroRankCount)
  -- function num : 0_4
  self.drawHeroRankCount = drawHeroRankCount
end

AllLtrPoolData.IsDrawHeroRankCountAboveZero = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if (PlayerDataCenter.allLtrData).drawHeroRankCount ~= nil and (PlayerDataCenter.allLtrData).drawHeroRankCount > 0 then
    return true
  end
end

AllLtrPoolData.GetOpeningLtrPoolDataList = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local ltrDataList = {}
  for ltrId,ltrData in pairs(self.ltrDataDic) do
    if ltrData:IsLtrPoolOpen() then
      (table.insert)(ltrDataList, ltrData)
    end
  end
  ;
  (table.sort)(ltrDataList, function(a, b)
    -- function num : 0_6_0 , upvalues : _ENV
    do return ((ConfigData.lottery_para)[a.poolId]).line < ((ConfigData.lottery_para)[b.poolId]).line end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return ltrDataList
end

AllLtrPoolData.GetIsSpecificPoolOpen = function(self, ltrId)
  -- function num : 0_7
  local ltrData = (self.ltrDataDic)[ltrId]
  if ltrData == nil then
    return false
  end
  return ltrData:IsLtrPoolOpen()
end

return AllLtrPoolData


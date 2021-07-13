-- params : ...
-- function num : 0 , upvalues : _ENV
local RecommeFormationData = class("RecommeFormationData")
local RecommeFormationSingleData = require("Game.Formation.Data.RecommeFormationSingleData")
RecommeFormationData.ctor = function(self)
  -- function num : 0_0
  self.list = {}
end

RecommeFormationData.CreateData = function(stageId, msg)
  -- function num : 0_1 , upvalues : RecommeFormationData, RecommeFormationSingleData, _ENV
  local data = RecommeFormationData:New()
  data.stageId = stageId
  data.refreshTime = msg.refreshTime or 0
  for i = 1, #msg.data do
    local singleData = (RecommeFormationSingleData.CreateData)((msg.data)[i])
    ;
    (table.insert)(data.list, singleData)
  end
  return data
end

RecommeFormationData.SortByPower = function(self)
  -- function num : 0_2 , upvalues : _ENV, RecommeFormationData
  (table.sort)(self.list, RecommeFormationData.__DefaultSort)
end

RecommeFormationData.SortByHeroCount = function(self)
  -- function num : 0_3 , upvalues : _ENV, RecommeFormationData
  for key,value in pairs(self.list) do
    value.haveCount = value:GetHaveCount()
  end
  ;
  (table.sort)(self.list, RecommeFormationData.__CountSort)
end

RecommeFormationData.__CountSort = function(a, b)
  -- function num : 0_4 , upvalues : RecommeFormationData
  local aHasAll = a.haveCount == a.heroCount
  local bHasAll = b.haveCount == b.heroCount
  if aHasAll ~= bHasAll then
    return aHasAll
  end
  if a.heroCount ~= b.heroCount then
    if a.heroCount >= b.heroCount then
      do return not aHasAll end
      do return (RecommeFormationData.__DefaultSort)(a, b) end
      if b.heroCount >= a.heroCount then
        do return a.haveCount == b.haveCount end
        do return (RecommeFormationData.__DefaultSort)(a, b) end
        -- DECOMPILER ERROR: 8 unprocessed JMP targets
      end
    end
  end
end

RecommeFormationData.__DefaultSort = function(a, b)
  -- function num : 0_5
  if a.power >= b.power then
    do return a.power == b.power end
    if a.heroCount >= b.heroCount then
      do return a.heroCount == b.heroCount end
      if a.starMax >= b.starMax then
        do return a.starMax == b.starMax end
        if a.levelMax >= b.levelMax then
          do return a.levelMax == b.levelMax end
          do return a.idAddtion < b.idAddtion end
          -- DECOMPILER ERROR: 9 unprocessed JMP targets
        end
      end
    end
  end
end

return RecommeFormationData


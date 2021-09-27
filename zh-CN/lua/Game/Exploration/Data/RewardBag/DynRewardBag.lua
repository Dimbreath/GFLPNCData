local DynRewardBag = class("DynRewardBag")
DynRewardBag.InitEpDynRewardBag = function(self, epStmGoods)
  -- function num : 0_0 , upvalues : _ENV
  self.rewardBagDataList = {}
  if epStmGoods ~= nil then
    for k,elem in ipairs(epStmGoods.stmStore) do
      (table.insert)(self.rewardBagDataList, elem)
    end
  end
end

DynRewardBag.UpdateEpDynRewardBag = function(self, epStmGoodsList)
  -- function num : 0_1 , upvalues : _ENV
  for k,elem in ipairs(epStmGoodsList) do
    (table.insert)(self.rewardBagDataList, elem)
  end
  self.lastRewardDataList = epStmGoodsList
end

DynRewardBag.GetEpRewardBagDataList = function(self)
  -- function num : 0_2
  return self.rewardBagDataList
end

DynRewardBag.GetEpRewardBagDataDic = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local rewardDic = {}
  for k,v in ipairs(self.rewardBagDataList) do
    if rewardDic[v.itemId] == nil then
      rewardDic[v.itemId] = v.num
    else
      rewardDic[v.itemId] = rewardDic[v.itemId] + v.num
    end
  end
  return rewardDic
end

DynRewardBag.HasEpRewardBagData = function(self)
  -- function num : 0_4
  do return #self.rewardBagDataList > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynRewardBag.TryGetLastEpRewardBagDataList = function(self)
  -- function num : 0_5
  local lastRewardDataList = self.lastRewardDataList
  self.lastRewardDataList = nil
  return lastRewardDataList
end

return DynRewardBag


local InfinityData = class("InfinityData")
InfinityData.ctor = function(self)
  -- function num : 0_0
  self.sectorCompleteDic = {}
  self.processingLevel = {}
  self.jumpLevelInfo = {}
end

InfinityData.InitInfinityData = function(self, highest, processing)
  -- function num : 0_1 , upvalues : _ENV
  if highest ~= nil then
    for _sectorId,dungeonId in pairs(highest) do
      local sectorId, index = self:__GetInfinityDungeonInfo(dungeonId)
      if _sectorId ~= sectorId then
        error("server infinity sectorId:" .. tostring(_sectorId) .. " local infinty sectorId:" .. tostring(sectorId))
      end
      -- DECOMPILER ERROR at PC23: Confused about usage of register: R10 in 'UnsetPending'

      ;
      (self.sectorCompleteDic)[sectorId] = index
    end
  end
  do
    if processing ~= nil then
      (table.merge)(self.processingLevel, processing)
    end
  end
end

InfinityData.UpdateInfinityData = function(self, completed, processingUpdate)
  -- function num : 0_2 , upvalues : _ENV
  if completed ~= nil then
    for dungeonId,_ in pairs(completed) do
      local sectorId, index = self:__GetInfinityDungeonInfo(dungeonId)
      if (self.sectorCompleteDic)[sectorId] ~= nil then
        if index - (self.sectorCompleteDic)[sectorId] > 1 then
          self:__GenJumpLevelInfo(sectorId, index)
        end
        -- DECOMPILER ERROR at PC23: Confused about usage of register: R10 in 'UnsetPending'

        ;
        (self.sectorCompleteDic)[sectorId] = index
      else
        if index > 1 then
          self:__GenJumpLevelInfo(sectorId, index)
        end
        -- DECOMPILER ERROR at PC32: Confused about usage of register: R10 in 'UnsetPending'

        ;
        (self.sectorCompleteDic)[sectorId] = index
      end
    end
  end
  do
    if processingUpdate ~= nil then
      (table.merge)(self.processingLevel, processingUpdate)
    end
  end
end

InfinityData.IsInfinityDungeonCompleted = function(self, dungeonId)
  -- function num : 0_3
  local sectorId, index = self:__GetInfinityDungeonInfo(dungeonId)
  if (self.sectorCompleteDic)[sectorId] ~= nil and index <= (self.sectorCompleteDic)[sectorId] then
    return true
  end
  return false
end

InfinityData.GetInfinityDungeonProcess = function(self, dungeonId)
  -- function num : 0_4
  if self.processingLevel ~= nil and (self.processingLevel)[dungeonId] ~= nil then
    return (self.processingLevel)[dungeonId]
  end
end

InfinityData.GetCompletedInfinityLevelNum = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local num = 0
  for sectorId,maxIndex in pairs(self.sectorCompleteDic) do
    num = num + maxIndex
  end
  return num
end

InfinityData.GetJumpLevelReward = function(self, sectorId)
  -- function num : 0_6
  if (self.jumpLevelInfo)[sectorId] ~= nil then
    return ((self.jumpLevelInfo)[sectorId]).items
  end
end

InfinityData.CleanJumpLevelReward = function(self, sectorId)
  -- function num : 0_7
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.jumpLevelInfo)[sectorId] = nil
end

InfinityData.__GetInfinityDungeonInfo = function(self, dungeonId)
  -- function num : 0_8 , upvalues : _ENV
  local levelDicCfg = ((ConfigData.endless).levelDic)[dungeonId]
  if levelDicCfg ~= nil then
    return levelDicCfg.sectorId, levelDicCfg.index
  end
end

InfinityData.__GenJumpLevelInfo = function(self, sectorId, freshIndex)
  -- function num : 0_9 , upvalues : _ENV
  local info = {}
  local items = {}
  local oldHeighestIndex = (self.sectorCompleteDic)[sectorId] or 1
  for index = oldHeighestIndex + 1, freshIndex do
    local endlessCfg = ((ConfigData.endless)[sectorId])[index]
    local dungeonId = endlessCfg.id
    local startLayer = 1
    if (self.processingLevel)[dungeonId] ~= nil then
      info[dungeonId] = (self.processingLevel)[dungeonId]
      startLayer = (self.processingLevel)[dungeonId] + 1
    else
      info[dungeonId] = true
      startLayer = 1
    end
    for i = startLayer, #endlessCfg.layer do
      local layerId = (endlessCfg.layer)[i]
      if layerId == nil then
        error("layerId is nil ,sectorId=" .. tostring(sectorId) .. " index=" .. tostring(i))
      else
        local layerCfg = (ConfigData.endless_layer)[layerId]
        if layerCfg == nil then
          error("layerCfg is nil with id=" .. tostring(layerId))
        else
          for index,itemId in ipairs(layerCfg.reward_itemIds) do
            if items[itemId] ~= nil then
              items[itemId] = items[itemId] + (layerCfg.reward_itemNums)[index]
            else
              items[itemId] = (layerCfg.reward_itemNums)[index]
            end
          end
        end
      end
    end
    for index,itemId in ipairs(endlessCfg.clear_reward_itemIds) do
      if items[itemId] ~= nil then
        items[itemId] = items[itemId] + (endlessCfg.clear_reward_itemNums)[index]
      else
        items[itemId] = (endlessCfg.clear_reward_itemNums)[index]
      end
    end
  end
  -- DECOMPILER ERROR at PC107: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.jumpLevelInfo)[sectorId] = {info = info, items = items}
end

InfinityData.GetCanCompleteInfinityMinPower = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local endlessCfg = nil
  for _,sectorId in ipairs((ConfigData.sector).id_sort_list) do
    if (PlayerDataCenter.sectorStage):IsSectorUnlock(sectorId) then
      local nowCompleteIndex = (self.sectorCompleteDic)[sectorId]
      if nowCompleteIndex == nil then
        nowCompleteIndex = 5
      else
        nowCompleteIndex = nowCompleteIndex + 5
        nowCompleteIndex = nowCompleteIndex - (nowCompleteIndex) % 5
      end
      local tempEndlessCfg = ((ConfigData.endless)[sectorId])[nowCompleteIndex]
      if tempEndlessCfg ~= nil and (endlessCfg == nil or tempEndlessCfg.combat < endlessCfg.combat) then
        endlessCfg = tempEndlessCfg
      end
    end
  end
  return endlessCfg
end

return InfinityData


-- params : ...
-- function num : 0 , upvalues : _ENV
local EpDataCenter = class("EpDataCenter")
local eDetailType = (require("Game.Sector.Enum.SectorLevelDetailEnum")).eDetailType
EpDataCenter.ctor = function(self)
  -- function num : 0_0
end

EpDataCenter.InitEpDataCenter = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self.epChipIdDic = {}
  self.__onSetEpChipUpdate = BindCallback(self, self.OnSetEpChipUpdate)
  MsgCenter:AddListener(eMsgEventId.SectorChipSet, self.__onSetEpChipUpdate)
end

EpDataCenter.GetStageEpChipData = function(self, stageCfg)
  -- function num : 0_2 , upvalues : _ENV
  local chipDic = {}
  for k,v in pairs(stageCfg.function_extra) do
    chipDic[v] = true
  end
  for _,epId in pairs(stageCfg.exploration_list) do
    local epCfg = (ConfigData.exploration)[epId]
    if epCfg ~= nil then
      for _,poolId in pairs(epCfg.chip_pool) do
        local funcPoolCfg = (ConfigData.ep_function_pool)[poolId]
        if funcPoolCfg ~= nil then
          for _,chipId in pairs(funcPoolCfg.function_pool) do
            chipDic[chipId] = true
          end
        end
      end
    end
  end
  for itemId,_ in pairs(chipDic) do
    local isChip = ConfigData:GetItemType(itemId) == eItemType.GlobalChip
    -- DECOMPILER ERROR at PC54: Confused about usage of register: R9 in 'UnsetPending'

    if isChip then
      (self.epChipIdDic)[itemId] = true
    end
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

EpDataCenter.GetInfinityEpChipData = function(self, infinityCfg)
  -- function num : 0_3 , upvalues : _ENV
  local chipDic = {}
  for k,v in pairs(infinityCfg.chip) do
    chipDic[v] = true
  end
  for itemId,_ in pairs(chipDic) do
    local isChip = ConfigData:GetItemType(itemId) == eItemType.GlobalChip
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R9 in 'UnsetPending'

    if isChip then
      (self.epChipIdDic)[itemId] = true
    end
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

EpDataCenter.OnSetEpChipUpdate = function(self, chipSetTab)
  -- function num : 0_4 , upvalues : _ENV
  for chipId,_ in pairs(self.epChipIdDic) do
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R7 in 'UnsetPending'

    if chipSetTab[chipId] ~= nil then
      (self.epChipIdDic)[chipId] = false
    end
  end
end

EpDataCenter.AddNewChip = function(self, chipId)
  -- function num : 0_5 , upvalues : _ENV
  if chipId == nil then
    error("chipId is not found")
    return 
  end
  local isNew = self:IsNewChip(chipId)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

  if isNew or isNew == nil then
    (self.epChipIdDic)[chipId] = false
  end
end

EpDataCenter.IsNewChip = function(self, chipId)
  -- function num : 0_6
  return (self.epChipIdDic)[chipId]
end

EpDataCenter.GetEpChipIdDic = function(self)
  -- function num : 0_7
  return self.epChipIdDic
end

EpDataCenter.CleanEpDataCenter = function(self)
  -- function num : 0_8 , upvalues : _ENV
  self.levelChipIdDic = nil
  MsgCenter:RemoveListener(eMsgEventId.SectorChipSet, self.__onSetEpChipUpdate)
end

return EpDataCenter

-- params : ...
-- function num : 0 , upvalues : _ENV
local EpDataCenter = class("EpDataCenter")
local eDetailType =
    (require("Game.Sector.Enum.SectorLevelDetailEnum")).eDetailType
EpDataCenter.ctor = function(self)
    -- function num : 0_0
end

EpDataCenter.InitEpDataCenter = function(self)
    -- function num : 0_1 , upvalues : _ENV
    self.epChipIdDic = {}
    self.__onSetEpChipUpdate = BindCallback(self, self.OnSetEpChipUpdate)
    MsgCenter:AddListener(eMsgEventId.SectorChipSet, self.__onSetEpChipUpdate)
end

EpDataCenter.GetStageEpChipData = function(self, stageCfg)
    -- function num : 0_2 , upvalues : _ENV
    local chipDic = {}
    for k, v in pairs(stageCfg.function_extra) do chipDic[v] = true end
    for _, epId in pairs(stageCfg.exploration_list) do
        local epCfg = (ConfigData.exploration)[epId]
        if epCfg ~= nil then
            for _, poolId in pairs(epCfg.chip_pool) do
                local funcPoolCfg = (ConfigData.ep_function_pool)[poolId]
                if funcPoolCfg ~= nil then
                    for _, chipId in pairs(funcPoolCfg.function_pool) do
                        chipDic[chipId] = true
                    end
                end
            end
        end
    end
    for itemId, _ in pairs(chipDic) do
        local isChip = ConfigData:GetItemType(itemId) == eItemType.GlobalChip
        -- DECOMPILER ERROR at PC54: Confused about usage of register: R9 in 'UnsetPending'

        if isChip then (self.epChipIdDic)[itemId] = true end
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

EpDataCenter.GetInfinityEpChipData = function(self, infinityCfg)
    -- function num : 0_3 , upvalues : _ENV
    local chipDic = {}
    for k, v in pairs(infinityCfg.chip) do chipDic[v] = true end
    for itemId, _ in pairs(chipDic) do
        local isChip = ConfigData:GetItemType(itemId) == eItemType.GlobalChip
        -- DECOMPILER ERROR at PC25: Confused about usage of register: R9 in 'UnsetPending'

        if isChip then (self.epChipIdDic)[itemId] = true end
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

EpDataCenter.OnSetEpChipUpdate = function(self, chipSetTab)
    -- function num : 0_4 , upvalues : _ENV
    for chipId, _ in pairs(self.epChipIdDic) do
        -- DECOMPILER ERROR at PC8: Confused about usage of register: R7 in 'UnsetPending'

        if chipSetTab[chipId] ~= nil then
            (self.epChipIdDic)[chipId] = false
        end
    end
end

EpDataCenter.AddNewChip = function(self, chipId)
    -- function num : 0_5 , upvalues : _ENV
    if chipId == nil then
        error("chipId is not found")
        return
    end
    local isNew = self:IsNewChip(chipId)
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

    if isNew or isNew == nil then (self.epChipIdDic)[chipId] = false end
end

EpDataCenter.IsNewChip = function(self, chipId)
    -- function num : 0_6
    return (self.epChipIdDic)[chipId]
end

EpDataCenter.GetEpChipIdDic = function(self)
    -- function num : 0_7
    return self.epChipIdDic
end

EpDataCenter.CleanEpDataCenter = function(self)
    -- function num : 0_8 , upvalues : _ENV
    self.levelChipIdDic = nil
    MsgCenter:RemoveListener(eMsgEventId.SectorChipSet, self.__onSetEpChipUpdate)
end

return EpDataCenter


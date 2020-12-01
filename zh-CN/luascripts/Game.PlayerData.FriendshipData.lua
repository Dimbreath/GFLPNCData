-- params : ...
-- function num : 0 , upvalues : _ENV
local FriendshipData = class("FriendshipData")
local maxLevel = 0
FriendshipData.ctor = function(self)
  -- function num : 0_0 , upvalues : maxLevel, _ENV
  self.FriendshipDataList = {}
  self.AddedTotalLevel = nil
  maxLevel = #ConfigData.friendship_level
end

FriendshipData.UpdateData = function(self, netMsg)
  -- function num : 0_1 , upvalues : _ENV
  for heroId,data in pairs(netMsg.heroIntimacy) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R7 in 'UnsetPending'

    (self.FriendshipDataList)[heroId] = data
  end
end

FriendshipData.GetLevel = function(self, heroId)
  -- function num : 0_2
  local data = (self.FriendshipDataList)[heroId]
  if data == nil then
    return 1
  end
  return data.lv
end

FriendshipData.GetExp = function(self, heroId)
  -- function num : 0_3
  local data = (self.FriendshipDataList)[heroId]
  if data == nil then
    return 0
  end
  return data.exp
end

FriendshipData.IsFriendShipMaxLevel = function(self, heroId)
  -- function num : 0_4 , upvalues : maxLevel
  local level = self:GetLevel(heroId)
  do return maxLevel <= level end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

FriendshipData.GetBattleTimes = function(self, heroId)
  -- function num : 0_5
  local data = (self.FriendshipDataList)[heroId]
  if data == nil then
    return 0
  end
  return data.times
end

FriendshipData.GetTotalLevel = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local totalLevel = 0
  for id,value in pairs(PlayerDataCenter.heroDic) do
    totalLevel = totalLevel + self:GetLevel(id)
  end
  return totalLevel
end

FriendshipData.IsForestLineUnlock = function(self, heroId, fosterId)
  -- function num : 0_7
  local data = (self.FriendshipDataList)[heroId]
  if data == nil then
    return false
  end
  if (data.lineData)[fosterId] ~= nil then
    return true
  end
  return false
end

FriendshipData.GetForestLineLevel = function(self, heroId, fosterId)
  -- function num : 0_8
  if not self:IsForestLineUnlock(heroId, fosterId) then
    return 0
  end
  local data = (self.FriendshipDataList)[heroId]
  if (data.lineData)[fosterId] ~= nil then
    return (data.lineData)[fosterId]
  end
  return 0
end

FriendshipData.GetCouldUnlockOrUpgrade = function(self, heroId, fosterId)
  -- function num : 0_9 , upvalues : _ENV
  local friendshipLevel = self:GetLevel(heroId)
  local heroLevel = ((PlayerDataCenter.heroDic)[heroId]).level
  local curLineLevel = self:GetForestLineLevel(heroId, fosterId)
  local cfg = ((ConfigData.friendship_foster)[fosterId])[curLineLevel + 1]
  if cfg == nil then
    return false
  end
  local requireFriendshipLevel = cfg.friendship_level
  local requireHeroLevel = cfg.hero_level
  do return requireFriendshipLevel <= friendshipLevel and requireHeroLevel <= heroLevel, curLineLevel == 0, requireFriendshipLevel, requireHeroLevel, requireFriendshipLevel <= friendshipLevel, requireHeroLevel <= heroLevel end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

FriendshipData.AddFriendshipgBonus = function(self, totalLevel)
  -- function num : 0_10 , upvalues : _ENV
  if not totalLevel then
    totalLevel = self:GetTotalLevel()
  end
  local cfg = (ConfigData.friendship_total_level)[totalLevel]
  if cfg == nil then
    error("can\'t read friendship_total_level with id = " .. totalLevel)
    return 
  end
  local logicList = cfg.logic
  for index,logic in ipairs(logicList) do
    local para1 = (cfg.para1)[index]
    local para2 = (cfg.para2)[index]
    local para3 = (cfg.para3)[index]
    ;
    (PlayerDataCenter.playerBonus):InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship, 0, logic, para1, para2, para3)
  end
  ;
  (PlayerDataCenter.playerBonus):CheckPlayerBonusBroadcast()
  self.AddedTotalLevel = totalLevel
end

FriendshipData.AddFosterBonus = function(self)
  -- function num : 0_11 , upvalues : _ENV
  for heroID,cfg in pairs(self.FriendshipDataList) do
    for lineId,lineLevel in pairs(cfg.lineData) do
      local levelCfg = ((ConfigData.friendship_foster)[lineId])[lineLevel]
      for index,attrId in ipairs(levelCfg.attributeIds) do
        (PlayerDataCenter.attributeBonus):SetSingleHroeBonus(heroID, attrId, (levelCfg.attributeNums)[index])
      end
    end
  end
  MsgCenter:Broadcast(eMsgEventId.OnHeroFriendshipDataChange)
end

FriendshipData.RemoveFosterBonus = function(self)
  -- function num : 0_12 , upvalues : _ENV
  for heroID,cfg in pairs(self.FriendshipDataList) do
    for lineId,lineLevel in pairs(cfg.lineData) do
      local levelCfg = ((ConfigData.friendship_foster)[lineId])[lineLevel]
      for index,attrId in ipairs(levelCfg.attributeIds) do
        (PlayerDataCenter.attributeBonus):SetSingleHroeBonus(heroID, attrId, -(levelCfg.attributeNums)[index])
      end
    end
  end
end

FriendshipData.HeroAddBattleTime = function(self, heroIds)
  -- function num : 0_13 , upvalues : _ENV
  for _,heroId in ipairs(heroIds) do
    local data = (self.FriendshipDataList)[heroId]
    if data ~= nil then
      data.times = data.times + 1
      data.exp = data.exp + (ConfigData.game_config).FriendshipPerBattle or 0
      if ((ConfigData.friendship_level)[data.lv]).friendship <= data.exp then
        data.lv = data.lv + 1
        data.exp = data.exp - ((ConfigData.friendship_level)[data.lv]).friendship
      end
    end
  end
  self:AddFriendshipgBonus()
end

return FriendshipData

-- params : ...
-- function num : 0 , upvalues : _ENV
local FriendshipData = class("FriendshipData")
local maxLevel = 0
FriendshipData.ctor = function(self)
    -- function num : 0_0 , upvalues : maxLevel, _ENV
    self.FriendshipDataList = {}
    self.AddedTotalLevel = nil
    maxLevel = #ConfigData.friendship_level
end

FriendshipData.UpdateData = function(self, netMsg)
    -- function num : 0_1 , upvalues : _ENV
    for heroId, data in pairs(netMsg.heroIntimacy) do
        -- DECOMPILER ERROR at PC5: Confused about usage of register: R7 in 'UnsetPending'

        (self.FriendshipDataList)[heroId] = data
    end
end

FriendshipData.GetLevel = function(self, heroId)
    -- function num : 0_2
    local data = (self.FriendshipDataList)[heroId]
    if data == nil then return 1 end
    return data.lv
end

FriendshipData.GetExp = function(self, heroId)
    -- function num : 0_3
    local data = (self.FriendshipDataList)[heroId]
    if data == nil then return 0 end
    return data.exp
end

FriendshipData.IsFriendShipMaxLevel = function(self, heroId)
    -- function num : 0_4 , upvalues : maxLevel
    local level = self:GetLevel(heroId)
    do return maxLevel <= level end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

FriendshipData.GetBattleTimes = function(self, heroId)
    -- function num : 0_5
    local data = (self.FriendshipDataList)[heroId]
    if data == nil then return 0 end
    return data.times
end

FriendshipData.GetTotalLevel = function(self)
    -- function num : 0_6 , upvalues : _ENV
    local totalLevel = 0
    for id, value in pairs(PlayerDataCenter.heroDic) do
        totalLevel = totalLevel + self:GetLevel(id)
    end
    return totalLevel
end

FriendshipData.IsForestLineUnlock = function(self, heroId, fosterId)
    -- function num : 0_7
    local data = (self.FriendshipDataList)[heroId]
    if data == nil then return false end
    if (data.lineData)[fosterId] ~= nil then return true end
    return false
end

FriendshipData.GetForestLineLevel = function(self, heroId, fosterId)
    -- function num : 0_8
    if not self:IsForestLineUnlock(heroId, fosterId) then return 0 end
    local data = (self.FriendshipDataList)[heroId]
    if (data.lineData)[fosterId] ~= nil then return (data.lineData)[fosterId] end
    return 0
end

FriendshipData.GetCouldUnlockOrUpgrade =
    function(self, heroId, fosterId)
        -- function num : 0_9 , upvalues : _ENV
        local friendshipLevel = self:GetLevel(heroId)
        local heroLevel = ((PlayerDataCenter.heroDic)[heroId]).level
        local curLineLevel = self:GetForestLineLevel(heroId, fosterId)
        local cfg = ((ConfigData.friendship_foster)[fosterId])[curLineLevel + 1]
        if cfg == nil then return false end
        local requireFriendshipLevel = cfg.friendship_level
        local requireHeroLevel = cfg.hero_level
        do
            return requireFriendshipLevel <= friendshipLevel and
                       requireHeroLevel <= heroLevel, curLineLevel == 0,
                   requireFriendshipLevel, requireHeroLevel,
                   requireFriendshipLevel <= friendshipLevel,
                   requireHeroLevel <= heroLevel
        end
        -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end

FriendshipData.AddFriendshipgBonus = function(self, totalLevel)
    -- function num : 0_10 , upvalues : _ENV
    if not totalLevel then totalLevel = self:GetTotalLevel() end
    local cfg = (ConfigData.friendship_total_level)[totalLevel]
    if cfg == nil then
        error("can\'t read friendship_total_level with id = " .. totalLevel)
        return
    end
    local logicList = cfg.logic
    for index, logic in ipairs(logicList) do
        local para1 = (cfg.para1)[index]
        local para2 = (cfg.para2)[index]
        local para3 = (cfg.para3)[index];
        (PlayerDataCenter.playerBonus):InstallPlayerBonus(
            proto_csmsg_SystemFunctionID.SystemFunctionID_friendship, 0, logic,
            para1, para2, para3)
    end
    (PlayerDataCenter.playerBonus):CheckPlayerBonusBroadcast()
    self.AddedTotalLevel = totalLevel
end

FriendshipData.AddFosterBonus = function(self)
    -- function num : 0_11 , upvalues : _ENV
    for heroID, cfg in pairs(self.FriendshipDataList) do
        for lineId, lineLevel in pairs(cfg.lineData) do
            local levelCfg = ((ConfigData.friendship_foster)[lineId])[lineLevel]
            for index, attrId in ipairs(levelCfg.attributeIds) do
                (PlayerDataCenter.attributeBonus):SetSingleHroeBonus(heroID,
                                                                     attrId,
                                                                     (levelCfg.attributeNums)[index])
            end
        end
    end
    MsgCenter:Broadcast(eMsgEventId.OnHeroFriendshipDataChange)
end

FriendshipData.RemoveFosterBonus = function(self)
    -- function num : 0_12 , upvalues : _ENV
    for heroID, cfg in pairs(self.FriendshipDataList) do
        for lineId, lineLevel in pairs(cfg.lineData) do
            local levelCfg = ((ConfigData.friendship_foster)[lineId])[lineLevel]
            for index, attrId in ipairs(levelCfg.attributeIds) do
                (PlayerDataCenter.attributeBonus):SetSingleHroeBonus(heroID,
                                                                     attrId,
                                                                     -(levelCfg.attributeNums)[index])
            end
        end
    end
end

FriendshipData.HeroAddBattleTime = function(self, heroIds)
    -- function num : 0_13 , upvalues : _ENV
    for _, heroId in ipairs(heroIds) do
        local data = (self.FriendshipDataList)[heroId]
        if data ~= nil then
            data.times = data.times + 1
            data.exp =
                data.exp + (ConfigData.game_config).FriendshipPerBattle or 0
            if ((ConfigData.friendship_level)[data.lv]).friendship <= data.exp then
                data.lv = data.lv + 1
                data.exp = data.exp -
                               ((ConfigData.friendship_level)[data.lv]).friendship
            end
        end
    end
    self:AddFriendshipgBonus()
end

return FriendshipData


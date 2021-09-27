local DormBriefData = class("DormBriefData")
DormBriefData.ctor = function(self)
  -- function num : 0_0
  self.__dormHasReward = false
  self.dormComfort = 0
  self.__comfortLevel = 0
end

local RoomBinaryLock = function(unlockBinary, roomId)
  -- function num : 0_1
  local sign = 1 << roomId
  do return unlockBinary & sign == 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DormBriefData.CreateDormBriefByServer = function(dormBrief)
  -- function num : 0_2 , upvalues : DormBriefData
  local dormBriefData = (DormBriefData.New)()
  dormBriefData:UpdateDormBriefByServer(dormBrief)
  dormBriefData:_InitUnlock(dormBrief)
  return dormBriefData
end

DormBriefData._InitUnlock = function(self, dormBrief)
  -- function num : 0_3 , upvalues : _ENV, RoomBinaryLock
  for houseId,houseUnlockCfg in pairs(ConfigData.dorm_room_unlock) do
    local unlockBinary = (dormBrief.unlockedRoom)[houseId]
    local OnUnlockRoomFunc = BindCallback(self, self._OnUnlockRoom, houseId)
    for roomId,unlockCfg in pairs(houseUnlockCfg) do
      if unlockBinary == nil or RoomBinaryLock(unlockBinary, roomId) then
        UnlockCenter:AddUnlockElemEvent(OnUnlockRoomFunc, unlockCfg.unlock_logic, unlockCfg.unlock_para1)
      end
    end
  end
end

DormBriefData._OnUnlockRoom = function(self, houseId, logicId, para1)
  -- function num : 0_4 , upvalues : _ENV
  local dormNetwork = NetworkManager:GetNetwork(NetworkTypeID.Dorm)
  dormNetwork:CS_DORM_BriefDetailWhenUnlock()
end

DormBriefData.UpdateDormBriefByServer = function(self, dormBrief)
  -- function num : 0_5
  self.rewardsRecord = dormBrief.RewardsRecord
  if not self:UpdateHistoryMaxComfort(dormBrief.comfort) then
    self:__CalcDormLevelAndReward()
  end
end

DormBriefData.IsDormComfortPicked = function(self, level)
  -- function num : 0_6
  local sign = 1 << level - 1
  do return self.rewardsRecord & sign > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DormBriefData.RecordComfortPicked = function(self, level)
  -- function num : 0_7
  local sign = 1 << level - 1
  self.rewardsRecord = self.rewardsRecord | sign
  self:__CalcDormLevelAndReward()
end

DormBriefData.HistoryMaxComfort = function(self)
  -- function num : 0_8
  return self.dormComfort
end

DormBriefData.UpdateHistoryMaxComfort = function(self, comfort)
  -- function num : 0_9 , upvalues : _ENV
  if comfort <= self.dormComfort then
    return false
  end
  self.dormComfort = comfort
  self:__CalcDormLevelAndReward()
  MsgCenter:Broadcast(eMsgEventId.DormMaxComfortChanged, self.dormComfort, self.__comfortLevel)
  return true
end

DormBriefData.IsDormHasReward = function(self)
  -- function num : 0_10
  return self.__dormHasReward
end

DormBriefData.GetDormComfortLevel = function(self)
  -- function num : 0_11 , upvalues : _ENV
  return self.__comfortLevel, (ConfigData.dorm_comfort).max_level
end

DormBriefData.GetDormComfortLevelCfg = function(self)
  -- function num : 0_12 , upvalues : _ENV
  return (ConfigData.dorm_comfort)[self.__comfortLevel]
end

DormBriefData.__CalcDormLevelAndReward = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local dormHasReward = false
  local templevel = 1
  for _,level in ipairs((ConfigData.dorm_comfort).level_sort) do
    local comfortCfg = (ConfigData.dorm_comfort)[level]
    if comfortCfg == nil then
      error("dorm comfort cfg is null,id:" .. tostring(level))
      return nil
    end
    if comfortCfg.comfort <= self.dormComfort then
      templevel = level
      if not dormHasReward and #comfortCfg.rewardIds > 0 and not self:IsDormComfortPicked(level) then
        dormHasReward = true
      end
    else
      break
    end
  end
  do
    if self.__comfortLevel ~= templevel then
      if self.__comfortLevel > 0 then
        local levelCfg = (ConfigData.dorm_comfort)[self.__comfortLevel]
        for k,logic in ipairs(levelCfg.logic) do
          local para1 = (levelCfg.para1)[k]
          local para2 = (levelCfg.para2)[k]
          local para3 = (levelCfg.para3)[k]
          ;
          (PlayerDataCenter.playerBonus):UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm, 0, logic, para1, para2, para3)
        end
      end
      do
        self.__comfortLevel = templevel
        local levelCfg = (ConfigData.dorm_comfort)[self.__comfortLevel]
        for k,logic in ipairs(levelCfg.logic) do
          local para1 = (levelCfg.para1)[k]
          local para2 = (levelCfg.para2)[k]
          local para3 = (levelCfg.para3)[k]
          ;
          (PlayerDataCenter.playerBonus):InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm, 0, logic, para1, para2, para3)
        end
        do
          self:__UpdateDormHasReward(dormHasReward)
        end
      end
    end
  end
end

DormBriefData.__UpdateDormHasReward = function(self, hasReward)
  -- function num : 0_14 , upvalues : _ENV
  if self.__dormHasReward == hasReward then
    return 
  end
  self.__dormHasReward = hasReward
  local ok, comfortNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Dorm, RedDotStaticTypeId.DormComfort)
  if hasReward then
    comfortNode:SetRedDotCount(1)
  else
    comfortNode:SetRedDotCount(0)
  end
end

return DormBriefData


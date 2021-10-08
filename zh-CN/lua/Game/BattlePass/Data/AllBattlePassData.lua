local AllBattlePassData = class("AllBattlePassData")
local BattlePassData = require("Game.BattlePass.Data.BattlePassData")
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")
local NoticeData = require("Game.Notice.NoticeData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
AllBattlePassData.ctor = function(self)
  -- function num : 0_0
  self.passInfos = {}
end

AllBattlePassData.__UpdateBattlePassInternal = function(self, id, battlepass)
  -- function num : 0_1 , upvalues : _ENV, BattlePassData
  if (self.passInfos)[id] ~= nil then
    ((self.passInfos)[id]):UpdateBattlePass(battlepass)
    return 
  end
  local battlepassCfg = (ConfigData.battlepass_type)[id]
  if battlepassCfg == nil then
    error("battle pass type is nil,id:" .. tostring(id))
    return 
  end
  local passData = (BattlePassData.CreateBattlePass)(battlepass, battlepassCfg)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.passInfos)[id] = passData
end

AllBattlePassData.InitAllBattlePass = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  for id,battlepass in pairs(data.infos) do
    self:__UpdateBattlePassInternal(id, battlepass)
    MsgCenter:Broadcast(eMsgEventId.BattlePassChange, id)
  end
  self:__RefreshBattleWeeklyExpiredTm()
end

AllBattlePassData.__RefreshBattleWeeklyExpiredTm = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local mainBattlePass = self:GetMainBattlePass()
  if mainBattlePass ~= nil and (self.__mainBattlePassId ~= mainBattlePass.id or self.__mainBattleweeklyExpiredTm ~= mainBattlePass.weeklyNextExpiredTm) then
    self.__mainBattlePassId = mainBattlePass.id
    self.__mainBattleweeklyExpiredTm = mainBattlePass.weeklyNextExpiredTm
    local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, true)
    timePassCtrl:AddEventTimer(self.__mainBattleweeklyExpiredTm, function()
    -- function num : 0_3_0 , upvalues : _ENV
    (NetworkManager:GetNetwork(NetworkTypeID.BattlePass)):CS_BATTLEPASS_Detail()
  end
)
  end
end

AllBattlePassData.UpdateAllBattlePass = function(self, update)
  -- function num : 0_4 , upvalues : _ENV
  for id,battlepass in pairs(update) do
    self:__UpdateBattlePassInternal(id, battlepass)
    MsgCenter:Broadcast(eMsgEventId.BattlePassChange, id)
  end
  self:__RefreshBattleWeeklyExpiredTm()
end

AllBattlePassData.GetMainBattlePass = function(self)
  -- function num : 0_5 , upvalues : _ENV
  for id,passData in pairs(self.passInfos) do
    if passData:IsBattleType() and passData:IsBattlePassValid() then
      return passData
    end
  end
  return nil
end

AllBattlePassData.UpdatePlayerLevel = function(self, level)
  -- function num : 0_6 , upvalues : _ENV, BattlePassEnum, NoticeData
  local isHaveNewCouldReward = false
  for k,v in pairs(self.passInfos) do
    if (v.passCfg).condition == (BattlePassEnum.ConditionType).AchievementLevel then
      v.level = (PlayerDataCenter.playerLevel).level
      v:__UpdateHaveRewardTake()
      isHaveNewCouldReward = v:GetIsThisLeveHaveNewReward(level)
    end
  end
  if isHaveNewCouldReward then
    NoticeManager:AddNotice((NoticeData.CreateNoticeData)(PlayerDataCenter.timestamp, (NoticeManager.eNoticeType).GrowBagLevelup, nil, nil, nil))
  end
end

return AllBattlePassData


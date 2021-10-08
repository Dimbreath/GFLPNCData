local NoticeData = require("Game.Notice.NoticeData")
local eDungeonEnum = require("Game.Dungeon.eDungeonEnum")
local JumpManager = require("Game.Jump.JumpManager")
local cs_MessageCommon = CS.MessageCommon
local TimePassPostprocessFunc = {[proto_object_CounterModule.CounterModuleDailyChallenge] = function(isUpdate)
  -- function num : 0_0 , upvalues : _ENV
  local _, periodicRedNote = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, RedDotStaticTypeId.PeriodicChallenge)
  if not (PlayerDataCenter.periodicChallengeData):GetIsDailyChallengeFished() or not 0 then
    local num = periodicRedNote == nil or 1
  end
  periodicRedNote:SetRedDotCount(num)
end
, [proto_object_CounterModule.CounterModuleGlobalDailyFlush] = function(isUpdate)
  -- function num : 0_1 , upvalues : _ENV
  if not isUpdate then
    return 
  end
  NoticeManager:RefreshDungeonRewardRateNotice(true, false)
end
, [proto_object_CounterModule.CounterModuleMaintain] = function(isUpdate, data, timeFuncData)
  -- function num : 0_2 , upvalues : _ENV, cs_MessageCommon
  if not isUpdate then
    return 
  end
  local maintianTimeStamp = data.nextExpiredTm
  if timeFuncData.maintainTimerId ~= nil then
    TimerManager:StopTimer(timeFuncData.maintainTimerId)
    timeFuncData.maintainTimerId = nil
    timeFuncData.maintainTimeIsPoped = {}
  end
  timeFuncData.maintainTimerId = TimerManager:StartTimer(1, function()
    -- function num : 0_2_0 , upvalues : maintianTimeStamp, _ENV, timeFuncData, cs_MessageCommon
    local beforeMaintainSpan = maintianTimeStamp - PlayerDataCenter.timestamp
    if beforeMaintainSpan < 0 then
      TimerManager:StopTimer(timeFuncData.maintainTimerId)
      timeFuncData.maintainTimerId = nil
      timeFuncData.maintainTimeIsPoped = {}
      return 
    end
    local timeList = (ConfigData.game_config).maintainNoticeTimeList
    for index,noticeTime in ipairs(timeList) do
      if beforeMaintainSpan < noticeTime then
        if (timeFuncData.maintainTimeIsPoped)[noticeTime] then
          return 
        end
        -- DECOMPILER ERROR at PC29: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (timeFuncData.maintainTimeIsPoped)[noticeTime] = true
        local min = 0
        local second = 0
        min = noticeTime // 60
        second = noticeTime % 60
        local str = ""
        if min > 0 then
          str = str .. tostring(min) .. ConfigData:GetTipContent(TipContent.TimeName_min)
        end
        if second > 0 then
          str = str .. tostring(second) .. ConfigData:GetTipContent(TipContent.TimeName_second)
        end
        ;
        (cs_MessageCommon.ShowMessageTips)((string.format)(ConfigData:GetTipContent(TipContent.MaintainNotice), str))
        if index == 1 then
          TimerManager:StopTimer(timeFuncData.maintainTimerId)
          timeFuncData.maintainTimerId = nil
          timeFuncData.maintainTimeIsPoped = {}
        end
        return 
      end
    end
  end
, nil, nil, nil, true)
end
}
return TimePassPostprocessFunc


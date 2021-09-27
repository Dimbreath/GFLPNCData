local GameNoticeData = class("GameNoticeData")
local GameNoticEnum = require("Game.GameNotice.GameNoticEnum")
GameNoticeData.CreateData = function(jasonData)
  -- function num : 0_0 , upvalues : GameNoticeData
  local noticeData = (GameNoticeData.New)()
  noticeData.idx = jasonData.id
  noticeData:UpdateBaseGNData(jasonData)
  return noticeData
end

GameNoticeData.ctor = function(self)
  -- function num : 0_1 , upvalues : GameNoticEnum
  self.idx = nil
  self.type = nil
  self.name = nil
  self.startTimeStamp = nil
  self.endTimeStamp = nil
  self.template = nil
  self.targetUrl = nil
  self.picName = nil
  self._jumpType = (GameNoticEnum.eJumpType).none
  self._jumpTargetId = nil
  self._jumpArgs = nil
  self._jumpUrl = nil
end

GameNoticeData.UpdateBaseGNData = function(self, jasonData)
  -- function num : 0_2
  self.type = jasonData.type
  self.name = jasonData.name
  self.endTimeStamp = jasonData.end_time
  self.startTimeStamp = jasonData.start_time
  self.template = jasonData.content_type_id
  self.picName = jasonData.pic_name
  self:_UpdateJumpData(jasonData)
  self:_UpdateTargetUrl(jasonData)
end

GameNoticeData._UpdateTargetUrl = function(self, jasonData)
  -- function num : 0_3 , upvalues : GameNoticEnum
  local targetUrl = ""
  if jasonData.content_type_id == (GameNoticEnum.eTemplates).banner then
    targetUrl = jasonData.content
  end
  self.targetUrl = targetUrl
end

GameNoticeData._UpdateJumpData = function(self, jasonData)
  -- function num : 0_4 , upvalues : GameNoticEnum
  if self.template ~= (GameNoticEnum.eTemplates).banner and jasonData.skip == nil then
    return 
  end
  if (jasonData.skip).jump_type_id == nil then
    return 
  end
  self._jumpType = (jasonData.skip).jump_type_id
  if self:IsJumpInner() then
    self._jumpTargetId = (jasonData.skip).jump_id
    self._jumpArgs = (jasonData.skip).jump_arg
    return 
  end
  if self:IsJumpOuter() then
    self._jumpUrl = (jasonData.skip).jump_url
    return 
  end
end

GameNoticeData.IsOutOfDate = function(self)
  -- function num : 0_5
  do return self:GetGNLeftDate() < 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

GameNoticeData.HasBannerPicName = function(self)
  -- function num : 0_6
  do return self.picName ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

GameNoticeData.IsJumpInner = function(self)
  -- function num : 0_7 , upvalues : GameNoticEnum
  do return self._jumpType == (GameNoticEnum.eJumpType).inner end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

GameNoticeData.IsJumpOuter = function(self)
  -- function num : 0_8 , upvalues : GameNoticEnum
  do return self._jumpType == (GameNoticEnum.eJumpType).outer end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

GameNoticeData.GetJumpID = function(self)
  -- function num : 0_9
  return self._jumpTargetId
end

GameNoticeData.GetJumpArgs = function(self)
  -- function num : 0_10
  return self._jumpArgs
end

GameNoticeData.GetJumpUrl = function(self)
  -- function num : 0_11
  return self._jumpUrl
end

GameNoticeData.GetGNLeftDate = function(self)
  -- function num : 0_12 , upvalues : _ENV
  return self.endTimeStamp - PlayerDataCenter.timestamp
end

return GameNoticeData


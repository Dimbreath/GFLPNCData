-- params : ...
-- function num : 0 , upvalues : _ENV
local HomeSideNoticeData = class("HomeSideNoticeData")
local HomeEnum = require("Game.Home.HomeEnum")
HomeSideNoticeData.CreateNoticeData = function(timeStamp, type, noticeStr, jumpInfo, noticeStrList, extrId)
  -- function num : 0_0 , upvalues : HomeSideNoticeData, _ENV
  local NoticeData = (HomeSideNoticeData.New)()
  NoticeData:InitNoticeData(timeStamp, type, noticeStr, jumpInfo, noticeStrList, extrData)
  return NoticeData
end

HomeSideNoticeData.ctor = function(self)
  -- function num : 0_1
  self.timeStamp = 0
  self.type = nil
  self.jumpInfo = nil
  self.noticeStrList = nil
  self.extrId = nil
end

HomeSideNoticeData.InitNoticeData = function(self, timeStamp, type, jumpInfo, noticeStrList, extrId)
  -- function num : 0_2 , upvalues : _ENV
  if not timeStamp or not (math.floor)(timeStamp) then
    self.timeStamp = PlayerDataCenter.timestamp
    self.type = type
    self.jumpInfo = jumpInfo
    self.noticeStrList = noticeStrList
    self.extrId = extrId
  end
end

HomeSideNoticeData.GetNoticeStr = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.noticeStrList ~= nil then
    return (string.format)((LanguageUtil.GetLocaleText)(((ConfigData.homeside_info)[self.type]).describe), (table.unpack)(self.noticeStrList))
  else
    return (LanguageUtil.GetLocaleText)(((ConfigData.homeside_info)[self.type]).describe)
  end
end

HomeSideNoticeData.GetIcon = function(self)
  -- function num : 0_4 , upvalues : _ENV
  return ((ConfigData.homeside_info)[self.type]).icon
end

HomeSideNoticeData.GetNoticeIcon = function(self)
  -- function num : 0_5
end

return HomeSideNoticeData


-- params : ...
-- function num : 0 , upvalues : _ENV
local NoticeData = class("NoticeData")
NoticeData.CreateNoticeData = function(timeStamp, type, jumpInfo, noticeStrList, extraData)
  -- function num : 0_0 , upvalues : NoticeData
  local NoticeData = (NoticeData.New)()
  NoticeData:InitNoticeData(timeStamp, type, jumpInfo, noticeStrList, extraData)
  return NoticeData
end

NoticeData.ctor = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self.timeStamp = 0
  self.timeStampOfShow = 0
  self.type = nil
  self.jumpInfo = nil
  self.noticeStrList = nil
  self.extraData = nil
  self.noticeCfg = nil
  self.noticeShowType = (NoticeManager.eNoticeShowType).defualt
end

NoticeData.InitNoticeData = function(self, timeStamp, type, jumpInfo, noticeStrList, extraData)
  -- function num : 0_2 , upvalues : _ENV
  if not timeStamp or not (math.floor)(timeStamp) then
    self.timeStamp = PlayerDataCenter.timestamp
    self.type = type
    self.jumpInfo = jumpInfo
    self.noticeStrList = noticeStrList
    self.extraData = extraData
    self.noticeCfg = (ConfigData.homeside_info)[self.type]
    if self.noticeCfg == nil then
      error("can\'t read noticeCfg with typeId: " .. tostring(self.type))
    end
    self.noticeShowType = (self.noticeCfg).type
  end
end

NoticeData.GetNoticeStr = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.noticeStrList ~= nil then
    return (string.format)((LanguageUtil.GetLocaleText)((self.noticeCfg).describe), (table.unpack)(self.noticeStrList))
  else
    return (LanguageUtil.GetLocaleText)((self.noticeCfg).describe)
  end
end

NoticeData.GetNoticeTitle = function(self)
  -- function num : 0_4 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.noticeCfg).title)
end

NoticeData.GetIcon = function(self)
  -- function num : 0_5
  return (self.noticeCfg).icon
end

NoticeData.GetNoticeIcon = function(self)
  -- function num : 0_6
  return (self.noticeCfg).icon
end

NoticeData.IsNeedRedDot = function(self)
  -- function num : 0_7
  if (self.noticeCfg).is_reddot then
    return self:GetIsPutInHomeside()
  end
end

NoticeData.GetIsMerge = function(self)
  -- function num : 0_8
  return (self.noticeCfg).is_merge
end

NoticeData.GetIsPutInHomeside = function(self)
  -- function num : 0_9
  return (self.noticeCfg).put_in_homeside
end

return NoticeData


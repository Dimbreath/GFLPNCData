local GameNoticeController = class("GameNoticeController", ControllerBase)
local base = ControllerBase
local rapidjson = require("rapidjson")
local GameNoticeData = require("Game.GameNotice.GameNoticeData")
local GameNoticEnum = require("Game.GameNotice.GameNoticEnum")
local cs_MicaSDKManager = (CS.MicaSDKManager).Instance
local cs_HttpDownloadHelper = (CS.HttpDownloadHelper).Instance
GameNoticeController.OnInit = function(self)
  -- function num : 0_0
  self.jsonUrl = nil
  self.noticeHtml = nil
  self:_InitRedDot()
end

GameNoticeController.LoadGameNoticeDatas = function(self, loadCallback)
  -- function num : 0_1 , upvalues : _ENV
  self.gameNoticDatas = nil
  self._loadOver = false
  self._loadCallback = loadCallback
  if self.jsonUrl == nil or self.noticeHtml == nil then
    self:LoadUrl()
  end
  if isGameDev then
    print("GameNoticeController jsonUrl:" .. tostring(self.jsonUrl))
  end
  if self.jsonUrl == nil then
    self._loadOver = false
    if self._loadCallback ~= nil then
      (self._loadCallback)(false)
    end
    return 
  end
  if self._onJsonFormUrlCallback == nil then
    self._onJsonFormUrlCallback = BindCallback(self, self._OnGNJsonFormUrlCallback)
  end
  self:GetJsonFromURL(self.jsonUrl, self._onJsonFormUrlCallback, 5)
end

GameNoticeController.LoadUrl = function(self)
  -- function num : 0_2 , upvalues : cs_MicaSDKManager
  if not cs_MicaSDKManager:IsUseSdk() then
    return 
  end
  self.jsonUrl = (cs_MicaSDKManager.gameResUrls).GetNoticeUrl
  self.noticeHtml = (cs_MicaSDKManager.gameResUrls).GetNoticeHtmlUrl
end

GameNoticeController._OnGNJsonFormUrlCallback = function(self, jsonTable)
  -- function num : 0_3 , upvalues : _ENV, GameNoticeData
  self._hasValidData = false
  if jsonTable == nil or jsonTable.code ~= 0 or jsonTable.data == nil then
    if self._loadCallback ~= nil then
      (self._loadCallback)(false)
    end
    return 
  end
  local originData = {}
  self.gameNoticDatas = {}
  local useFulNameList = {}
  local noticeIds = {}
  for _,jsonData in ipairs((jsonTable.data).list) do
    local noticeData = (GameNoticeData.CreateData)(jsonData)
    if not noticeData:IsOutOfDate() then
      if noticeData:HasBannerPicName() then
        (table.insert)(useFulNameList, noticeData.picName)
      end
      -- DECOMPILER ERROR at PC50: Confused about usage of register: R11 in 'UnsetPending'

      if (self.gameNoticDatas)[noticeData.type] == nil then
        (self.gameNoticDatas)[noticeData.type] = {}
      end
      ;
      (table.insert)((self.gameNoticDatas)[noticeData.type], noticeData)
      ;
      (table.insert)(originData, noticeData)
    end
    noticeIds[noticeData.idx] = false
  end
  self._hasValidData = #originData > 0
  self:TryDeleteOutOfDataImg(useFulNameList)
  ;
  (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):DiffLocalGNReadData(noticeIds)
  self._loadOver = true
  self:_InitNewDic()
  if self._loadCallback ~= nil then
    (self._loadCallback)(true)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

GameNoticeController.GetEncryptHtmlUrl = function(self, gameNoticeIdx)
  -- function num : 0_4 , upvalues : _ENV
  if self.noticeHtml == nil then
    warn("GameNoticeController noticeHtml is nil")
    self.noticeHtml = ""
  end
  local url = self.noticeHtml .. "&notice_id=" .. tostring(gameNoticeIdx)
  return url
end

GameNoticeController.HasNoticData = function(self)
  -- function num : 0_5
  do return self._loadOver and ((self.gameNoticDatas ~= nil and self._hasValidData)) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

GameNoticeController.GetNoticDataList = function(self, eNoticType)
  -- function num : 0_6
  return (self.gameNoticDatas)[eNoticType]
end

GameNoticeController.GetNoticData = function(self, eNoticType, index)
  -- function num : 0_7
  return ((self.gameNoticDatas)[eNoticType])[index]
end

GameNoticeController._InitNewDic = function(self)
  -- function num : 0_8 , upvalues : _ENV
  self._hasNewDic = {}
  for typeId,list in pairs(self.gameNoticDatas) do
    local hasNewList = {}
    for index,data in ipairs(list) do
      if self:ContainGameNoticeIsNew(data.idx) then
        (table.insert)(hasNewList, index)
      end
    end
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R7 in 'UnsetPending'

    if #hasNewList > 0 then
      (self._hasNewDic)[typeId] = hasNewList
    end
    self:_RefreshNoticeTypeRedDot(typeId, #hasNewList)
  end
end

GameNoticeController.GetNewGNType = function(self)
  -- function num : 0_9 , upvalues : _ENV, GameNoticEnum
  do
    if self._hasNewDic ~= nil then
      local count = (table.count)(self._hasNewDic)
      if count >= 2 or count == 0 or (self._hasNewDic)[(GameNoticEnum.eNoticType).activity] ~= nil then
        return (GameNoticEnum.eNoticType).activity
      end
    end
    return (GameNoticEnum.eNoticType).system
  end
end

GameNoticeController.GetNewGNDataIndex = function(self, eNoticType)
  -- function num : 0_10
  if (self._hasNewDic)[eNoticType] == nil then
    return 1
  end
  return ((self._hasNewDic)[eNoticType])[1]
end

GameNoticeController.HasGameNoticData = function(self, eNoticType)
  -- function num : 0_11
  do return (self.gameNoticDatas)[eNoticType] ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

GameNoticeController.SetGameNoticeIsRead = function(self, eNoticType, index)
  -- function num : 0_12 , upvalues : _ENV
  local gameNoticeData = self:GetNoticData(eNoticType, index)
  local list = (self._hasNewDic)[eNoticType]
  if list == nil then
    self:_RefreshNoticeTypeRedDot(eNoticType, 0)
  else
    local delIdx = nil
    for k,v in ipairs(list) do
      if index == v then
        delIdx = k
        break
      end
    end
    do
      do
        if delIdx ~= nil then
          (table.remove)(list, delIdx)
          self:_RefreshNoticeTypeRedDot(eNoticType, #list)
        end
        ;
        (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):SaveIsReadGameNotice(gameNoticeData.idx)
      end
    end
  end
end

GameNoticeController.SaveModelData = function(self)
  -- function num : 0_13 , upvalues : _ENV
  PersistentManager:SaveModelData((PersistentConfig.ePackage).UserData)
end

GameNoticeController.ContainGameNoticeIsNew = function(self, gameNoticeIdx)
  -- function num : 0_14 , upvalues : _ENV
  return not (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):ContainGameNoticeIsRead(gameNoticeIdx)
end

GameNoticeController.SaveTimestamp = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local timestamp = (math.floor)(PlayerDataCenter.timestamp)
  ;
  (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):SaveGameNoticeTimestamp(timestamp)
end

GameNoticeController.CanAutoPushGameNotice = function(self)
  -- function num : 0_16 , upvalues : _ENV
  local saveTimestamp = (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):GetGameNoticeTimestamp()
  if saveTimestamp == 0 or saveTimestamp == nil then
    return true
  end
  local saveTimeDate = TimestampToDate(saveTimestamp)
  local curTimestamp = (math.floor)(PlayerDataCenter.timestamp)
  local curTimeDate = TimestampToDate(curTimestamp)
  local isDay = saveTimeDate.day == curTimeDate.day
  local isMonth = saveTimeDate.month == curTimeDate.month
  local isYear = saveTimeDate.year == curTimeDate.year
  if isDay and isMonth and isYear then
    return false
  end
  do return true end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

GameNoticeController._InitRedDot = function(self)
  -- function num : 0_17 , upvalues : _ENV, GameNoticEnum
  for _,typeID in pairs(GameNoticEnum.eNoticType) do
    RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.GameNotice, typeID)
  end
end

GameNoticeController._RefreshNoticeTypeRedDot = function(self, typeId, count)
  -- function num : 0_18 , upvalues : _ENV
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.GameNotice, typeId)
  if ok then
    node:SetRedDotCount(count)
  end
end

GameNoticeController.GetJsonFromURL = function(self, url, callback, timeout)
  -- function num : 0_19 , upvalues : cs_HttpDownloadHelper, _ENV, rapidjson
  cs_HttpDownloadHelper:GetStringFromUrl(url, function(str)
    -- function num : 0_19_0 , upvalues : _ENV, url, callback, rapidjson
    if (string.IsNullOrEmpty)(str) then
      warn("banner error url:" .. tostring(url))
      callback(nil)
      return 
    end
    local tab = (rapidjson.decode)(str)
    callback(tab)
  end
, timeout)
end

GameNoticeController.GetNoticPicFromHTTP = function(self, url, fileName, callback)
  -- function num : 0_20 , upvalues : _ENV, cs_HttpDownloadHelper
  if (string.IsNullOrEmpty)(url) then
    warn("GetNoticPicFromHTTP url Address is null")
    return 
  end
  if (string.IsNullOrEmpty)(fileName) then
    warn("GetNoticPicFromHTTP fileName is null")
    return 
  end
  cs_HttpDownloadHelper:GetImgFromUrl(url, PathConsts:GetPersistentNoticeCachePath(fileName), function(Sprite)
    -- function num : 0_20_0 , upvalues : _ENV, url, fileName, callback
    if Sprite == nil then
      if isGameDev then
        error("banner error url:" .. tostring(url) .. " sprite fileName:" .. tostring(fileName))
      end
      callback(nil)
    end
    callback(Sprite)
  end
)
end

GameNoticeController.TryDeleteOutOfDataImg = function(self, useFulNameList)
  -- function num : 0_21 , upvalues : cs_HttpDownloadHelper, _ENV
  cs_HttpDownloadHelper:DeleteImgNotUseful(PathConsts.PersistentNoticeCachePath, useFulNameList)
end

GameNoticeController.OnDelete = function(self)
  -- function num : 0_22 , upvalues : base
  (base.OnDelete)(self)
end

return GameNoticeController


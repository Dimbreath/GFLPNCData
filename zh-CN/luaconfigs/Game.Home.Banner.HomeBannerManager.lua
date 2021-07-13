-- params : ...
-- function num : 0 , upvalues : _ENV
local HomeBannerManager = {}
local cs_HttpDownloadHelper = (CS.HttpDownloadHelper).Instance
local rapidjson = require("rapidjson")
local HomeBannerData = require("Game.Home.Banner.HomeBannerData")
HomeBannerManager.Init = function(self)
  -- function num : 0_0
  self.getJsonUrl = nil
  self.bannerDataList = {}
end

HomeBannerManager.OnResUrlLoadOver = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self.getJsonUrl = (((CS.MicaSDKManager).Instance).gameResUrls).GetBannerUrl
end

HomeBannerManager.RefreshBannerDataList = function(self, refreshOverCallback)
  -- function num : 0_2 , upvalues : _ENV, HomeBannerData
  if self.getJsonUrl == nil then
    self.getJsonUrl = (((CS.MicaSDKManager).Instance).gameResUrls).GetBannerUrl
    if self.getJsonUrl == nil then
      refreshOverCallback()
      return 
    end
  end
  self.bannerDataList = {}
  local usefulNameList = {}
  self:GetBannerJsonFromURL(self.getJsonUrl, function(bannerDataJson)
    -- function num : 0_2_0 , upvalues : refreshOverCallback, _ENV, HomeBannerData, self, usefulNameList
    if bannerDataJson == nil or bannerDataJson.code ~= 0 or bannerDataJson.data == nil then
      refreshOverCallback()
    end
    for _,bannerJsonData in pairs(bannerDataJson.data) do
      local bannerData = (HomeBannerData.CreateNewBannerData)(bannerJsonData)
      if not bannerData:GetBannerIsOutOfData() and not bannerData:GetIsLotteryOrShopItemClosed() then
        if #self.bannerDataList == 0 then
          (table.insert)(self.bannerDataList, bannerData)
        else
          local isInserted = false
          for index,bannerDataInList in ipairs(self.bannerDataList) do
            if bannerDataInList.sort < bannerData.sort then
              (table.insert)(self.bannerDataList, index, bannerData)
              isInserted = true
              break
            else
              if bannerDataInList.sort == bannerData.sort and bannerData.id < bannerDataInList.id then
                warn("banners have same sort")
                ;
                (table.insert)(self.bannerDataList, index, bannerData)
                isInserted = true
                break
              end
            end
          end
          do
            do
              do
                if not isInserted then
                  (table.insert)(self.bannerDataList, #self.bannerDataList + 1, bannerData)
                end
                ;
                (table.insert)(usefulNameList, bannerData.pic_name)
                -- DECOMPILER ERROR at PC89: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC89: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC89: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC89: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC89: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC89: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      end
    end
    self:TryDeleteOutOfDataImg(usefulNameList)
    refreshOverCallback(self.bannerDataList)
  end
)
end

HomeBannerManager.GetNextBannerData = function(self, curIndex)
  -- function num : 0_3
  local listSize = #self.bannerDataList
  if listSize == 0 then
    return nil
  end
  if #self.bannerDataList < curIndex or curIndex == nil then
    return (self.bannerDataList)[1]
  end
  return (self.bannerDataList)[curIndex + 1]
end

HomeBannerManager.GetBannerJsonFromURL = function(self, url, callback)
  -- function num : 0_4 , upvalues : cs_HttpDownloadHelper, _ENV, rapidjson
  cs_HttpDownloadHelper:GetStringFromUrl(url, function(str)
    -- function num : 0_4_0 , upvalues : _ENV, url, callback, rapidjson
    if str == nil or (string.IsNullOrEmpty)(str) then
      warn("banner error url:" .. tostring(url))
      callback(nil)
    end
    local tab = (rapidjson.decode)(str)
    callback(tab)
  end
)
end

HomeBannerManager.GetBannerPicFromHTTP = function(self, url, fileName, callback)
  -- function num : 0_5 , upvalues : cs_HttpDownloadHelper, _ENV
  cs_HttpDownloadHelper:GetImgFromUrl(url, PathConsts:GetPersistentBannerCachePath(fileName), function(Sprite)
    -- function num : 0_5_0 , upvalues : _ENV, url, fileName, callback
    if Sprite == nil then
      error("banner error url:" .. tostring(url) .. " sprite fileName:" .. tostring(fileName))
      callback(nil)
    end
    callback(Sprite)
  end
)
end

HomeBannerManager.TryDeleteOutOfDataImg = function(self, useFulfileNameList)
  -- function num : 0_6 , upvalues : cs_HttpDownloadHelper, _ENV
  cs_HttpDownloadHelper:DeleteImgNotUseful(PathConsts.PersistentBannerCachePath, useFulfileNameList)
end

HomeBannerManager:Init()
return HomeBannerManager


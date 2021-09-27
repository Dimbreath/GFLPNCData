local RequestPreview = {}
local cs_MicaSDKManager = CS.MicaSDKManager
RequestPreview.RequestReview = function(self)
  -- function num : 0_0 , upvalues : cs_MicaSDKManager, _ENV
  local channelId = (cs_MicaSDKManager.Instance).channelId
  if GameSystemInfo.Platform == (GameSystemInfo.PlatformType).iOS then
    ((CS.UnityExtension).RequestIOSPreview)()
  else
  end
  if GameSystemInfo.Platform == (GameSystemInfo.PlatformType).Android and channelId ~= (Consts.GameChannelType).Bilibili and channelId ~= (Consts.GameChannelType).BilibiliKol and channelId ~= (Consts.GameChannelType).BilibiliGray and channelId == (Consts.GameChannelType).BilibiliQATest then
  end
end

RequestPreview.TryRequestReview = function(self, rewardElemList)
  -- function num : 0_1 , upvalues : _ENV
  if (PlayerDataCenter.allLtrData):IsDrawHeroRankCountAboveZero() then
    return 
  end
  local isNeed = false
  for _,rewardData in pairs(rewardElemList) do
    if rewardData.heroData ~= nil and (rewardData.heroData):GetHeroDefaultRank() == 6 then
      isNeed = true
      break
    end
  end
  do
    if not isNeed then
      return 
    else
      -- DECOMPILER ERROR at PC30: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (PlayerDataCenter.allLtrData).drawHeroRankCount = 1
    end
    if isGameDev then
      print("打算弹评价")
    end
    self:RequestReview()
  end
end

return RequestPreview


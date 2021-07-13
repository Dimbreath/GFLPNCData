-- params : ...
-- function num : 0 , upvalues : _ENV
local HomeBannerData = class("HomeBannerData")
local JumpManager = require("Game.Jump.JumpManager")
HomeBannerData.CreateNewBannerData = function(bannerJsonData)
  -- function num : 0_0 , upvalues : HomeBannerData
  local bannerData = (HomeBannerData.New)()
  bannerData.id = bannerJsonData.id
  bannerData:UpdateBannerData(bannerJsonData)
  return bannerData
end

HomeBannerData.ctor = function(self)
  -- function num : 0_1
  self.id = nil
  self.pic_name = nil
  self.pic_url = nil
  self.__isOpenUrl = false
  self.targetUrl = nil
  self.__isInnerJump = false
  self.jumpTargetId = nil
  self.jumpArgs = nil
  self.sort = nil
  self.delay = 3
  self.outOfDataTimeStamp = nil
  self.__isShowLeftTime = false
end

HomeBannerData.UpdateBannerData = function(self, bannerJsonData)
  -- function num : 0_2 , upvalues : _ENV
  self.pic_name = bannerJsonData.pic_name
  self.pic_url = bannerJsonData.pic_url
  if bannerJsonData.type_id ~= nil then
    if bannerJsonData.type_id >= 0 or bannerJsonData.type_id == 0 then
      self.__isOpenUrl = true
      self.targetUrl = bannerJsonData.extra
    else
      self.__isInnerJump = true
      if not bannerJsonData.extra_id then
        error("can\'t read bannerCfg with type_id:" .. tostring(bannerJsonData.type_id) .. " extra_id:" .. tostring(not bannerJsonData.extra_id and ((ConfigData.banner_tv)[bannerJsonData.type_id])[(ConfigData.banner_tv)[bannerJsonData.type_id] == nil or 0] ~= nil or 0))
        self.__isInnerJump = false
        do
          local bannerCfg = ((ConfigData.banner_tv)[bannerJsonData.type_id])[bannerJsonData.extra_id or 0]
          self.jumpTargetId = bannerCfg.jump_id
          self.jumpArgs = bannerCfg.jump_arg
          self.sort = bannerJsonData.sort
          self.delay = bannerJsonData.delay
          self.outOfDataTimeStamp = TimeStringToTimeStamp(bannerJsonData.end_time)
          self.__isShowLeftTime = bannerJsonData.is_time_limit
        end
      end
    end
  end
end

HomeBannerData.GetBannerIsInnerJump = function(self)
  -- function num : 0_3
  return self.__isInnerJump
end

HomeBannerData.GetBannerIsOpenURL = function(self)
  -- function num : 0_4
  return self.__isOpenUrl
end

HomeBannerData.GetBannerIsShowLeftTime = function(self)
  -- function num : 0_5
  return self.__isShowLeftTime
end

HomeBannerData.GetBannerLeftTime = function(self)
  -- function num : 0_6 , upvalues : _ENV
  return self.outOfDataTimeStamp - PlayerDataCenter.timestamp
end

HomeBannerData.GetBannerIsOutOfData = function(self)
  -- function num : 0_7
  do return self:GetBannerLeftTime() <= 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

HomeBannerData.GetBannerPicUrl = function(self)
  -- function num : 0_8
  return self.pic_url
end

HomeBannerData.GetIsLotteryOrShopItemClosed = function(self)
  -- function num : 0_9 , upvalues : JumpManager, _ENV
  if self.jumpTargetId == (JumpManager.eJumpTarget).DynLottery then
    if self.jumpArgs == nil or #self.jumpArgs <= 0 then
      return false
    end
    local poolId = nil
    if self.jumpArgs ~= nil then
      poolId = (self.jumpArgs)[1]
    end
    return not (PlayerDataCenter.allLtrData):GetIsSpecificPoolOpen(poolId)
  else
    do
      if self.jumpTargetId == (JumpManager.eJumpTarget).DynShop then
        if self.jumpArgs == nil or #self.jumpArgs <= 0 then
          return false
        end
        local shopId, shopDataId, shopPageId = nil, nil, nil
        if self.jumpArgs ~= nil then
          shopId = (self.jumpArgs)[1]
          shopDataId = (self.jumpArgs)[2]
          shopPageId = (self.jumpArgs)[3]
        end
        local ctrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
        return ctrl:GetShelfIsSouldOut(shopId, shopDataId)
      else
        do
          if self.jumpTargetId == (JumpManager.eJumpTarget).DynActivity then
            if self.jumpArgs == nil or #self.jumpArgs <= 0 then
              return false
            end
            return not JumpManager:Jump2DynActivityValidate(self.jumpArgs)
          end
          return false
        end
      end
    end
  end
end

HomeBannerData.GetBannerPicName = function(self)
  -- function num : 0_10
  return self.pic_name
end

return HomeBannerData


-- params : ...
-- function num : 0 , upvalues : _ENV
local SettingController = class("SettingController", ControllerBase)
local PstConfig = require("Game.PersistentManager.PersistentData.PersistentConfig")
local cs_RenderManager = (CS.RenderManager).Instance
SettingController.OnInit = function(self)
  -- function num : 0_0
end

SettingController.InitSettingData = function(self)
  -- function num : 0_1 , upvalues : _ENV, PstConfig
  PersistentManager:LoadAndDecodeData((PstConfig.ePackage).SystemData)
  local audioSetting = self:GetSettingAudioData()
  local cs_AudioManager = (CS.AudioManager).Instance
  for index = 1, 3 do
    cs_AudioManager:SetVolume(index, (audioSetting.volumes)[index])
    ;
    ((CS.AudioManager).Instance):SetMute(index, (audioSetting.mutes)[index])
  end
  local displaySetting = self:GetSettingDisplayData()
  self:SetResolutionIndex(displaySetting.resolution or 1)
  self:SetTextureLimit(displaySetting.texture_limit or 0)
  self:SetFrameRateIndex(displaySetting.frame_rate or 0)
  self:SetDynShadowIndex(displaySetting.dyn_shadow or 1)
  self:SetAntiAliasingIndex(displaySetting.anti_aliasing or 0)
end

SettingController.GetSettingAudioData = function(self)
  -- function num : 0_2 , upvalues : _ENV, PstConfig
  return (PersistentManager:GetDataModel((PstConfig.ePackage).SystemData)):GetAudioData()
end

SettingController.GetSettingDisplayData = function(self)
  -- function num : 0_3 , upvalues : _ENV, PstConfig
  return (PersistentManager:GetDataModel((PstConfig.ePackage).SystemData)):GetDisplayData()
end

SettingController.GetSettingNoticeSwitch = function(self)
  -- function num : 0_4 , upvalues : _ENV, PstConfig
  return (PersistentManager:GetDataModel((PstConfig.ePackage).UserData)):GetNoticeSwitchOff()
end

SettingController.SetResolutionIndex = function(self, index)
  -- function num : 0_5 , upvalues : cs_RenderManager
  if index == 0 then
    cs_RenderManager:SetResolutionRatio(1)
  else
    if index == 1 then
      cs_RenderManager:SetResolutionRatio(0.85)
    else
      if index == 2 then
        cs_RenderManager:SetResolutionRatio(0.7)
      end
    end
  end
  local displaySetting = self:GetSettingDisplayData()
  displaySetting.resolution = index
end

SettingController.SetTextureLimit = function(self, limit)
  -- function num : 0_6 , upvalues : cs_RenderManager
  cs_RenderManager:SetTextureLimit(limit)
  local displaySetting = self:GetSettingDisplayData()
  displaySetting.texture_limit = limit
end

SettingController.SetFrameRateIndex = function(self, index)
  -- function num : 0_7 , upvalues : cs_RenderManager
  if index == 0 then
    cs_RenderManager:SetFrameRate(30)
  else
    if index == 1 then
      cs_RenderManager:SetFrameRate(60)
    end
  end
  local displaySetting = self:GetSettingDisplayData()
  displaySetting.frame_rate = index
end

SettingController.SetDynShadowIndex = function(self, index)
  -- function num : 0_8 , upvalues : cs_RenderManager
  if index == 0 then
    cs_RenderManager:SetDynShadow(false)
  else
    if index == 1 then
      cs_RenderManager:SetDynShadow(true)
    end
  end
  local displaySetting = self:GetSettingDisplayData()
  displaySetting.dyn_shadow = index
end

SettingController.SetAntiAliasingIndex = function(self, index)
  -- function num : 0_9 , upvalues : cs_RenderManager
  cs_RenderManager:SetAntiAliasing(index * 4)
  local displaySetting = self:GetSettingDisplayData()
  displaySetting.anti_aliasing = index
end

SettingController.SetNoticeSwitchOff = function(self, noticeId, value)
  -- function num : 0_10 , upvalues : _ENV, PstConfig
  (PersistentManager:GetDataModel((PstConfig.ePackage).UserData)):SetNoticeSwitchOff(noticeId, value)
end

SettingController.UserLogout = function(self)
  -- function num : 0_11 , upvalues : _ENV
  (NetworkManager.luaNetworkAgent):LogoutToLogin(true)
end

SettingController.OpenUserCenter = function(self)
  -- function num : 0_12 , upvalues : _ENV
  ((CS.MicaSDKManager).Instance):OpenUserCenter()
end

SettingController.OnDelete = function(self)
  -- function num : 0_13
end

return SettingController

-- params : ...
-- function num : 0 , upvalues : _ENV
local SettingController = class("SettingController", ControllerBase)
local PstConfig = require(
                      "Game.PersistentManager.PersistentData.PersistentConfig")
local cs_RenderManager = (CS.RenderManager).Instance
SettingController.OnInit = function(self)
    -- function num : 0_0
end

SettingController.InitSettingData = function(self)
    -- function num : 0_1 , upvalues : _ENV, PstConfig
    PersistentManager:LoadAndDecodeData((PstConfig.ePackage).SystemData)
    local audioSetting = self:GetSettingAudioData()
    local cs_AudioManager = (CS.AudioManager).Instance
    for index = 1, 3 do
        cs_AudioManager:SetVolume(index, (audioSetting.volumes)[index]);
        ((CS.AudioManager).Instance):SetMute(index, (audioSetting.mutes)[index])
    end
    local displaySetting = self:GetSettingDisplayData()
    self:SetResolutionIndex(displaySetting.resolution or 1)
    self:SetTextureLimit(displaySetting.texture_limit or 0)
    self:SetFrameRateIndex(displaySetting.frame_rate or 0)
    self:SetDynShadowIndex(displaySetting.dyn_shadow or 1)
    self:SetAntiAliasingIndex(displaySetting.anti_aliasing or 0)
end

SettingController.GetSettingAudioData = function(self)
    -- function num : 0_2 , upvalues : _ENV, PstConfig
    return
        (PersistentManager:GetDataModel((PstConfig.ePackage).SystemData)):GetAudioData()
end

SettingController.GetSettingDisplayData =
    function(self)
        -- function num : 0_3 , upvalues : _ENV, PstConfig
        return
            (PersistentManager:GetDataModel((PstConfig.ePackage).SystemData)):GetDisplayData()
    end

SettingController.GetSettingNoticeSwitch =
    function(self)
        -- function num : 0_4 , upvalues : _ENV, PstConfig
        return
            (PersistentManager:GetDataModel((PstConfig.ePackage).UserData)):GetNoticeSwitchOff()
    end

SettingController.SetResolutionIndex = function(self, index)
    -- function num : 0_5 , upvalues : cs_RenderManager
    if index == 0 then
        cs_RenderManager:SetResolutionRatio(1)
    else
        if index == 1 then
            cs_RenderManager:SetResolutionRatio(0.85)
        else
            if index == 2 then
                cs_RenderManager:SetResolutionRatio(0.7)
            end
        end
    end
    local displaySetting = self:GetSettingDisplayData()
    displaySetting.resolution = index
end

SettingController.SetTextureLimit = function(self, limit)
    -- function num : 0_6 , upvalues : cs_RenderManager
    cs_RenderManager:SetTextureLimit(limit)
    local displaySetting = self:GetSettingDisplayData()
    displaySetting.texture_limit = limit
end

SettingController.SetFrameRateIndex = function(self, index)
    -- function num : 0_7 , upvalues : cs_RenderManager
    if index == 0 then
        cs_RenderManager:SetFrameRate(30)
    else
        if index == 1 then cs_RenderManager:SetFrameRate(60) end
    end
    local displaySetting = self:GetSettingDisplayData()
    displaySetting.frame_rate = index
end

SettingController.SetDynShadowIndex = function(self, index)
    -- function num : 0_8 , upvalues : cs_RenderManager
    if index == 0 then
        cs_RenderManager:SetDynShadow(false)
    else
        if index == 1 then cs_RenderManager:SetDynShadow(true) end
    end
    local displaySetting = self:GetSettingDisplayData()
    displaySetting.dyn_shadow = index
end

SettingController.SetAntiAliasingIndex =
    function(self, index)
        -- function num : 0_9 , upvalues : cs_RenderManager
        cs_RenderManager:SetAntiAliasing(index * 4)
        local displaySetting = self:GetSettingDisplayData()
        displaySetting.anti_aliasing = index
    end

SettingController.SetNoticeSwitchOff = function(self, noticeId, value)
    -- function num : 0_10 , upvalues : _ENV, PstConfig
    (PersistentManager:GetDataModel((PstConfig.ePackage).UserData)):SetNoticeSwitchOff(
        noticeId, value)
end

SettingController.UserLogout = function(self)
    -- function num : 0_11 , upvalues : _ENV
    (NetworkManager.luaNetworkAgent):LogoutToLogin(true)
end

SettingController.OpenUserCenter = function(self)
    -- function num : 0_12 , upvalues : _ENV
    ((CS.MicaSDKManager).Instance):OpenUserCenter()
end

SettingController.OnDelete = function(self)
    -- function num : 0_13
end

return SettingController


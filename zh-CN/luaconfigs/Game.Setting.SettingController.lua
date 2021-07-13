-- params : ...
-- function num : 0 , upvalues : _ENV
local SettingController = class("SettingController", ControllerBase)
local cs_RenderManager = (CS.RenderManager).Instance
SettingController.OnInit = function(self)
  -- function num : 0_0
end

SettingController.InitSettingData = function(self)
  -- function num : 0_1 , upvalues : _ENV, cs_RenderManager
  PersistentManager:LoadAndDecodeData((PersistentConfig.ePackage).SystemData)
  local audioSetting = self:GetSettingAudioData()
  local cs_AudioManager = (CS.AudioManager).Instance
  for index = 1, 3 do
    cs_AudioManager:SetVolume(index, (audioSetting.volumes)[index])
    ;
    ((CS.AudioManager).Instance):SetMute(index, (audioSetting.mutes)[index])
  end
  cs_RenderManager:ResetRenderSetting()
  local systemSaveData = self:GetSystemSaveData()
  self:SetResolutionIndex(systemSaveData:GetDisplaySettingValue("resolution"))
  self:SetTextureLimit(systemSaveData:GetDisplaySettingValue("texture_limit"))
  self:SetFrameRateIndex(systemSaveData:GetDisplaySettingValue("frame_rate"))
  self:SetDynShadowIndex(systemSaveData:GetDisplaySettingValue("dyn_shadow"))
  self:SetAntiAliasingIndex(systemSaveData:GetDisplaySettingValue("anti_aliasing"))
  self:SetEffectQuality(systemSaveData:GetDisplaySettingValue("effect_quality"))
  self:SetModelQuality(systemSaveData:GetDisplaySettingValue("model_quality"))
  self:SetOutlineIndex(systemSaveData:GetDisplaySettingValue("outline"))
  self:SetPostEffect(systemSaveData:GetDisplaySettingValue("post_effect"))
end

SettingController.GetSystemSaveData = function(self)
  -- function num : 0_2 , upvalues : _ENV
  return PersistentManager:GetDataModel((PersistentConfig.ePackage).SystemData)
end

SettingController.GetSettingAudioData = function(self)
  -- function num : 0_3 , upvalues : _ENV
  return (PersistentManager:GetDataModel((PersistentConfig.ePackage).SystemData)):GetAudioData()
end

SettingController.SetSettingAudioVolume = function(self, index, value)
  -- function num : 0_4
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetAudioDataVolume(index, value)
end

SettingController.SetSettingAudioMute = function(self, index, value)
  -- function num : 0_5
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetAudioDataMute(index, value)
end

SettingController.GetSettingNoticeSwitch = function(self)
  -- function num : 0_6 , upvalues : _ENV
  return (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):GetNoticeSwitchOff()
end

SettingController.SetResolutionIndex = function(self, index)
  -- function num : 0_7 , upvalues : cs_RenderManager
  if cs_RenderManager.originHeight >= 1000 then
    if index == 0 then
      cs_RenderManager:SetResolutionRatio(1)
    else
      if index == 1 then
        cs_RenderManager:SetResolutionRatio(0.9)
      else
        if index == 2 then
          cs_RenderManager:SetResolutionRatio(0.8)
        else
          if index == 3 then
            cs_RenderManager:SetResolutionRatio(0.68)
          end
        end
      end
    end
  else
    if index == 0 then
      cs_RenderManager:SetResolutionRatio(1)
    else
      if index == 1 then
        cs_RenderManager:SetResolutionRatio(0.95)
      else
        if index == 2 then
          cs_RenderManager:SetResolutionRatio(0.88)
        else
          if index == 3 then
            cs_RenderManager:SetResolutionRatio(0.8)
          end
        end
      end
    end
  end
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetDisplaySettingValue("resolution", index)
end

SettingController.SetTextureLimit = function(self, limit)
  -- function num : 0_8 , upvalues : cs_RenderManager
  cs_RenderManager:SetTextureLimit(limit)
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetDisplaySettingValue("texture_limit", limit)
end

SettingController.SetEffectQuality = function(self, quality)
  -- function num : 0_9 , upvalues : cs_RenderManager
  cs_RenderManager:SetEffectQualityLevel(quality)
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetDisplaySettingValue("effect_quality", quality)
end

SettingController.SetModelQuality = function(self, quality)
  -- function num : 0_10 , upvalues : cs_RenderManager
  cs_RenderManager:SetModelQualityLevel(quality)
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetDisplaySettingValue("model_quality", quality)
end

SettingController.SetPostEffect = function(self, quality)
  -- function num : 0_11 , upvalues : cs_RenderManager
  cs_RenderManager:SetPostEffectLevel(quality)
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetDisplaySettingValue("post_effect", quality)
end

SettingController.SetFrameRateIndex = function(self, index)
  -- function num : 0_12 , upvalues : cs_RenderManager
  if index == 0 then
    cs_RenderManager:SetFrameRate(30)
  else
    if index == 1 then
      cs_RenderManager:SetFrameRate(60)
    end
  end
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetDisplaySettingValue("frame_rate", index)
end

SettingController.SetDynShadowIndex = function(self, index)
  -- function num : 0_13 , upvalues : cs_RenderManager
  if index == 0 then
    cs_RenderManager:SetDynShadow(false)
  else
    if index > 0 then
      cs_RenderManager:SetDynShadow(true)
    end
  end
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetDisplaySettingValue("dyn_shadow", index)
end

SettingController.SetAntiAliasingIndex = function(self, index)
  -- function num : 0_14 , upvalues : cs_RenderManager
  cs_RenderManager:SetAntiAliasing(index * 4)
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetDisplaySettingValue("anti_aliasing", index)
end

SettingController.SetOutlineIndex = function(self, index)
  -- function num : 0_15 , upvalues : cs_RenderManager
  if index == 0 then
    cs_RenderManager:SetOutlineActive(false)
  else
    if index > 0 then
      cs_RenderManager:SetOutlineActive(true)
    end
  end
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetDisplaySettingValue("outline", index)
end

SettingController.SetNoticeSwitchOff = function(self, noticeId, value)
  -- function num : 0_16 , upvalues : _ENV
  (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):SetNoticeSwitchOff(noticeId, value)
end

SettingController.UserLogout = function(self)
  -- function num : 0_17 , upvalues : _ENV
  (NetworkManager.luaNetworkAgent):LogoutToLogin(true)
end

SettingController.OpenUserCenter = function(self)
  -- function num : 0_18 , upvalues : _ENV
  ((CS.MicaSDKManager).Instance):OpenUserCenter()
end

SettingController.EnterCustomService = function(self)
  -- function num : 0_19 , upvalues : _ENV
  ((CS.MicaSDKManager).Instance):EnterCustomService()
end

SettingController.OnDelete = function(self)
  -- function num : 0_20
end

return SettingController


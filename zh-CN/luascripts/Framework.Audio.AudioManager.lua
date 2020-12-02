-- params : ...
-- function num : 0 , upvalues : _ENV
local AudioManager = {}
local CS_AudioManager = (CS.AudioManager).Instance
AudioManager.AudioTypeCount = 3
AudioManager.PlayAudio = function(self, cueName, cueSheetName, sourceType, completeEvent, ignoreSameBgm)
  -- function num : 0_0 , upvalues : CS_AudioManager
  if ignoreSameBgm == nil then
    ignoreSameBgm = true
  end
  return CS_AudioManager:PlayAudio(cueName, cueSheetName, sourceType, completeEvent, ignoreSameBgm)
end

AudioManager.PlayAudioById = function(self, audioId, completeEvent, ignoreSameBgm)
  -- function num : 0_1 , upvalues : _ENV
  local cueName, cueSheetName, sourceType = ConfigData:GetAudioCfg(audioId)
  if (string.IsNullOrEmpty)(cueName) then
    error("cueName is nil or empty, audioId = " .. tostring(audioId))
    return 
  end
  return self:PlayAudio(cueName, cueSheetName, sourceType, completeEvent, ignoreSameBgm)
end

AudioManager.StopSource = function(self, sourceType)
  -- function num : 0_2 , upvalues : CS_AudioManager
  CS_AudioManager:StopSource(sourceType)
end

AudioManager.StopAudioByBack = function(self, audioPlayback)
  -- function num : 0_3 , upvalues : CS_AudioManager
  CS_AudioManager:StopAudioByBack(audioPlayback)
end

AudioManager.SetVolume = function(self, sourceType, volume)
  -- function num : 0_4 , upvalues : CS_AudioManager
  CS_AudioManager:SetVolume(sourceType, volume)
end

AudioManager.PauseSource = function(self, sourceType, pause)
  -- function num : 0_5 , upvalues : CS_AudioManager
  CS_AudioManager:PauseSource(sourceType, pause)
end

AudioManager.GetVolume = function(self, sourceType)
  -- function num : 0_6 , upvalues : CS_AudioManager
  return CS_AudioManager:GetVolume(sourceType)
end

AudioManager.RecordCurBgm = function(self)
  -- function num : 0_7 , upvalues : CS_AudioManager
  CS_AudioManager:RecordCurBgm()
end

AudioManager.ResumeLastBgm = function(self)
  -- function num : 0_8 , upvalues : CS_AudioManager
  CS_AudioManager:ResumeLastBgm()
end

AudioManager.SetSourceSelectorLabel = function(self, sourceType, selector, label)
  -- function num : 0_9 , upvalues : CS_AudioManager
  CS_AudioManager:SetSourceSelectorLabel(sourceType, selector, label)
end

AudioManager.RemoveCueSheet = function(self, cueSheet)
  -- function num : 0_10 , upvalues : CS_AudioManager
  CS_AudioManager:RemoveCueSheet(cueSheet)
end

AudioManager.RemoveCueSheetsWithPrefix = function(self, prefix)
  -- function num : 0_11 , upvalues : CS_AudioManager
  CS_AudioManager:RemoveCueSheetsWithPrefix(prefix)
end

AudioManager.SetSourceAisacControl = function(self, sourceType, controlName, value)
  -- function num : 0_12 , upvalues : CS_AudioManager
  CS_AudioManager:SetSourceAisacControl(sourceType, controlName, value)
end

AudioManager.SetBgmSourceFadeInAndOutTime = function(self, fadeInTime, fadeOutTime)
  -- function num : 0_13 , upvalues : CS_AudioManager
  CS_AudioManager:SetBgmSourceFadeInAndOutTime(fadeInTime, fadeOutTime)
end

AudioManager.ResetBgmSourceFadeParam = function(self)
  -- function num : 0_14 , upvalues : CS_AudioManager
  CS_AudioManager:ResetBgmSourceFadeParam()
end

AudioManager.RemoveBgmSourceFader = function(self)
  -- function num : 0_15 , upvalues : CS_AudioManager
  CS_AudioManager:RemoveBgmSourceFader()
end

return AudioManager


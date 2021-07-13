-- params : ...
-- function num : 0 , upvalues : _ENV
local CharacterVoiceController = class("AvgController", ControllerBase)
local base = ControllerBase
local CS_LanguageGlobal = CS.LanguageGlobal
local SheetMaxNum = 10
CharacterVoiceController.OnInit = function(self)
  -- function num : 0_0
  self.sheetDic = {}
  self.textCfgDic = {}
end

CharacterVoiceController.HasCv = function(self, heroId)
  -- function num : 0_1 , upvalues : _ENV
  do return (ConfigData.audio_voice_hero)[heroId] ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

CharacterVoiceController.PlayCv = function(self, heroId, voiceId, completeEvent)
  -- function num : 0_2 , upvalues : _ENV, SheetMaxNum
  local sheetName, cueName = self:GetSheetNameAndCueName(heroId, voiceId)
  if sheetName == nil then
    return 
  end
  if (self.sheetDic)[heroId] == nil and SheetMaxNum <= (table.count)(self.sheetDic) then
    for k,v in pairs(self.sheetDic) do
      self:RemoveCvCueSheet(k)
      do break end
    end
  end
  do
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.sheetDic)[heroId] = sheetName
    self.lastPlayedHeroId = heroId
    return AudioManager:PlayAudio(cueName, sheetName, eAudioSourceType.VoiceSource, completeEvent)
  end
end

CharacterVoiceController.RemoveCvCueSheet = function(self, heroId)
  -- function num : 0_3 , upvalues : _ENV
  local sheetName = (self.sheetDic)[heroId]
  if sheetName ~= nil then
    AudioManager:RemoveCueSheet(sheetName)
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.sheetDic)[heroId] = nil
  end
end

CharacterVoiceController.RemoveCvAllCueSheet = function(self, removeLastCvHero)
  -- function num : 0_4 , upvalues : _ENV
  local lastSheetName = nil
  for heroId,sheetName in pairs(self.sheetDic) do
    if not removeLastCvHero and heroId == self.lastPlayedHeroId then
      lastSheetName = sheetName
    else
      AudioManager:RemoveCueSheet(sheetName)
    end
  end
  self.sheetDic = {}
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'

  if not removeLastCvHero and self.lastPlayedHeroId ~= nil then
    (self.sheetDic)[self.lastPlayedHeroId] = lastSheetName
  end
end

CharacterVoiceController.GetCvText = function(self, heroId, voiceId)
  -- function num : 0_5 , upvalues : _ENV, CS_LanguageGlobal
  if not self:HasCv(heroId) then
    return 
  end
  local heroCfg = (ConfigData.hero_data)[heroId]
  if heroCfg == nil then
    error("Cant get hero_data, heroId = " .. tostring(heroId))
    return 
  end
  local resCfg = (ConfigData.resource_model)[heroCfg.src_id]
  if resCfg == nil then
    error("resource model Cfg is null,id:" .. tostring(heroCfg.src_id))
    return 
  end
  local voiceCfg = (ConfigData.audio_voice)[voiceId]
  if voiceCfg == nil then
    error("Cant get audio_voice, voiceId = " .. tostring(voiceId))
    return 
  end
  local textCfg = (self.textCfgDic)[heroId]
  if textCfg == nil then
    local lang = (CS_LanguageGlobal.GetLanguageStr)()
    do
      local langPath = "CvTextConfig." .. resCfg.res_Name .. "_" .. lang
      local ok, err = pcall(function()
    -- function num : 0_5_0 , upvalues : textCfg, _ENV, langPath
    textCfg = require(langPath)
    textCfg.cvLangPath = langPath
    return true
  end
)
      if not ok then
        error("Can\'t get CvLanguage, path = " .. langPath .. ",\n" .. err)
        return 
      end
      -- DECOMPILER ERROR at PC71: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (self.textCfgDic)[heroId] = textCfg
    end
  end
  do
    local text = textCfg[voiceCfg.name]
    if (string.IsNullOrEmpty)(text) then
      error("Can\'t get CvLanguage, heroId = " .. tostring(heroId) .. ", voiceId = " .. tostring(voiceId))
      return 
    end
    return text
  end
end

CharacterVoiceController.RemoveCvText = function(self, heroId)
  -- function num : 0_6 , upvalues : _ENV
  local textCfg = (self.textCfgDic)[heroId]
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  if textCfg ~= nil then
    (package.loaded)[textCfg.cvLangPath] = nil
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.textCfgDic)[heroId] = nil
    collectgarbage()
  end
end

CharacterVoiceController.RemoveAllCvText = function(self)
  -- function num : 0_7 , upvalues : _ENV
  for k,textCfg in pairs(self.textCfgDic) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

    (package.loaded)[textCfg.cvLangPath] = nil
  end
  self.textCfgDic = {}
  collectgarbage()
end

CharacterVoiceController.GetVoiceIdFromName = function(self, voiceName)
  -- function num : 0_8 , upvalues : _ENV
  for id,cfg in pairs(ConfigData.audio_voice) do
    if cfg.name == voiceName then
      return id
    end
  end
  return nil
end

CharacterVoiceController.GetSheetNameAndCueName = function(self, heroId, voiceId)
  -- function num : 0_9 , upvalues : _ENV
  if not self:HasCv(heroId) then
    return 
  end
  local heroCfg = (ConfigData.hero_data)[heroId]
  if heroCfg == nil then
    error("Cant get hero_data, heroId = " .. tostring(heroId))
    return 
  end
  local resCfg = (ConfigData.resource_model)[heroCfg.src_id]
  if resCfg == nil then
    error("resource model Cfg is null,id:" .. tostring(heroCfg.src_id))
    return 
  end
  local voiceCfg = (ConfigData.audio_voice)[voiceId]
  if voiceCfg == nil then
    error("Cant get audio_voice, voiceId = " .. tostring(voiceId))
    return 
  end
  local sheetName = "VO_" .. resCfg.res_Name
  local cueName = resCfg.res_Name .. "_" .. voiceCfg.name
  return sheetName, cueName
end

CharacterVoiceController.OnDelete = function(self)
  -- function num : 0_10 , upvalues : base
  self:RemoveAllCvText()
  self:RemoveCvAllCueSheet(true)
  ;
  (base.OnDelete)(self)
end

return CharacterVoiceController


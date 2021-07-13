-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroInfoVoiceNode = class("UINHeroInfoVoiceNode", UIBaseNode)
local base = UIBaseNode
local UINHeroInfoVoiceNodeItem = require("Game.Hero.NewUI.HeroInfo.UINHeroInfoVoiceNodeItem")
UINHeroInfoVoiceNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroInfoVoiceNodeItem
  self.voiceDatas = nil
  self.__playStoryVoice = BindCallback(self, self.PlayStoryVoice)
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.voiceItemPool = (UIItemPool.New)(UINHeroInfoVoiceNodeItem, (self.ui).friendShipItem)
  ;
  ((self.ui).friendShipItem):SetActive(false)
end

UINHeroInfoVoiceNode.InitUsefulData = function(self, heroData, HeroInfoTextUtil)
  -- function num : 0_1
  self.heroData = heroData
  self.voiceDatas = nil
end

UINHeroInfoVoiceNode.InitHeroInfoNode = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local heroId = (self.heroData).dataId
  if self.voiceDatas == nil then
    self.voiceDatas = {}
    for key,cfg in pairs(ConfigData.audio_voice) do
      if cfg.is_show > 0 then
        local isNewVoice = not (self.heroData):IsAudioListed(cfg.is_show)
        local isUnlock = ((CheckCondition.CheckLua)(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2))
        local unlockInfo = nil
        if not isUnlock then
          unlockInfo = (CheckCondition.GetUnlockInfoLua)(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2)
        end
        ;
        (table.insert)(self.voiceDatas, {heroData = self.heroData, isNewVoice = isNewVoice, isUnlock = isUnlock, cfg = cfg, unlockInfo = unlockInfo, heroId = heroId})
      end
    end
  end
  do
    self:RefreshAllVoiceItem()
  end
end

UINHeroInfoVoiceNode.RefreshAllVoiceItem = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self.voiceItemPool):HideAll()
  for _,voiceData in ipairs(self.voiceDatas) do
    local item = (self.voiceItemPool):GetOne()
    item:InitHeroInfoNodeItem(voiceData, self.__playStoryVoice)
  end
end

UINHeroInfoVoiceNode.PlayStoryVoice = function(self, heroId, voiceId, playerRateCallback, playOverCallback)
  -- function num : 0_4 , upvalues : _ENV
  local CVController = ControllerManager:GetController(ControllerTypeId.Cv, true)
  if self.isPlayingVoice and self.AudioPlayback ~= nil then
    AudioManager:StopAudioByBack(self.AudioPlayback)
    self.AudioPlayback = nil
    self:__HideVoiceWords()
    if self.playOverCallback ~= nil then
      (self.playOverCallback)()
    end
    if self.playerRateTimer ~= nil then
      (self.playerRateTimer):Stop()
      self.playerRateTimer = nil
    end
    if self.playerRateCallback ~= nil then
      (self.playerRateCallback)(0)
    end
  end
  self.playOverCallback = playOverCallback
  self.playerRateCallback = playerRateCallback
  self.isPlayingVoice = true
  self:__ShowVoiceWords(CVController:GetCvText(heroId, voiceId))
  self.AudioPlayback = CVController:PlayCv(heroId, voiceId, function()
    -- function num : 0_4_0 , upvalues : self
    self.AudioPlayback = nil
    self.isPlayingVoice = false
    self:__HideVoiceWords()
    if self.playOverCallback ~= nil then
      (self.playOverCallback)()
    end
    if self.playerRateTimer ~= nil then
      (self.playerRateTimer):Stop()
      self.playerRateTimer = nil
    end
    if self.playerRateCallback ~= nil then
      (self.playerRateCallback)(0)
    end
  end
)
  local sheetName, cueName = CVController:GetSheetNameAndCueName(heroId, voiceId)
  local RefreshPlayRate = function()
    -- function num : 0_4_1 , upvalues : self, _ENV, sheetName, cueName
    local curLength = 0
    local totalLength = 1
    if self.AudioPlayback ~= nil then
      totalLength = AudioManager:GetAudioLengthById(sheetName, cueName)
      curLength = AudioManager:GetAudioPlayedTime(self.AudioPlayback)
    end
    if self.playerRateCallback ~= nil then
      (self.playerRateCallback)(curLength / totalLength)
    end
  end

  RefreshPlayRate()
  self.playerRateTimer = (TimerManager:GetTimer(0.0167, function()
    -- function num : 0_4_2 , upvalues : RefreshPlayRate
    RefreshPlayRate()
  end
, self, false, false, false)):Start()
end

UINHeroInfoVoiceNode.__ShowVoiceWords = function(self, text)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_VoiceDialog).text = text
  ;
  ((self.ui).voiceDialog):SetActive(true)
end

UINHeroInfoVoiceNode.__HideVoiceWords = function(self)
  -- function num : 0_6
  if self.ui == nil or (self.ui).voiceDialog == nil then
    return 
  end
  ;
  ((self.ui).voiceDialog):SetActive(false)
end

UINHeroInfoVoiceNode.StopPlayVoice = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self.isPlayingVoice and self.AudioPlayback ~= nil then
    AudioManager:StopAudioByBack(self.AudioPlayback)
    self.AudioPlayback = nil
    self:__HideVoiceWords()
    if self.playOverCallback ~= nil then
      (self.playOverCallback)()
      self.playOverCallback = nil
    end
    if self.playerRateTimer ~= nil then
      (self.playerRateTimer):Stop()
      self.playerRateTimer = nil
    end
    if self.playerRateCallback ~= nil then
      (self.playerRateCallback)(0)
      self.playerRateCallback = nil
    end
  end
end

UINHeroInfoVoiceNode.OnTcpLogOut_HeroInfoNode = function(self)
  -- function num : 0_8
  if self.playerRateTimer ~= nil then
    (self.playerRateTimer):Stop()
    self.playerRateTimer = nil
  end
end

UINHeroInfoVoiceNode.OnDelete = function(self)
  -- function num : 0_9 , upvalues : base
  if self.playerRateTimer ~= nil then
    (self.playerRateTimer):Stop()
    self.playerRateTimer = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINHeroInfoVoiceNode


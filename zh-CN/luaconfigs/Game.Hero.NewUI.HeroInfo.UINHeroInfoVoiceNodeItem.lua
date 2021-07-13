-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroInfoVoiceNodeItem = class("UINHeroInfoVoiceNodeItem", UIBaseNode)
local base = UIBaseNode
local eHeroInfoenum = require("Game.Hero.NewUI.HeroInfo.eHeroInfoenum")
UINHeroInfoVoiceNodeItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.__setPlayRate = BindCallback(self, self.__SetPlayRate)
  self.__onPlayOver = BindCallback(self, self.__OnPlayOver)
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_friendShipItem, self, self.OnClickPlayVoice)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_Rate).fillAmount = 0
end

UINHeroInfoVoiceNodeItem.InitHeroInfoNodeItem = function(self, voiceData, playVoiceCallback)
  -- function num : 0_1 , upvalues : _ENV
  self.voiceData = voiceData
  self.playVoiceCallback = playVoiceCallback
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)((voiceData.cfg).describe)
  ;
  ((self.ui).obj_lock):SetActive(not voiceData.isUnlock)
  if voiceData.isUnlock then
    ((self.ui).obj_img_isNew):SetActive(voiceData.isNewVoice)
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R3 in 'UnsetPending'

    if voiceData.unlockInfo ~= nil then
      ((self.ui).tex_lockCondit).text = voiceData.unlockInfo
    end
  end
end

UINHeroInfoVoiceNodeItem.OnClickPlayVoice = function(self)
  -- function num : 0_2 , upvalues : _ENV, eHeroInfoenum
  if self.playVoiceCallback ~= nil then
    (self.playVoiceCallback)((self.voiceData).heroId, ((self.voiceData).cfg).id, self.__setPlayRate, self.__onPlayOver)
  end
  if (self.voiceData).isNewVoice then
    (NetworkManager:GetNetwork(NetworkTypeID.Hero)):CS_HERO_Record((self.voiceData).heroId, (eHeroInfoenum.recordType).audio, ((self.voiceData).cfg).is_show, function()
    -- function num : 0_2_0 , upvalues : self
    ((self.voiceData).heroData):SetAudioListed(((self.voiceData).cfg).is_show)
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (self.voiceData).isNewVoice = false
    ;
    ((self.ui).obj_img_isNew):SetActive(false)
  end
)
  end
end

UINHeroInfoVoiceNodeItem.__SetPlayRate = function(self, rate)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).img_Rate).fillAmount = rate
end

UINHeroInfoVoiceNodeItem.__OnPlayOver = function(self)
  -- function num : 0_4
end

UINHeroInfoVoiceNodeItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINHeroInfoVoiceNodeItem


-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroInfoStrotyNodeUnlockedItem = class("UINHeroInfoStrotyNodeUnlockedItem", UIBaseNode)
local base = UIBaseNode
UINHeroInfoStrotyNodeUnlockedItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.isOpen = false
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_head, self, self.OnClickExpandUnlockedItem)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_voiceItem, self, self.OnClickPlayVoice)
  self.__setPlayRate = BindCallback(self, self.__SetPlayRate)
  self.__onPlayOver = BindCallback(self, self.__OnPlayOver)
  self.originSizeDelta = {x = (((self.ui).img_Bar).sizeDelta).x, y = (((self.ui).img_Bar).sizeDelta).y}
  self:__SetPlayRate(0)
end

UINHeroInfoStrotyNodeUnlockedItem.InitHISNUnlockedItem = function(self, storyData, HeroInfoTextUtil, playVoiceCallback, isHaveVoiceRes)
  -- function num : 0_1 , upvalues : _ENV
  self.storyData = storyData
  self.isVoice = (storyData.cfg).is_audio
  self.heroId = (storyData.cfg).heroID
  self.playVoiceCallback = playVoiceCallback
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Type).text = (LanguageUtil.GetLocaleText)((storyData.cfg).describe)
  ;
  ((self.ui).voiceItem):SetActive(not self.isVoice or isHaveVoiceRes)
  if self.isVoice then
    ((self.ui).img_head):SetIndex(1)
    local cvController = ControllerManager:GetController(ControllerTypeId.Cv, true)
    self.voiceId = cvController:GetVoiceIdFromName((storyData.cfg).open)
    -- DECOMPILER ERROR at PC55: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_Content).text = (ControllerManager:GetController(ControllerTypeId.Cv, true)):GetCvText(self.heroId, self.voiceId)
  else
    do
      ;
      ((self.ui).img_head):SetIndex(0)
      -- DECOMPILER ERROR at PC69: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).tex_Content).text = (HeroInfoTextUtil.GetArchiveText)(self.heroId, (storyData.cfg).open)
      self.isOpen = false
      ;
      ((self.ui).content):SetActive(false)
      -- DECOMPILER ERROR at PC85: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (((self.ui).img_Triangle).transform).rotation = (Vector3.New)(0, 0, 180)
    end
  end
end

UINHeroInfoStrotyNodeUnlockedItem.OnClickExpandUnlockedItem = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.isOpen = not self.isOpen
  ;
  ((self.ui).content):SetActive(self.isOpen)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  if self.isOpen then
    (((self.ui).img_Triangle).transform).rotation = (Vector3.New)(0, 0, 0)
  else
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (((self.ui).img_Triangle).transform).rotation = (Vector3.New)(0, 0, 180)
  end
end

UINHeroInfoStrotyNodeUnlockedItem.__SetPlayRate = function(self, rate)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).img_Bar).sizeDelta = (Vector2.New)(rate * (self.originSizeDelta).x, (self.originSizeDelta).y)
end

UINHeroInfoStrotyNodeUnlockedItem.__OnPlayOver = function(self)
  -- function num : 0_4
end

UINHeroInfoStrotyNodeUnlockedItem.OnClickPlayVoice = function(self)
  -- function num : 0_5
  if not self.isVoice then
    return 
  end
  if self.playVoiceCallback ~= nil then
    (self.playVoiceCallback)(self.heroId, self.voiceId, self.__setPlayRate, self.__onPlayOver)
  end
end

UINHeroInfoStrotyNodeUnlockedItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UINHeroInfoStrotyNodeUnlockedItem


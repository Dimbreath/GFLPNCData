local UINHeroInfoStrotyNode = class("UINHeroInfoStrotyNode", UIBaseNode)
local base = UIBaseNode
local UINHeroInfoStrotyNodeLockedItem = require("Game.Hero.NewUI.HeroInfo.UINHeroInfoStrotyNodeLockedItem")
local UINHeroInfoStrotyNodeUnlockedItem = require("Game.Hero.NewUI.HeroInfo.UINHeroInfoStrotyNodeUnlockedItem")
local eHeroInfoenum = require("Game.Hero.NewUI.HeroInfo.eHeroInfoenum")
UINHeroInfoStrotyNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroInfoStrotyNodeLockedItem, UINHeroInfoStrotyNodeUnlockedItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.lockedItemPool = (UIItemPool.New)(UINHeroInfoStrotyNodeLockedItem, (self.ui).lockedItem)
  self.unlockedItemPool = (UIItemPool.New)(UINHeroInfoStrotyNodeUnlockedItem, (self.ui).unlockItem)
  ;
  ((self.ui).lockedItem):SetActive(false)
  ;
  ((self.ui).unlockItem):SetActive(false)
  self.lockedItemDic = {}
  self.unlockedItemDic = {}
  self.__unlockLockedItem = BindCallback(self, self.UnlockLockedItem)
  self.__playStoryVoice = BindCallback(self, self.PlayStoryVoice)
end

UINHeroInfoStrotyNode.InitUsefulData = function(self, heroData, HeroInfoTextUtil)
  -- function num : 0_1 , upvalues : _ENV
  self.isPlayingVoice = false
  self.heroData = heroData
  self.HeroInfoTextUtil = HeroInfoTextUtil
  self:RefreshBuleDot()
  self.__IsHaveVoiceRes = (ControllerManager:GetController(ControllerTypeId.Cv, true)):HasCv((self.heroData).dataId)
end

UINHeroInfoStrotyNode.InitHeroInfoNode = function(self)
  -- function num : 0_2 , upvalues : _ENV, eHeroInfoenum
  local friendship_awardCfg = (ConfigData.friendship_award)[(self.heroData).dataId]
  if friendship_awardCfg == nil then
    error("hero " .. tostring((self.heroData).dataId) .. "not have friendship_awardCfg")
    return 
  end
  local storyDataList = {}
  local friendShipLevel = (PlayerDataCenter.allFriendshipData):GetLevel((self.heroData).dataId)
  for fsLevel,cfg in pairs(friendship_awardCfg) do
    local state = nil
    if (self.heroData):IsArchiveUnlocked(cfg.friendship_level) then
      state = (eHeroInfoenum.achriveState).unlocked
    else
      if fsLevel <= friendShipLevel then
        state = (eHeroInfoenum.achriveState).completed
      else
        state = (eHeroInfoenum.achriveState).locked
      end
    end
    ;
    (table.insert)(storyDataList, {state = state, cfg = cfg})
  end
  ;
  (table.sort)(storyDataList, function(a, b)
    -- function num : 0_2_0
    do return (a.cfg).friendship_level < (b.cfg).friendship_level end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self.lockedItemPool):HideAll()
  ;
  (self.unlockedItemPool):HideAll()
  for _,storyData in ipairs(storyDataList) do
    if storyData.state == (eHeroInfoenum.achriveState).unlocked then
      local item = (self.unlockedItemPool):GetOne()
      item:InitHISNUnlockedItem(storyData, self.HeroInfoTextUtil, self.__playStoryVoice, self.__IsHaveVoiceRes)
      -- DECOMPILER ERROR at PC86: Confused about usage of register: R10 in 'UnsetPending'

      ;
      (self.unlockedItemDic)[(storyData.cfg).friendship_level] = item
    else
      do
        do
          local item = (self.lockedItemPool):GetOne()
          item:InitHISNLockedItem(storyData, self.__unlockLockedItem)
          -- DECOMPILER ERROR at PC98: Confused about usage of register: R10 in 'UnsetPending'

          ;
          (self.lockedItemDic)[(storyData.cfg).friendship_level] = item
          -- DECOMPILER ERROR at PC99: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC99: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC99: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

UINHeroInfoStrotyNode.RefreshBuleDot = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local ok, heroInfoNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, (self.heroData).dataId, RedDotStaticTypeId.HeroInfomation)
  if ok then
    if (self.heroData):IsHaveCouldGetRewardArchive() then
      heroInfoNode:SetRedDotCount(1)
      ;
      ((self.ui).redDot):SetActive(true)
    else
      heroInfoNode:SetRedDotCount(0)
      ;
      ((self.ui).redDot):SetActive(false)
    end
  end
end

UINHeroInfoStrotyNode.UnlockLockedItem = function(self, storyData)
  -- function num : 0_4 , upvalues : _ENV, eHeroInfoenum
  if self.__IsUnlocking then
    return 
  end
  self.__IsUnlocking = true
  PlayerDataCenter:TakeHeroIdSnapShoot()
  ;
  (NetworkManager:GetNetwork(NetworkTypeID.Hero)):CS_HERO_Record((self.heroData).dataId, (eHeroInfoenum.recordType).archives, (storyData.cfg).friendship_level, function()
    -- function num : 0_4_0 , upvalues : self, storyData, _ENV, eHeroInfoenum
    self.__IsUnlocking = false
    ;
    (self.heroData):SetArchiveUnlocked((storyData.cfg).friendship_level)
    local lockedItem = (self.lockedItemDic)[(storyData.cfg).friendship_level]
    if lockedItem == nil then
      error("not have lockedItem")
      return 
    end
    local siblingIndex = (lockedItem.transform):GetSiblingIndex()
    storyData.state = (eHeroInfoenum.achriveState).locked
    local item = (self.unlockedItemPool):GetOne()
    item:InitHISNUnlockedItem(storyData, self.HeroInfoTextUtil, self.__playStoryVoice, self.__IsHaveVoiceRes)
    ;
    (self.lockedItemPool):HideOne(lockedItem)
    ;
    (item.transform):SetSiblingIndex(siblingIndex)
    if storyData.cfg ~= nil and (storyData.cfg).awardIds ~= nil then
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      -- function num : 0_4_0_0 , upvalues : storyData, _ENV
      if window == nil then
        return 
      end
      window:InitRewardsItem((storyData.cfg).awardIds, (storyData.cfg).awardNums, PlayerDataCenter:GetHeroIdSnapShoot())
    end
)
    end
    self:RefreshBuleDot()
  end
)
end

UINHeroInfoStrotyNode.PlayStoryVoice = function(self, heroId, voiceId, playerRateCallback, playOverCallback)
  -- function num : 0_5 , upvalues : _ENV
  if self.isPlayingVoice and self.AudioPlayback ~= nil then
    AudioManager:StopAudioByBack(self.AudioPlayback)
    self.AudioPlayback = nil
    if self.playerRateCallback ~= nil then
      (self.playerRateCallback)(0)
      self.playerRateCallback = nil
    end
    if self.playOverCallback ~= nil then
      (self.playOverCallback)()
      self.playOverCallback = nil
    end
    if self.playerRateTimerId ~= nil then
      TimerManager:StopTimer(self.playerRateTimerId)
      self.playerRateTimerId = nil
    end
  end
  if self.voiceId ~= voiceId then
    self.voiceId = voiceId
  else
    if self.isPlayingVoice then
      self.isPlayingVoice = false
      return 
    end
  end
  self.playOverCallback = playOverCallback
  self.playerRateCallback = playerRateCallback
  self.isPlayingVoice = true
  self.AudioPlayback = (ControllerManager:GetController(ControllerTypeId.Cv, true)):PlayCv(heroId, voiceId, function()
    -- function num : 0_5_0 , upvalues : self, _ENV
    self.AudioPlayback = nil
    self.isPlayingVoice = false
    if self.playOverCallback ~= nil then
      (self.playOverCallback)()
    end
    if self.playerRateTimerId ~= nil then
      TimerManager:StopTimer(self.playerRateTimerId)
      self.playerRateTimerId = nil
    end
    if self.playerRateCallback ~= nil then
      (self.playerRateCallback)(0)
    end
  end
)
  local sheetName, cueName = (ControllerManager:GetController(ControllerTypeId.Cv, true)):GetSheetNameAndCueName(heroId, voiceId)
  local RefreshPlayRate = function()
    -- function num : 0_5_1 , upvalues : self, _ENV, sheetName, cueName
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
  self.playerRateTimerId = TimerManager:StartTimer(0.0167, function()
    -- function num : 0_5_2 , upvalues : RefreshPlayRate
    RefreshPlayRate()
  end
, self, false, false, false)
end

UINHeroInfoStrotyNode.StopPlayVoice = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.isPlayingVoice and self.AudioPlayback ~= nil then
    AudioManager:StopAudioByBack(self.AudioPlayback)
    self.AudioPlayback = nil
    if self.playOverCallback ~= nil then
      (self.playOverCallback)()
      self.playOverCallback = nil
    end
    TimerManager:StopTimer(self.playerRateTimerId)
    self.playerRateTimerId = nil
    if self.playerRateCallback ~= nil then
      (self.playerRateCallback)(0)
      self.playerRateCallback = nil
    end
  end
end

UINHeroInfoStrotyNode.OnTcpLogOut_HeroInfoNode = function(self)
  -- function num : 0_7 , upvalues : _ENV
  TimerManager:StopTimer(self.playerRateTimerId)
  self.playerRateTimerId = nil
end

UINHeroInfoStrotyNode.OnDelete = function(self)
  -- function num : 0_8 , upvalues : _ENV, base
  TimerManager:StopTimer(self.playerRateTimerId)
  self.playerRateTimerId = nil
  ;
  (base.OnDelete)(self)
end

return UINHeroInfoStrotyNode


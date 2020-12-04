-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgController = class("AvgController", ControllerBase)
local base = ControllerBase
local util = require("XLua.Common.xlua_util")
local CS_LanguageGlobal = CS.LanguageGlobal
AvgController.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.avgWaitingList = {}
  self.autoPlayMode = false
  self.actDelayRatio = 1
  self.speedupMode = false
  self.__waitAvgCompleteNetowrk = false
  self.__onAvgComplete = BindCallback(self, self.OnAvgComplete)
end

AvgController.StartAvg = function(self, chapterName, avgId, completeFunc, shieldControlSwitch, isGuideAvg, ignoreTimeScale)
  -- function num : 0_1 , upvalues : _ENV, util
  if (string.IsNullOrEmpty)(chapterName) then
    error("Avg chapterName IsNullOrEmpty")
    return 
  end
  local wating = {chapterName = chapterName, completeFunc = completeFunc, avgId = avgId, shieldControlSwitch = shieldControlSwitch or false, isGuideAvg = isGuideAvg or false, ignoreTimeScale = ignoreTimeScale or false}
  ;
  (table.insert)(self.avgWaitingList, wating)
  if self.__playCoroutine == nil then
    self.__playCoroutine = (GR.StartCoroutine)((util.cs_generator)(BindCallback(self, self.PlayCoroutineFunc)))
  end
end

AvgController.PlayCoroutineFunc = function(self)
  -- function num : 0_2 , upvalues : _ENV
  while 1 do
    while 1 do
      if #self.avgWaitingList > 0 then
        if UIManager:GetWindow(UIWindowTypeID.CommonReward) ~= nil or UIManager:IsWindowInLoading(UIWindowTypeID.CommonReward) then
          (coroutine.yield)(nil)
          -- DECOMPILER ERROR at PC22: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC22: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC22: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC22: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    local waiting = (table.remove)(self.avgWaitingList, 1)
    self.avgCachePlayParam = waiting
    while not waiting.isGuideAvg and GuideManager.inGuide do
      (coroutine.yield)(nil)
    end
    self.__waitAvgCompleteNetowrk = waiting.avgId ~= nil
    self:ShowAvg(waiting.chapterName, waiting.completeFunc, waiting.shieldControlSwitch, waiting.ignoreTimeScale)
    while self.avgIsPlaying do
      (coroutine.yield)(nil)
    end
    while self.__waitAvgCompleteNetowrk do
      (coroutine.yield)(nil)
    end
    while UIManager:GetWindow(UIWindowTypeID.CommonReward) ~= nil or UIManager:IsWindowInLoading(UIWindowTypeID.CommonReward) do
      (coroutine.yield)(nil)
    end
    while waiting.isGuideAvg or GuideManager.inGuide do
      (coroutine.yield)(nil)
    end
  end
  self.__playCoroutine = nil
  self:Delete()
  -- DECOMPILER ERROR: 8 unprocessed JMP targets
end

AvgController.ShowAvg = function(self, chapterName, completeFunc, shieldControlSwitch, ignoreTimeScale)
  -- function num : 0_3 , upvalues : _ENV
  if self.avgIsPlaying then
    if self.avgCachePlayParam ~= nil then
      error("正在进行缓存播放模式,不可以直接播放avg,请先结束缓存播放模式(delete controller)")
      return 
    end
    self:ClearCurAvg()
  end
  if (string.IsNullOrEmpty)(chapterName) then
    error("Avg chapterName IsNullOrEmpty")
    return 
  end
  AudioManager:RecordCurBgm()
  self.completeFunc = completeFunc
  self.__originTimeScale = (Time.unity_time).timeScale
  self._hasError = nil
  if not self:LoadAvgCfg(chapterName) then
    return 
  end
  self.__ignoreTimeScale = ignoreTimeScale or false
  self.__shieldControlSwitch = shieldControlSwitch or false
  self.chapterName = chapterName
  self:ChangeSpeed()
  self.recordDataList = {}
  self.avgIsPlaying = true
  UIManager:ShowWindowAsync(UIWindowTypeID.Avg, function(window)
    -- function num : 0_3_0 , upvalues : self, shieldControlSwitch
    if window == nil then
      return 
    end
    self.avgWindow = window
    window:InitAvgSystem(self)
    window:SetTopControlActive(not shieldControlSwitch)
    self:PlayAvgAct(1)
  end
)
end

AvgController.PlayAvgAct = function(self, actId)
  -- function num : 0_4 , upvalues : _ENV
  local actCfg = (self.avgCfg)[actId]
  if actCfg == nil then
    warn("没有该 actId : " .. tostring(actId))
    return 
  end
  self.curActId = actId
  self.avgActComplete = false
  ;
  (self.avgWindow):PlayAvgAct(actCfg)
  self:RecordAct(actCfg, actId)
end

AvgController.PlayNextAvgAct = function(self)
  -- function num : 0_5
  if self.curActId == nil then
    return 
  end
  local actCfg = (self.avgCfg)[self.curActId]
  if actCfg.isEnd then
    return 
  end
  local nextActId = nil
  if actCfg.nextId == nil then
    nextActId = self.curActId + 1
  else
    nextActId = actCfg.nextId
  end
  if (self.avgCfg)[nextActId] == nil then
    return 
  end
  self:PlayAvgAct(nextActId)
end

AvgController.ClickContinueAvg = function(self)
  -- function num : 0_6
  if self.autoPlayMode then
    self:ClearDelayPlatNextTimer()
  end
  if self:AvgIsEnd(self.curActId) then
    self:CompleteAllAvg()
    return 
  end
  self:PlayNextAvgAct()
end

AvgController.OnAvgActComplete = function(self, jumpAct, jumpChapter, contentLen)
  -- function num : 0_7 , upvalues : _ENV
  self.avgActComplete = true
  ;
  (self.avgWindow):StopAvgVoice()
  local avgIsEnd = self:AvgIsEnd(self.curActId)
  if avgIsEnd and not self.autoPlayMode then
    return 
  end
  if jumpAct ~= nil then
    if (self.avgCfg)[jumpAct] == nil then
      error("没有该分支,id = " .. tostring(jumpAct))
      return 
    end
    self:RecordSelectedAct(jumpAct)
    self:PlayAvgAct(jumpAct)
  else
    if not (string.IsNullOrEmpty)(jumpChapter) then
      self:JumpChapter(jumpChapter)
    else
      if not self.autoPlayMode then
        return 
      end
      if self.actDelayRatio ~= 1 or not (ConfigData.buildinConfig).AvgActDelayFactor1 then
        local ratio = (ConfigData.buildinConfig).AvgActDelayFactor2
      end
      local duration = (ConfigData.buildinConfig).AvgActDelayBase + contentLen * ratio
      self.__delayPlatNextTimer = (TimerManager:GetTimer(duration, function()
    -- function num : 0_7_0 , upvalues : self, avgIsEnd
    self.__delayPlatNextTimer = nil
    if self.avgCfg == nil then
      return 
    end
    if avgIsEnd then
      self:CompleteAllAvg()
    else
      self:PlayNextAvgAct()
    end
  end
, nil, true, false, self:AvgIgnoreTimeScale())):Start()
    end
  end
end

AvgController.AvgIsEnd = function(self, actId)
  -- function num : 0_8
  local actCfg = self:GetAcgActCfg(actId)
  if actCfg.isEnd then
    return true
  end
  if actCfg.nextId ~= nil then
    return false
  end
  if (self.avgCfg)[actId + 1] == nil then
    return true
  end
  return false
end

AvgController.LoadAvgCfg = function(self, storyName)
  -- function num : 0_9 , upvalues : _ENV, CS_LanguageGlobal
  local cfgPath = "AvgConfig." .. storyName .. ".AvgCfg_" .. storyName
  local ok, err = pcall(function()
    -- function num : 0_9_0 , upvalues : self, _ENV, cfgPath
    self.avgCfg = require(cfgPath)
    self.avgCfgPath = cfgPath
    return true
  end
)
  if not ok then
    error("Can\'t get AvgCfg, path = " .. cfgPath .. ",\n" .. err)
    self:CompleteAllAvg(true)
    return 
  end
  local lang = (CS_LanguageGlobal.GetLanguageStr)()
  local langPath = "AvgConfig." .. storyName .. ".AvgLang_" .. storyName .. "_" .. lang
  local ok, err = pcall(function()
    -- function num : 0_9_1 , upvalues : self, _ENV, langPath
    self.avgLangCfg = require(langPath)
    self.avgLangPath = langPath
    return true
  end
)
  if not ok then
    error("Can\'t get AvgLanguage, path = " .. langPath .. ",\n" .. err)
    self:CompleteAllAvg(true)
    return 
  end
  return true
end

AvgController.UnloadAvgCfg = function(self)
  -- function num : 0_10 , upvalues : _ENV
  self.avgCfg = nil
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  if self.avgCfgPath ~= nil then
    (package.loaded)[self.avgCfgPath] = nil
    self.avgCfgPath = nil
  end
  self.avgLangCfg = nil
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  if self.avgLangPath ~= nil then
    (package.loaded)[self.avgLangPath] = nil
    self.avgLangPath = nil
  end
  collectgarbage()
end

AvgController.GetAvgLanguage = function(self, id)
  -- function num : 0_11 , upvalues : _ENV
  local content = (self.avgLangCfg)[id]
  if (string.IsNullOrEmpty)(content) then
    warn("Avg language is nil, contentId = " .. tostring(id))
    return ""
  end
  return content
end

AvgController.SwitchAvgAutoPlay = function(self)
  -- function num : 0_12
  local delayRatio = self.actDelayRatio
  local autoPlayMode = self.autoPlayMode
  if autoPlayMode then
    if delayRatio == 1 then
      delayRatio = 2
    else
      autoPlayMode = false
      delayRatio = 1
    end
  else
    autoPlayMode = true
    delayRatio = 1
  end
  return self:SetAvgAutoPlayMode(autoPlayMode, delayRatio)
end

AvgController.SetAvgAutoPlayMode = function(self, autoPlayMode, delayRatio)
  -- function num : 0_13
  self.autoPlayMode = autoPlayMode
  if self.autoPlayMode and self.avgActComplete then
    self:PlayNextAvgAct()
  end
  self:ClearDelayPlatNextTimer()
  self.actDelayRatio = delayRatio or 1
  return self.autoPlayMode, self.actDelayRatio
end

AvgController.GetAvgAutoPlayMode = function(self)
  -- function num : 0_14
  return self.autoPlayMode, self.actDelayRatio
end

AvgController.SwitchAvgSpeedup = function(self)
  -- function num : 0_15
  self.speedupMode = not self.speedupMode
  self:ChangeSpeed()
  return self.speedupMode
end

AvgController.GetAvgSpeedupMode = function(self)
  -- function num : 0_16
  return self.speedupMode
end

AvgController.ChangeSpeed = function(self)
  -- function num : 0_17 , upvalues : _ENV
  if self:AvgIgnoreTimeScale() then
    return 
  end
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (Time.unity_time).timeScale = self.speedupMode and (ConfigData.game_config).AvgSpeedupTimescale or 1
end

AvgController.ClearDelayPlatNextTimer = function(self)
  -- function num : 0_18
  if self.__delayPlatNextTimer ~= nil then
    (self.__delayPlatNextTimer):Stop()
    self.__delayPlatNextTimer = nil
  end
end

AvgController.RecordAct = function(self, actCfg, actId)
  -- function num : 0_19 , upvalues : _ENV
  if actCfg.content == nil and actCfg.branch == nil then
    return 
  end
  local recordData = {actId = actId, selectedActId = nil}
  ;
  (table.insert)(self.recordDataList, recordData)
end

AvgController.RecordSelectedAct = function(self, selectedActId)
  -- function num : 0_20 , upvalues : _ENV
  local recordData = (self.recordDataList)[#self.recordDataList]
  if recordData == nil then
    warn("Current recordData is nil.")
    return 
  end
  recordData.selectedActId = selectedActId
end

AvgController.GetAvgRecordData = function(self)
  -- function num : 0_21 , upvalues : _ENV
  local list = {}
  for k,v in ipairs(self.recordDataList) do
    list[k] = v
  end
  return list
end

AvgController.GetAcgActCfg = function(self, actId)
  -- function num : 0_22 , upvalues : _ENV
  local actCfg = (self.avgCfg)[actId]
  if actCfg == nil then
    error("Can\'t get actCfg, actId = " .. tostring(actId))
    return table.emptytable
  end
  return actCfg
end

AvgController.GetCurActId = function(self)
  -- function num : 0_23
  return self.curActId
end

AvgController.GetCurChapterName = function(self)
  -- function num : 0_24
  return self.chapterName
end

AvgController.JumpChapter = function(self, chapterName)
  -- function num : 0_25
  self:ClearCurAvg()
  self:ShowAvg(chapterName, self.completeFunc, self.__shieldControlSwitch, self.__ignoreTimeScale)
end

AvgController.AvgIgnoreTimeScale = function(self)
  -- function num : 0_26
  return self.__ignoreTimeScale
end

AvgController.CompleteAllAvg = function(self, hasError)
  -- function num : 0_27 , upvalues : _ENV
  self._hasError = hasError
  if self.avgCachePlayParam ~= nil and (self.avgCachePlayParam).avgId ~= nil then
    if (ControllerManager:GetController(ControllerTypeId.AvgPlay)):IsAvgPlayed((self.avgCachePlayParam).avgId) then
      self:OnAvgComplete(nil)
    else
      ;
      (ControllerManager:GetController(ControllerTypeId.AvgPlay)):RecordAvgPlayed((self.avgCachePlayParam).avgId)
      self._heroIdSnapShoot = PlayerDataCenter:GetHeroIdSnapShoot()
      ;
      (NetworkManager:GetNetwork(NetworkTypeID.Avg)):CS_AVG_Complete((self.avgCachePlayParam).avgId, self.__onAvgComplete)
    end
  else
    self:OnAvgComplete(nil)
  end
end

AvgController.OnAvgComplete = function(self, objList)
  -- function num : 0_28 , upvalues : _ENV
  if objList ~= nil and objList.Count > 0 and self.avgCachePlayParam ~= nil then
    local ok = objList[0]
    if ok then
      local avgCfg = (ConfigData.story_avg)[(self.avgCachePlayParam).avgId]
      do
        if #avgCfg.rewardIds ~= 0 then
          UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_28_0 , upvalues : avgCfg, self
    if window == nil then
      return 
    end
    window:InitRewardsItem(avgCfg.rewardIds, avgCfg.rewardNums, self._heroIdSnapShoot)
  end
)
        end
      end
    end
  end
  do
    self.__waitAvgCompleteNetowrk = false
    self:ClearCurAvg()
    self.avgIsPlaying = false
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (Time.unity_time).timeScale = self.__originTimeScale
    AudioManager:RemoveBgmSourceFader()
    AudioManager:ResumeLastBgm()
    if self.completeFunc ~= nil then
      (self.completeFunc)()
      self.completeFunc = nil
    end
    if self.avgCachePlayParam == nil then
      self:Delete()
    end
  end
end

AvgController.ClearCurAvg = function(self)
  -- function num : 0_29 , upvalues : _ENV
  UIManager:DeleteWindow(UIWindowTypeID.Avg)
  self:ClearDelayPlatNextTimer()
  self:UnloadAvgCfg()
end

AvgController.RecordAvgAudioSheet = function(self, sheetName)
  -- function num : 0_30 , upvalues : _ENV
  if sheetName == eAuCueSheet.Music or sheetName == eAuCueSheet.UI then
    return 
  end
  if self._waitRemoveSheet == nil then
    self._waitRemoveSheet = {}
  end
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._waitRemoveSheet)[sheetName] = true
end

AvgController._RemoveCueSheet = function(self)
  -- function num : 0_31 , upvalues : _ENV
  if self._waitRemoveSheet == nil then
    return 
  end
  for sheetName,v in pairs(self._waitRemoveSheet) do
    AudioManager:RemoveCueSheet(sheetName)
  end
  self._waitRemoveSheet = nil
end

AvgController.OnDelete = function(self)
  -- function num : 0_32 , upvalues : _ENV, base
  self:ClearCurAvg()
  if self.__playCoroutine ~= nil then
    (GR.StopCoroutine)(self.__playCoroutine)
    self.__playCoroutine = nil
  end
  self:_RemoveCueSheet()
  ;
  (base.OnDelete)(self)
end

return AvgController


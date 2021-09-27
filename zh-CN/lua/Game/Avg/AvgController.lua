local AvgController = class("AvgController", ControllerBase)
local base = ControllerBase
local util = require("XLua.Common.xlua_util")
local CS_LanguageGlobal = CS.LanguageGlobal
local TAStrTag = "<TA>"
AvgController.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.avgWaitingList = {}
  self.autoPlayMode = false
  self.actDelayRatio = 1
  self.speedupMode = false
  self.__waitAvgCompleteNetowrk = false
  self.__onAvgComplete = BindCallback(self, self.OnAvgComplete)
  self:InitAvgIdDicByScriptName()
end

AvgController.InitAvgIdDicByScriptName = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self.scriptIddic = {}
  for key,value in pairs(ConfigData.story_avg) do
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R6 in 'UnsetPending'

    (self.scriptIddic)[value.script_id] = key
  end
  local NameScriptId = "cpt00_e_01_05"
  local ChouKaScriptId = "cpt00_e_01_06"
  local NameID = -1000
  local ChouKaId = -1001
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.scriptIddic)[NameScriptId] = -1000
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.scriptIddic)[ChouKaScriptId] = -1001
end

AvgController.StartAvg = function(self, chapterName, avgId, completeFunc, shieldControlSwitch, isGuideAvg, ignoreTimeScale)
  -- function num : 0_2 , upvalues : _ENV, util
  if (string.IsNullOrEmpty)(chapterName) and avgId == nil then
    error("Avg chapterName IsNullOrEmpty:" .. tostring(chapterName) .. " " .. tostring(avgId))
    return 
  end
  do
    if avgId ~= nil and (string.IsNullOrEmpty)(chapterName) then
      local avgCfg = (ConfigData.story_avg)[avgId]
      if avgCfg == nil then
        error("avg story cfg is null,id:" .. tostring(avgId))
        return 
      end
      chapterName = avgCfg.script_id
    end
    local wating = {chapterName = chapterName, completeFunc = completeFunc, avgId = avgId, shieldControlSwitch = shieldControlSwitch or false, isGuideAvg = isGuideAvg or false, ignoreTimeScale = ignoreTimeScale or false}
    self.AVGID = (self.scriptIddic)[chapterName]
    ;
    (table.insert)(self.avgWaitingList, wating)
    if self.__playCoroutine == nil then
      self.__playCoroutine = (GR.StartCoroutine)((util.cs_generator)(BindCallback(self, self.PlayCoroutineFunc)))
    end
  end
end

AvgController.PlayCoroutineFunc = function(self)
  -- function num : 0_3 , upvalues : _ENV
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
  MsgCenter:Broadcast(eMsgEventId.AVGCtrlPlayEnd)
  -- DECOMPILER ERROR: 8 unprocessed JMP targets
end

AvgController.ShowAvg = function(self, chapterName, completeFunc, shieldControlSwitch, ignoreTimeScale)
  -- function num : 0_4 , upvalues : _ENV
  if self.avgIsPlaying then
    if self.avgCachePlayParam ~= nil then
      error((string.format)("正在进行缓存播放模式,不可以直接播放avg(%s),请先结束缓存播放模式(delete controller)", chapterName))
      return 
    end
    self:ClearCurAvg()
  end
  if (string.IsNullOrEmpty)(chapterName) then
    error("Avg chapterName IsNullOrEmpty")
    return 
  end
  AudioManager:RecordCurBgm()
  AudioManager:RemoveAllVoice(true)
  self.completeFunc = completeFunc
  self.__originTimeScale = (Time.unity_time).timeScale
  self._hasError = nil
  if not self:LoadAvgCfg(chapterName) then
    return 
  end
  self.__ignoreTimeScale = ignoreTimeScale or false
  self.__shieldControlSwitch = shieldControlSwitch or false
  self.chapterName = chapterName
  self.AVGID = (self.scriptIddic)[chapterName]
  self:ChangeSpeed()
  self.recordDataList = {}
  self.avgIsPlaying = true
  self._reqCompleteAllAvg = false
  UIManager:ShowWindowAsync(UIWindowTypeID.Avg, function(window)
    -- function num : 0_4_0 , upvalues : self, shieldControlSwitch
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
  -- function num : 0_5 , upvalues : _ENV
  local nextActCfg = (self.avgCfg)[actId]
  if nextActCfg == nil then
    warn("没有该 actId : " .. tostring(actId))
    return 
  end
  self.curActId = actId
  self.avgActComplete = false
  ;
  (self.avgWindow):PlayAvgAct(nextActCfg)
  self:RecordAct(nextActCfg, actId)
end

AvgController.PlayNextAvgAct = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.curActId == nil then
    return 
  end
  local nextActCfg = (self.avgCfg)[self.curActId]
  if nextActCfg.isEnd then
    return 
  end
  local nextActId = nil
  if nextActCfg.nextId == nil then
    nextActId = self.curActId + 1
  else
    nextActId = nextActCfg.nextId
  end
  if (self.avgCfg)[nextActId] == nil then
    return 
  end
  local nextActCfg = (self.avgCfg)[nextActId]
  if nextActCfg == nil then
    warn("没有该 actId : " .. tostring(nextActId))
    return 
  end
  do
    if nextActCfg.branch ~= nil and (nextActCfg.branch).disableSelected ~= nil then
      local canNotSelectNum = 0
      for index,branchCfg in ipairs(nextActCfg.branch) do
        if branchCfg.jumpAct ~= nil and self:GetIsBranchSelected(nextActId, index) then
          canNotSelectNum = canNotSelectNum + 1
        end
      end
      if #nextActCfg.branch <= canNotSelectNum then
        self:PlayAvgAct((nextActCfg.branch).finalAct)
        return 
      end
    end
    self:PlayAvgAct(nextActId)
  end
end

AvgController.ClickContinueAvg = function(self)
  -- function num : 0_7
  if self.autoPlayMode then
    self:ClearDelayPlatNextTimer()
  end
  if self:AvgIsEnd(self.curActId) then
    self:CompleteAllAvg()
    return 
  end
  self:PlayNextAvgAct()
end

AvgController.OnAvgActComplete = function(self, selectBranchIndex, jumpAct, jumpChapter, contentLen)
  -- function num : 0_8 , upvalues : _ENV
  self.avgActComplete = true
  ;
  (self.avgWindow):StopAvgVoice()
  local avgIsEnd = self:AvgIsEnd(self.curActId)
  if avgIsEnd and not self.autoPlayMode then
    return false
  end
  if jumpAct ~= nil then
    if (self.avgCfg)[jumpAct] == nil then
      self:AvgLogError("没有该分支,id = " .. tostring(jumpAct))
      return 
    end
    self:RecordSelectedBranch(selectBranchIndex)
    self:PlayAvgAct(jumpAct)
    return true
  else
    if not (string.IsNullOrEmpty)(jumpChapter) then
      self:JumpChapter(jumpChapter)
      return true
    else
      if not self.autoPlayMode then
        return false
      end
      if self.actDelayRatio ~= 1 or not (ConfigData.buildinConfig).AvgActDelayFactor1 then
        local ratio = (ConfigData.buildinConfig).AvgActDelayFactor2
      end
      local duration = (ConfigData.buildinConfig).AvgActDelayBase + contentLen * ratio
      self.__delayPlatNextTimerId = TimerManager:StartTimer(duration, function()
    -- function num : 0_8_0 , upvalues : self, avgIsEnd
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
, nil, true, false, self:AvgIgnoreTimeScale())
      return true
    end
  end
end

AvgController.AvgIsEnd = function(self, actId)
  -- function num : 0_9
  local nextActCfg = self:GetAvgNextActCfg(actId)
  if nextActCfg.isEnd then
    return true
  end
  if nextActCfg.nextId ~= nil then
    return false
  end
  if (self.avgCfg)[actId + 1] == nil then
    return true
  end
  return false
end

AvgController.LoadAvgCfg = function(self, storyName)
  -- function num : 0_10 , upvalues : _ENV, CS_LanguageGlobal
  local cfgPath = "AvgConfig." .. storyName .. ".AvgCfg_" .. storyName
  local ok, err = pcall(function()
    -- function num : 0_10_0 , upvalues : self, _ENV, cfgPath
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
    -- function num : 0_10_1 , upvalues : self, _ENV, langPath
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
  -- function num : 0_11 , upvalues : _ENV
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
  -- function num : 0_12 , upvalues : _ENV, TAStrTag
  local content = (self.avgLangCfg)[id]
  if (string.IsNullOrEmpty)(content) then
    warn("Avg language is nil, contentId = " .. tostring(id))
    return ""
  end
  local isGirl = (PlayerDataCenter.inforData ~= nil and (PlayerDataCenter.inforData):GetSex())
  do
    if not isGirl or not ConfigData:GetTipContent(12101) then
      local taStr = ConfigData:GetTipContent(12100)
    end
    content = (string.gsub)(content, TAStrTag, taStr)
    do return content end
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
  end
end

AvgController.SwitchAvgAutoPlay = function(self)
  -- function num : 0_13
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
  -- function num : 0_14
  self.autoPlayMode = autoPlayMode
  if self.autoPlayMode and self.avgActComplete then
    self:ClearDelayPlatNextTimer()
    self:PlayNextAvgAct()
  end
  self:ClearDelayPlatNextTimer()
  self.actDelayRatio = delayRatio or 1
  return self.autoPlayMode, self.actDelayRatio
end

AvgController.CloseAvgAutoPlayMode = function(self)
  -- function num : 0_15
  return self:SetAvgAutoPlayMode(false, 1)
end

AvgController.GetAvgAutoPlayMode = function(self)
  -- function num : 0_16
  return self.autoPlayMode, self.actDelayRatio
end

AvgController.SwitchAvgSpeedup = function(self)
  -- function num : 0_17
  self.speedupMode = not self.speedupMode
  self:ChangeSpeed()
  return self.speedupMode
end

AvgController.GetAvgSpeedupMode = function(self)
  -- function num : 0_18
  return self.speedupMode
end

AvgController.ChangeSpeed = function(self)
  -- function num : 0_19 , upvalues : _ENV
  if self:AvgIgnoreTimeScale() then
    return 
  end
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (Time.unity_time).timeScale = self.speedupMode and (ConfigData.game_config).AvgSpeedupTimescale or 1
end

AvgController.ClearDelayPlatNextTimer = function(self)
  -- function num : 0_20 , upvalues : _ENV
  TimerManager:StopTimer(self.__delayPlatNextTimerId)
end

AvgController.RecordAct = function(self, nextActCfg, actId)
  -- function num : 0_21 , upvalues : _ENV
  if nextActCfg.content == nil and nextActCfg.branch == nil then
    return 
  end
  local recordData = {actId = actId, selectedActBranchIdx = nil}
  ;
  (table.insert)(self.recordDataList, recordData)
end

AvgController.RecordSelectedBranch = function(self, selectedActBranch)
  -- function num : 0_22 , upvalues : _ENV
  local recordData = (self.recordDataList)[#self.recordDataList]
  if recordData == nil then
    warn("Current recordData is nil.")
    return 
  end
  recordData.selectedActBranchIdx = selectedActBranch
end

AvgController.GetAvgRecordData = function(self)
  -- function num : 0_23 , upvalues : _ENV
  local list = {}
  for k,v in ipairs(self.recordDataList) do
    list[k] = v
  end
  return list
end

AvgController.GetIsBranchSelected = function(self, actId, branchActId)
  -- function num : 0_24 , upvalues : _ENV
  for index,recordData in ipairs(self.recordDataList) do
    if recordData.actId == actId and recordData.selectedActBranchIdx == branchActId then
      return true
    end
  end
  return false
end

AvgController.GetAvgNextActCfg = function(self, actId)
  -- function num : 0_25 , upvalues : _ENV
  local nextActCfg = (self.avgCfg)[actId]
  if nextActCfg == nil then
    self:AvgLogError("Can\'t get nextActCfg, actId = " .. tostring(actId))
    return table.emptytable
  end
  return nextActCfg
end

AvgController.GetCurActId = function(self)
  -- function num : 0_26
  return self.curActId
end

AvgController.GetCurChapterName = function(self)
  -- function num : 0_27
  return self.chapterName
end

AvgController.JumpChapter = function(self, chapterName)
  -- function num : 0_28
  self:ClearCurAvg()
  self:ShowAvg(chapterName, self.completeFunc, self.__shieldControlSwitch, self.__ignoreTimeScale)
end

AvgController.AvgIgnoreTimeScale = function(self)
  -- function num : 0_29
  return self.__ignoreTimeScale
end

AvgController.SkipAvg = function(self)
  -- function num : 0_30
  local skip2EndActId = ((self.avgCfg)[1]).skip2EndActId
  if skip2EndActId ~= nil and (self.avgCfg)[skip2EndActId] ~= nil and ((self.avgCfg)[skip2EndActId]).isEnd == true and self.curActId ~= skip2EndActId then
    self:PlayAvgAct(skip2EndActId)
    return 
  end
  self:CompleteAllAvg()
end

AvgController.CompleteAllAvg = function(self, hasError)
  -- function num : 0_31 , upvalues : _ENV
  self._hasError = hasError
  if self._reqCompleteAllAvg then
    return 
  end
  self._reqCompleteAllAvg = true
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

AvgController.__CallAvgCompleteFunc = function(self)
  -- function num : 0_32
  if self.completeFunc ~= nil then
    (self.completeFunc)()
    self.completeFunc = nil
  end
end

AvgController.OnAvgComplete = function(self, objList)
  -- function num : 0_33 , upvalues : _ENV
  local hasReward = false
  if objList ~= nil and objList.Count > 0 and self.avgCachePlayParam ~= nil then
    local ok = objList[0]
    if ok then
      local avgCfg = (ConfigData.story_avg)[(self.avgCachePlayParam).avgId]
      do
        if #avgCfg.rewardIds > 0 then
          hasReward = true
          UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_33_0 , upvalues : self, avgCfg
    if window == nil then
      self:__CallAvgCompleteFunc()
      return 
    end
    window:InitRewardsItem(avgCfg.rewardIds, avgCfg.rewardNums, self._heroIdSnapShoot)
    window:BindCommonRewardExit(function()
      -- function num : 0_33_0_0 , upvalues : self
      self:__CallAvgCompleteFunc()
    end
)
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
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (Time.unity_time).timeScale = self.__originTimeScale
    AudioManager:RemoveBgmSourceFader()
    AudioManager:ResumeLastBgm()
    AudioManager:RemoveAllVoice(true)
    if self.avgCachePlayParam == nil then
      self:Delete()
    end
    if not hasReward then
      self:__CallAvgCompleteFunc()
    end
  end
end

AvgController.ClearCurAvg = function(self)
  -- function num : 0_34 , upvalues : _ENV
  local avgWindow = UIManager:GetWindow(UIWindowTypeID.Avg)
  if avgWindow ~= nil then
    avgWindow:CloseUIAVGSystem()
  end
  self:ClearDelayPlatNextTimer()
  self:UnloadAvgCfg()
end

AvgController.RecordAvgAudioSheet = function(self, sheetName)
  -- function num : 0_35 , upvalues : _ENV
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

AvgController.AvgLogError = function(self, msg)
  -- function num : 0_36 , upvalues : _ENV
  msg = msg .. (string.format)("\n Avg chapterName:%s, actId:%s", self.chapterName, self.curActId)
  error(msg)
  if not isGameDev then
    self:CompleteAllAvg(true)
  end
end

AvgController._RemoveCueSheet = function(self)
  -- function num : 0_37 , upvalues : _ENV
  if self._waitRemoveSheet == nil then
    return 
  end
  for sheetName,v in pairs(self._waitRemoveSheet) do
    AudioManager:RemoveCueSheet(sheetName)
  end
  self._waitRemoveSheet = nil
end

AvgController.OnDelete = function(self)
  -- function num : 0_38 , upvalues : _ENV, base
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


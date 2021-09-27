local UIBattlePause = class("UIBattlePause", UIBaseWindow)
local base = UIBaseWindow
local SectorEnum = require("Game.Sector.SectorEnum")
UIBattlePause.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_GiveUp, self, self.__OnClickGiveUp)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Reload, self, self.__OnClickRestart)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GoOn, self, self.__OnClickContinue)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Setting, self, self.__OnClickSetting)
  local isUnlockBattleExit = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BattleExit)
  if not isUnlockBattleExit then
    (((self.ui).btn_GiveUp).gameObject):SetActive(false)
  end
end

UIBattlePause.InitBattlePause = function(self, giveUpBattleFunc, restartFunc, pauseFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.giveUpBattleFunc = giveUpBattleFunc
  self.restartFunc = restartFunc
  self.pauseFunc = pauseFunc
  local isInExploration = ExplorationManager:IsInExploration()
  self.__hasRestartLimit = not isInExploration or ExplorationManager:GetEpModuleId() ~= proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge
  ;
  ((self.ui).obj_levelInfo):SetActive(isInExploration)
  ;
  (((self.ui).tex_RestartCount).gameObject):SetActive(self.__hasRestartLimit)
  local sectorStageCfg = ExplorationManager:GetSectorStageCfg()
  if sectorStageCfg ~= nil then
    if sectorStageCfg.endlessCfg ~= nil then
      ((self.ui).tex_LevelCount):SetIndex(1, tostring((sectorStageCfg.endlessCfg).index * 10))
    elseif sectorStageCfg.challengeCfg ~= nil then
      ((self.ui).tex_LevelCount):SetIndex(2)
    else
      local sectorId = ConfigData:GetSectorIdShow(sectorStageCfg.sector)
      ;
      ((self.ui).tex_LevelCount):SetIndex(0, tostring(sectorId) .. "-" .. tostring(sectorStageCfg.num))
    end
    -- DECOMPILER ERROR at PC80: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_LevelName).text = (LanguageUtil.GetLocaleText)(sectorStageCfg.name)
    if self.__hasRestartLimit then
      self.__battleCountLimit = ((ExplorationManager.epCtrl).battleCtrl):GetEpBattleLastCount()
      ;
      ((self.ui).tex_RestartCount):SetIndex(0, tostring(self.__battleCountLimit))
      -- DECOMPILER ERROR at PC103: Confused about usage of register: R6 in 'UnsetPending'

      if self.__battleCountLimit <= 0 then
        ((self.ui).cs_Restart).alpha = 0.4
      else
        -- DECOMPILER ERROR at PC107: Confused about usage of register: R6 in 'UnsetPending'

        ((self.ui).cs_Restart).alpha = 1
      end
    end
    if (ExplorationManager.epCtrl):IsCompleteExploration() then
      ((self.ui).tex_GiveupDes):SetIndex(1)
    else
      ((self.ui).tex_GiveupDes):SetIndex(0)
    end
  end
  if isInExploration and ((ExplorationManager.epCtrl).battleCtrl):IsCloseReloadSupport() then
    self:SetAboutBattleUIActive(false)
  else
    self:SetAboutBattleUIActive(true)
  end
  ;
  (self.transform):SetAsLastSibling()
  if BattleDungeonManager:InBattleDungeon() then
    local isInDungeonAuto = (BattleDungeonManager.autoCtrl):IsEnbaleDungeonAutoMode()
  end
  ;
  (((self.ui).tex_GiveupAutoDes).gameObject):SetActive(isInDungeonAuto)
  -- DECOMPILER ERROR: 12 unprocessed JMP targets
end

UIBattlePause.__OnClickGiveUp = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.giveUpBattleFunc ~= nil then
    (self.giveUpBattleFunc)()
  end
  AudioManager:PlayAudioById(1082)
end

UIBattlePause.__OnClickRestart = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.__hasRestartLimit and self.__battleCountLimit <= 0 then
    ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(171))
    return 
  end
  AudioManager:StopSource(eAudioSourceType.VoiceSource)
  AudioManager:PlayAudioById(1084)
  if self.restartFunc ~= nil then
    (self.restartFunc)()
    self:Hide()
  end
  UIManager:DeleteWindow(UIWindowTypeID.BattleCrazyMode)
  UIManager:DeleteWindow(UIWindowTypeID.RichIntro)
  local win = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if win ~= nil then
    win:StopUseChipEffect()
  end
end

UIBattlePause.__OnClickContinue = function(self)
  -- function num : 0_4 , upvalues : _ENV
  AudioManager:PlayAudioById(1083)
  if self.pauseFunc ~= nil then
    (self.pauseFunc)(false)
  end
  self:Hide()
  local win = UIManager:GetWindow(UIWindowTypeID.BattleCrazyMode)
  if win ~= nil then
    win:OnBattleContinue()
  end
end

UIBattlePause.__OnClickSetting = function(self)
  -- function num : 0_5 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.Setting, function(win)
    -- function num : 0_5_0 , upvalues : _ENV
    if win ~= nil then
      win:InitSettingByFrom(UIWindowTypeID.BattlePause)
    end
  end
)
end

UIBattlePause.SetAboutBattleUIActive = function(self, active)
  -- function num : 0_6
  (((self.ui).btn_Reload).gameObject):SetActive(active)
  ;
  (((self.ui).tex_RestartCount).gameObject):SetActive(not self.__hasRestartLimit or active)
end

UIBattlePause.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnDelete)(self)
end

return UIBattlePause


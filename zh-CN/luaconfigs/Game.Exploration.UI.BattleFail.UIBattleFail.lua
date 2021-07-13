-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBattleFail = class("UIBattleFail", UIBaseWindow)
local base = UIBaseWindow
UIBattleFail.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_GiveUp, self, self.__OnClickGiveUp)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Reload, self, self.__OnClickRestart)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Statistic, self, self.__ShowBattleStatistic)
  local isUnlockBattleExit = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BattleFailExit)
  if not isUnlockBattleExit then
    (((self.ui).btn_GiveUp).gameObject):SetActive(false)
  end
  ;
  ((self.ui).tex_Fail):SetIndex(0)
end

UIBattleFail.InitBattleFail = function(self, giveUpBattleFunc, restartFunc, statisticFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.giveUpBattleFunc = giveUpBattleFunc
  self.restartFunc = restartFunc
  self.statisticFunc = statisticFunc
  local isInExploration = ExplorationManager:IsInExploration()
  self.__hasRestartLimit = not isInExploration or ExplorationManager:GetEpModuleId() ~= proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge
  ;
  ((self.ui).obj_levelInfo):SetActive(isInExploration)
  local sectorStageCfg = ExplorationManager:GetSectorStageCfg()
  do
    if sectorStageCfg ~= nil then
      local roomData = ((ExplorationManager.epCtrl).playerCtrl):GetCurrentRoomData()
      if roomData ~= nil then
        local roomType = roomData.type
        local roomTypeCfg = (ConfigData.exploration_roomtype)[roomType]
        -- DECOMPILER ERROR at PC45: Confused about usage of register: R9 in 'UnsetPending'

        ;
        ((self.ui).tex_LevelCount).text = (LanguageUtil.GetLocaleText)(roomTypeCfg.title)
        if (ExplorationManager.epCtrl):IsCompleteExploration() then
          ((self.ui).tex_Fail):SetIndex(0)
        else
          ((self.ui).tex_Fail):SetIndex(1)
        end
      else
        (((self.ui).tex_LevelCount).gameObject):SetActive(false)
      end
      ;
      (((self.ui).tex_RestartCount).gameObject):SetActive(self.__hasRestartLimit)
      if self.__hasRestartLimit then
        self.__battleCountLimit = ((ExplorationManager.epCtrl).battleCtrl):GetEpBattleLastCount()
        ;
        ((self.ui).tex_RestartCount):SetIndex(0, tostring(self.__battleCountLimit))
        -- DECOMPILER ERROR at PC98: Confused about usage of register: R7 in 'UnsetPending'

        if self.__battleCountLimit <= 0 then
          ((self.ui).cs_Restart).alpha = 0.4
        else
          -- DECOMPILER ERROR at PC102: Confused about usage of register: R7 in 'UnsetPending'

          ((self.ui).cs_Restart).alpha = 1
        end
      end
    end
    -- DECOMPILER ERROR: 7 unprocessed JMP targets
  end
end

UIBattleFail.__OnClickGiveUp = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.giveUpBattleFunc ~= nil then
    (self.giveUpBattleFunc)()
  end
  AudioManager:PlayAudioById(1082)
  self:Delete()
end

UIBattleFail.__OnClickRestart = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.__hasRestartLimit and self.__battleCountLimit <= 0 then
    ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(171))
    return 
  end
  AudioManager:PlayAudioById(1084)
  if self.restartFunc ~= nil then
    (self.restartFunc)()
    self:Hide()
  end
  UIManager:DeleteWindow(UIWindowTypeID.BattleCrazyMode)
  UIManager:DeleteWindow(UIWindowTypeID.RichIntro)
end

UIBattleFail.__ShowBattleStatistic = function(self)
  -- function num : 0_4
  if self.statisticFunc ~= nil then
    (self.statisticFunc)()
  end
end

UIBattleFail.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UIBattleFail


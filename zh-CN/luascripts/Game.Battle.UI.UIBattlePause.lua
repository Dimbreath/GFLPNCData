-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBattlePause = class("UIBattlePause", UIBaseWindow)
local base = UIBaseWindow
UIBattlePause.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_GiveUp, self, self.__OnClickGiveUp)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Reload, self, self.__OnClickRestart)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GoOn, self, self.__OnClickContinue)
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
  ;
  ((self.ui).obj_levelInfo):SetActive(isInExploration)
  if isInExploration then
    local sectorStageCfg = ExplorationManager:GetSectorStageCfg()
    if sectorStageCfg ~= nil then
      if sectorStageCfg.endlessCfg ~= nil then
        ((self.ui).tex_LevelCount):SetIndex(1, tostring((sectorStageCfg.endlessCfg).index * 10))
      else
        if sectorStageCfg.challengeCfg ~= nil then
          ((self.ui).tex_LevelCount):SetIndex(2)
        else
          ;
          ((self.ui).tex_LevelCount):SetIndex(0, tostring(sectorStageCfg.sector) .. "-" .. tostring(sectorStageCfg.num))
        end
      end
      -- DECOMPILER ERROR at PC60: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).tex_LevelName).text = (LanguageUtil.GetLocaleText)(sectorStageCfg.name)
    end
  end
end

UIBattlePause.__OnClickGiveUp = function(self)
  -- function num : 0_2
  if self.giveUpBattleFunc ~= nil then
    (self.giveUpBattleFunc)()
  end
end

UIBattlePause.__OnClickRestart = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.restartFunc ~= nil then
    (self.restartFunc)()
    self:Hide()
  end
  UIManager:DeleteWindow(UIWindowTypeID.BattleCrazyMode)
end

UIBattlePause.__OnClickContinue = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self.pauseFunc ~= nil then
    (self.pauseFunc)(false)
    self:Hide()
  end
  local win = UIManager:GetWindow(UIWindowTypeID.BattleCrazyMode)
  if win ~= nil then
    win:OnBattleContinue()
  end
end

UIBattlePause.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UIBattlePause


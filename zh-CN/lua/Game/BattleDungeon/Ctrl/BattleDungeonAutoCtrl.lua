local BattleDungeonAutoCtrl = class("BattleDungeonAutoCtrl")
local cs_MessageCommon = CS.MessageCommon
BattleDungeonAutoCtrl.ctor = function(self, dungeonCtrl)
  -- function num : 0_0 , upvalues : _ENV
  self.dungeonCtrl = dungeonCtrl
  self._enableDungeonAuto = false
  self._totalCount = 0
  self._remainCount = 0
  self.__OnEnterBattleDeploy = BindCallback(self, self.OnEnterBattleDeploy)
  self.__BreakAuto = BindCallback(self, self.BreakAuto)
  self._curBreakOpeation = nil
end

BattleDungeonAutoCtrl.IsEnbaleDungeonAutoMode = function(self)
  -- function num : 0_1
  return self._enableDungeonAuto
end

BattleDungeonAutoCtrl.GetRemainDungeonAutoCount = function(self)
  -- function num : 0_2
  if self._enableDungeonAuto then
    return self._remainCount
  end
  return 0
end

BattleDungeonAutoCtrl.GetTotalDungeonAutoCount = function(self)
  -- function num : 0_3
  if self._enableDungeonAuto then
    return self._totalCount
  end
  return 0
end

BattleDungeonAutoCtrl.EnterDungeonAutoModel = function(self, count)
  -- function num : 0_4 , upvalues : _ENV
  if count <= 1 then
    return 
  end
  self._enableDungeonAuto = true
  self._totalCount = count
  self._remainCount = count
  self._isBreaking = false
  self._curBreakOpeation = nil
  MsgCenter:AddListener(eMsgEventId.OnBattleReady, self.__OnEnterBattleDeploy)
end

BattleDungeonAutoCtrl.RecordAndCheckAutoState = function(self)
  -- function num : 0_5
  if not self._enableDungeonAuto or self._remainCount <= 0 then
    return false, false
  end
  self._remainCount = self._remainCount - 1
  do return true, self._remainCount <= 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BattleDungeonAutoCtrl.ExitDungeonAutoModel = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if not self._enableDungeonAuto then
    return 
  end
  self._enableDungeonAuto = false
  UIManager:DeleteWindow(UIWindowTypeID.EpAutoMode)
  TimerManager:StopTimer(self.__autoWaitTimerId)
  self.__autoWaitTimerId = nil
  self._isBreaking = false
  self._curBreakOpeation = nil
  MsgCenter:RemoveListener(eMsgEventId.OnBattleReady, self.__OnEnterBattleDeploy)
end

BattleDungeonAutoCtrl.BreakAuto = function(self)
  -- function num : 0_7 , upvalues : cs_MessageCommon, _ENV
  self:AutoBreak(true)
  ;
  (cs_MessageCommon.ShowMessageBox)(ConfigData:GetTipContent(8102), function()
    -- function num : 0_7_0 , upvalues : self, _ENV
    self:ExitDungeonAutoModel()
    ;
    ((BattleDungeonManager.dungeonCtrl).battleCtrl):ExitBattleDungeon()
  end
, function()
    -- function num : 0_7_1 , upvalues : self
    self:AutoBreak(false)
  end
)
end

BattleDungeonAutoCtrl.AutoBreak = function(self, flag)
  -- function num : 0_8
  if not self._enableDungeonAuto then
    return 
  end
  self._isBreaking = flag
  if not flag and self._curBreakOpeation ~= nil then
    (self._curBreakOpeation)()
    self._curBreakOpeation = nil
  end
end

BattleDungeonAutoCtrl.OnEnterBattleResult = function(self, againAction, finishAction, checkAction)
  -- function num : 0_9 , upvalues : _ENV, cs_MessageCommon
  if not self._enableDungeonAuto then
    return 
  end
  local autoTime = (ConfigData.game_config).dungeonAutoWaitingTime
  local epAutoWindow = UIManager:ShowWindow(UIWindowTypeID.EpAutoMode)
  epAutoWindow:SetAutoMaskClickFunc(self.__BreakAuto)
  epAutoWindow:SetAutoTitleActive(true)
  epAutoWindow:SetAutoOperatorActive(false)
  epAutoWindow:SetAutoTitleState(0)
  epAutoWindow:SetAutoMaskActive(true)
  self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
    -- function num : 0_9_0 , upvalues : autoTime, _ENV, self, epAutoWindow, checkAction, againAction, cs_MessageCommon, finishAction
    autoTime = autoTime - 1
    do
      if autoTime > 0 then
        local resultUI = UIManager:GetWindow(UIWindowTypeID.DungeonResult)
        if resultUI ~= nil then
          resultUI:RefreshAutoCutdown(autoTime)
        end
        return 
      end
      if self._isBreaking then
        return 
      end
      TimerManager:StopTimer(self.__autoWaitTimerId)
      self.__autoWaitTimerId = nil
      epAutoWindow:SetAutoTitleState(0)
      epAutoWindow:SetAutoMaskActive(false)
      local resultExtraUI = UIManager:GetWindow(UIWindowTypeID.BattleResultExtra)
      if resultExtraUI ~= nil then
        resultExtraUI:Delete()
      end
      if self._remainCount > 0 then
        local isCanContinue, tip = checkAction()
        if isCanContinue then
          againAction()
        else
          ;
          (cs_MessageCommon.ShowMessageBox)(tip, function()
      -- function num : 0_9_0_0 , upvalues : againAction
      againAction()
    end
, function()
      -- function num : 0_9_0_1 , upvalues : finishAction
      finishAction()
    end
)
        end
      else
        do
          finishAction()
        end
      end
    end
  end
)
end

BattleDungeonAutoCtrl.OnEnterBattleDeploy = function(self)
  -- function num : 0_10 , upvalues : _ENV
  if not self._enableDungeonAuto then
    return 
  end
  local startFunc = function()
    -- function num : 0_10_0 , upvalues : _ENV
    local battleWindow = UIManager:GetWindow(UIWindowTypeID.Battle)
    if battleWindow ~= nil then
      battleWindow:RealStartBattle()
    end
  end

  if not self._isBreaking then
    startFunc()
  else
    self._curBreakOpeation = startFunc
  end
end

BattleDungeonAutoCtrl.GetBattleCount = function(self)
  -- function num : 0_11
  if self._enableDungeonAuto then
    return self._totalCount - self._remainCount
  end
  return 0
end

return BattleDungeonAutoCtrl


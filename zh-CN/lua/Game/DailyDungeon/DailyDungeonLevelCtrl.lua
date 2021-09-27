local DailyDungeonLevelCtrl = class("ControllerBase", ControllerBase)
local base = ControllerBase
local eDungeonEnum = require("Game.Dungeon.eDungeonEnum")
local JumpManager = require("Game.Jump.JumpManager")
local ShopEnum = require("Game.Shop.ShopEnum")
local CS_GSceneManager_Ins = (CS.GSceneManager).Instance
local cs_MessageCommon = CS.MessageCommon
DailyDungeonLevelCtrl.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._OnDailyDgOutOfDataFunc = BindCallback(self, self._OnDailyDgOutOfData)
  MsgCenter:AddListener(eMsgEventId.DailyDungeonOutOfData, self._OnDailyDgOutOfDataFunc)
end

DailyDungeonLevelCtrl.ShowDailyDungeonMain = function(self, onShowWinFunc, closeFunc, openCurDiff, formBattleWin)
  -- function num : 0_1 , upvalues : _ENV
  self.closeFunc = closeFunc
  UIManager:ShowWindowAsync(UIWindowTypeID.DailyDungeonMain, function(window)
    -- function num : 0_1_0 , upvalues : onShowWinFunc, self, openCurDiff, _ENV, formBattleWin
    if window == nil then
      return 
    end
    if onShowWinFunc ~= nil then
      onShowWinFunc()
    end
    window:InitDailyDungeonMain(self, openCurDiff)
    local dungeonDyncElem = (PlayerDataCenter.dungeonDyncData):GetDailyDungeonDyncData()
    if formBattleWin and dungeonDyncElem:IsDgDyncComplete() then
      UIManager:ShowWindowAsync(UIWindowTypeID.DailyDungeonComplete, function(win)
      -- function num : 0_1_0_0 , upvalues : dungeonDyncElem
      if win == nil then
        return 
      end
      local name = dungeonDyncElem:GetDgDyncElemName()
      win:InitDailyDungeonComplete(name)
    end
)
    end
  end
)
  self:UpdDailyDgRemainTime()
end

DailyDungeonLevelCtrl.UpdDailyDgRemainTime = function(self)
  -- function num : 0_2 , upvalues : _ENV, eDungeonEnum
  local counterElem = (ControllerManager:GetController(ControllerTypeId.TimePass)):getCounterElemData(proto_object_CounterModule.CounterModuleRefreshableDungeon, (eDungeonEnum.eMatDungeonGroup).DailyDungeon)
  if counterElem ~= nil then
    self.netxRefreshTimeStamp = counterElem.nextExpiredTm
    self:_SetRemaindTime()
  end
end

DailyDungeonLevelCtrl.ReqEnterDailyDungeon = function(self, stageId)
  -- function num : 0_3 , upvalues : _ENV
  BattleDungeonManager:InjectBattleExitEvent(BindCallback(self, self._ExitBattleFunc))
  local lastFmtId = (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):GetLastDailyFormationId()
  local formationData = (PlayerDataCenter.formationDic)[lastFmtId]
  if formationData == nil then
    formationData = PlayerDataCenter:CreateFormation(lastFmtId)
  end
  BattleDungeonManager:SaveFormation(formationData)
  BattleDungeonManager:RequestEnterDungeon(stageId, formationData, nil, nil, function()
    -- function num : 0_3_0 , upvalues : self, _ENV
    self:Delete()
    ControllerManager:DeleteController(ControllerTypeId.SectorController)
  end
)
end

DailyDungeonLevelCtrl._ExitBattleFunc = function(self, isBatlleWin)
  -- function num : 0_4 , upvalues : _ENV, CS_GSceneManager_Ins
  ControllerManager:DeleteController(ControllerTypeId.Formation)
  local loadMatUIFunc = function()
    -- function num : 0_4_0 , upvalues : _ENV, isBatlleWin
    (UIUtil.CloseOneCover)("loadMatUIFunc")
    local dailyDgCtrl = ControllerManager:GetController(ControllerTypeId.DailyDungeonLevelCtrl, true)
    dailyDgCtrl:ShowDailyDungeonMain(nil, function(tohome)
      -- function num : 0_4_0_0 , upvalues : _ENV
      local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController, true)
      sectorCtrl:ResetToNormalState(tohome)
    end
, true, isBatlleWin)
  end

  ;
  (UIManager:GetWindow(UIWindowTypeID.Loading)):SetLoadingTipsSystemId(2)
  CS_GSceneManager_Ins:LoadSceneAsyncByAB((Consts.SceneName).Sector, function()
    -- function num : 0_4_1 , upvalues : _ENV, loadMatUIFunc
    local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController, true)
    ;
    (UIUtil.AddOneCover)("loadMatUIFunc")
    sectorCtrl:SetFrom(AreaConst.DungeonBattle, loadMatUIFunc)
    sectorCtrl:OnEnterDailyDungeon()
  end
)
end

DailyDungeonLevelCtrl._OnDailyDgOutOfData = function(self)
  -- function num : 0_5 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.DailyDungeonMain, function(window)
    -- function num : 0_5_0 , upvalues : self, _ENV
    if window == nil then
      return 
    end
    window:InitDailyDungeonMain(self)
    if (UIUtil.CheckIsHaveSpecialMarker)(UIWindowTypeID.DailyDungeonMain) then
      (UIUtil.ReturnUntil2Marker)(UIWindowTypeID.DailyDungeonMain)
    end
  end
)
  self:UpdDailyDgRemainTime()
end

DailyDungeonLevelCtrl._SetRemaindTime = function(self)
  -- function num : 0_6 , upvalues : _ENV
  self:_ClearRemainTimer()
  if self.netxRefreshTimeStamp == nil or self.netxRefreshTimeStamp <= PlayerDataCenter.timestamp then
    return 
  end
  self:_RefreshRemaindTime()
  self.remainTimerId = TimerManager:StartTimer(1, self._RefreshRemaindTime, self, false, false, false)
end

DailyDungeonLevelCtrl._RefreshRemaindTime = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local remaindTime = (math.max)((math.floor)(self.netxRefreshTimeStamp - PlayerDataCenter.timestamp), 0)
  local d, h, m, s = TimestampToTimeInter(remaindTime, false, true)
  if h < 10 or not tostring(h) then
    local hStr = "0" .. tostring(h)
  end
  if m < 10 or not tostring(m) then
    local mStr = "0" .. tostring(m)
  end
  if s < 10 or not tostring(s) then
    local sStr = "0" .. tostring(s)
  end
  if remaindTime <= 0 then
    self:_ClearRemainTimer()
  end
  local mainWin = UIManager:GetWindow(UIWindowTypeID.DailyDungeonMain)
  if mainWin ~= nil then
    mainWin:UpdDailyDgMainTime(d, hStr, mStr, sStr)
  end
  local levelWin = UIManager:GetWindow(UIWindowTypeID.DailyDungeonLevel)
  if levelWin ~= nil then
    levelWin:UpdDailyDgLevelTime(d, hStr, mStr, sStr)
  end
end

DailyDungeonLevelCtrl._ClearRemainTimer = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self.remainTimerId ~= nil then
    TimerManager:StopTimer(self.remainTimerId)
    self.remainTimerId = nil
  end
end

DailyDungeonLevelCtrl.ExitDailyDungeon = function(self, toHome)
  -- function num : 0_9
  if self.closeFunc ~= nil then
    (self.closeFunc)(toHome)
  end
  self:Delete()
end

DailyDungeonLevelCtrl.OpenDailyDungeonShop = function(self)
  -- function num : 0_10 , upvalues : JumpManager, ShopEnum
  JumpManager:DirectShowShop(nil, nil, (ShopEnum.ShopId).DailyDungeonShop)
end

DailyDungeonLevelCtrl.OnDelete = function(self)
  -- function num : 0_11 , upvalues : _ENV, base
  self:_ClearRemainTimer()
  UIManager:DeleteWindow(UIWindowTypeID.DailyDungeonMain)
  MsgCenter:RemoveListener(eMsgEventId.DailyDungeonOutOfData, self._OnDailyDgOutOfDataFunc)
  ;
  (base.OnDelete)(self)
end

return DailyDungeonLevelCtrl


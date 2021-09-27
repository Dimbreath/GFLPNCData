local LoginController = class("LoginController", ControllerBase)
local util = require("XLua.Common.xlua_util")
LoginController.OnInit = function(self)
  -- function num : 0_0
end

LoginController.FirstGameStart = function(self, loadComplete)
  -- function num : 0_1 , upvalues : _ENV
  ((CS.GSceneManager).Instance):LoadScene((Consts.SceneName).Empty)
  UIManager:ShowWindowAsync(UIWindowTypeID.Login, function(window)
    -- function num : 0_1_0 , upvalues : loadComplete
    if loadComplete ~= nil then
      loadComplete()
    end
  end
)
end

LoginController.OnLoginUserDataComplete = function(self, noShowLoading)
  -- function num : 0_2 , upvalues : _ENV, util
  local skipGuide, onlyFirst = (GR.SkipGameGuide)()
  if skipGuide then
    GuideManager:SetGMSkipGuide(not onlyFirst)
    self.noShowLoading = noShowLoading or false
    if (GuideManager.firstBattleGuideCtrl):TryStartFirstBattleGuide() then
      return 
    end
    ;
    (GR.StartCoroutine)((util.cs_generator)(BindCallback(self, self.__BeforeLoadingHome)))
  end
end

LoginController.__BeforeLoadingHome = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local needShowSettingWin = false
  local avgTaskList = {}
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay, true)
  for k,taskData in pairs((PlayerDataCenter.allTaskData).avgTaskDatas) do
    if taskData.id == (ConfigData.buildinConfig).FirstGuideTaskId then
      needShowSettingWin = true
    end
    local avgId = (taskData.stcData).story
    local avgCfg = (ConfigData.story_avg)[avgId]
    do
      if avgCfg == nil then
        error("Can\'t find avgCfg, avgId = " .. tostring(avgId))
      else
        if not avgPlayCtrl:IsAvgPlayed(avgId) and avgPlayCtrl:IsAvgUnlock(avgId) then
          do
            (table.insert)(avgTaskList, taskData)
            -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  if needShowSettingWin then
    self:_SettingGraph()
    self:_SettingDescribe()
  end
  if #avgTaskList > 0 then
    (table.sort)(avgTaskList, function(a, b)
    -- function num : 0_3_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    UIManager:ShowWindowAsync(UIWindowTypeID.Avg, nil)
    local window = UIManager:GetWindow(UIWindowTypeID.Avg)
    while window == nil do
      (coroutine.yield)(nil)
      window = UIManager:GetWindow(UIWindowTypeID.Avg)
    end
    UIManager:DeleteWindow(UIWindowTypeID.Login)
    for k,taskData in ipairs(avgTaskList) do
      local story2guide_condition = (taskData.stcData).story2guide_condition
      local avgCfg = (ConfigData.story_avg)[(taskData.stcData).story]
      local avgCompleteFunc = nil
      local isLast = k == #avgTaskList
      avgCompleteFunc = function()
    -- function num : 0_3_1 , upvalues : isLast, _ENV, self, story2guide_condition
    if isLast and not (GuideManager.firstBattleGuideCtrl).lastbattleGuide then
      self:__LoadingHome()
    end
    if story2guide_condition > 0 then
      GuideManager:TryTriggerGuide(story2guide_condition)
    end
  end

      ;
      (ControllerManager:GetController(ControllerTypeId.Avg, true)):StartAvg(avgCfg.script_id, avgCfg.id, avgCompleteFunc)
    end
  else
    self:__LoadingHome()
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

LoginController.__LoadingHome = function(self)
  -- function num : 0_4 , upvalues : _ENV, util
  local firstEnterHome = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_FirstEnterHome)
  if not firstEnterHome then
    self:__NewbeeToSector()
    return 
  end
  local loadingFunc = function()
    -- function num : 0_4_0 , upvalues : _ENV
    local homeCtr = ControllerManager:GetController(ControllerTypeId.HomeController, true)
    homeCtr:OnEnterHome()
    UIManager:ShowWindowAsync(UIWindowTypeID.TopStatus, function(window)
      -- function num : 0_4_0_0
      if window ~= nil then
        window:Hide()
      end
    end
)
    while UIManager:GetWindow(UIWindowTypeID.TopStatus) == nil do
      (coroutine.yield)(nil)
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.Home)
    while UIManager:GetWindow(UIWindowTypeID.Home) == nil do
      (coroutine.yield)(nil)
    end
  end

  local loadedFunc = function()
    -- function num : 0_4_1 , upvalues : _ENV, self
    UIManager:DeleteWindow(UIWindowTypeID.Login)
    self:__EnterUIHome()
  end

  ;
  ((CS.GSceneManager).Instance):LoadSceneAsyncByABEx((Consts.SceneName).Main, true, self.noShowLoading, loadedFunc, (util.cs_generator)(loadingFunc))
  local loginWindow = UIManager:GetWindow(UIWindowTypeID.Login)
  if loginWindow ~= nil then
    loginWindow:ShowLoading()
  end
end

LoginController.__NewbeeToSector = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((CS.GSceneManager).Instance):LoadSceneByAB((Consts.SceneName).Sector, function()
    -- function num : 0_5_0 , upvalues : _ENV
    (ControllerManager:GetController(ControllerTypeId.SectorController, true)):SetFrom(AreaConst.Exploration)
    UIManager:DeleteWindow(UIWindowTypeID.Login)
  end
)
end

LoginController.__EnterUIHome = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.Home)
  window:SetFrom2Home(AreaConst.Sector)
end

LoginController._SettingGraph = function(self)
  -- function num : 0_7 , upvalues : _ENV
  do
    if ((CS.MTPManager).Instance).isSimulator then
      local settingCtrl = ControllerManager:GetController(ControllerTypeId.Setting, true)
      settingCtrl:SetPerformanceLevel(5)
      settingCtrl:ForceSetToCurrentPerformanceLevel()
      PersistentManager:SaveModelData((PersistentConfig.ePackage).SystemData)
      return 
    end
    local setGraphComplete = false
    UIManager:ShowWindowAsync(UIWindowTypeID.SettingGraph, function(window)
    -- function num : 0_7_0 , upvalues : setGraphComplete, _ENV
    window:InitSettingGraph(function()
      -- function num : 0_7_0_0 , upvalues : setGraphComplete
      setGraphComplete = true
    end
)
    UIManager:DeleteWindow(UIWindowTypeID.Login)
  end
)
    while not setGraphComplete do
      (coroutine.yield)()
    end
  end
end

LoginController._SettingDescribe = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local setComplete = false
  UIManager:ShowWindowAsync(UIWindowTypeID.SettingDescribe, function(win)
    -- function num : 0_8_0 , upvalues : setComplete
    if win == nil then
      setComplete = true
      return 
    end
    win:InitSettingDescribe(function()
      -- function num : 0_8_0_0 , upvalues : setComplete
      setComplete = true
    end
)
  end
)
  while not setComplete do
    (coroutine.yield)()
  end
end

LoginController.OnDelete = function(self)
  -- function num : 0_9
end

return LoginController


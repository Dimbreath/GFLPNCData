-- params : ...
-- function num : 0 , upvalues : _ENV
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
  self.noShowLoading = noShowLoading or false
  if (GuideManager.firstBattleGuideCtrl):TryStartFirstBattleGuide() then
    return 
  end
  ;
  (GR.StartCoroutine)((util.cs_generator)(BindCallback(self, self.__BeforeLoadingHome)))
end

LoginController.__BeforeLoadingHome = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local avgTaskList = {}
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay, true)
  for k,taskData in pairs((PlayerDataCenter.allTaskData).avgTaskDatas) do
    local avgId = (taskData.stcData).story
    local avgCfg = (ConfigData.story_avg)[avgId]
    do
      if avgCfg == nil then
        error("Can\'t find avgCfg, avgId = " .. tostring(avgId))
      else
        if not avgPlayCtrl:IsAvgPlayed(avgId) and avgPlayCtrl:IsAvgUnlock(avgId) then
          do
            (table.insert)(avgTaskList, taskData)
            -- DECOMPILER ERROR at PC43: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC43: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC43: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC43: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
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
  local loadingFunc = function()
    -- function num : 0_4_0 , upvalues : _ENV
    local homeCtr = ControllerManager:GetController(ControllerTypeId.HomeController, true)
    UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(window)
      -- function num : 0_4_0_0
    end
)
    local window = UIManager:GetWindow(UIWindowTypeID.Home)
    while window == nil do
      (coroutine.yield)(nil)
      window = UIManager:GetWindow(UIWindowTypeID.Home)
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

LoginController.__EnterUIHome = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.Home)
  window:SetFrom2Home(AreaConst.Sector)
  local homeCtr = ControllerManager:GetController(ControllerTypeId.HomeController)
  if homeCtr ~= nil then
    homeCtr:PlayLoginHeroGreeting()
  end
end

LoginController.OnDelete = function(self)
  -- function num : 0_6
end

return LoginController


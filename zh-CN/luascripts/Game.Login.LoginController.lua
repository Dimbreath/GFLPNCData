-- params : ...
-- function num : 0 , upvalues : _ENV
local LoginController = class("LoginController", ControllerBase)
local util = require("XLua.Common.xlua_util")
LoginController.OnInit = function(self)
  -- function num : 0_0
end

LoginController.FirstGameStart = function(self, loadComplete)
  -- function num : 0_1 , upvalues : _ENV
  (ControllerManager:GetController(ControllerTypeId.Setting, true)):InitSettingData()
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
  if not noShowLoading then
    noShowLoading = false
  end
  if (GuideManager.firstBattleGuideCtrl):TryStartFirstBattleGuide() then
    return 
  end
  local avgTaskList = {}
  local loadingFunc = function()
    -- function num : 0_2_0 , upvalues : _ENV, avgTaskList
    UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(window)
      -- function num : 0_2_0_0
    end
)
    local window = UIManager:GetWindow(UIWindowTypeID.Home)
    while window == nil do
      (coroutine.yield)(nil)
      window = UIManager:GetWindow(UIWindowTypeID.Home)
    end
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay, true)
    for k,taskData in pairs((PlayerDataCenter.allTaskData).avgTaskDatas) do
      local avgId = (taskData.stcData).story
      local avgCfg = (ConfigData.story_avg)[avgId]
      if avgCfg == nil then
        error("Can\'t find avgCfg, avgId = " .. tostring(avgId))
      else
        if not avgPlayCtrl:IsAvgPlayed(avgId) and avgPlayCtrl:IsAvgUnlock(avgId) then
          (table.insert)(avgTaskList, taskData)
        end
      end
    end
    if #avgTaskList > 0 then
      (table.sort)(avgTaskList, function(a, b)
      -- function num : 0_2_0_1
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
    end
  end

  local loadedFunc = function()
    -- function num : 0_2_1 , upvalues : _ENV, avgTaskList, self
    UIManager:DeleteWindow(UIWindowTypeID.Login)
    if #avgTaskList > 0 then
      for k,taskData in ipairs(avgTaskList) do
        local story2guide_condition = (taskData.stcData).story2guide_condition
        do
          local avgCfg = (ConfigData.story_avg)[(taskData.stcData).story]
          local avgCompleteFunc = nil
          local isLast = k == #avgTaskList
          avgCompleteFunc = function()
      -- function num : 0_2_1_0 , upvalues : isLast, self, story2guide_condition, _ENV
      if isLast then
        self:__EnterUIHome()
      end
      if story2guide_condition > 0 then
        GuideManager:TryTriggerGuide(story2guide_condition)
      end
    end

          ;
          (ControllerManager:GetController(ControllerTypeId.Avg, true)):StartAvg(avgCfg.script_id, avgCfg.id, avgCompleteFunc)
        end
      end
    else
      self:__EnterUIHome()
    end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end

  ;
  ((CS.GSceneManager).Instance):LoadSceneAsyncByABEx((Consts.SceneName).Main, true, noShowLoading, loadedFunc, (util.cs_generator)(loadingFunc))
  local loginWindow = UIManager:GetWindow(UIWindowTypeID.Login)
  if loginWindow ~= nil then
    loginWindow:ShowLoading()
  end
end

LoginController.__EnterUIHome = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (UIManager:GetWindow(UIWindowTypeID.Home)):SetFrom(AreaConst.Sector)
end

LoginController.OnDelete = function(self)
  -- function num : 0_4
end

return LoginController

-- params : ...
-- function num : 0 , upvalues : _ENV
local LoginController = class("LoginController", ControllerBase)
local util = require("XLua.Common.xlua_util")
LoginController.OnInit = function(self)
    -- function num : 0_0
end

LoginController.FirstGameStart = function(self, loadComplete)
    -- function num : 0_1 , upvalues : _ENV
    (ControllerManager:GetController(ControllerTypeId.Setting, true)):InitSettingData()
    UIManager:ShowWindowAsync(UIWindowTypeID.Login, function(window)
        -- function num : 0_1_0 , upvalues : loadComplete
        if loadComplete ~= nil then loadComplete() end
    end)
end

LoginController.OnLoginUserDataComplete =
    function(self, noShowLoading)
        -- function num : 0_2 , upvalues : _ENV, util
        if not noShowLoading then noShowLoading = false end
        if (GuideManager.firstBattleGuideCtrl):TryStartFirstBattleGuide() then
            return
        end
        local avgTaskList = {}
        local loadingFunc = function()
            -- function num : 0_2_0 , upvalues : _ENV, avgTaskList
            UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(window)
                -- function num : 0_2_0_0
            end)
            local window = UIManager:GetWindow(UIWindowTypeID.Home)
            while window == nil do
                (coroutine.yield)(nil)
                window = UIManager:GetWindow(UIWindowTypeID.Home)
            end
            local avgPlayCtrl = ControllerManager:GetController(
                                    ControllerTypeId.AvgPlay, true)
            for k, taskData in
                pairs((PlayerDataCenter.allTaskData).avgTaskDatas) do
                local avgId = (taskData.stcData).story
                local avgCfg = (ConfigData.story_avg)[avgId]
                if avgCfg == nil then
                    error("Can\'t find avgCfg, avgId = " .. tostring(avgId))
                else
                    if not avgPlayCtrl:IsAvgPlayed(avgId) and
                        avgPlayCtrl:IsAvgUnlock(avgId) then
                        (table.insert)(avgTaskList, taskData)
                    end
                end
            end
            if #avgTaskList > 0 then
                (table.sort)(avgTaskList, function(a, b)
                    -- function num : 0_2_0_1
                    do return a.id < b.id end
                    -- DECOMPILER ERROR: 1 unprocessed JMP targets
                end)
                UIManager:ShowWindowAsync(UIWindowTypeID.Avg, nil)
                local window = UIManager:GetWindow(UIWindowTypeID.Avg)
                while window == nil do
                    (coroutine.yield)(nil)
                    window = UIManager:GetWindow(UIWindowTypeID.Avg)
                end
            end
        end

        local loadedFunc = function()
            -- function num : 0_2_1 , upvalues : _ENV, avgTaskList, self
            UIManager:DeleteWindow(UIWindowTypeID.Login)
            if #avgTaskList > 0 then
                for k, taskData in ipairs(avgTaskList) do
                    local story2guide_condition =
                        (taskData.stcData).story2guide_condition
                    do
                        local avgCfg =
                            (ConfigData.story_avg)[(taskData.stcData).story]
                        local avgCompleteFunc = nil
                        local isLast = k == #avgTaskList
                        avgCompleteFunc =
                            function()
                                -- function num : 0_2_1_0 , upvalues : isLast, self, story2guide_condition, _ENV
                                if isLast then
                                    self:__EnterUIHome()
                                end
                                if story2guide_condition > 0 then
                                    GuideManager:TryTriggerGuide(
                                        story2guide_condition)
                                end
                            end;
                        (ControllerManager:GetController(ControllerTypeId.Avg,
                                                         true)):StartAvg(
                            avgCfg.script_id, avgCfg.id, avgCompleteFunc)
                    end
                end
            else
                self:__EnterUIHome()
            end
            -- DECOMPILER ERROR: 4 unprocessed JMP targets
        end;
        ((CS.GSceneManager).Instance):LoadSceneAsyncByABEx(
            (Consts.SceneName).Main, true, noShowLoading, loadedFunc,
            (util.cs_generator)(loadingFunc))
        local loginWindow = UIManager:GetWindow(UIWindowTypeID.Login)
        if loginWindow ~= nil then loginWindow:ShowLoading() end
    end

LoginController.__EnterUIHome = function(self)
    -- function num : 0_3 , upvalues : _ENV
    (UIManager:GetWindow(UIWindowTypeID.Home)):SetFrom(AreaConst.Sector)
end

LoginController.OnDelete = function(self)
    -- function num : 0_4
end

return LoginController


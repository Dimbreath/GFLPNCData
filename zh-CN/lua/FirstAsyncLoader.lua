local FirstAsyncLoader = {}
local xlua_util = require("Xlua.Common.xlua_util")
FirstAsyncLoader.LoadFunc = function()
  -- function num : 0_0 , upvalues : _ENV
  local cs_DownloadWindow = (CS.UI_Downloading).Instance
  require("Consts.Consts")
  CRH = require("Game.Res.CommonResHelper")
  CRH:Init()
  CRH:LoadCommonAtlas(cs_DownloadWindow, 0.1)
  CRH:LoadBaseItemFx()
  ;
  (coroutine.yield)()
  local progress = 0.21
  cs_DownloadWindow:UpdateProgress(progress)
  local ConfigDataLoader = require("Game.ConfigData.ConfigDataLoader")
  local configNameList = (ConfigDataLoader.GetConfigNameList)()
  local configDataCount = #configNameList
  local OneConfigProgress = 0.7 / configDataCount
  local frameLoadConfigCount = 15
  local loadedConfigCount = 0
  for _,tdata in pairs(configNameList) do
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R13 in 'UnsetPending'

    ConfigData[tdata[1]] = require(ConfigDataLoader.LoadConfigHead .. tdata[2])
    loadedConfigCount = loadedConfigCount + 1
    if frameLoadConfigCount <= loadedConfigCount then
      loadedConfigCount = 0
      ;
      (coroutine.yield)()
      progress = (math.min)(1, progress + OneConfigProgress * frameLoadConfigCount)
      cs_DownloadWindow:UpdateProgress(progress)
    end
  end
  ;
  (ConfigDataLoader.AfterLoadConfigComplete)()
  -- DECOMPILER ERROR at PC72: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (package.loaded)["Game.ConfigData.ConfigDataLoader"] = nil
  ;
  (coroutine.yield)()
  progress = (math.min)(1, progress + 0.01)
  cs_DownloadWindow:UpdateProgress(progress)
  require("Global")
  ;
  (coroutine.yield)()
  progress = (math.min)(1, progress + 0.02)
  cs_DownloadWindow:UpdateProgress(progress)
  require("Game.GlobalConfig.UIGlobalConfig")
  ;
  (coroutine.yield)()
  progress = (math.min)(1, progress + 0.02)
  cs_DownloadWindow:UpdateProgress(progress)
  require("Game.GlobalConfig.NetworkGlobalConfig")
  ;
  (coroutine.yield)()
  progress = (math.min)(1, progress + 0.01)
  cs_DownloadWindow:UpdateProgress(progress)
  require("Game.GlobalConfig.ControllerGlobalConfig")
  ;
  (coroutine.yield)()
  progress = (math.min)(1, progress + 0.01)
  cs_DownloadWindow:UpdateProgress(progress)
  PersistentManager:InitManager()
  ;
  (coroutine.yield)()
  progress = (math.min)(1, progress + 0.02)
  cs_DownloadWindow:UpdateProgress(progress)
  NotifyOfflineManager:InitManager()
  ;
  (GameSystemInfo.InitDefaultPerformance)()
  ;
  (ControllerManager:GetController(ControllerTypeId.Setting, true)):InitSettingData()
  ;
  (coroutine.yield)()
  progress = (math.min)(1, progress + 0.01)
  cs_DownloadWindow:UpdateProgress(progress)
  UIManager:ShowWindowAsync(UIWindowTypeID.Loading, function(window)
    -- function num : 0_0_0
    if window ~= nil then
      window:Hide()
    end
  end
)
  while UIManager:GetWindow(UIWindowTypeID.Loading) == nil do
    (coroutine.yield)(nil)
  end
  ;
  (coroutine.yield)()
  progress = 1
  cs_DownloadWindow:UpdateProgress(progress)
  print("first load complete,start game...")
  TimerManager:Start()
  UpdateManager:Start()
  NetworkManager:InitNetwork()
  ;
  (ControllerManager:GetController(ControllerTypeId.Login, true)):FirstGameStart(function()
    -- function num : 0_0_1 , upvalues : cs_DownloadWindow, _ENV
    cs_DownloadWindow:Dispose()
    cs_DownloadWindow = nil
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (package.loaded).FirstAsyncLoader = nil
  end
)
end

FirstAsyncLoader.StartFirstLoad = function()
  -- function num : 0_1 , upvalues : _ENV, xlua_util, FirstAsyncLoader
  ((CS.GlobalRegister).StartCoroutine)((xlua_util.cs_generator)(FirstAsyncLoader.LoadFunc))
end

return FirstAsyncLoader


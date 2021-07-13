-- params : ...
-- function num : 0 , upvalues : _ENV
local NotifyOfflineEnum = require("Game.NotifyOffline.NotifyOfflineEnum")
local NotifyOfflineFunc = require("Game.NotifyOffline.NotifyOfflineFunc")
local NotifyOfflineManager = {}
local cs_NotifyOfflineCenter = (CS.NotifyOffline).NotifyOfflineCenter
NotifyOfflineManager.InitManager = function(self)
  -- function num : 0_0 , upvalues : _ENV
  ((CS.MonoDriver).Instance):onApplicationPause("+", BindCallback(self, self.__ApplicatonPause))
end

NotifyOfflineManager.__AddNotifyOfflineByDelaySec = function(self, delaySec, isRepeatDay, cfgTable)
  -- function num : 0_1 , upvalues : _ENV, cs_NotifyOfflineCenter
  local id = cfgTable.id
  local title = (LanguageUtil.GetLocaleText)(cfgTable.title)
  local context = (LanguageUtil.GetLocaleText)(cfgTable.context)
  ;
  (cs_NotifyOfflineCenter.AddNotify)(id, delaySec, isRepeatDay, title, context)
end

NotifyOfflineManager.__ApplicatonPause = function(self, flag)
  -- function num : 0_2 , upvalues : _ENV, NotifyOfflineFunc, cs_NotifyOfflineCenter
  -- DECOMPILER ERROR at PC13: Unhandled construct in 'MakeBoolean' P1

  if flag and PlayerDataCenter ~= nil and PlayerDataCenter.isOnline then
    local func = BindCallback(self, self.__AddNotifyOfflineByDelaySec)
    for k,v in pairs(ConfigData.offline_push) do
      (NotifyOfflineFunc[v.type])(v, func)
    end
  end
  do
    ;
    (cs_NotifyOfflineCenter.ClearNotify)()
  end
end

return NotifyOfflineManager


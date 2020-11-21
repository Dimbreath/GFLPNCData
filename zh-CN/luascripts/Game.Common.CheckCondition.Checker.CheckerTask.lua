-- params : ...
-- function num : 0 , upvalues : _ENV
local CheckerTask = {}
CheckerTask.LengthCheck = function(param)
    -- function num : 0_0
    if #param >= 2 then return true end
    return false
end

CheckerTask.ParamsCheck = function(param)
    -- function num : 0_1 , upvalues : _ENV
    return (PlayerDataCenter.allTaskData):IsMainTaskComplete(param[2])
end

CheckerTask.GetUnlockInfo = function(param)
    -- function num : 0_2 , upvalues : _ENV
    local taskId = param[2]
    local taskCfg = (ConfigData.task)[taskId]
    if taskCfg ~= nil then
        return (string.format)("完成（%s）任务后解锁",
                               (LanguageUtil.GetLocaleText)(taskCfg.name))
    end
    return ""
end

return CheckerTask


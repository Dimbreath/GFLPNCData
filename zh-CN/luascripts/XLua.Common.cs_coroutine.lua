-- params : ...
-- function num : 0 , upvalues : _ENV
local util = require("XLua.Common.util")
local gameobject = ((CS.UnityEngine).GameObject)("CoroutineRunner")
;
(((CS.UnityEngine).Object).DontDestroyOnLoad)(gameobject)
local cs_coroutine_runner = gameobject:AddComponent(typeof(CS.CoroutineRunner))
local async_yield_return = function(to_yield, cb)
  -- function num : 0_0 , upvalues : cs_coroutine_runner
  cs_coroutine_runner:YieldAndCallback(to_yield, cb)
end

return {yield_return = (util.async_to_sync)(async_yield_return), start = function(...)
  -- function num : 0_1 , upvalues : cs_coroutine_runner, util
  return cs_coroutine_runner:StartCoroutine((util.cs_generator)(...))
end
, stop = function(coroutine)
  -- function num : 0_2 , upvalues : cs_coroutine_runner
  cs_coroutine_runner:StopCoroutine(coroutine)
end
, stopall = function()
  -- function num : 0_3 , upvalues : cs_coroutine_runner
  cs_coroutine_runner:StopAllCoroutines()
end
}


local HotfixCubismInterationController = class("HotfixCubismInterationController", HotfixBase)
local cs_CubismInterationController = (((((CS.Live2D).Cubism).Samples).OriginalWorkflow).Demo).CubismInterationController
local PlayWaitLive2D = function(self)
  -- function num : 0_0 , upvalues : _ENV
  local arrLength = (self._waitAnimationMotions).Length
  if arrLength == 0 then
    return 
  end
  local lastWaitPlayIndex = self.lastWaitPlayIndex
  local motionIndex = (math.random)(1, arrLength) - 1
  if arrLength > 1 and lastWaitPlayIndex == motionIndex and (arrLength > lastWaitPlayIndex + 1 or not 0) then
    motionIndex = lastWaitPlayIndex + 1
  end
  self.lastWaitPlayIndex = motionIndex
  self.__hasPlayed = false
  local _playMotion = (self._waitAnimationMotions)[motionIndex]
  self._playMotion = _playMotion
  local OnAnimationPlayEvent = self["&OnAnimationPlayEvent"]
  if OnAnimationPlayEvent ~= nil then
    OnAnimationPlayEvent("short call", _playMotion.name, _playMotion.length)
  end
end

HotfixCubismInterationController.Register = function(self)
  -- function num : 0_1 , upvalues : cs_CubismInterationController, PlayWaitLive2D
  self:RegisterHotfix(cs_CubismInterationController, "PlayWaitLive2D", PlayWaitLive2D, true)
end

return HotfixCubismInterationController


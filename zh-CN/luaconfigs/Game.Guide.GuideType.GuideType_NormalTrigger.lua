-- params : ...
-- function num : 0 , upvalues : _ENV
local GuideType_Normal = require("Game.Guide.GuideType.GuideType_Normal")
local GuideType_NormalTrigger = class("GuideType_NormalTrigger", GuideType_Normal)
GuideType_NormalTrigger.ctor = function(self)
  -- function num : 0_0
  self.__sendGuideMsg = false
end

GuideType_NormalTrigger.EndGuide = function(self, success)
  -- function num : 0_1 , upvalues : GuideType_Normal
  if self.guideCfg ~= nil and not self.__sendGuideMsg then
    self:__ReqTriggerGuideComplete()
  end
  self.__sendGuideMsg = false
  ;
  (GuideType_Normal.EndGuide)(self, success)
end

GuideType_NormalTrigger.__ReqTriggerGuideComplete = function(self, action)
  -- function num : 0_2 , upvalues : _ENV
  local guideId = (self.guideCfg).id
  ;
  (NetworkManager:GetNetwork(NetworkTypeID.Object)):CS_GUIDE_TriggerComplete(guideId, action)
  GuideManager:AddCompleteTriggerGuide(guideId)
end

GuideType_NormalTrigger.OnStepFinishAction = function(self, stepIndex, action)
  -- function num : 0_3
  if self.guideCfg == nil then
    return 
  end
  if (self.guideCfg).step_finish == stepIndex and (self.guideCfg).step_finish < #(self.guideCfg).step_list then
    self.__sendGuideMsg = true
    self:__ReqTriggerGuideComplete(action)
    return 
  end
  if action ~= nil then
    action()
  end
end

GuideType_NormalTrigger.BreakEndGuide = function(self)
  -- function num : 0_4 , upvalues : GuideType_Normal
  self.__sendGuideMsg = false
  ;
  (GuideType_Normal.EndGuide)(self, false)
end

return GuideType_NormalTrigger


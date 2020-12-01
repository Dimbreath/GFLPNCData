-- params : ...
-- function num : 0 , upvalues : _ENV
local GuideType_Normal = require("Game.Guide.GuideType.GuideType_Normal")
local GuideType_NormalTrigger = class("GuideType_NormalTrigger", GuideType_Normal)
GuideType_NormalTrigger.EndGuide = function(self, success)
  -- function num : 0_0 , upvalues : _ENV, GuideType_Normal
  local guideId = (self.guideCfg).id
  ;
  (NetworkManager:GetNetwork(NetworkTypeID.Object)):CS_GUIDE_TriggerComplete(guideId)
  GuideManager:AddCompleteTriggerGuide(guideId)
  ;
  (GuideType_Normal.EndGuide)(self, success)
end

GuideType_NormalTrigger.BreakEndGuide = function(self)
  -- function num : 0_1 , upvalues : GuideType_Normal
  (GuideType_Normal.EndGuide)(self, false)
end

return GuideType_NormalTrigger

-- params : ...
-- function num : 0 , upvalues : _ENV
local GuideType_Normal = require("Game.Guide.GuideType.GuideType_Normal")
local GuideType_NormalTrigger = class("GuideType_NormalTrigger",
                                      GuideType_Normal)
GuideType_NormalTrigger.EndGuide = function(self, success)
    -- function num : 0_0 , upvalues : _ENV, GuideType_Normal
    local guideId = (self.guideCfg).id;
    (NetworkManager:GetNetwork(NetworkTypeID.Object)):CS_GUIDE_TriggerComplete(
        guideId)
    GuideManager:AddCompleteTriggerGuide(guideId);
    (GuideType_Normal.EndGuide)(self, success)
end

GuideType_NormalTrigger.BreakEndGuide = function(self)
    -- function num : 0_1 , upvalues : GuideType_Normal
    (GuideType_Normal.EndGuide)(self, false)
end

return GuideType_NormalTrigger


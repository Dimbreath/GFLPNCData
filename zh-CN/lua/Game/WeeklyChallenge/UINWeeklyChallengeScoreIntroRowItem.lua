local UINLogicPreviewRowBase = require("Game.CommonUI.LogicPreviewNode.UINLogicPreviewRowBase")
local UINWeeklyChallengeScoreIntroRowItem = class("UINWeeklyChallengeScoreIntroRowItem", UINLogicPreviewRowBase)
local base = UINLogicPreviewRowBase
UINWeeklyChallengeScoreIntroRowItem.InitWeeklyRewardRow = function(self, scoreMin, scoreMax, cfg, showIndexs)
  -- function num : 0_0 , upvalues : _ENV
  (self.attrPool):HideAll()
  local scoreStr = nil
  if scoreMin ~= nil and scoreMax ~= nil then
    scoreStr = tostring(scoreMin) .. "~" .. tostring(scoreMax)
  else
    if scoreMax == nil then
      scoreStr = ">" .. tostring(scoreMin)
    else
      if scoreMin == nil then
        scoreStr = "<" .. tostring(scoreMax)
      end
    end
  end
  local item = (self.attrPool):GetOne(true)
  item:InitAttrItem(scoreStr)
  for _,type_id in ipairs(showIndexs) do
    item = (self.attrPool):GetOne(true)
    item:InitAttrItem(tostring((cfg[type_id]).reward))
  end
end

return UINWeeklyChallengeScoreIntroRowItem


-- params : ...
-- function num : 0 , upvalues : _ENV
local UINActivityStarUpPreItem = class("UINActivityStarUpPreItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
UINActivityStarUpPreItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithReceived
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).rewardItem):SetActive(false)
  self.rewardPool = (UIItemPool.New)(UINBaseItemWithReceived, (self.ui).rewardItem)
end

UINActivityStarUpPreItem.InitItem = function(self, activityInfo, stageId)
  -- function num : 0_1 , upvalues : _ENV
  local stageState = nil
  if stageId < activityInfo.curStageId then
    stageState = 0
  else
    if activityInfo.curStageId < stageId then
      stageState = 1
    else
      stageState = 2
    end
  end
  ;
  ((self.ui).img_stageItem):SetIndex(stageState)
  ;
  ((self.ui).tex_State):SetIndex(stageState)
  ;
  ((self.ui).tex_Stage):SetIndex(stageState, (LanguageUtil.GetLocaleText)((((activityInfo.cfg).phase)[stageId]).name))
  ;
  (self.rewardPool):HideAll()
  local taskCfg = (activityInfo:GetTasks(stageId, true)).stcData
  for i,v in ipairs(taskCfg.rewardIds) do
    local item = (self.rewardPool):GetOne(true)
    local itemCfg = (ConfigData.item)[v]
    local num = (taskCfg.rewardNums)[i]
    item:InitItemWithCount(itemCfg, num, nil, stageState == 0)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

return UINActivityStarUpPreItem


local UINEpTaskItemDetail = class("UINEpTaskItemDetail", UIBaseNode)
local base = UIBaseNode
UINEpTaskItemDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Get, self, self.OnClickGetBtn)
end

UINEpTaskItemDetail.InitTaskItem = function(self, taskData, callback, stateId)
  -- function num : 0_1
  self.callback = callback
  self.taskData = taskData
  self:RefreshTaskUI(stateId)
end

UINEpTaskItemDetail.RefreshTaskUI = function(self, stateId)
  -- function num : 0_2 , upvalues : _ENV
  ;
  ((self.ui).btn_text):SetIndex(stateId or 0)
  local taskCfg = (self.taskData):GetStepCfg()
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_taskName).text = (LanguageUtil.GetLocaleText)(taskCfg.title)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Content).text = (LanguageUtil.GetLocaleText)(taskCfg.intro)
  if ((self.taskData).stcData).rewardIds == nil or #((self.taskData).stcData).rewardIds == 0 then
    ((self.ui).reward):SetActive(false)
  else
    ;
    ((self.ui).reward):SetActive(true)
    local rewardId = (((self.taskData).stcData).rewardIds)[1]
    local rewardCount = (((self.taskData).stcData).rewardNums)[1]
    -- DECOMPILER ERROR at PC61: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).tex_Reward).text = "x" .. tostring(rewardCount)
    local itemCfg = (ConfigData.item)[rewardId]
    -- DECOMPILER ERROR at PC71: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).img_Reward).sprite = CRH:GetSpriteByItemConfig(itemCfg)
  end
  do
    local quality = (self.taskData):GetQuality()
    local color = ItemQualityColor[quality]
    if color == nil then
      color = ItemQualityColor[eItemQualityType.Orange]
    end
    -- DECOMPILER ERROR at PC85: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).img_Quality).color = color
    -- DECOMPILER ERROR at PC88: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).img_Col).color = color
  end
end

UINEpTaskItemDetail.OnClickGetBtn = function(self)
  -- function num : 0_3
  if self.callback ~= nil then
    (self.callback)((self.taskData).id)
  end
end

return UINEpTaskItemDetail


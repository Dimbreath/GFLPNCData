-- params : ...
-- function num : 0 , upvalues : _ENV
local UITrainingState = class("UITrainingState", UIBaseWindow)
local base = UIBaseWindow
local AttriItem = require("Game.Training.TrainingState.UITrainingStateAttriItem")
UITrainingState.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.OnSettleEvent = nil
  self.__OnUpdateProgress = BindCallback(self, self.UpdateProgress)
  MsgCenter:AddListener(eMsgEventId.UpdateTrainingProgress, self.__OnUpdateProgress)
  ;
  ((self.ui).attriItem):SetActive(false)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Cancel, self, self.__OnClickCancel)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Completed, self, self.__OnClickComplete)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.__OnClickClose)
  self.__seconds = nil
end

UITrainingState.InitState = function(self, slotData, heroCard, timestamp, efficiencyCfg)
  -- function num : 0_1 , upvalues : _ENV
  self.attriTab = {}
  self.attriPool = {}
  self.slotData = slotData
  self.heroCard = heroCard
  self.efficiencyCfg = efficiencyCfg
  ;
  ((self.ui).tex_OldLevel):SetIndex(0, tostring(heroCard.level))
  self.__totalTimeAttri = self:__GetAttriItem(true)
  self:UpdateProgress(slotData.index, slotData.duration, slotData.remainSecond, slotData.progress)
end

UITrainingState.UpdateProgress = function(self, index, duration, remainSecond, progress)
  -- function num : 0_2 , upvalues : _ENV
  if (self.slotData).index ~= index then
    return 
  end
  ;
  (self.__totalTimeAttri):SetAttriIndex(0, TimestampToTime(duration))
  local second = (math.floor)(duration / 60)
  if self.__seconds == second then
    return 
  end
  self.__seconds = second
  self:__RecycleAllAttriItem()
  local complete = progress >= 1
  ;
  ((self.ui).tex_Title):SetIndex(complete and 1 or 0)
  ;
  (((self.ui).btn_Cancel).gameObject):SetActive(not complete)
  ;
  (((self.ui).btn_Completed).gameObject):SetActive(complete)
  local type_id = (self.slotData).effectiveness + 1
  local cfg = (self.efficiencyCfg)[type_id]
  if cfg == nil then
    error("training.xlsx 找不到该效率配置，type_id=" .. type_id)
    return 
  end
  local efficiency = cfg.training_para
  local totalExp = (math.floor)(efficiency * (self.slotData).totalTime / 60)
  local baseExp = efficiency * second
  ;
  (self:__GetAttriItem()):SetAttriIndex(1, tostring(baseExp))
  local extraExp = 0
  ;
  (self:__GetAttriItem()):SetAttriIndex(2, tostring(extraExp))
  local addExp = baseExp + extraExp
  local testLevel, nextExp, nextTotalExp, overFlowExp = (self.heroCard):AddTestExp(addExp)
  ;
  ((self.ui).tex_NewLevel):SetIndex(0, tostring(testLevel))
  ;
  (self:__GetAttriItem()):SetAttriIndex(3, tostring(overFlowExp))
  local remainExp = totalExp - addExp
  ;
  (self:__GetAttriItem()):SetAttriIndex(4, tostring(remainExp))
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UITrainingState.__GetAttriItem = function(self, notInAttriTab)
  -- function num : 0_3 , upvalues : _ENV, AttriItem
  local item = nil
  if #self.attriPool > 0 then
    item = (table.remove)(self.attriPool, 1)
  else
    local go = ((self.ui).attriItem):Instantiate()
    item = (AttriItem.New)()
    item:Init(go)
  end
  do
    ;
    (item.gameObject):SetActive(true)
    ;
    (item.transform):SetAsLastSibling()
    if not notInAttriTab then
      (table.insert)(self.attriTab, item)
    end
    return item
  end
end

UITrainingState.__RecycleAllAttriItem = function(self)
  -- function num : 0_4 , upvalues : _ENV
  for k,v in ipairs(self.attriTab) do
    (v.gameObject):SetActive(false)
    ;
    (table.insert)(self.attriPool, v)
  end
  self.attriTab = {}
end

UITrainingState.__OnClickCancel = function(self)
  -- function num : 0_5
  if self.OnSettleEvent ~= nil then
    (self.OnSettleEvent)((self.slotData).index, false)
  end
  self:__OnClickClose()
end

UITrainingState.__OnClickComplete = function(self)
  -- function num : 0_6
  if self.OnSettleEvent ~= nil then
    (self.OnSettleEvent)((self.slotData).index, true)
  end
  self:__OnClickClose()
end

UITrainingState.__OnClickClose = function(self)
  -- function num : 0_7
  self:Delete()
end

UITrainingState.OnDelete = function(self)
  -- function num : 0_8 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateTrainingProgress, self.__OnUpdateProgress)
  for k,v in ipairs(self.attriPool) do
    v:OnDelete()
  end
  self.attriPool = {}
  for k,v in ipairs(self.attriTab) do
    v:OnDelete()
  end
  self.attriTab = {}
  if self.__totalTimeAttri ~= nil then
    (self.__totalTimeAttri):OnDelete()
    self.__totalTimeAttri = nil
  end
  ;
  (base.OnDelete)(self)
end

return UITrainingState


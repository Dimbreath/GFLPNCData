local UINChallengeTaskInfoItem = class("UINChallengeTaskInfoItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local TaskEnum = require("Game.Task.TaskEnum")
UINChallengeTaskInfoItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.itemPool = (UIItemPool.New)(UINBaseItemWithCount, (self.ui).uINBaseItem)
  ;
  ((self.ui).uINBaseItem):SetActive(false)
  ;
  (UIUtil.AddButtonListener)((self.ui).infoItem, self, self.OnClickTaskPanel)
  self.__RefreshReddotState = BindCallback(self, self.RefreshReddotState)
  RedDotController:AddListener(RedDotStaticTypeId.Main .. "." .. RedDotStaticTypeId.WeeklyChallengeTask, self.__RefreshReddotState)
  self.__RefreshScoreInfo = BindCallback(self, self.RefreshScoreInfo)
  MsgCenter:AddListener(eMsgEventId.PeroidUpdate, self.__RefreshScoreInfo)
end

UINChallengeTaskInfoItem.InitTaskInfoItem = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  local counterElem = (PlayerDataCenter.allWeeklyChallengeData):GetCounterElem()
  if counterElem ~= nil then
    self.netxRefreshTimeStamp = counterElem.nextExpiredTm
    if self.netxRefreshTimeStamp ~= nil and PlayerDataCenter.timestamp < self.netxRefreshTimeStamp then
      self.timerId = TimerManager:StartTimer(1, self.CutdownTime, self, false, false, false)
      self:CutdownTime()
    end
  end
  self:RefreshScoreInfo()
  local ok, reddot = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.WeeklyChallengeTask)
  self:RefreshReddotState(reddot)
end

UINChallengeTaskInfoItem.RefreshScoreInfo = function(self)
  -- function num : 0_2 , upvalues : _ENV, TaskEnum
  local taskCtrl = ControllerManager:GetController(ControllerTypeId.Task)
  local peroidDatas = taskCtrl:GetDatas4Peroid((TaskEnum.eTaskPeriodType).WeeklyChallengeTask)
  local pointId = ((peroidDatas[1]).stcData).activeId
  local currActiveNum = PlayerDataCenter:GetItemCount(pointId)
  local totalActiveNum = 0
  local selectPeroidData = nil
  local isLimit = false
  for i,data in ipairs(peroidDatas) do
    totalActiveNum = (data.stcData).activeNum
    if currActiveNum < totalActiveNum then
      selectPeroidData = data
      break
    else
      if i == #peroidDatas then
        selectPeroidData = data
        isLimit = true
      end
    end
  end
  do
    ;
    ((self.ui).scoreText):SetIndex(0, tostring(currActiveNum), tostring(totalActiveNum))
    ;
    ((self.ui).obj_isLimit):SetActive(isLimit)
    ;
    ((self.ui).obj_isGetALL):SetActive(isLimit)
    ;
    ((self.ui).obj_rewardNode):SetActive(not isLimit)
    ;
    (self.itemPool):HideAll()
    if isLimit then
      return 
    end
    for i,itemId in ipairs((selectPeroidData.stcData).rewardIds) do
      local itemCount = ((selectPeroidData.stcData).rewardNums)[i]
      local itemCfg = (ConfigData.item)[itemId]
      local item = (self.itemPool):GetOne()
      item:InitItemWithCount(itemCfg, itemCount)
    end
  end
end

UINChallengeTaskInfoItem.OnClickTaskPanel = function(self)
  -- function num : 0_3 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.SectorTask, function(win)
    -- function num : 0_3_0
    if win == nil then
      return 
    end
    win:InitWeeklyChallengeTask()
  end
)
end

UINChallengeTaskInfoItem.CutdownTime = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local remaindTime = (math.max)((math.floor)(self.netxRefreshTimeStamp - PlayerDataCenter.timestamp), 0)
  local d, h, m, s = TimestampToTimeInter(remaindTime, false, true)
  if h < 10 or not tostring(h) then
    local hStr = "0" .. tostring(h)
  end
  if m < 10 or not tostring(m) then
    local mStr = "0" .. tostring(m)
  end
  if s < 10 or not tostring(s) then
    local sStr = "0" .. tostring(s)
  end
  if d > 0 then
    ((self.ui).tex_Timer):SetIndex(0, tostring(d), hStr, mStr, sStr)
  else
    ;
    ((self.ui).tex_Timer):SetIndex(1, hStr, mStr, sStr)
  end
  if remaindTime <= 0 and self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
end

UINChallengeTaskInfoItem.RefreshReddotState = function(self, reddot)
  -- function num : 0_5
  ;
  ((self.ui).redDot):SetActive(reddot ~= nil and reddot:GetRedDotCount() > 0)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINChallengeTaskInfoItem.OnHide = function(self)
  -- function num : 0_6 , upvalues : _ENV, base
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  ;
  (base.OnHide)(self)
end

UINChallengeTaskInfoItem.OnDelete = function(self)
  -- function num : 0_7 , upvalues : _ENV, base
  RedDotController:RemoveListener(RedDotStaticTypeId.Main .. "." .. RedDotStaticTypeId.WeeklyChallengeTask, self.__RefreshReddotState)
  MsgCenter:RemoveListener(eMsgEventId.PeroidUpdate, self.__RefreshScoreInfo)
  ;
  (base.OnDelete)(self)
end

return UINChallengeTaskInfoItem


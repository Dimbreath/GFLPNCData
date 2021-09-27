local ActivityFrameController = class("ActivityFrameController", ControllerBase)
local base = ControllerBase
local ActivityFrameData = require("Game.ActivityFrame.ActivityFrameData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ActivityFrameOpenFunc = require("Game.ActivityFrame.ActivityFrameOpenFunc")
local HomeEnum = require("Game.Home.HomeEnum")
local CheckerTypeId, CheckerGlobalConfig = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
ActivityFrameController.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.AllActivityFrameDataDic = {}
  self.WaitShowActivityDic = {}
  self.OpendActivityDic = {}
  self.__BC_Listern2PreConditona = BindCallback(self, self.__Listern2PreConditon)
  MsgCenter:AddListener(eMsgEventId.PreCondition, self.__BC_Listern2PreConditona)
  self.nextOperaTime = -1
  self.noviceSignDic = {}
  self.wechatActivityElems = {}
end

ActivityFrameController.UpdateActivity = function(self, activityElemDic)
  -- function num : 0_1 , upvalues : _ENV, ActivityFrameData, ActivityFrameEnum
  local wechatActivityIds = {}
  for id,activityElem in pairs(activityElemDic) do
    local actInfo = (self.AllActivityFrameDataDic)[id]
    if actInfo == nil then
      actInfo = (ActivityFrameData.CreateActivityFrameData)(activityElem)
      -- DECOMPILER ERROR at PC14: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self.AllActivityFrameDataDic)[id] = actInfo
    else
      actInfo:UpdateActivityFrameData(activityElem)
    end
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R9 in 'UnsetPending'

    if actInfo:GetCouldRuningActivity() then
      (self.WaitShowActivityDic)[id] = nil
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self.OpendActivityDic)[id] = actInfo
    else
      -- DECOMPILER ERROR at PC29: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self.WaitShowActivityDic)[id] = actInfo
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self.OpendActivityDic)[id] = nil
    end
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R9 in 'UnsetPending'

    if actInfo.actCat == (ActivityFrameEnum.eActivityType).SevenDayLogin then
      (self.noviceSignDic)[id] = actInfo
    end
    if actInfo.actCat == (ActivityFrameEnum.eActivityType).Tickets then
      wechatActivityIds[actInfo.actId] = true
    end
  end
  do
    if (table.count)(wechatActivityIds) then
      local actFrameCtr = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
      actFrameCtr:CS_ACTIVITY_Wechat_Detail(wechatActivityIds)
    end
    if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SignIn) then
      self:AddFakeSigninActivityData()
    end
    self:TimerTimeCalculate()
    if self.timerId ~= nil then
      TimerManager:StopTimer(self.timerId)
      self.timerId = nil
    end
    self.timerId = TimerManager:StartTimer(1, self.TimerCallback, self, false, false, false)
  end
end

ActivityFrameController.UpdateWechatActivityElems = function(self, datas, flag)
  -- function num : 0_2
  self.wechatActivityElems = datas
end

ActivityFrameController.UpdateWechatActivityFollowed = function(self, id, flag)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self.wechatActivityElems)[id]).followed = flag
end

ActivityFrameController.AddFakeSigninActivityData = function(self)
  -- function num : 0_4 , upvalues : ActivityFrameEnum, ActivityFrameData
  local fackId = (ActivityFrameEnum.eActiveityFakeId).dailySignIn
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  if (self.AllActivityFrameDataDic)[fackId] == nil then
    (self.AllActivityFrameDataDic)[fackId] = (ActivityFrameData.CreateActivityFrameDataFromFakeData)({id = fackId, actCat = (ActivityFrameEnum.eActivityType).dailySignIn, actId = fackId, enterType = (ActivityFrameEnum.eActivityEnterType).LimitTime, order = 999})
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self.OpendActivityDic)[fackId] = (self.AllActivityFrameDataDic)[fackId]
  end
end

ActivityFrameController.DeleteActivity = function(self, activityDeleteDic)
  -- function num : 0_5 , upvalues : _ENV
  for id,_ in pairs(activityDeleteDic) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R7 in 'UnsetPending'

    (self.AllActivityFrameDataDic)[id] = nil
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self.WaitShowActivityDic)[id] = nil
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self.OpendActivityDic)[id] = nil
  end
end

ActivityFrameController.GetActivityFrameData = function(self, id)
  -- function num : 0_6
  if id == nil then
    return nil
  end
  return (self.AllActivityFrameDataDic)[id]
end

ActivityFrameController.GetActivityFrameState = function(self, id)
  -- function num : 0_7 , upvalues : ActivityFrameData
  return (ActivityFrameData.GetActivityFrameState)((self.AllActivityFrameDataDic)[id])
end

ActivityFrameController.HideActivityByExtraLogic = function(self, actType, actId)
  -- function num : 0_8
  local id = self:GetIdByActTypeAndActId(actType, actId)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  if id ~= nil then
    ((self.AllActivityFrameDataDic)[id]).isHideBySpecial = true
    self:__FinishActivitys({id})
  end
end

ActivityFrameController.IsHaveShowByEnterType = function(self, enterType)
  -- function num : 0_9 , upvalues : _ENV
  for k,v in pairs(self.OpendActivityDic) do
    if v.enterType == enterType and v:GetCouldShowActivity() then
      return true
    end
  end
  return false
end

ActivityFrameController.GetShowByEnterType = function(self, enterType)
  -- function num : 0_10 , upvalues : _ENV
  local dic = {}
  for k,v in pairs(self.OpendActivityDic) do
    if v.enterType == enterType and v:GetCouldShowActivity() then
      dic[k] = v
    end
  end
  return dic
end

ActivityFrameController.GetIsHaveUnlockedActivity = function(self)
  -- function num : 0_11 , upvalues : _ENV, ActivityFrameEnum
  for index,enterType in ipairs(ActivityFrameEnum.eActivityEnterTypePriority) do
    if self:IsHaveShowByEnterType(enterType) then
      return enterType
    end
  end
  return nil
end

ActivityFrameController.GetIdByActTypeAndActId = function(self, actType, actId)
  -- function num : 0_12 , upvalues : _ENV
  for k,v in pairs(self.AllActivityFrameDataDic) do
    if v.actCat == actType and v.actId == actId then
      return k
    end
  end
  return nil
end

ActivityFrameController.SetReddot = function(self, actType, actId, count)
  -- function num : 0_13 , upvalues : ActivityFrameEnum, _ENV
  local id = self:GetIdByActTypeAndActId(actType, actId)
  local actInfo = (self.OpendActivityDic)[id]
  if actInfo == nil then
    return 
  end
  local enterTypeRedNode = nil
  if actInfo.enterType == (ActivityFrameEnum.eActivityEnterType).Novice then
    _ = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityFrameNovice)
  else
    -- DECOMPILER ERROR at PC37: Overwrote pending register: R6 in 'AssignReg'

    if actInfo.enterType == (ActivityFrameEnum.eActivityEnterType).LimitTime then
      _ = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityFrameLimitTime)
    end
  end
  if enterTypeRedNode == nil then
    return 
  end
  local node = enterTypeRedNode:AddChild(id)
  node:SetRedDotCount(count)
end

ActivityFrameController.__OpenActivitys = function(self, ids)
  -- function num : 0_14 , upvalues : _ENV, ActivityFrameOpenFunc
  if ids == nil or #ids <= 0 then
    return 
  end
  for _,id in ipairs(ids) do
    local activity = (self.WaitShowActivityDic)[id]
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self.OpendActivityDic)[id] = activity
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self.WaitShowActivityDic)[id] = nil
    if ActivityFrameOpenFunc[activity.actCat] ~= nil then
      (ActivityFrameOpenFunc[activity.actCat])(activity.actId)
    end
  end
  MsgCenter:Broadcast(eMsgEventId.ActivityShowChange, ids)
end

ActivityFrameController.__FinishActivitys = function(self, ids)
  -- function num : 0_15 , upvalues : _ENV, ActivityFrameEnum
  if ids == nil or #ids <= 0 then
    return 
  end
  for _,id in ipairs(ids) do
    local actInfo = (self.OpendActivityDic)[id]
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self.OpendActivityDic)[id] = nil
    local enterTypeRedNode = nil
    if actInfo.enterType == (ActivityFrameEnum.eActivityEnterType).Novice then
      _ = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityFrameNovice)
    else
      -- DECOMPILER ERROR at PC42: Overwrote pending register: R8 in 'AssignReg'

      if actInfo.enterType == (ActivityFrameEnum.eActivityEnterType).LimitTime then
        _ = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityFrameNovice)
      end
    end
    if enterTypeRedNode ~= nil then
      enterTypeRedNode:RemoveChild(id)
    end
  end
  MsgCenter:Broadcast(eMsgEventId.ActivityShowChange, ids)
end

ActivityFrameController.IsExistOpenActByActType = function(self, actType)
  -- function num : 0_16 , upvalues : _ENV
  for k,v in pairs(self.OpendActivityDic) do
    if v.actCat == actType then
      return true
    end
  end
  return false
end

ActivityFrameController.__Listern2PreConditon = function(self, conditionId)
  -- function num : 0_17 , upvalues : _ENV
  local ids = {}
  for id,activityFrameData in pairs(self.WaitShowActivityDic) do
    if activityFrameData:IsHaveThisCondition(conditionId) and activityFrameData:GetCouldRuningActivity() then
      (table.insert)(ids, id)
    end
  end
  self:__OpenActivitys(ids)
end

ActivityFrameController.TimerTimeCalculate = function(self)
  -- function num : 0_18 , upvalues : _ENV
  if (table.count)(self.WaitShowActivityDic) == 0 and (table.count)(self.OpendActivityDic) == 0 then
    self.nextOperaTime = -1
    return 
  end
  local timeDelay = -1
  local currentTime = PlayerDataCenter.timestamp
  for k,v in pairs(self.WaitShowActivityDic) do
    local tempDelay = v.startTime - currentTime
    if timeDelay == -1 or tempDelay < timeDelay then
      timeDelay = tempDelay
    end
  end
  for k,v in pairs(self.OpendActivityDic) do
    if v.endTime ~= -1 then
      local tempDelay = v.endTime - currentTime
      if timeDelay == -1 or tempDelay < timeDelay then
        timeDelay = tempDelay
      end
    end
  end
  if timeDelay < 0 then
    self.nextOperaTime = -1
  else
    self.nextOperaTime = PlayerDataCenter.timestamp + timeDelay
  end
end

ActivityFrameController.TimerCallback = function(self)
  -- function num : 0_19
  self:OpenAndCloseTimeDeal()
  self:ExtraTimeDeal()
end

ActivityFrameController.OpenAndCloseTimeDeal = function(self)
  -- function num : 0_20 , upvalues : _ENV
  if self.nextOperaTime == -1 or (((table.count)(self.WaitShowActivityDic) == 0 and (table.count)(self.OpendActivityDic) == 0) or PlayerDataCenter.timestamp < self.nextOperaTime) then
    return 
  end
  local openIds = {}
  for k,v in pairs(self.WaitShowActivityDic) do
    if v:GetCouldRuningActivity() then
      (table.insert)(openIds, v.id)
    end
  end
  local closeIds = {}
  for k,v in pairs(self.OpendActivityDic) do
    if v:GetIsActivityFinished() then
      (table.insert)(closeIds, v.id)
    end
  end
  self:__OpenActivitys(openIds)
  self:__FinishActivitys(closeIds)
  self:TimerTimeCalculate()
end

ActivityFrameController.ExtraTimeDeal = function(self)
  -- function num : 0_21 , upvalues : _ENV, HomeEnum
  if self.nextNoviceSignTime == nil or self.nextNoviceSignTime < PlayerDataCenter.timestamp then
    local eventSignWindow = UIManager:GetWindow(UIWindowTypeID.EventNoviceSign)
    if eventSignWindow ~= nil then
      eventSignWindow:RefreshNoviceSign()
    end
    local isAddPopGuide = false
    for k,v in pairs(self.noviceSignDic) do
      local signData = ((PlayerDataCenter.eventNoviceSignData).dataDic)[v.actId]
      self:SetReddot(v.actCat, v.actId, signData ~= nil and signData:IsAllowReceive() and 1 or 0)
      if (self.OpendActivityDic)[k] ~= nil and signData ~= nil and signData:IsCanPop() then
        isAddPopGuide = true
      end
    end
    local HomeController = ControllerManager:GetController(ControllerTypeId.HomeController)
    if HomeController ~= nil and HomeController.homeState == (HomeEnum.eHomeState).Normal and isAddPopGuide then
      HomeController:AddAutoShowGuide((HomeEnum.eAutoShwoCommand).NoviceSign)
    end
    self.nextNoviceSignTime = (math.floor)(PlayerDataCenter.timestamp)
    local timeTable = TimestampToDate(self.nextNoviceSignTime)
    timeTable.hour = 0
    timeTable.min = 0
    timeTable.sec = 1
    self.nextNoviceSignTime = (os.time)(timeTable) + 86400
  end
end

ActivityFrameController.OnDelete = function(self)
  -- function num : 0_22 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.PreCondition, self.__BC_Listern2PreConditona)
  TimerManager:StopTimer(self.timerId)
  self.AllActivityFrameDataDic = nil
  self.WaitShowActivityDic = nil
  self.OpendActivityDic = nil
  self.nextOperaTime = -1
  self.nextNoviceSignTime = -1
  ;
  (base.OnDelete)(self)
end

return ActivityFrameController


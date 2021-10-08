local ActivityFrameController = class("ActivityFrameController", ControllerBase)
local base = ControllerBase
local ActivityFrameData = require("Game.ActivityFrame.ActivityFrameData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ActivityFrameOpenFunc = require("Game.ActivityFrame.ActivityFrameOpenFunc")
local ActivityFrameChangeFunc = require("Game.ActivityFrame.ActivityFrameChangeFunc")
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
  -- function num : 0_1 , upvalues : _ENV, ActivityFrameData, ActivityFrameChangeFunc, ActivityFrameEnum
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
      if ActivityFrameChangeFunc[actInfo.actCat] ~= nil then
        (ActivityFrameChangeFunc[actInfo.actCat])(actInfo)
      end
    else
      -- DECOMPILER ERROR at PC37: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self.WaitShowActivityDic)[id] = actInfo
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self.OpendActivityDic)[id] = nil
    end
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R9 in 'UnsetPending'

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
  -- function num : 0_2 , upvalues : _ENV, ActivityFrameEnum
  self.wechatActivityElems = datas
  for actId,elem in pairs(self.wechatActivityElems) do
    if elem.redeemed or (CS.ClientConsts).IsAudit then
      self:HideActivityByExtraLogic((ActivityFrameEnum.eActivityType).Tickets, actId)
    end
  end
end

ActivityFrameController.UpdateWechatActivityFollowed = function(self, actId, flag)
  -- function num : 0_3
  local elem = (self.wechatActivityElems)[actId]
  if elem == nil then
    return 
  end
  elem.followed = flag
end

ActivityFrameController.UpdateWechatActivityRedeemed = function(self, actId)
  -- function num : 0_4 , upvalues : ActivityFrameEnum
  local elem = (self.wechatActivityElems)[actId]
  if elem == nil then
    return 
  end
  elem.redeemed = true
  self:HideActivityByExtraLogic((ActivityFrameEnum.eActivityType).Tickets, actId)
end

ActivityFrameController.AddFakeSigninActivityData = function(self)
  -- function num : 0_5 , upvalues : ActivityFrameEnum, ActivityFrameData
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
  -- function num : 0_6 , upvalues : _ENV
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
  -- function num : 0_7
  if id == nil then
    return nil
  end
  return (self.AllActivityFrameDataDic)[id]
end

ActivityFrameController.GetActivityFrameState = function(self, id)
  -- function num : 0_8 , upvalues : ActivityFrameData
  return (ActivityFrameData.GetActivityFrameState)((self.AllActivityFrameDataDic)[id])
end

ActivityFrameController.HideActivityByExtraLogic = function(self, actType, actId)
  -- function num : 0_9
  local id = self:GetIdByActTypeAndActId(actType, actId)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  if id ~= nil then
    ((self.AllActivityFrameDataDic)[id]).isHideBySpecial = true
    self:__FinishActivitys({id})
  end
end

ActivityFrameController.IsHaveShowByEnterType = function(self, enterType)
  -- function num : 0_10 , upvalues : _ENV
  for k,v in pairs(self.OpendActivityDic) do
    if v.enterType == enterType and v:GetCouldShowActivity() then
      return true
    end
  end
  return false
end

ActivityFrameController.GetShowByEnterType = function(self, enterType)
  -- function num : 0_11 , upvalues : _ENV
  local dic = {}
  for k,v in pairs(self.OpendActivityDic) do
    if v.enterType == enterType and v:GetCouldShowActivity() then
      dic[k] = v
    end
  end
  return dic
end

ActivityFrameController.GetIsHaveUnlockedActivity = function(self)
  -- function num : 0_12 , upvalues : _ENV, ActivityFrameEnum
  for index,enterType in ipairs(ActivityFrameEnum.eActivityEnterTypePriority) do
    if self:IsHaveShowByEnterType(enterType) then
      return enterType
    end
  end
  return nil
end

ActivityFrameController.GetIdByActTypeAndActId = function(self, actType, actId)
  -- function num : 0_13 , upvalues : _ENV
  for k,v in pairs(self.AllActivityFrameDataDic) do
    if v.actCat == actType and v.actId == actId then
      return k
    end
  end
  return nil
end

ActivityFrameController.SetReddot = function(self, actType, actId, count)
  -- function num : 0_14
  local node = self:GetActivityReddot(actType, actId)
  if node == nil then
    return 
  end
  node:SetRedDotCount(count)
end

ActivityFrameController.GetActivityReddot = function(self, actType, actId)
  -- function num : 0_15 , upvalues : ActivityFrameEnum, _ENV
  local id = self:GetIdByActTypeAndActId(actType, actId)
  if id == nil then
    return 
  end
  local actInfo = (self.OpendActivityDic)[id]
  if actInfo == nil then
    return 
  end
  local enterTypeRedNode = nil
  if actInfo.enterType == (ActivityFrameEnum.eActivityEnterType).Novice then
    _ = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityFrameNovice)
  else
    -- DECOMPILER ERROR at PC40: Overwrote pending register: R5 in 'AssignReg'

    if actInfo.enterType == (ActivityFrameEnum.eActivityEnterType).LimitTime then
      _ = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityFrameLimitTime)
    end
  end
  if enterTypeRedNode == nil then
    return 
  end
  local node = enterTypeRedNode:AddChild(id)
  return node
end

ActivityFrameController.__OpenActivitys = function(self, ids)
  -- function num : 0_16 , upvalues : _ENV, ActivityFrameOpenFunc, ActivityFrameChangeFunc
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
    if activity ~= nil then
      if ActivityFrameOpenFunc[activity.actCat] ~= nil then
        (ActivityFrameOpenFunc[activity.actCat])(activity.actId)
      end
      if ActivityFrameChangeFunc[activity.actCat] ~= nil then
        (ActivityFrameChangeFunc[activity.actCat])(activity)
      end
    end
  end
  MsgCenter:Broadcast(eMsgEventId.ActivityShowChange, ids)
end

ActivityFrameController.__FinishActivitys = function(self, ids)
  -- function num : 0_17 , upvalues : _ENV, ActivityFrameEnum, ActivityFrameChangeFunc
  if ids == nil or #ids <= 0 then
    return 
  end
  for _,id in ipairs(ids) do
    local actInfo = (self.OpendActivityDic)[id]
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self.OpendActivityDic)[id] = nil
    if actInfo ~= nil then
      local enterTypeRedNode = nil
      if actInfo.enterType == (ActivityFrameEnum.eActivityEnterType).Novice then
        _ = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityFrameNovice)
      else
        -- DECOMPILER ERROR at PC44: Overwrote pending register: R8 in 'AssignReg'

        if actInfo.enterType == (ActivityFrameEnum.eActivityEnterType).LimitTime then
          _ = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityFrameLimitTime)
        end
      end
      if enterTypeRedNode ~= nil then
        enterTypeRedNode:RemoveChild(id)
      end
      if ActivityFrameChangeFunc[actInfo.actCat] ~= nil then
        (ActivityFrameChangeFunc[actInfo.actCat])(actInfo)
      end
    end
  end
  MsgCenter:Broadcast(eMsgEventId.ActivityShowChange, ids)
end

ActivityFrameController.IsExistOpenActByActType = function(self, actType)
  -- function num : 0_18 , upvalues : _ENV
  for k,v in pairs(self.OpendActivityDic) do
    if v.actCat == actType then
      return true
    end
  end
  return false
end

ActivityFrameController.__Listern2PreConditon = function(self, conditionId)
  -- function num : 0_19 , upvalues : _ENV
  local ids = {}
  for id,activityFrameData in pairs(self.WaitShowActivityDic) do
    if activityFrameData:IsHaveThisCondition(conditionId) and activityFrameData:GetCouldRuningActivity() then
      (table.insert)(ids, id)
    end
  end
  self:__OpenActivitys(ids)
end

ActivityFrameController.TimerTimeCalculate = function(self)
  -- function num : 0_20 , upvalues : _ENV
  if (table.count)(self.WaitShowActivityDic) == 0 and (table.count)(self.OpendActivityDic) == 0 then
    self.nextOperaTime = -1
    return 
  end
  local timeDelay = -1
  local currentTime = PlayerDataCenter.timestamp
  for k,v in pairs(self.WaitShowActivityDic) do
    if currentTime < v.startTime then
      local tempDelay = v.startTime - currentTime
      if timeDelay == -1 or tempDelay < timeDelay then
        timeDelay = tempDelay
      end
    end
  end
  for k,v in pairs(self.OpendActivityDic) do
    if v.endTime ~= -1 and currentTime < v.endTime then
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
  -- function num : 0_21
  self:OpenAndCloseTimeDeal()
  self:ExtraTimeDeal()
end

ActivityFrameController.OpenAndCloseTimeDeal = function(self)
  -- function num : 0_22 , upvalues : _ENV
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
  self:__FinishActivitys(closeIds)
  self:__OpenActivitys(openIds)
  self:TimerTimeCalculate()
end

ActivityFrameController.ExtraTimeDeal = function(self)
  -- function num : 0_23 , upvalues : _ENV, HomeEnum
  if self.nextNoviceSignTime == nil or self.nextNoviceSignTime < PlayerDataCenter.timestamp then
    local eventSignWindow = UIManager:GetWindow(UIWindowTypeID.EventNoviceSign)
    if eventSignWindow ~= nil then
      eventSignWindow:RefreshNoviceSign()
    end
    local festivalSignWindow = UIManager:GetWindow(UIWindowTypeID.EventFestivalSignIn)
    if festivalSignWindow ~= nil then
      festivalSignWindow:UpdUIFestivalSignIn()
    end
    local HomeController = ControllerManager:GetController(ControllerTypeId.HomeController)
    local isAddGuide = false
    for k,v in pairs(self.noviceSignDic) do
      local signData = ((PlayerDataCenter.eventNoviceSignData).dataDic)[v.actId]
      self:SetReddot(v.actCat, v.actId, signData ~= nil and signData:IsAllowReceive() and 1 or 0)
      if (self.OpendActivityDic)[k] ~= nil and signData ~= nil and signData:IsCanPop() then
        isAddGuide = true
        if HomeController ~= nil and HomeController.homeState == (HomeEnum.eHomeState).Normal then
          HomeController:AddAutoShowGuide((HomeEnum.eAutoShwoCommand).NoviceSign, true)
        end
      end
    end
    if isAddGuide then
      HomeController:TryRunAutoShow()
    end
    local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass)
    _ = timePassCtrl:GetIsLogicToday(PlayerDataCenter.timestamp)
  end
end

ActivityFrameController.OnDelete = function(self)
  -- function num : 0_24 , upvalues : _ENV, base
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


local UnlockCenter = {}
local CheckerTypeId, _ = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
UnlockCenter.eUnlockLogic = {CompleteStage = 1}
local unlockLogicId2CheckerTypeId = {[(UnlockCenter.eUnlockLogic).CompleteStage] = CheckerTypeId.CompleteStage}
UnlockCenter.InitUnlockCenter = function(self)
  -- function num : 0_0
  self.unlockLogicDic = {}
end

UnlockCenter.AddUnlockElemEvent = function(self, callback, logic, para1)
  -- function num : 0_1 , upvalues : _ENV
  if callback == nil or logic == nil or para1 == nil then
    error((string.format)("param error, callback:%s, logic:%s, para1:%s", callback, logic, para1))
    return 
  end
  if logic == 0 then
    return 
  end
  if not (self.unlockLogicDic)[logic] then
    local unlockLogic = {}
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R5 in 'UnsetPending'

  if (self.unlockLogicDic)[logic] == nil then
    (self.unlockLogicDic)[logic] = unlockLogic
  end
  if not unlockLogic[para1] then
    local eventDic = {}
  end
  if unlockLogic[para1] == nil then
    unlockLogic[para1] = eventDic
  end
  if eventDic[callback] ~= nil then
    error("Aready cotains callback : " .. tostring(callback))
    return 
  end
  eventDic[callback] = true
end

UnlockCenter.TriggerUnlockEvent = function(self, logic, para1)
  -- function num : 0_2 , upvalues : _ENV
  if (self.unlockLogicDic)[logic] == nil or ((self.unlockLogicDic)[logic])[para1] == nil then
    return 
  end
  local eventDic = ((self.unlockLogicDic)[logic])[para1]
  for callback,v in pairs(eventDic) do
    callback(logic, para1)
  end
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.unlockLogicDic)[logic])[para1] = nil
end

UnlockCenter.UnlockCheck = function(self, logic, para1)
  -- function num : 0_3 , upvalues : unlockLogicId2CheckerTypeId, _ENV
  local pre_condition = unlockLogicId2CheckerTypeId[logic]
  if pre_condition == nil then
    error("Unsupported logic, id = " .. tostring(logic))
    return false
  end
  return (CheckCondition.CheckLua)({pre_condition}, {para1})
end

UnlockCenter.GetUnlockElemDes = function(self, logic, para1)
  -- function num : 0_4 , upvalues : unlockLogicId2CheckerTypeId, _ENV
  local pre_condition = unlockLogicId2CheckerTypeId[logic]
  if pre_condition == nil then
    error("Unsupported logic, id = " .. tostring(logic))
    return false
  end
  local lockStr = (CheckCondition.GetUnlockInfoLua)({pre_condition}, {para1})
  return lockStr
end

return UnlockCenter


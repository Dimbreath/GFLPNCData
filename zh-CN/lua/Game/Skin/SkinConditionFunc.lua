local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local SkinConditionFunc = {[proto_csmsg_SystemFunctionID.SystemFunctionID_Store] = function(cfg)
  -- function num : 0_0 , upvalues : _ENV
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Store) then
    return false
  end
  local param = cfg.condition_para
  local shopCtr = ControllerManager:GetController(ControllerTypeId.Shop, true)
  for i,v in ipairs(param) do
    local shopData = (shopCtr.shopDataDic)[v]
    if shopData ~= nil and shopData:GetShopGoodDataByItemId(cfg.id, true) ~= nil then
      return true
    end
  end
  return false
end
, [proto_csmsg_SystemFunctionID.SystemFunctionID_Operate_Active] = function(cfg)
  -- function num : 0_1 , upvalues : _ENV, ActivityFrameEnum
  local actFrameCtr = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local param = cfg.condition_para
  for i,v in ipairs(param) do
    if actFrameCtr:GetActivityFrameState(v) == (ActivityFrameEnum.eActivityState).Opening then
      return true
    end
  end
  return false
end
, [proto_csmsg_SystemFunctionID.SystemFunctionID_HeroRank] = function()
  -- function num : 0_2
  return true
end
}
return SkinConditionFunc


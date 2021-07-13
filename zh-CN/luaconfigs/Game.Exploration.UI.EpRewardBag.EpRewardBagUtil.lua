-- params : ...
-- function num : 0 , upvalues : _ENV
local EpRewardBagUtil = {}
local epModuleTypeDic = {[proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration] = 1, [proto_csmsg_SystemFunctionID.SystemFunctionID_Hard] = 2, [proto_csmsg_SystemFunctionID.SystemFunctionID_Endless] = 3}
EpRewardBagUtil.GetEpRewardItemPrice = function(itemId, epModuleId, stageId, num, original)
  -- function num : 0_0 , upvalues : epModuleTypeDic, _ENV
  local stateType = epModuleTypeDic[epModuleId]
  if stateType == nil then
    error((string.format)("EpModuleId is invalid,EpModuleId = %s, itemId = %s, stateType = %s", epModuleId, itemId, stateType))
    return 0
  end
  local stageTypeDic = ((ConfigData.reward_purchase).rewardPurchaseDic)[itemId]
  if stageTypeDic == nil then
    error((string.format)("Cant get reward_purchase cfg, itemId = %s, stateType = %s", itemId, stateType))
    return 0
  end
  local stageIdList = stageTypeDic[stateType]
  if stageIdList == nil then
    error((string.format)("Cant get reward_purchase cfg, itemId = %s, stateType = %s", itemId, stateType))
    return 0
  end
  local price = 0
  if original then
    local id = stageIdList[1]
    price = ((ConfigData.reward_purchase)[id]).item_price
  else
    do
      for k,v in ipairs(stageIdList) do
        local curCfg = (ConfigData.reward_purchase)[v]
        local nextCfg = (ConfigData.reward_purchase)[stageIdList[k + 1]]
        if nextCfg == nil then
          price = curCfg.item_price
          break
        end
        if stageId < nextCfg.stage_id then
          price = curCfg.item_price
          break
        end
      end
      do
        return price * num
      end
    end
  end
end

EpRewardBagUtil.GetEpRewardItemPriceStr = function(self, price)
  -- function num : 0_1 , upvalues : _ENV
  local dividend = (ConfigData.game_config).staminaDividend / 10
  local value = (math.ceil)(price / dividend)
  value = FormatNum(value / 10)
  return tostring(value)
end

return EpRewardBagUtil


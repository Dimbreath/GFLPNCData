local EpAutoUtil = {}
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
EpAutoUtil.AbleGetNewChip = function(dynPlayer)
  -- function num : 0_0
  local isOverLimit, nowCount, nowLimit = dynPlayer:IsChipOverLimitNum()
  if isOverLimit then
    return true, false
  end
  local ableGetNew = true
  if nowCount == nowLimit then
    local costItemId, costItemNum = dynPlayer:GetChipUpgradeLimitPrice()
    local curMoney = dynPlayer:GetItemCount(costItemId)
    ableGetNew = costItemNum <= curMoney
  end
  do return false, ableGetNew end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

EpAutoUtil.GetAutoBestValueChip = function(dynPlayer, chipList, totalPowerDic)
  -- function num : 0_1 , upvalues : _ENV
  local fightPower = -1
  local totalPower = -1
  local quality = -1
  local bestChipData = nil
  for k,chipData in pairs(chipList) do
    local tmpPower = dynPlayer:GetChipCombatEffect(chipData, false, true)
    do
      if tmpPower == fightPower then
        local tmpTotalPower = totalPowerDic[chipData]
      end
      if (tmpTotalPower ~= totalPower or quality >= chipData:GetQuality()) and totalPower >= tmpTotalPower and fightPower >= tmpPower then
        do
          bestChipData = chipData
          fightPower = tmpPower
          totalPower = totalPowerDic[chipData]
          quality = chipData:GetQuality()
          -- DECOMPILER ERROR at PC33: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC33: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC33: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
  end
  return bestChipData
end

local eventAutoChoiceFuncTab = {[(ExplorationEnum.eAutoEventChoiceType).AllRoleHpLess] = function(auto_choice_arg, dynPlayer)
  -- function num : 0_2 , upvalues : _ENV
  local hp = auto_choice_arg[1] * 10
  local autoSuccess = true
  for _,dynHero in ipairs(dynPlayer.heroList) do
    if hp < dynHero.hpPer then
      autoSuccess = false
      break
    end
  end
  do
    return autoSuccess
  end
end
, [(ExplorationEnum.eAutoEventChoiceType).OneRoleHpLess] = function(auto_choice_arg, dynPlayer)
  -- function num : 0_3 , upvalues : _ENV
  local hp = auto_choice_arg[1] * 10
  local autoSuccess = false
  for _,dynHero in ipairs(dynPlayer.heroList) do
    if dynHero.hpPer <= hp then
      autoSuccess = true
      break
    end
  end
  do
    return autoSuccess
  end
end
, [(ExplorationEnum.eAutoEventChoiceType).HasItemCount] = function(auto_choice_arg, dynPlayer)
  -- function num : 0_4
  local autoSuccess = false
  if auto_choice_arg[2] <= dynPlayer:GetItemCount(auto_choice_arg[1]) then
    autoSuccess = true
  end
  return autoSuccess
end
, [(ExplorationEnum.eAutoEventChoiceType).RoleAvgHpLess] = function(auto_choice_arg, dynPlayer)
  -- function num : 0_5 , upvalues : _ENV
  local autoSuccess = false
  local totalHp = 0
  local c = 0
  for _,dynHero in ipairs(dynPlayer.heroList) do
    if not dynHero.onBench then
      totalHp = totalHp + dynHero.hpPer
      c = c + 1
    end
  end
  local avgHp = 0
  if c > 0 then
    avgHp = (totalHp) / (c)
  end
  if avgHp <= auto_choice_arg[1] * 10 then
    autoSuccess = true
  end
  return autoSuccess
end
, [(ExplorationEnum.eAutoEventChoiceType).RoleAvgHpGreate] = function(auto_choice_arg, dynPlayer)
  -- function num : 0_6 , upvalues : _ENV
  local autoSuccess = false
  local totalHp = 0
  local c = 0
  for _,dynHero in ipairs(dynPlayer.heroList) do
    if not dynHero.onBench then
      totalHp = totalHp + dynHero.hpPer
      c = c + 1
    end
  end
  local avgHp = 0
  if c > 0 then
    avgHp = (totalHp) / (c)
  end
  if auto_choice_arg[1] * 10 < avgHp then
    autoSuccess = true
  end
  return autoSuccess
end
}
EpAutoUtil.IsEventChoiceAutoSuccess = function(auto_choice_type, auto_choice_arg, dynPlayer)
  -- function num : 0_7 , upvalues : eventAutoChoiceFuncTab
  if auto_choice_type <= 0 then
    return false
  end
  local func = eventAutoChoiceFuncTab[auto_choice_type]
  if func == nil then
    return false
  end
  return func(auto_choice_arg, dynPlayer)
end

return EpAutoUtil


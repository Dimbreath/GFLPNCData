-- params : ...
-- function num : 0 , upvalues : _ENV
local PlayerBonus = class("PlayerBonus")
local PlayerBonusElem = require("Game.PlayerData.PlayerBonus.PlayerBonusElem")
PlayerBonus.ctor = function(self)
  -- function num : 0_0
  self.__broadcast = {}
  self.allBunosDataDic = {}
end

PlayerBonus.InstallPlayerBonus = function(self, module, id, ...)
  -- function num : 0_1 , upvalues : _ENV, PlayerBonusElem
  local uid = self:__GetUid(module, id)
  local logicTab = {...}
  if #logicTab < 2 then
    error("InstallBonus: logic param error")
    return 
  end
  local logic = logicTab[1]
  local bonusElem = (self.allBunosDataDic)[logic]
  if bonusElem == nil then
    bonusElem = (PlayerBonusElem.New)()
    bonusElem:InitPlayerBonusElem(logic)
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self.allBunosDataDic)[logic] = bonusElem
  end
  bonusElem:InstallBonus(uid, logicTab[2], logicTab[3], logicTab[4])
end

PlayerBonus.UninstallPlayerBonus = function(self, module, id, logic)
  -- function num : 0_2
  local uid = self:__GetUid(module, id)
  local bonusElem = (self.allBunosDataDic)[logic]
  if bonusElem ~= nil then
    bonusElem:UninstallBonus(uid)
  end
end

PlayerBonus.CheckPlayerBonusBroadcast = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if (self.__broadcast).warehouse then
    MsgCenter:Broadcast(eMsgEventId.UpdateWarehouse)
    ;
    (PlayerDataCenter.allEffectorData):OnUpdateItemCeil()
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self.__broadcast).warehouse = false
  end
  ;
  (PlayerDataCenter.allEffectorData):OnARGItemChnage()
  if (self.__broadcast).AutoRecoverItem then
    MsgCenter:Broadcast(eMsgEventId.UpdateAutoRecoverItemSpeed)
    ;
    (PlayerDataCenter.allEffectorData):OnUpdateItemGenerateSpeed()
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self.__broadcast).AutoRecoverItem = false
  end
end

PlayerBonus.AddPlayerBonusBroadcast = function(self, name)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.__broadcast)[name] = true
end

PlayerBonus.__GetUid = function(self, module, id)
  -- function num : 0_5
  return module << 32 | id
end

PlayerBonus.GetWarehouseCapcity = function(self, id)
  -- function num : 0_6 , upvalues : _ENV
  local bonusElem = (self.allBunosDataDic)[eLogicType.ResourceLimit]
  if bonusElem == nil then
    return 0
  end
  return (bonusElem.totalData)[id]
end

PlayerBonus.GetFactoryPipelieCount = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local bonusElem = (self.allBunosDataDic)[eLogicType.FactoryPipelie]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData
end

PlayerBonus.GetGlobalExpCeiling = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local bonusElem = (self.allBunosDataDic)[eLogicType.GlobalExpCeiling]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData
end

PlayerBonus.GetStaminaCeiling = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local bonusElem = (self.allBunosDataDic)[eLogicType.StaminaCeiling]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData
end

PlayerBonus.GetStaminaOutput = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local bonusElem = (self.allBunosDataDic)[eLogicType.StaminaOutput]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData
end

PlayerBonus.GetResOutputEfficiency = function(self, id)
  -- function num : 0_11 , upvalues : _ENV
  local bonusElem = (self.allBunosDataDic)[eLogicType.ResOutputEfficiency]
  if bonusElem == nil then
    return 0
  end
  return (bonusElem.totalData)[id]
end

PlayerBonus.GetBuildQueueCount = function(self, id)
  -- function num : 0_12 , upvalues : _ENV
  local bonusElem = (self.allBunosDataDic)[eLogicType.BuildQueue]
  if bonusElem == nil then
    return 0
  end
  return (bonusElem.totalData)[id]
end

PlayerBonus.GetBuildSpeed = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local bonusElem = (self.allBunosDataDic)[eLogicType.BuildSpeed]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData
end

PlayerBonus.GetGlobalExpRatio = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local bonusElem = (self.allBunosDataDic)[eLogicType.GlobalExpRatio]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData
end

PlayerBonus.GetOverClock = function(self, id)
  -- function num : 0_15 , upvalues : _ENV
  local bonusElem = (self.allBunosDataDic)[eLogicType.OverClock]
  if bonusElem == nil then
    return 0
  end
  return (bonusElem.totalData)[id]
end

PlayerBonus.GetOverClockFreeNum = function(self)
  -- function num : 0_16 , upvalues : _ENV
  local bonusElem = (self.allBunosDataDic)[eLogicType.OverClockFreeNum]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData
end

PlayerBonus.GetFocusPointCeiling = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local bonusElem = (self.allBunosDataDic)[eLogicType.FocusPointCeiling]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData
end

PlayerBonus.GetBattleExpBonus = function(self)
  -- function num : 0_18 , upvalues : _ENV
  local bonusElem = (self.allBunosDataDic)[eLogicType.BattleExpBonus]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData
end

PlayerBonus.GetDynSkillUpgrade = function(self)
  -- function num : 0_19 , upvalues : _ENV
  local bonusElem = (self.allBunosDataDic)[eLogicType.DynSkillUpgrade]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData
end

PlayerBonus.GetHeroLevelCeiling = function(self)
  -- function num : 0_20 , upvalues : _ENV
  local bonusElem = (self.allBunosDataDic)[eLogicType.HeroLevelCeiling]
  if bonusElem == nil then
    return 0
  end
  return bonusElem.totalData
end

PlayerBonus.GetAutoRecoverItemSpeed = function(self, id)
  -- function num : 0_21 , upvalues : _ENV
  local bonusElem = (self.allBunosDataDic)[eLogicType.AutoRecoverItem]
  if bonusElem == nil then
    return 0
  end
  return (bonusElem.totalData)[id]
end

PlayerBonus.GetDungeonCountAdd = function(self, id)
  -- function num : 0_22 , upvalues : _ENV
  local bonusElem = (self.allBunosDataDic)[eLogicType.DungeonCountAdd]
  if bonusElem == nil then
    return 0
  end
  return (bonusElem.totalData)[id]
end

PlayerBonus.GetFactoryEfficiency = function(self, id)
  -- function num : 0_23 , upvalues : _ENV
  local bonusElem = (self.allBunosDataDic)[eLogicType.FactoryEfficiency]
  if bonusElem == nil then
    return 0
  end
  return (bonusElem.totalData)[id]
end

PlayerBonus.GetCtgrCampBuff = function(self, camp, attriId)
  -- function num : 0_24 , upvalues : _ENV
  local bonusElem = (self.allBunosDataDic)[eLogicType.CampBuff]
  if bonusElem == nil then
    return table.emptytable
  end
  local categoryValueDic = {}
  for uid,data in pairs(bonusElem.categoryDataDic) do
    if data[camp] ~= nil and (data[camp])[attriId] ~= nil then
      categoryValueDic[uid] = (data[camp])[attriId]
    end
  end
  return categoryValueDic
end

PlayerBonus.GetCtgrCareerBuff = function(self, career, attriId)
  -- function num : 0_25 , upvalues : _ENV
  local bonusElem = (self.allBunosDataDic)[eLogicType.CareerBuff]
  if bonusElem == nil then
    return table.emptytable
  end
  local categoryValueDic = {}
  for uid,data in pairs(bonusElem.categoryDataDic) do
    if data[career] ~= nil and (data[career])[attriId] ~= nil then
      categoryValueDic[uid] = (data[career])[attriId]
    end
  end
  return categoryValueDic
end

PlayerBonus.GetCtgrAllHeroBuff = function(self, attriId)
  -- function num : 0_26 , upvalues : _ENV
  local bonusElem = (self.allBunosDataDic)[eLogicType.AllHeroBuff]
  if bonusElem == nil then
    return table.emptytable
  end
  local categoryValueDic = {}
  for uid,data in pairs(bonusElem.categoryDataDic) do
    if data[attriId] ~= nil then
      categoryValueDic[uid] = data[attriId]
    end
  end
  return categoryValueDic
end

return PlayerBonus

-- params : ...
-- function num : 0 , upvalues : _ENV
local PlayerBonus = class("PlayerBonus")
local PlayerBonusElem = require("Game.PlayerData.PlayerBonus.PlayerBonusElem")
PlayerBonus.ctor = function(self)
    -- function num : 0_0
    self.__broadcast = {}
    self.allBunosDataDic = {}
end

PlayerBonus.InstallPlayerBonus = function(self, module, id, ...)
    -- function num : 0_1 , upvalues : _ENV, PlayerBonusElem
    local uid = self:__GetUid(module, id)
    local logicTab = {...}
    if #logicTab < 2 then
        error("InstallBonus: logic param error")
        return
    end
    local logic = logicTab[1]
    local bonusElem = (self.allBunosDataDic)[logic]
    if bonusElem == nil then
        bonusElem = (PlayerBonusElem.New)()
        bonusElem:InitPlayerBonusElem(logic) -- DECOMPILER ERROR at PC26: Confused about usage of register: R7 in 'UnsetPending'
        ;
        (self.allBunosDataDic)[logic] = bonusElem
    end
    bonusElem:InstallBonus(uid, logicTab[2], logicTab[3], logicTab[4])
end

PlayerBonus.UninstallPlayerBonus = function(self, module, id, logic)
    -- function num : 0_2
    local uid = self:__GetUid(module, id)
    local bonusElem = (self.allBunosDataDic)[logic]
    if bonusElem ~= nil then bonusElem:UninstallBonus(uid) end
end

PlayerBonus.CheckPlayerBonusBroadcast = function(self)
    -- function num : 0_3 , upvalues : _ENV
    if (self.__broadcast).warehouse then
        MsgCenter:Broadcast(eMsgEventId.UpdateWarehouse);
        (PlayerDataCenter.allEffectorData):OnUpdateItemCeil() -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'
        ;
        (self.__broadcast).warehouse = false
    end
    (PlayerDataCenter.allEffectorData):OnARGItemChnage()
    if (self.__broadcast).AutoRecoverItem then
        MsgCenter:Broadcast(eMsgEventId.UpdateAutoRecoverItemSpeed);
        (PlayerDataCenter.allEffectorData):OnUpdateItemGenerateSpeed() -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'
        ;
        (self.__broadcast).AutoRecoverItem = false
    end
end

PlayerBonus.AddPlayerBonusBroadcast = function(self, name)
    -- function num : 0_4
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

    (self.__broadcast)[name] = true
end

PlayerBonus.__GetUid = function(self, module, id)
    -- function num : 0_5
    return module << 32 | id
end

PlayerBonus.GetWarehouseCapcity = function(self, id)
    -- function num : 0_6 , upvalues : _ENV
    local bonusElem = (self.allBunosDataDic)[eLogicType.ResourceLimit]
    if bonusElem == nil then return 0 end
    return (bonusElem.totalData)[id]
end

PlayerBonus.GetFactoryPipelieCount = function(self)
    -- function num : 0_7 , upvalues : _ENV
    local bonusElem = (self.allBunosDataDic)[eLogicType.FactoryPipelie]
    if bonusElem == nil then return 0 end
    return bonusElem.totalData
end

PlayerBonus.GetGlobalExpCeiling = function(self)
    -- function num : 0_8 , upvalues : _ENV
    local bonusElem = (self.allBunosDataDic)[eLogicType.GlobalExpCeiling]
    if bonusElem == nil then return 0 end
    return bonusElem.totalData
end

PlayerBonus.GetStaminaCeiling = function(self)
    -- function num : 0_9 , upvalues : _ENV
    local bonusElem = (self.allBunosDataDic)[eLogicType.StaminaCeiling]
    if bonusElem == nil then return 0 end
    return bonusElem.totalData
end

PlayerBonus.GetStaminaOutput = function(self)
    -- function num : 0_10 , upvalues : _ENV
    local bonusElem = (self.allBunosDataDic)[eLogicType.StaminaOutput]
    if bonusElem == nil then return 0 end
    return bonusElem.totalData
end

PlayerBonus.GetResOutputEfficiency = function(self, id)
    -- function num : 0_11 , upvalues : _ENV
    local bonusElem = (self.allBunosDataDic)[eLogicType.ResOutputEfficiency]
    if bonusElem == nil then return 0 end
    return (bonusElem.totalData)[id]
end

PlayerBonus.GetBuildQueueCount = function(self, id)
    -- function num : 0_12 , upvalues : _ENV
    local bonusElem = (self.allBunosDataDic)[eLogicType.BuildQueue]
    if bonusElem == nil then return 0 end
    return (bonusElem.totalData)[id]
end

PlayerBonus.GetBuildSpeed = function(self)
    -- function num : 0_13 , upvalues : _ENV
    local bonusElem = (self.allBunosDataDic)[eLogicType.BuildSpeed]
    if bonusElem == nil then return 0 end
    return bonusElem.totalData
end

PlayerBonus.GetGlobalExpRatio = function(self)
    -- function num : 0_14 , upvalues : _ENV
    local bonusElem = (self.allBunosDataDic)[eLogicType.GlobalExpRatio]
    if bonusElem == nil then return 0 end
    return bonusElem.totalData
end

PlayerBonus.GetOverClock = function(self, id)
    -- function num : 0_15 , upvalues : _ENV
    local bonusElem = (self.allBunosDataDic)[eLogicType.OverClock]
    if bonusElem == nil then return 0 end
    return (bonusElem.totalData)[id]
end

PlayerBonus.GetOverClockFreeNum = function(self)
    -- function num : 0_16 , upvalues : _ENV
    local bonusElem = (self.allBunosDataDic)[eLogicType.OverClockFreeNum]
    if bonusElem == nil then return 0 end
    return bonusElem.totalData
end

PlayerBonus.GetFocusPointCeiling = function(self)
    -- function num : 0_17 , upvalues : _ENV
    local bonusElem = (self.allBunosDataDic)[eLogicType.FocusPointCeiling]
    if bonusElem == nil then return 0 end
    return bonusElem.totalData
end

PlayerBonus.GetBattleExpBonus = function(self)
    -- function num : 0_18 , upvalues : _ENV
    local bonusElem = (self.allBunosDataDic)[eLogicType.BattleExpBonus]
    if bonusElem == nil then return 0 end
    return bonusElem.totalData
end

PlayerBonus.GetDynSkillUpgrade = function(self)
    -- function num : 0_19 , upvalues : _ENV
    local bonusElem = (self.allBunosDataDic)[eLogicType.DynSkillUpgrade]
    if bonusElem == nil then return 0 end
    return bonusElem.totalData
end

PlayerBonus.GetHeroLevelCeiling = function(self)
    -- function num : 0_20 , upvalues : _ENV
    local bonusElem = (self.allBunosDataDic)[eLogicType.HeroLevelCeiling]
    if bonusElem == nil then return 0 end
    return bonusElem.totalData
end

PlayerBonus.GetAutoRecoverItemSpeed = function(self, id)
    -- function num : 0_21 , upvalues : _ENV
    local bonusElem = (self.allBunosDataDic)[eLogicType.AutoRecoverItem]
    if bonusElem == nil then return 0 end
    return (bonusElem.totalData)[id]
end

PlayerBonus.GetDungeonCountAdd = function(self, id)
    -- function num : 0_22 , upvalues : _ENV
    local bonusElem = (self.allBunosDataDic)[eLogicType.DungeonCountAdd]
    if bonusElem == nil then return 0 end
    return (bonusElem.totalData)[id]
end

PlayerBonus.GetFactoryEfficiency = function(self, id)
    -- function num : 0_23 , upvalues : _ENV
    local bonusElem = (self.allBunosDataDic)[eLogicType.FactoryEfficiency]
    if bonusElem == nil then return 0 end
    return (bonusElem.totalData)[id]
end

PlayerBonus.GetCtgrCampBuff = function(self, camp, attriId)
    -- function num : 0_24 , upvalues : _ENV
    local bonusElem = (self.allBunosDataDic)[eLogicType.CampBuff]
    if bonusElem == nil then return table.emptytable end
    local categoryValueDic = {}
    for uid, data in pairs(bonusElem.categoryDataDic) do
        if data[camp] ~= nil and (data[camp])[attriId] ~= nil then
            categoryValueDic[uid] = (data[camp])[attriId]
        end
    end
    return categoryValueDic
end

PlayerBonus.GetCtgrCareerBuff = function(self, career, attriId)
    -- function num : 0_25 , upvalues : _ENV
    local bonusElem = (self.allBunosDataDic)[eLogicType.CareerBuff]
    if bonusElem == nil then return table.emptytable end
    local categoryValueDic = {}
    for uid, data in pairs(bonusElem.categoryDataDic) do
        if data[career] ~= nil and (data[career])[attriId] ~= nil then
            categoryValueDic[uid] = (data[career])[attriId]
        end
    end
    return categoryValueDic
end

PlayerBonus.GetCtgrAllHeroBuff = function(self, attriId)
    -- function num : 0_26 , upvalues : _ENV
    local bonusElem = (self.allBunosDataDic)[eLogicType.AllHeroBuff]
    if bonusElem == nil then return table.emptytable end
    local categoryValueDic = {}
    for uid, data in pairs(bonusElem.categoryDataDic) do
        if data[attriId] ~= nil then
            categoryValueDic[uid] = data[attriId]
        end
    end
    return categoryValueDic
end

return PlayerBonus

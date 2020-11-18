-- params : ...
-- function num : 0 , upvalues : _ENV
local PlayerBonusElem = class("PlayerBonusElem")
local InitFunc1Para = function(self)
  -- function num : 0_0
  self.totalData = 0
end

local InitFunc2Para = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self.totalData = (table.GetDefaulValueTable)(0)
end

local InitFuncDic = {[eBuildingLogic.ResourceLimit] = function(self)
  -- function num : 0_2 , upvalues : InitFunc2Para
  InitFunc2Para(self)
end
, [eBuildingLogic.FactoryPipelie] = function(self)
  -- function num : 0_3 , upvalues : InitFunc1Para
  InitFunc1Para(self)
end
, [eBuildingLogic.GlobalExpCeiling] = function(self)
  -- function num : 0_4 , upvalues : InitFunc1Para
  InitFunc1Para(self)
end
, [eBuildingLogic.StaminaCeiling] = function(self)
  -- function num : 0_5 , upvalues : InitFunc1Para
  InitFunc1Para(self)
end
, [eBuildingLogic.StaminaOutput] = function(self)
  -- function num : 0_6 , upvalues : InitFunc1Para
  InitFunc1Para(self)
end
, [eBuildingLogic.ResOutputEfficiency] = function(self)
  -- function num : 0_7 , upvalues : InitFunc2Para
  InitFunc2Para(self)
end
, [eBuildingLogic.BuildQueue] = function(self)
  -- function num : 0_8 , upvalues : InitFunc2Para
  InitFunc2Para(self)
end
, [eBuildingLogic.BuildSpeed] = function(self)
  -- function num : 0_9 , upvalues : InitFunc1Para
  InitFunc1Para(self)
end
, [eBuildingLogic.GlobalExpRatio] = function(self)
  -- function num : 0_10 , upvalues : InitFunc1Para
  InitFunc1Para(self)
end
, [eBuildingLogic.OverClock] = function(self)
  -- function num : 0_11 , upvalues : InitFunc2Para
  InitFunc2Para(self)
end
, [eBuildingLogic.OverClockFreeNum] = function(self)
  -- function num : 0_12 , upvalues : InitFunc1Para
  InitFunc1Para(self)
end
, [eBuildingLogic.FocusPointCeiling] = function(self)
  -- function num : 0_13 , upvalues : InitFunc1Para
  InitFunc1Para(self)
end
, [eBuildingLogic.BattleExpBonus] = function(self)
  -- function num : 0_14 , upvalues : InitFunc1Para
  InitFunc1Para(self)
end
, [eBuildingLogic.DynSkillUpgrade] = function(self)
  -- function num : 0_15 , upvalues : InitFunc1Para
  InitFunc1Para(self)
end
}
local InstallFunc1Para = function(self, uid, para1, para2, para3)
  -- function num : 0_16
  local ori = (self.categoryDataDic)[uid]
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.categoryDataDic)[uid] = para1
  if ori ~= nil then
    self.totalData = self.totalData - ori
  end
  self.totalData = self.totalData + para1
end

local InstallFunc2Para = function(self, uid, para1, para2, para3)
  -- function num : 0_17
  local data = (self.categoryDataDic)[uid]
  if data == nil then
    data = {}
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.categoryDataDic)[uid] = data
  end
  local ori = data[para1] or 0
  data[para1] = para2
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

  if ori <= para2 then
    (self.totalData)[para1] = (self.totalData)[para1] + para2 - ori
  else
    local diff = ori - para2
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R8 in 'UnsetPending'

    if diff < (self.totalData)[para1] then
      (self.totalData)[para1] = (self.totalData)[para1] - diff
    else
      -- DECOMPILER ERROR at PC34: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self.totalData)[para1] = nil
    end
  end
end

local InstallFuncDic = {[eBuildingLogic.ResourceLimit] = function(self, uid, para1, para2, para3)
  -- function num : 0_18 , upvalues : InstallFunc2Para, _ENV
  InstallFunc2Para(self, uid, para1, para2, para3)
  ;
  (PlayerDataCenter.playerBonus):AddPlayerBonusBroadcast("warehouse")
end
, [eBuildingLogic.CampBuff] = function(self, uid, para1, para2, para3)
  -- function num : 0_19 , upvalues : _ENV
  local data = (self.categoryDataDic)[uid]
  if data == nil then
    data = {}
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.categoryDataDic)[uid] = data
  end
  if data[para1] == nil then
    data[para1] = {}
  end
  if (data[para1])[para2] ~= nil then
    (PlayerDataCenter.attributeBonus):RemoveCampBonus(para1, para2, (data[para1])[para2])
  end
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (data[para1])[para2] = para3
  ;
  (PlayerDataCenter.attributeBonus):AddCampBonus(para1, para2, para3)
end
, [eBuildingLogic.CareerBuff] = function(self, uid, para1, para2, para3)
  -- function num : 0_20 , upvalues : _ENV
  local data = (self.categoryDataDic)[uid]
  if data == nil then
    data = {}
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.categoryDataDic)[uid] = data
  end
  if data[para1] == nil then
    data[para1] = {}
  end
  if (data[para1])[para2] ~= nil then
    (PlayerDataCenter.attributeBonus):RemoveCareerBonus(para1, para2, (data[para1])[para2])
  end
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (data[para1])[para2] = para3
  ;
  (PlayerDataCenter.attributeBonus):AddCareerBonus(para1, para2, para3)
end
, [eBuildingLogic.FactoryPipelie] = function(self, uid, para1, para2, para3)
  -- function num : 0_21 , upvalues : InstallFunc1Para
  InstallFunc1Para(self, uid, para1, para2, para3)
end
, [eBuildingLogic.GlobalExpCeiling] = function(self, uid, para1, para2, para3)
  -- function num : 0_22 , upvalues : InstallFunc1Para
  InstallFunc1Para(self, uid, para1, para2, para3)
end
, [eBuildingLogic.StaminaCeiling] = function(self, uid, para1, para2, para3)
  -- function num : 0_23 , upvalues : InstallFunc1Para, _ENV
  InstallFunc1Para(self, uid, para1, para2, para3)
  ;
  (PlayerDataCenter.stamina):UpdateStaminaLogic()
  ;
  (PlayerDataCenter.playerBonus):AddPlayerBonusBroadcast("stamina")
end
, [eBuildingLogic.StaminaOutput] = function(self, uid, para1, para2, para3)
  -- function num : 0_24 , upvalues : InstallFunc1Para, _ENV
  InstallFunc1Para(self, uid, para1, para2, para3)
  ;
  (PlayerDataCenter.stamina):UpdateStaminaLogic()
  ;
  (PlayerDataCenter.playerBonus):AddPlayerBonusBroadcast("stamina")
end
, [eBuildingLogic.ResOutputEfficiency] = function(self, uid, para1, para2, para3)
  -- function num : 0_25 , upvalues : InstallFunc2Para
  InstallFunc2Para(self, uid, para1, para2, para3)
end
, [eBuildingLogic.BuildQueue] = function(self, uid, para1, para2, para3)
  -- function num : 0_26 , upvalues : InstallFunc2Para
  InstallFunc2Para(self, uid, para1, para2, para3)
end
, [eBuildingLogic.BuildSpeed] = function(self, uid, para1, para2, para3)
  -- function num : 0_27 , upvalues : InstallFunc1Para
  InstallFunc1Para(self, uid, para1, para2, para3)
end
, [eBuildingLogic.GlobalExpRatio] = function(self, uid, para1, para2, para3)
  -- function num : 0_28 , upvalues : InstallFunc1Para
  InstallFunc1Para(self, uid, para1, para2, para3)
end
, [eBuildingLogic.AllHeroBuff] = function(self, uid, para1, para2, para3)
  -- function num : 0_29 , upvalues : _ENV
  local data = (self.categoryDataDic)[uid]
  if data == nil then
    data = {}
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.categoryDataDic)[uid] = data
  end
  if data[para1] ~= nil then
    (PlayerDataCenter.attributeBonus):RemoveAllBonus(para1, data[para1])
  end
  data[para1] = para2
  ;
  (PlayerDataCenter.attributeBonus):AddAllBonus(para1, para2)
end
, [eBuildingLogic.OverClock] = function(self, uid, para1, para2, para3)
  -- function num : 0_30 , upvalues : InstallFunc2Para
  InstallFunc2Para(self, uid, para1, para2, para3)
end
, [eBuildingLogic.OverClockFreeNum] = function(self, uid, para1, para2, para3)
  -- function num : 0_31 , upvalues : InstallFunc1Para
  InstallFunc1Para(self, uid, para1, para2, para3)
end
, [eBuildingLogic.FocusPointCeiling] = function(self, uid, para1, para2, para3)
  -- function num : 0_32 , upvalues : InstallFunc1Para
  InstallFunc1Para(self, uid, para1, para2, para3)
end
, [eBuildingLogic.BattleExpBonus] = function(self, uid, para1, para2, para3)
  -- function num : 0_33 , upvalues : InstallFunc1Para
  InstallFunc1Para(self, uid, para1, para2, para3)
end
, [eBuildingLogic.DynSkillUpgrade] = function(self, uid, para1, para2, para3)
  -- function num : 0_34 , upvalues : InstallFunc1Para
  InstallFunc1Para(self, uid, para1, para2, para3)
end
}
local uninstallFunc1Para = function(self, uid)
  -- function num : 0_35 , upvalues : _ENV
  local data = (self.categoryDataDic)[uid]
  if data == nil then
    error((string.format)("No categoryData, uid = %s, logic = %s, module = %s, id = %s", self.logic, uid, uid >> 32, uid & CommonUtil.UInt32Max))
    return 
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.categoryDataDic)[uid] = nil
  self.totalData = (math.max)(0, self.totalData - data)
end

local uninstallFunc2Para = function(self, uid)
  -- function num : 0_36 , upvalues : _ENV
  local data = (self.categoryDataDic)[uid]
  if data == nil then
    error((string.format)("No categoryData, uid = %s, logic = %s, module = %s, id = %s", self.logic, uid, uid >> 32, uid & CommonUtil.UInt32Max))
    return 
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.categoryDataDic)[uid] = nil
  for k,v in pairs(data) do
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R8 in 'UnsetPending'

    if v < (self.totalData)[k] then
      (self.totalData)[k] = (self.totalData)[k] - v
    else
      -- DECOMPILER ERROR at PC34: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self.totalData)[k] = nil
    end
  end
end

local UninstallFuncDic = {[eBuildingLogic.ResourceLimit] = function(self, uid)
  -- function num : 0_37 , upvalues : uninstallFunc2Para, _ENV
  uninstallFunc2Para(self, uid)
  ;
  (PlayerDataCenter.playerBonus):AddPlayerBonusBroadcast("warehouse")
end
, [eBuildingLogic.CampBuff] = function(self, uid)
  -- function num : 0_38 , upvalues : _ENV
  local data = (self.categoryDataDic)[uid]
  if data == nil then
    error((string.format)("No categoryData, uid = %s, logic = %s, module = %s, id = %s", self.logic, uid, uid >> 32, uid & CommonUtil.UInt32Max))
    return 
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.categoryDataDic)[uid] = nil
  for para1,v in pairs(data) do
    for para2,para3 in pairs(v) do
      (PlayerDataCenter.attributeBonus):RemoveCampBonus(para1, para2, para3)
    end
  end
end
, [eBuildingLogic.CareerBuff] = function(self, uid)
  -- function num : 0_39 , upvalues : _ENV
  local data = (self.categoryDataDic)[uid]
  if data == nil then
    error((string.format)("No categoryData, uid = %s, logic = %s, module = %s, id = %s", self.logic, uid, uid >> 32, uid & CommonUtil.UInt32Max))
    return 
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.categoryDataDic)[uid] = nil
  for para1,v in pairs(data) do
    for para2,para3 in pairs(v) do
      (PlayerDataCenter.attributeBonus):RemoveCareerBonus(para1, para2, para3)
    end
  end
end
, [eBuildingLogic.FactoryPipelie] = function(self, uid)
  -- function num : 0_40 , upvalues : uninstallFunc1Para
  uninstallFunc1Para(self, uid)
end
, [eBuildingLogic.GlobalExpCeiling] = function(self, uid)
  -- function num : 0_41 , upvalues : uninstallFunc1Para
  uninstallFunc1Para(self, uid)
end
, [eBuildingLogic.StaminaCeiling] = function(self, uid)
  -- function num : 0_42 , upvalues : uninstallFunc1Para, _ENV
  uninstallFunc1Para(self, uid)
  ;
  (PlayerDataCenter.stamina):UpdateStaminaLogic()
  ;
  (PlayerDataCenter.playerBonus):AddPlayerBonusBroadcast("stamina")
end
, [eBuildingLogic.StaminaOutput] = function(self, uid)
  -- function num : 0_43 , upvalues : uninstallFunc1Para, _ENV
  uninstallFunc1Para(self, uid)
  ;
  (PlayerDataCenter.stamina):UpdateStaminaLogic()
  ;
  (PlayerDataCenter.playerBonus):AddPlayerBonusBroadcast("stamina")
end
, [eBuildingLogic.ResOutputEfficiency] = function(self, uid)
  -- function num : 0_44 , upvalues : uninstallFunc2Para
  uninstallFunc2Para(self, uid)
end
, [eBuildingLogic.BuildQueue] = function(self, uid)
  -- function num : 0_45 , upvalues : uninstallFunc2Para
  uninstallFunc2Para(self, uid)
end
, [eBuildingLogic.BuildSpeed] = function(self, uid)
  -- function num : 0_46 , upvalues : uninstallFunc1Para
  uninstallFunc1Para(self, uid)
end
, [eBuildingLogic.GlobalExpRatio] = function(self, uid)
  -- function num : 0_47 , upvalues : uninstallFunc1Para
  uninstallFunc1Para(self, uid)
end
, [eBuildingLogic.AllHeroBuff] = function(self, uid)
  -- function num : 0_48 , upvalues : _ENV
  local data = (self.categoryDataDic)[uid]
  if data == nil then
    error((string.format)("No categoryData, uid = %s, logic = %s, module = %s, id = %s", self.logic, uid, uid >> 32, uid & CommonUtil.UInt32Max))
    return 
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.categoryDataDic)[uid] = nil
  for para1,para2 in pairs(data) do
    (PlayerDataCenter.attributeBonus):RemoveAllBonus(para1, para2)
  end
end
, [eBuildingLogic.OverClock] = function(self, uid)
  -- function num : 0_49 , upvalues : uninstallFunc2Para
  uninstallFunc2Para(self, uid)
end
, [eBuildingLogic.OverClockFreeNum] = function(self, uid)
  -- function num : 0_50 , upvalues : uninstallFunc1Para
  uninstallFunc1Para(self, uid)
end
, [eBuildingLogic.FocusPointCeiling] = function(self, uid)
  -- function num : 0_51 , upvalues : uninstallFunc1Para
  uninstallFunc1Para(self, uid)
end
, [eBuildingLogic.BattleExpBonus] = function(self, uid)
  -- function num : 0_52 , upvalues : uninstallFunc1Para
  uninstallFunc1Para(self, uid)
end
, [eBuildingLogic.DynSkillUpgrade] = function(self, uid)
  -- function num : 0_53 , upvalues : uninstallFunc1Para
  uninstallFunc1Para(self, uid)
end
}
PlayerBonusElem.ctor = function(self)
  -- function num : 0_54
  self.categoryDataDic = {}
  self.totalData = nil
end

PlayerBonusElem.InitPlayerBonusElem = function(self, logic)
  -- function num : 0_55 , upvalues : InitFuncDic
  self.logic = logic
  local initFunc = InitFuncDic[logic]
  if initFunc == nil then
    return 
  end
  initFunc(self)
end

PlayerBonusElem.InstallBonus = function(self, uid, para1, para2, para3)
  -- function num : 0_56 , upvalues : InstallFuncDic
  local installFunc = InstallFuncDic[self.logic]
  if installFunc == nil then
    return 
  end
  installFunc(self, uid, para1, para2, para3)
end

PlayerBonusElem.UninstallBonus = function(self, uid)
  -- function num : 0_57 , upvalues : UninstallFuncDic
  local uninstallFunc = UninstallFuncDic[self.logic]
  if uninstallFunc == nil then
    return 
  end
  uninstallFunc(self, uid)
end

return PlayerBonusElem


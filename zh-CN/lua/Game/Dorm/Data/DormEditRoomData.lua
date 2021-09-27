local DormEditRoomData = class("DormEditRoomData")
local DormEnum = require("Game.Dorm.DormEnum")
local DormUtil = require("Game.Dorm.DormUtil")
DormEditRoomData.ResetStorateFntData = function(self)
  -- function num : 0_0 , upvalues : _ENV, DormUtil
  self.storageFntDic = {}
  self:__ResetBroadcastDiff()
  local fntItemDic = PlayerDataCenter:GetItemDicByType(eItemType.DormFurniture)
  local fntItemList = {}
  for id,v in pairs(fntItemDic) do
    if not (DormUtil.IsDmRoomDefaultDoorId)(id) then
      local storageFnt = self:__NewStorateFnt(id, v:GetCount())
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R9 in 'UnsetPending'

      if storageFnt ~= nil then
        (self.storageFntDic)[id] = storageFnt
      end
    end
  end
end

DormEditRoomData.__Add2Broadcast = function(self, storageFnt, isAdd)
  -- function num : 0_1 , upvalues : _ENV
  if isAdd == nil then
    isAdd = false
  end
  if not self._waitBroadDic then
    self._waitBroadDic = {}
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._waitBroadDic)[storageFnt] = isAdd
    if self._waitBroadcast == false then
      self._waitBroadcast = true
      if not self.__BroadcastDiffFunc then
        self.__BroadcastDiffFunc = BindCallback(self, self.__BroadcastDiff)
        TimerManager:AddLateCommand(self.__BroadcastDiffFunc)
      end
    end
  end
end

DormEditRoomData.__BroadcastDiff = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._waitBroadcast == false then
    return 
  end
  MsgCenter:Broadcast(eMsgEventId.DormRoomEditDataChange, self._waitBroadDic)
  self:__ResetBroadcastDiff()
end

DormEditRoomData.__ResetBroadcastDiff = function(self)
  -- function num : 0_3
  self._waitAddList = nil
  self._waitRemoveList = nil
  self._waitBroadcast = false
  self._waitBroadDic = nil
end

DormEditRoomData.InstallFntData = function(self, id)
  -- function num : 0_4
  local storageFnt = (self.storageFntDic)[id]
  if storageFnt ~= nil then
    storageFnt.count = storageFnt.count - 1
    self:__Add2Broadcast(storageFnt, false)
  end
end

DormEditRoomData.UninstallFntData = function(self, id)
  -- function num : 0_5
  local isAdd = false
  local storageFnt = (self.storageFntDic)[id]
  if storageFnt == nil then
    storageFnt = self:__NewStorateFnt(id, 1)
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'

    if storageFnt ~= nil then
      (self.storageFntDic)[id] = storageFnt
      isAdd = true
    end
  else
    storageFnt.count = storageFnt.count + 1
  end
  if storageFnt ~= nil then
    self:__Add2Broadcast(storageFnt, isAdd)
  end
end

DormEditRoomData.OnItemChange = function(self, itemUpdate, resourceData)
  -- function num : 0_6 , upvalues : _ENV
  if resourceData.backpack == nil then
    return 
  end
  for id,v in pairs((resourceData.backpack).updates) do
    local itemCfg = (ConfigData.item)[id]
    if itemCfg == nil then
      error("Cant get itemCfg, id = " .. tostring(id))
    else
      if itemCfg.type == eItemType.DormFurniture then
        local storageFnt = (self.storageFntDic)[id]
        local isAdd = false
        if storageFnt == nil then
          storageFnt = self:__NewStorateFnt(id, v.count)
          -- DECOMPILER ERROR at PC40: Confused about usage of register: R11 in 'UnsetPending'

          if storageFnt ~= nil then
            (self.storageFntDic)[id] = storageFnt
            isAdd = true
          end
        else
          storageFnt.count = v.count
        end
        self:__Add2Broadcast(storageFnt, isAdd)
      end
    end
  end
end

DormEditRoomData.__NewStorateFnt = function(self, id, count)
  -- function num : 0_7 , upvalues : _ENV
  local fntCfg = (ConfigData.dorm_furniture)[id]
  if fntCfg == nil then
    error("Can\'t find dorm_furniture cfg, id = " .. tostring(id))
    return 
  end
  local itemCfg = (ConfigData.item)[id]
  if itemCfg == nil then
    error("Can\'t find item cfg, id = " .. tostring(id))
    return 
  end
  local fnt = {id = id, fntCfg = fntCfg, itemCfg = itemCfg, count = count}
  return fnt
end

DormEditRoomData.GetFntWarehouseList = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local fntWarehouseList = {}
  for k,v in pairs(self.storageFntDic) do
    (table.insert)(fntWarehouseList, v)
  end
  return fntWarehouseList
end

local DefaultWallData = {id = 0, isDefaultDmFnt = true, name = ConfigData:GetTipContent(2012), 
fntCfg = {type = (DormEnum.eDormFntType).Wall}
, icon = "ICON_furniture_39"}
local DefaultFloorData = {id = 0, isDefaultDmFnt = true, name = ConfigData:GetTipContent(2013), 
fntCfg = {type = (DormEnum.eDormFntType).Floor}
, icon = "ICON_furniture_40"}
DormEditRoomData.GetFntWarehouseCatgList = function(self)
  -- function num : 0_9 , upvalues : DormEnum, _ENV, DefaultWallData, DefaultFloorData
  local fntCatgList = {}
  local fntList = {}
  fntCatgList[(DormEnum.eDormFntCategory).Wall] = fntList
  ;
  (table.insert)(fntList, DefaultWallData)
  local fntList = {}
  fntCatgList[(DormEnum.eDormFntCategory).Floor] = fntList
  ;
  (table.insert)(fntList, DefaultFloorData)
  for k,v in pairs(self.storageFntDic) do
    local catgId = (v.fntCfg).category
    if fntCatgList[catgId] == nil then
      fntCatgList[catgId] = {}
    end
    local fntList = fntCatgList[catgId]
    ;
    (table.insert)(fntList, v)
  end
  return fntCatgList
end

return DormEditRoomData


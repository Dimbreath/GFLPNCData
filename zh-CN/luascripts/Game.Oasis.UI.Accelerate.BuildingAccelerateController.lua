-- params : ...
-- function num : 0 , upvalues : _ENV
local BuildingAccelerateController = class("BuildingAccelerateController", ControllerBase)
local base = ControllerBase
local cs_MessageCommon = CS.MessageCommon
BuildingAccelerateController.ctor = function(self)
  -- function num : 0_0
  self.accItemDataDic = nil
  self.couldAcc = nil
  self.m_accItemList = nil
  self.OnItemChangeCallback = nil
end

BuildingAccelerateController.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._m_OnItemRefresh = BindCallback(self, self.m_OnItemRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self._m_OnItemRefresh)
  self:m_RefreshItemDataInfo()
end

BuildingAccelerateController.IsCouldAcc = function(self, time)
  -- function num : 0_2 , upvalues : _ENV
  self.m_accItemList = {}
  local totalTime = 0
  for itemId,data in pairs(self.accItemDataDic) do
    if time <= totalTime + data.accTime * data.num then
      local num = (math.ceil)((time - totalTime) / data.accTime)
      if data.num < num then
        error("cal error,accelerate num overflow")
        return false
      end
      ;
      (table.insert)(self.m_accItemList, {id = itemId, num = data.num, needNum = num})
      return true, self.m_accItemList
    else
      do
        do
          local needNum = (math.ceil)((time - totalTime) / data.accTime)
          totalTime = totalTime + data.accTime * data.num
          ;
          (table.insert)(self.m_accItemList, {id = itemId, num = data.num, needNum = needNum})
          -- DECOMPILER ERROR at PC59: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC59: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC59: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  return false, self.m_accItemList
end

BuildingAccelerateController.m_RefreshItemDataInfo = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self.accItemDataDic = {}
  for _,id in pairs(((ConfigData.item).growUpIds)[eItemActionType.BuildingAcc]) do
    local itemData = (PlayerDataCenter.itemDic)[id]
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R7 in 'UnsetPending'

    if itemData ~= nil then
      (self.accItemDataDic)[id] = {num = itemData:GetCount(), accTime = itemData:GetActionArg(1)}
    else
      local itemCfg = (ConfigData.item)[id]
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self.accItemDataDic)[id] = {num = 0, accTime = (itemCfg.arg)[1] or 0}
    end
  end
end

BuildingAccelerateController.m_OnItemRefresh = function(self)
  -- function num : 0_4
  self:m_RefreshItemDataInfo()
  if self.OnItemChangeCallback ~= nil then
    (self.OnItemChangeCallback)()
  end
end

BuildingAccelerateController.SetOnItemChangeCallback = function(self, OnItemChangeCallback)
  -- function num : 0_5
  self.OnItemChangeCallback = OnItemChangeCallback
end

BuildingAccelerateController.SendAccRequest = function(self, buildId, callback)
  -- function num : 0_6 , upvalues : _ENV
  local cost = {}
  for index,data in ipairs(self.m_accItemList) do
    if data.needNum <= data.num then
      cost[data.id] = data.needNum
    else
      cost[data.id] = data.num
    end
  end
  ;
  (NetworkManager:GetNetwork(NetworkTypeID.Building)):SendBuildingAccelerate(buildId, cost, callback)
end

BuildingAccelerateController.Delete = function(self)
  -- function num : 0_7 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self._m_OnItemRefresh)
end

return BuildingAccelerateController


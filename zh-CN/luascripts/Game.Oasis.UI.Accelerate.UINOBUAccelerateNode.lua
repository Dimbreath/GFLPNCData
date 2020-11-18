-- params : ...
-- function num : 0 , upvalues : _ENV
local UINOBUAccelerateNode = class("UINOBUAccelerateNode", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local UINOBUAccelerateItem = require("Game.Oasis.UI.Accelerate.UINOBUAccelerateItem")
UINOBUAccelerateNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINOBUAccelerateItem
  self.itemNums = {}
  self.second = 0
  self.accTime = 0
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.OnClickReturn)
  if (self.ui).btn_DoComplete ~= nil then
    (UIUtil.AddButtonListener)((self.ui).btn_DoComplete, self, self.OnClickConfirm)
  end
  self.accItemPool = (UIItemPool.New)(UINOBUAccelerateItem, (self.ui).materialItem)
  self.__refreshItem = BindCallback(self, self.RefreshItem)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__refreshItem)
end

UINOBUAccelerateNode.InitAccelerateNode = function(self, remainSecond, AccelerateEvent, buildingId, returnFunc)
  -- function num : 0_1 , upvalues : _ENV
  self:UpdateAccItem()
  self.second = remainSecond
  self.AccelerateEvent = AccelerateEvent
  self.buildingId = buildingId
  self.returnFunc = returnFunc
  local totalTimeText = TimestampToTime(remainSecond)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_UpdateTime).text = totalTimeText
  local totalTime = self:_CalAddTime()
  for _,item in ipairs((self.accItemPool).listItem) do
    item:SetAddTimeLimt(self.second - totalTime)
  end
  self:AutoAdd(remainSecond)
end

UINOBUAccelerateNode.UpdateWithData = function(self, currentLevl, nextLevel)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).curLvlnum1).text = tostring(currentLevl // 10)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).curLvlnum2).text = tostring(currentLevl % 10)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).nxtLvlnum1).text = tostring(nextLevel // 10)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).nxtLvlnum2).text = tostring(nextLevel % 10)
end

UINOBUAccelerateNode.UpdateTime = function(self, second)
  -- function num : 0_3 , upvalues : _ENV
  if not second then
    self.second = self.second
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_UpdateTime).text = TimestampToTime(self.second)
  end
end

UINOBUAccelerateNode.RefreshItem = function(self)
  -- function num : 0_4
  self:UpdateAccItem()
  self:CalAndShowTime()
end

UINOBUAccelerateNode.UpdateAccItem = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (self.accItemPool):HideAll()
  for _,id in ipairs(((ConfigData.item).growUpIds)[eItemActionType.BuildingAcc]) do
    if (PlayerDataCenter.itemDic)[id] ~= nil then
      local itemData = (PlayerDataCenter.itemDic)[id]
      do
        local item = (self.accItemPool):GetOne(true)
        item:InitItem(itemData, function(num, notCal)
    -- function num : 0_5_0 , upvalues : self, itemData
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

    (self.itemNums)[itemData] = num
    if not notCal then
      self:CalAndShowTime()
    end
  end
)
      end
    else
      do
        do
          local item = (self.accItemPool):GetOne(true)
          item:InitEmptyItem(id)
          -- DECOMPILER ERROR at PC37: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC37: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC37: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

UINOBUAccelerateNode.CalAndShowTime = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local totalTime = self:_CalAddTime()
  for _,item in ipairs((self.accItemPool).listItem) do
    item:SetAddTimeLimt(self.second - totalTime)
  end
  if totalTime >= 0 then
    self.accTime = totalTime
  end
  self:UpdateTime()
end

UINOBUAccelerateNode._CalAddTime = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local totalTime = 0
  for itemData,num in pairs(self.itemNums) do
    totalTime = totalTime + itemData:GetActionArg(1) * num
  end
  return totalTime
end

UINOBUAccelerateNode.AutoFitNum = function(self, second)
  -- function num : 0_8 , upvalues : _ENV
  local overflowTime = self:_CalAddTime() - second
  if overflowTime <= 0 then
    return 
  end
  for _,item in ipairs((self.accItemPool).listItem) do
    if item.time < overflowTime then
      local itemNum = (math.floor)(overflowTime / item.time)
      item:SetSelectNum(item.selectedNum - itemNum)
      overflowTime = overflowTime - itemNum * item.time
    end
  end
end

UINOBUAccelerateNode.AutoAdd = function(self, second)
  -- function num : 0_9 , upvalues : _ENV
  if second == nil or second < 0 then
    return 
  end
  local totalTime = 0
  for _,item in ipairs((self.accItemPool).listItem) do
    if second < totalTime + item.time * item.itemNum then
      local num = (math.ceil)((second - totalTime) / item.time)
      item:SetSelectNum(item.itemNum, num)
      totalTime = totalTime + num * item.time
      self.finalItemNum = num
    else
      do
        do
          local num = (math.ceil)(second / item.time)
          item:SetSelectNum(item.itemNum, num)
          totalTime = totalTime + item.itemNum * item.time
          self.finalItemNum = (math.ceil)(second / item.time)
          -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  self:UpdateTime()
end

UINOBUAccelerateNode.CleanAll = function(self, notCal)
  -- function num : 0_10 , upvalues : _ENV
  for _,item in ipairs((self.accItemPool).listItem) do
    item:CleanAll(notCal)
  end
  for itemData,_ in pairs(self.itemNums) do
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R7 in 'UnsetPending'

    (self.itemNums)[itemData] = 0
  end
end

UINOBUAccelerateNode.OnClickConfirm = function(self)
  -- function num : 0_11 , upvalues : _ENV, cs_MessageCommon
  if (table.count)(self.itemNums) == 0 then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.CanFitAccBuild))
    return 
  end
  self:AutoFitNum(self.second)
  if self.accTime < self.second then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.CanFitAccBuild))
    return 
  end
  local itemTab = {}
  for itemData,num in pairs(self.itemNums) do
    if num > 0 then
      itemTab[itemData.dataId] = num
    end
  end
  if (table.count)(itemTab) == 0 then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.CanFitAccBuild))
    return 
  end
  if self.AccelerateEvent ~= nil then
    (self.AccelerateEvent)(self.buildingId, itemTab)
  end
  self:CleanAll(true)
end

UINOBUAccelerateNode.OnClickReturn = function(self)
  -- function num : 0_12
  if self.returnFunc ~= nil then
    (self.returnFunc)()
  end
  self:Hide()
end

UINOBUAccelerateNode.OnHide = function(self)
  -- function num : 0_13
  if self.returnFunc ~= nil then
    (self.returnFunc)()
  end
end

UINOBUAccelerateNode.OnDelete = function(self)
  -- function num : 0_14 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__refreshItem)
  if self.accItemPool ~= nil then
    (self.accItemPool):DeleteAll()
    self.accItemPool = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINOBUAccelerateNode


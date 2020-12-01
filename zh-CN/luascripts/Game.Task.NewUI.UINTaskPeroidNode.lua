-- params : ...
-- function num : 0 , upvalues : _ENV
local UINTaskPeroidNode = class("UINTaskPeroidNode", UIBaseWindow)
local base = UIBaseWindow
local UINTaskPeroidNodeItem = require("Game.Task.NewUI.UINTaskPeroidNodeItem")
local TaskEnum = require("Game.Task.TaskEnum")
local UINTaskViewReward = require("Game.Task.NewUI.UINTaskViewReward")
local cs_DoTween = ((CS.DG).Tweening).DOTween
UINTaskPeroidNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINTaskPeroidNodeItem, UINTaskViewReward
  self.itemNum = 0
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.peroidItemPool = (UIItemPool.New)(UINTaskPeroidNodeItem, (self.ui).obj_peroidItem)
  ;
  ((self.ui).obj_peroidItem):SetActive(false)
  self.viewReward = (UINTaskViewReward.New)()
  ;
  (self.viewReward):Init((self.ui).viewReward)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).col_processColor = ((self.ui).img_Process).color
end

UINTaskPeroidNode.RefreshPeroid = function(self, peroidId, peroidDatas)
  -- function num : 0_1 , upvalues : _ENV, TaskEnum
  self.itemNum = #peroidDatas
  local unitRate = 1 / (self.itemNum * 2 - 1)
  local needPoint = nil
  local pointId = ((peroidDatas[1]).stcData).activeId
  local currActiveNum = PlayerDataCenter:GetItemCount(pointId)
  local remaindActiveNum = currActiveNum
  local totalActiveNum = 0
  local fitNum = 0
  ;
  (self.peroidItemPool):HideAll()
  for index,data in ipairs(peroidDatas) do
    totalActiveNum = totalActiveNum + (data.stcData).activeNum
    local item = (self.peroidItemPool):GetOne()
    if data.stateType == (TaskEnum.eTaskState).Completed or data.stateType == (TaskEnum.eTaskState).Picked then
      fitNum = fitNum + 1
      remaindActiveNum = remaindActiveNum - (data.stcData).activeNum
    else
      if data.stateType == (TaskEnum.eTaskState).InProgress and needPoint == nil then
        needPoint = (data.stcData).activeNum
      end
    end
    local itemCfg, num = self:__GetHightestValueItemCfg((data.stcData).rewardIds, (data.stcData).rewardNums)
    item:InitPeroidItem(index, data.stateType, totalActiveNum, itemCfg, num, self.viewReward, data)
  end
  -- DECOMPILER ERROR at PC76: Confused about usage of register: R10 in 'UnsetPending'

  ;
  ((self.ui).tex_CurPoint).text = tostring(currActiveNum)
  -- DECOMPILER ERROR at PC84: Confused about usage of register: R10 in 'UnsetPending'

  ;
  ((self.ui).tex_TotalPoint).text = "/" .. tostring(totalActiveNum)
  local fillValue = 0
  if needPoint == nil then
    fillValue = unitRate * ((fitNum) * 2 - 1)
  else
    if fitNum == 0 then
      fillValue = unitRate * ((remaindActiveNum) / needPoint)
    else
      fillValue = unitRate * ((fitNum) * 2 - 1) + 2 * unitRate * ((remaindActiveNum) / needPoint)
    end
  end
  if self.peroidId ~= peroidId then
    if self.processSeq ~= nil then
      (self.processSeq):Kill()
    end
    -- DECOMPILER ERROR at PC115: Confused about usage of register: R11 in 'UnsetPending'

    ;
    ((self.ui).img_Process).fillAmount = fillValue
    -- DECOMPILER ERROR at PC120: Confused about usage of register: R11 in 'UnsetPending'

    ;
    ((self.ui).img_Process).color = (self.ui).col_processColor
    self.peroidId = peroidId
  else
    self:SetProcessTween(fillValue, 0.8)
  end
  local peroidTypeIndex = 0
  if peroidId == (TaskEnum.eTaskType).WeeklyTask then
    peroidTypeIndex = 1
  end
  ;
  ((self.ui).tex_peroidType):SetIndex(peroidTypeIndex)
  self:LayOutItems()
end

UINTaskPeroidNode.LayOutItems = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local startPos = ((self.ui).pointStart).position
  local endPos = ((self.ui).pointEnd).position
  local length = endPos.x - startPos.x
  local unitLength = length / (self.itemNum * 2 - 1)
  for i,item in ipairs((self.peroidItemPool).listItem) do
    local pos = (item.transform).position
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (item.transform).position = (Vector3.New)(startPos.x + unitLength * (2 * i - 1), pos.y, pos.z)
  end
end

UINTaskPeroidNode.__GetHightestValueItemCfg = function(self, idList, numList)
  -- function num : 0_3 , upvalues : _ENV
  local itemCfgs = {}
  for index,id in ipairs(idList) do
    (table.insert)(itemCfgs, {cfg = (ConfigData.item)[id], num = numList[index]})
  end
  ;
  (table.sort)(itemCfgs, function(a, b)
    -- function num : 0_3_0
    if (a.cfg).price >= (b.cfg).price then
      do return a.quality ~= b.quality end
      do return (a.cfg).quality < (b.cfg).quality end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  return (itemCfgs[1]).cfg, (itemCfgs[1]).num
end

UINTaskPeroidNode.SetProcessTween = function(self, setValue, duration)
  -- function num : 0_4 , upvalues : _ENV, cs_DoTween
  if setValue <= 0 then
    return 
  end
  local isComplete = (ControllerManager:GetController(ControllerTypeId.Task)):IsDailyCompleteToRefresh()
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

  if not isComplete then
    ((self.ui).img_Process).fillAmount = setValue
  else
    if self.processSeq ~= nil then
      (self.processSeq):Kill()
    end
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).img_Process).color = Color.white
    self.processSeq = (cs_DoTween.Sequence)()
    ;
    (self.processSeq):Append(((self.ui).img_Process):DOFillAmount(setValue, duration))
    ;
    (self.processSeq):Join((((self.ui).img_Process):DOColor((self.ui).col_processColor, 0.2)):SetLoops(5))
    ;
    (self.processSeq):SetAutoKill(false)
  end
end

UINTaskPeroidNode.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  if self.processSeq ~= nil then
    (self.processSeq):Kill()
    self.processSeq = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINTaskPeroidNode

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINTaskPeroidNode = class("UINTaskPeroidNode", UIBaseWindow)
local base = UIBaseWindow
local UINTaskPeroidNodeItem = require("Game.Task.NewUI.UINTaskPeroidNodeItem")
local TaskEnum = require("Game.Task.TaskEnum")
local UINTaskViewReward = require("Game.Task.NewUI.UINTaskViewReward")
local cs_DoTween = ((CS.DG).Tweening).DOTween
UINTaskPeroidNode.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINTaskPeroidNodeItem, UINTaskViewReward
    self.itemNum = 0;
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self.peroidItemPool = (UIItemPool.New)(UINTaskPeroidNodeItem,
                                           (self.ui).obj_peroidItem);
    ((self.ui).obj_peroidItem):SetActive(false)
    self.viewReward = (UINTaskViewReward.New)();
    (self.viewReward):Init((self.ui).viewReward) -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'
    ;
    (self.ui).col_processColor = ((self.ui).img_Process).color
end

UINTaskPeroidNode.RefreshPeroid = function(self, peroidId, peroidDatas)
    -- function num : 0_1 , upvalues : _ENV, TaskEnum
    self.itemNum = #peroidDatas
    local unitRate = 1 / (self.itemNum * 2 - 1)
    local needPoint = nil
    local pointId = ((peroidDatas[1]).stcData).activeId
    local currActiveNum = PlayerDataCenter:GetItemCount(pointId)
    local remaindActiveNum = currActiveNum
    local totalActiveNum = 0
    local fitNum = 0;
    (self.peroidItemPool):HideAll()
    for index, data in ipairs(peroidDatas) do
        totalActiveNum = totalActiveNum + (data.stcData).activeNum
        local item = (self.peroidItemPool):GetOne()
        if data.stateType == (TaskEnum.eTaskState).Completed or data.stateType ==
            (TaskEnum.eTaskState).Picked then
            fitNum = fitNum + 1
            remaindActiveNum = remaindActiveNum - (data.stcData).activeNum
        else
            if data.stateType == (TaskEnum.eTaskState).InProgress and needPoint ==
                nil then needPoint = (data.stcData).activeNum end
        end
        local itemCfg, num = self:__GetHightestValueItemCfg(
                                 (data.stcData).rewardIds,
                                 (data.stcData).rewardNums)
        item:InitPeroidItem(index, data.stateType, totalActiveNum, itemCfg, num,
                            self.viewReward, data)
    end -- DECOMPILER ERROR at PC76: Confused about usage of register: R10 in 'UnsetPending'
    
    ((self.ui).tex_CurPoint).text = tostring(currActiveNum) -- DECOMPILER ERROR at PC84: Confused about usage of register: R10 in 'UnsetPending'
    ;
    ((self.ui).tex_TotalPoint).text = "/" .. tostring(totalActiveNum)
    local fillValue = 0
    if needPoint == nil then
        fillValue = unitRate * ((fitNum) * 2 - 1)
    else
        if fitNum == 0 then
            fillValue = unitRate * ((remaindActiveNum) / needPoint)
        else
            fillValue = unitRate * ((fitNum) * 2 - 1) + 2 * unitRate *
                            ((remaindActiveNum) / needPoint)
        end
    end
    if self.peroidId ~= peroidId then
        if self.processSeq ~= nil then (self.processSeq):Kill() end -- DECOMPILER ERROR at PC115: Confused about usage of register: R11 in 'UnsetPending'
        
        ((self.ui).img_Process).fillAmount = fillValue -- DECOMPILER ERROR at PC120: Confused about usage of register: R11 in 'UnsetPending'
        ;
        ((self.ui).img_Process).color = (self.ui).col_processColor
        self.peroidId = peroidId
    else
        self:SetProcessTween(fillValue, 0.8)
    end
    local peroidTypeIndex = 0
    if peroidId == (TaskEnum.eTaskType).WeeklyTask then peroidTypeIndex = 1 end
    ((self.ui).tex_peroidType):SetIndex(peroidTypeIndex)
    self:LayOutItems()
end

UINTaskPeroidNode.LayOutItems = function(self)
    -- function num : 0_2 , upvalues : _ENV
    local startPos = ((self.ui).pointStart).position
    local endPos = ((self.ui).pointEnd).position
    local length = endPos.x - startPos.x
    local unitLength = length / (self.itemNum * 2 - 1)
    for i, item in ipairs((self.peroidItemPool).listItem) do
        local pos = (item.transform).position -- DECOMPILER ERROR at PC31: Confused about usage of register: R11 in 'UnsetPending'
        ;
        (item.transform).position = (Vector3.New)(
                                        startPos.x + unitLength * (2 * i - 1),
                                        pos.y, pos.z)
    end
end

UINTaskPeroidNode.__GetHightestValueItemCfg =
    function(self, idList, numList)
        -- function num : 0_3 , upvalues : _ENV
        local itemCfgs = {}
        for index, id in ipairs(idList) do
            (table.insert)(itemCfgs,
                           {cfg = (ConfigData.item)[id], num = numList[index]})
        end
        (table.sort)(itemCfgs, function(a, b)
            -- function num : 0_3_0
            if (a.cfg).price >= (b.cfg).price then
                do return a.quality ~= b.quality end
                do return (a.cfg).quality < (b.cfg).quality end
                -- DECOMPILER ERROR: 4 unprocessed JMP targets
            end
        end)
        return (itemCfgs[1]).cfg, (itemCfgs[1]).num
    end

UINTaskPeroidNode.SetProcessTween = function(self, setValue, duration)
    -- function num : 0_4 , upvalues : _ENV, cs_DoTween
    if setValue <= 0 then return end
    local isComplete =
        (ControllerManager:GetController(ControllerTypeId.Task)):IsDailyCompleteToRefresh()
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

    if not isComplete then
        ((self.ui).img_Process).fillAmount = setValue
    else
        if self.processSeq ~= nil then (self.processSeq):Kill() end -- DECOMPILER ERROR at PC26: Confused about usage of register: R4 in 'UnsetPending'
        
        ((self.ui).img_Process).color = Color.white
        self.processSeq = (cs_DoTween.Sequence)();
        (self.processSeq):Append(((self.ui).img_Process):DOFillAmount(setValue,
                                                                      duration));
        (self.processSeq):Join((((self.ui).img_Process):DOColor(
                                   (self.ui).col_processColor, 0.2)):SetLoops(5));
        (self.processSeq):SetAutoKill(false)
    end
end

UINTaskPeroidNode.OnDelete = function(self)
    -- function num : 0_5 , upvalues : base
    if self.processSeq ~= nil then
        (self.processSeq):Kill()
        self.processSeq = nil
    end
    (base.OnDelete)(self)
end

return UINTaskPeroidNode


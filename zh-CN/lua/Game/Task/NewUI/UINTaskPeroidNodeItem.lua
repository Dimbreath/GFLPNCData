local UINTaskPeroidNodeItem = class("UINTaskPeroidNodeItem", UIBaseNode)
local base = UIBaseNode
local TaskEnum = require("Game.Task.TaskEnum")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
UINTaskPeroidNodeItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItem
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Task)
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.closeViewState = BindCallback(self, self.SetViewState, false)
  self.baseItem = (UINBaseItem.New)()
  ;
  (self.baseItem):Init((self.ui).uINBaseItem)
  self._OnClick = BindCallback(self, self.OnClick)
end

UINTaskPeroidNodeItem.InitPeroidItem = function(self, index, eTaskState, point, itemCfg, num, viewReward, data)
  -- function num : 0_1 , upvalues : TaskEnum, _ENV
  self.data = data
  self.index = index
  self.eTaskState = eTaskState
  ;
  (self.baseItem):InitBaseItem(itemCfg, self._OnClick, nil, (TaskEnum.eTaskState).Completed < self.eTaskState)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).tex_Point).text = tostring(point)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).tex_Count).text = tostring(num)
  self.viewReward = viewReward
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).img_trangle).color = (self.ui).color_black
  ;
  ((self.ui).obj_isPicked):SetActive(false)
  local canPick = false
  self:SetRedDotActive(false)
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R9 in 'UnsetPending'

  if eTaskState == (TaskEnum.eTaskState).Completed then
    ((self.ui).img_trangle).color = (self.ui).color_oragnge
    canPick = true
    self:SetRedDotActive(true)
  else
    -- DECOMPILER ERROR at PC65: Confused about usage of register: R9 in 'UnsetPending'

    if eTaskState == (TaskEnum.eTaskState).Picked then
      ((self.ui).img_trangle).color = (self.ui).color_oragnge
      ;
      ((self.ui).obj_isPicked):SetActive(true)
      self:SetRedDotActive(false)
    end
  end
  if ((self.ui).obj_canPick).activeInHierarchy ~= canPick then
    ((self.ui).obj_canPick):SetActive(canPick)
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UINTaskPeroidNodeItem.OnClick = function(self)
  -- function num : 0_2 , upvalues : TaskEnum, HAType, VAType, _ENV
  if self.eTaskState == (TaskEnum.eTaskState).Completed then
    (self.ctrl):SendCommitTaskPeriod(self.index, (self.ctrl).showingActiveType)
    ;
    (self.baseItem):CloseGreatRewardLoopFx()
  else
    ;
    (self.viewReward):Show()
    ;
    (self.viewReward):FloatTo(self.transform, HAType.autoCenter, VAType.up)
    ;
    (self.viewReward):RefreshItems(((self.data).stcData).rewardIds, ((self.data).stcData).rewardNums, self.closeViewState)
    self:SetViewState(true)
    AudioManager:PlayAudioById(1055)
  end
end

UINTaskPeroidNodeItem.SetViewState = function(self, bool)
  -- function num : 0_3
  ((self.ui).obj_viewState):SetActive(bool)
end

UINTaskPeroidNodeItem.SetRedDotActive = function(self, bool)
  -- function num : 0_4
  ((self.ui).obj_RedDot):SetActive(bool)
end

UINTaskPeroidNodeItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINTaskPeroidNodeItem


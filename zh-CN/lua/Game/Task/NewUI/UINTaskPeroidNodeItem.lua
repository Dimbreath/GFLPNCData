local UINTaskPeroidNodeItem = class("UINTaskPeroidNodeItem", UIBaseNode)
local base = UIBaseNode
local TaskEnum = require("Game.Task.TaskEnum")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
UINTaskPeroidNodeItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Task)
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.closeViewState = BindCallback(self, self.SetViewState, false)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Item, self, self.OnClick)
end

UINTaskPeroidNodeItem.InitPeroidItem = function(self, index, eTaskState, point, itemCfg, num, viewReward, data)
  -- function num : 0_1 , upvalues : _ENV, TaskEnum
  self.data = data
  self.index = index
  self.eTaskState = eTaskState
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).tex_Point).text = tostring(point)
  self.viewReward = viewReward
  self.isPicked = eTaskState == (TaskEnum.eTaskState).Picked
  local canPick = eTaskState == (TaskEnum.eTaskState).Completed
  ;
  ((self.ui).obj_isPicked):SetActive(false)
  ;
  ((self.ui).obj_fx):SetActive(false)
  self:SetRedDotActive(false)
  self:SetViewState(false)
  ;
  ((self.ui).img_RewardState):SetIndex(eTaskState == (TaskEnum.eTaskState).Picked and 1 or 0)
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).tex_Point).color = ((self.ui).stateColors)[eTaskState]
  if eTaskState == (TaskEnum.eTaskState).Completed then
    self:SetRedDotActive(true)
  elseif eTaskState == (TaskEnum.eTaskState).Picked then
    ((self.ui).obj_isPicked):SetActive(true)
    self:SetRedDotActive(false)
  end
  if ((self.ui).obj_fx).activeInHierarchy ~= canPick then
    ((self.ui).obj_fx):SetActive(canPick)
  end
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

UINTaskPeroidNodeItem.OnClick = function(self)
  -- function num : 0_2 , upvalues : TaskEnum, HAType, VAType, _ENV
  if self.eTaskState == (TaskEnum.eTaskState).Completed then
    (self.ctrl):SendCommitTaskPeriod(self.index, (self.ctrl).showingActiveType)
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
  if self.isPicked then
    ((self.ui).obj_isPicked):SetActive(not bool)
  end
end

UINTaskPeroidNodeItem.SetRedDotActive = function(self, bool)
  -- function num : 0_4
  ((self.ui).obj_redDot):SetActive(bool)
end

UINTaskPeroidNodeItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINTaskPeroidNodeItem


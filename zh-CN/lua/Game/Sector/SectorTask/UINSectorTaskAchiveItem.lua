local UINSectorTaskAchiveItem = class("UINSectorTaskAchiveItem", UIBaseNode)
local base = UIBaseNode
local TaskEnum = require("Game.Task.TaskEnum")
UINSectorTaskAchiveItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.isPicking = false
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).rewardItem, self, self.__OnBtnClick)
end

UINSectorTaskAchiveItem.InitSectorTaskAchiveItem = function(self, index, state, iconIndex, pointCount, onClickFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.index = index
  self.state = state
  self.onClickFunc = onClickFunc
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Point).text = tostring(pointCount)
  ;
  ((self.ui).imgInfo_Icon):SetIndex(iconIndex)
  ;
  ((self.ui).obj_viewState):SetActive(false)
  ;
  ((self.ui).obj_isPicked):SetActive(false)
  ;
  ((self.ui).obj_redDot):SetActive(false)
  self:__RefreshItemStateUI()
end

UINSectorTaskAchiveItem.__RefreshItemStateUI = function(self)
  -- function num : 0_2 , upvalues : TaskEnum
  ;
  ((self.ui).rewardStateImg):SetIndex(self.state == (TaskEnum.eTaskState).Picked and 1 or 0)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Point).color = ((self.ui).stateColor)[self.state]
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_Point).color = ((self.ui).stateColor)[self.state]
  local isCompleted = self.state == (TaskEnum.eTaskState).Completed
  self.isPicked = self.state == (TaskEnum.eTaskState).Picked
  ;
  ((self.ui).fx_go):SetActive(isCompleted)
  ;
  ((self.ui).obj_redDot):SetActive(isCompleted)
  ;
  ((self.ui).obj_isPicked):SetActive(self.isPicked)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINSectorTaskAchiveItem.SetPicking = function(self, flag)
  -- function num : 0_3
  self.isPicking = flag
end

UINSectorTaskAchiveItem.SetViewState = function(self, active)
  -- function num : 0_4
  ((self.ui).obj_viewState):SetActive(active)
  if self.isPicked then
    ((self.ui).obj_isPicked):SetActive(not active)
  end
end

UINSectorTaskAchiveItem.__OnBtnClick = function(self)
  -- function num : 0_5
  if self.isPicking then
    return 
  end
  if self.onClickFunc then
    (self.onClickFunc)(self, self.index)
  end
end

UINSectorTaskAchiveItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UINSectorTaskAchiveItem


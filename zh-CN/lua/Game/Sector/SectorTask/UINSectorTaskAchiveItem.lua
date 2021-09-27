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
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

  if self.state ~= (TaskEnum.eTaskState).Picked or not (self.ui).col_pickedIcon then
    ((self.ui).img_reward).color = (self.ui).col_norIcon
    ;
    ((self.ui).fx_go):SetActive(self.state == (TaskEnum.eTaskState).Completed)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
end

UINSectorTaskAchiveItem.SetPicking = function(self, flag)
  -- function num : 0_3
  self.isPicking = flag
end

UINSectorTaskAchiveItem.__OnBtnClick = function(self)
  -- function num : 0_4
  if self.isPicking then
    return 
  end
  if self.onClickFunc then
    (self.onClickFunc)(self, self.index)
  end
end

UINSectorTaskAchiveItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINSectorTaskAchiveItem


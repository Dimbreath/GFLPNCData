local UIActivityStarUpPre = class("UIActivityStarUpPre", UIBaseWindow)
local base = UIBaseWindow
local UINActivityStarUpPreItem = require("Game.ActivityStarUp.UI.UINActivityStarUpPreItem")
UIActivityStarUpPre.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.__OnCloseFunc)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Bg, self, self.__OnCloseFunc)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scroll_preview).onInstantiateItem = BindCallback(self, self.OnInstantiateItem)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scroll_preview).onChangeItem = BindCallback(self, self.OnTaskChangeItem)
  self.taskItemDic = {}
end

UIActivityStarUpPre.InitView = function(self, activityInfo)
  -- function num : 0_1 , upvalues : _ENV
  self.activityInfo = activityInfo
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).scroll_preview).totalCount = #((self.activityInfo).cfg).phase
  ;
  ((self.ui).scroll_preview):RefillCells()
  if (self.activityInfo).curStageId == nil or not (self.activityInfo).curStageId then
    local index = #((self.activityInfo).cfg).phase
  end
  ;
  ((self.ui).scroll_preview):SrollToCell(index - 1, 0)
  ;
  (UIUtil.HideTopStatus)()
end

UIActivityStarUpPre.OnInstantiateItem = function(self, go)
  -- function num : 0_2 , upvalues : UINActivityStarUpPreItem
  local item = (UINActivityStarUpPreItem.New)()
  item:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.taskItemDic)[go] = item
end

UIActivityStarUpPre.OnTaskChangeItem = function(self, go, index)
  -- function num : 0_3
  ((self.taskItemDic)[go]):InitItem(self.activityInfo, index + 1)
end

UIActivityStarUpPre.__OnCloseFunc = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (UIUtil.ReShowTopStatus)()
  self:Delete()
end

return UIActivityStarUpPre


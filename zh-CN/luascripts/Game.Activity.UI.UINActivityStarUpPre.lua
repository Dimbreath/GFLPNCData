-- params : ...
-- function num : 0 , upvalues : _ENV
local UINActivityStarUpPre = class("UINActivityStarUpPre", UIBaseNode)
local base = UIBaseNode
local UINActivityStarUpPreItem = require("Game.Activity.UI.UINActivityStarUpPreItem")
UINActivityStarUpPre.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnClickClose)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scroll_preview).onInstantiateItem = BindCallback(self, self.OnInstantiateItem)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scroll_preview).onChangeItem = BindCallback(self, self.OnTaskChangeItem)
  self.taskItemDic = {}
end

UINActivityStarUpPre.InitView = function(self, activityInfo)
  -- function num : 0_1
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
end

UINActivityStarUpPre.OnInstantiateItem = function(self, go)
  -- function num : 0_2 , upvalues : UINActivityStarUpPreItem
  local item = (UINActivityStarUpPreItem.New)()
  item:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.taskItemDic)[go] = item
end

UINActivityStarUpPre.OnTaskChangeItem = function(self, go, index)
  -- function num : 0_3
  ((self.taskItemDic)[go]):InitItem(self.activityInfo, index + 1)
end

UINActivityStarUpPre.OnClickClose = function(self)
  -- function num : 0_4
  (self.gameObject):SetActive(false)
end

return UINActivityStarUpPre


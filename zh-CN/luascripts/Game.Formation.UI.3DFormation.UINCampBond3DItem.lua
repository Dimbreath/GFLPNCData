-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCampBond3DItem = class("UINCampBond3DItem", UIBaseNode)
local base = UIBaseNode
UINCampBond3DItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINCampBond3DItem.InitCampBond3DItem = function(self, campId, count)
  -- function num : 0_1 , upvalues : _ENV
  ((self.ui).imgItemInfo):SetIndex(campId - 1)
  local maxCount = 0
  for k,v in pairs((ConfigData.camp_connection)[campId]) do
    maxCount = (math.max)(v.fetters_num, maxCount)
  end
  ;
  ((self.ui).tex_HreoCount):SetIndex(0, tostring(count), tostring(maxCount))
end

UINCampBond3DItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINCampBond3DItem


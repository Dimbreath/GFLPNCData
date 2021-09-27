local DormFightConst = require("Game.Fight.DormFightConst")
local UIFightSceneUiItem = class("UIFightSceneUiItem", UIBaseNode)
UIFightSceneUiItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIFightSceneUiItem.SetPosition = function(self, position)
  -- function num : 0_1 , upvalues : _ENV
  if IsNull(self.transform) then
    return 
  end
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.transform).position = position
end

UIFightSceneUiItem.GetSceneUiType = function(self)
  -- function num : 0_2 , upvalues : DormFightConst
  return (DormFightConst.SceneUiType).Undefined
end

return UIFightSceneUiItem


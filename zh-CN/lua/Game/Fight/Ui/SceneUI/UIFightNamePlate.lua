local DormFightConst = require("Game.Fight.DormFightConst")
local UIFightSceneUiItem = require("Game.Fight.Ui.SceneUI.UIFightSceneUiItem")
local UIFightNamePlate = class("UIFightNamePlate", UIFightSceneUiItem)
UIFightNamePlate.SetName = function(self, name)
  -- function num : 0_0
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = name or ""
end

UIFightNamePlate.SetSelfStyle = function(self, isSelf)
  -- function num : 0_1
  ((self.ui).obj_Name):SetActive(not isSelf)
  ;
  ((self.ui).obj_Target):SetActive(isSelf)
end

UIFightNamePlate.GetSceneUiType = function(self)
  -- function num : 0_2 , upvalues : DormFightConst
  return (DormFightConst.SceneUiType).NamePlate
end

return UIFightNamePlate


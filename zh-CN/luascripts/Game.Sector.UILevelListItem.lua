-- params : ...
-- function num : 0 , upvalues : _ENV
local UIlevelListItem = class("Game.Sector.UILevelListItem", UIBaseNode)
local base = UIBaseNode
UIlevelListItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_LevelItem, self, self.Select)
  ;
  ((self.ui).stopStateNode):SetActive(false)
end

UIlevelListItem.InitLevelItem = function(self, levelData, callBack)
  -- function num : 0_1 , upvalues : _ENV
  self.levelNum = levelData.num
  self.levelData = levelData
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (string.format)("%d-%d", levelData.sector, levelData.num)
  self.clickAction = callBack
  self.stageState = (PlayerDataCenter.sectorStage):GetStageState(levelData.id)
  self.isUnlock = (PlayerDataCenter.sectorStage):IsStageUnlock(levelData.id)
  ;
  (((self.ui).img_Lock).gameObject):SetActive(not self.isUnlock)
  ;
  (((self.ui).img_Pic).gameObject):SetActive(self.isUnlock)
  ;
  ((self.ui).obj_ClearLevel):SetActive(self.stageState > 0)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIlevelListItem.Select = function(self)
  -- function num : 0_2
  if self.clickAction ~= nil then
    (self.clickAction)(self)
  end
end

UIlevelListItem.DisableSelect = function(self)
  -- function num : 0_3
  if not self.isUnlock then
    return 
  end
  ;
  ((self.ui).stopStateNode):SetActive(true)
end

UIlevelListItem.SetSelectUI = function(self, active)
  -- function num : 0_4
  ((self.ui).select):SetActive(active)
end

UIlevelListItem.ShowRedDot = function(self, show)
  -- function num : 0_5
  ((self.ui).redDot):SetActive(show)
end

UIlevelListItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UIlevelListItem


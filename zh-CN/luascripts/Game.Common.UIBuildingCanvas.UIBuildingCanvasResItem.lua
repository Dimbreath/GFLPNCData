-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBuildingCanvasResItem = class("UIBuildingCanvasResItem", UIBaseNode)
local base = UIBaseNode
local UIBuildingCanvasResBar = require("Game.Common.UIBuildingCanvas.UIBuildingCanvasResBar")
UIBuildingCanvasResItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIBuildingCanvasResBar
  self.OnClickEvent = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).rootBtn, self, self.__OnClickRootBtn)
  ;
  ((self.ui).resBar):SetActive(false)
  self.resBarPool = (UIItemPool.New)(UIBuildingCanvasResBar, (self.ui).resBar)
end

UIBuildingCanvasResItem.InitResItem = function(self, id, position, mainCam)
  -- function num : 0_1 , upvalues : _ENV
  self.id = id
  self:SetPosition(position)
  if not IsNull(mainCam) then
    local constraintSource = ((self.ui).rootRotCon):GetSource(0)
    constraintSource.sourceTransform = mainCam.transform
    ;
    ((self.ui).rootRotCon):SetSource(0, constraintSource)
  end
end

UIBuildingCanvasResItem.SetPosition = function(self, position)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.transform).position = position
end

UIBuildingCanvasResItem.UpdateUI = function(self, resTabSort, immediate)
  -- function num : 0_3 , upvalues : _ENV
  self.resTabSort = resTabSort
  ;
  (self.resBarPool):HideAll()
  for k,v in ipairs(resTabSort) do
    local bar = (self.resBarPool):GetOne()
    bar:UpdateResBar(v)
  end
end

UIBuildingCanvasResItem.__OnClickRootBtn = function(self)
  -- function num : 0_4
  if self.OnClickEvent ~= nil then
    (self.OnClickEvent)(self.id)
  end
end

UIBuildingCanvasResItem.ShowRedDotRes = function(self, show)
  -- function num : 0_5
  ((self.ui).redDotResMax):SetActive(show)
end

UIBuildingCanvasResItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (self.resBarPool):DeleteAll()
  self.resBarPool = nil
  ;
  (base.OnDelete)(self)
end

return UIBuildingCanvasResItem


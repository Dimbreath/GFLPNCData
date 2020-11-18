-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBuildingCanvas = class("UIBuildingCanvas", UIBaseNode)
local base = UIBaseNode
local ResItem = require("Game.Common.UIBuildingCanvas.UIBuildingCanvasResItem")
UIBuildingCanvas.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.CollectResEvent = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).resPrefab):SetActive(false)
  self.uiItems = {}
end

UIBuildingCanvas.InitBuildingCanvas = function(self, mainCam, setResCam)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).canvas).worldCamera = mainCam
  self.mainCam = mainCam
  self.setResCam = setResCam
end

UIBuildingCanvas.CreateItem = function(self, id, position)
  -- function num : 0_2 , upvalues : ResItem, _ENV
  local go = ((self.ui).resPrefab):Instantiate()
  go:SetActive(true)
  local item = ResItem:New()
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.uiItems)[id] = item
  item:Init(go)
  local cam = self.setResCam and self.mainCam or nil
  item:InitResItem(id, position, cam)
  item.OnClickEvent = BindCallback(self, self.__OnClickItem)
end

UIBuildingCanvas.ContainCanvasResItem = function(self, id)
  -- function num : 0_3
  do return (self.uiItems)[id] ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIBuildingCanvas.__OnClickItem = function(self, id)
  -- function num : 0_4
  if self.CollectResEvent ~= nil then
    (self.CollectResEvent)(id)
  end
end

UIBuildingCanvas.UpdateCanvasItem = function(self, id, resTabSort, immediate)
  -- function num : 0_5
  local item = (self.uiItems)[id]
  item:UpdateUI(resTabSort, immediate)
end

UIBuildingCanvas.ShowCanvasItem = function(self, id)
  -- function num : 0_6
  local item = (self.uiItems)[id]
  if item ~= nil then
    item:Show()
  end
end

UIBuildingCanvas.HideCanvasItem = function(self, id)
  -- function num : 0_7
  local item = (self.uiItems)[id]
  if item ~= nil then
    item:Hide()
  end
end

UIBuildingCanvas.UpdateCanvasItemPos = function(self, id, position)
  -- function num : 0_8
  local item = (self.uiItems)[id]
  if item ~= nil then
    item:SetPosition(position)
  end
end

UIBuildingCanvas.ShowResRedDot = function(self, id, show)
  -- function num : 0_9
  local item = (self.uiItems)[id]
  if item ~= nil then
    item:ShowRedDotRes(show)
  end
end

UIBuildingCanvas.OnDelete = function(self)
  -- function num : 0_10 , upvalues : _ENV, base
  if self.uiItems ~= nil then
    for k,v in pairs(self.uiItems) do
      v:OnDelete()
    end
  end
  do
    ;
    (base.OnDelete)(self)
  end
end

return UIBuildingCanvas


-- params : ...
-- function num : 0 , upvalues : _ENV
local base = require("Game.Common.UIBuildingCanvas.UIBuildingCanvas")
local UIOasisBuildingCanvas = class("UIOasisBuildingCanvas", base)
local NameItem = require("Game.Oasis.UI.UIOasisBuildingCanvasNameItem")
local ProcessItem = require("Game.Oasis.UI.UIOasisBuildingCanvasProgressItem")
UIOasisBuildingCanvas.OnInit = function(self)
  -- function num : 0_0 , upvalues : base, _ENV
  (base.OnInit)(self)
  local nameRoot = self:FindComponent("NameRoot", eUnityComponentID.Transform)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.ui).nameRoot = {}
  ;
  (UIUtil.LuaUIBindingTable)(nameRoot, (self.ui).nameRoot)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).nameRoot).gameObject = nameRoot.gameObject
  ;
  (((self.ui).nameRoot).namePrefab):SetActive(false)
  self.nameItems = {}
  self.nameItemPool = {}
  local progressRoot = self:FindComponent("ProgressRoot", eUnityComponentID.Transform)
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.ui).progressRoot = {}
  ;
  (UIUtil.LuaUIBindingTable)(progressRoot, (self.ui).progressRoot)
  ;
  (((self.ui).progressRoot).progressPrefab):SetActive(false)
  self.progressItem = {}
  self.progressItemPool = {}
end

UIOasisBuildingCanvas.CreateNameItem = function(self, id, UIbulidData, position)
  -- function num : 0_1 , upvalues : _ENV, NameItem
  local item = (self.nameItems)[id]
  if item == nil then
    if #self.nameItemPool > 0 then
      item = (table.remove)(self.nameItemPool, 1)
    else
      local go = (((self.ui).nameRoot).namePrefab):Instantiate()
      go:SetActive(true)
      item = (NameItem.New)()
      item:Init(go)
      item:Split(((self.ui).nameRoot).bgRoot, ((self.ui).nameRoot).textRoot)
    end
  end
  do
    item:InitCanvasNameItem(id, UIbulidData, position)
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self.nameItems)[id] = item
  end
end

UIOasisBuildingCanvas.UpdateNameItemLevel = function(self, id, level)
  -- function num : 0_2
  local item = (self.nameItems)[id]
  if item ~= nil then
    item:UpdateBuildingLevel(level)
  end
end

UIOasisBuildingCanvas.UpdateNamePos = function(self, id, position)
  -- function num : 0_3
  local item = (self.nameItems)[id]
  if item ~= nil then
    item:UpdateNamePos(position)
  end
end

UIOasisBuildingCanvas.RecycleNameItem = function(self, id)
  -- function num : 0_4 , upvalues : _ENV
  local item = (self.nameItems)[id]
  if item ~= nil then
    item:OnRecycle()
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.nameItems)[id] = nil
    ;
    (table.insert)(self.nameItemPool, item)
  end
end

UIOasisBuildingCanvas.SetNameRootActive = function(self, active)
  -- function num : 0_5
  if (self.ui).nameRoot ~= nil then
    (((self.ui).nameRoot).gameObject):SetActive(active)
  end
end

UIOasisBuildingCanvas.__GetProcessItem = function(self)
  -- function num : 0_6 , upvalues : _ENV, ProcessItem
  local item = nil
  if #self.progressItemPool > 0 then
    item = (table.remove)(self.progressItemPool, 1)
  else
    local go = (((self.ui).progressRoot).progressPrefab):Instantiate()
    go:SetActive(true)
    item = (ProcessItem.New)()
    item:Init(go)
    item:Split(((self.ui).progressRoot).bgRoot, ((self.ui).progressRoot).fillRoot, ((self.ui).progressRoot).textRoot)
  end
  do
    return item
  end
end

UIOasisBuildingCanvas.UpdateProcess = function(self, id, position, progress, text)
  -- function num : 0_7
  local item = (self.progressItem)[id]
  if item == nil then
    item = self:__GetProcessItem()
    item:InitCanvasProcessItem(id, position, progress, text)
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.progressItem)[id] = item
  else
    item:UpdateProcess(progress, text)
    item:UpdateProcessPos(position)
  end
end

UIOasisBuildingCanvas.UpdateProcessPos = function(self, id, position)
  -- function num : 0_8
  local item = (self.progressItem)[id]
  if item ~= nil then
    item:UpdateProcessPos(position)
  end
end

UIOasisBuildingCanvas.RecycleProcessItem = function(self, id)
  -- function num : 0_9 , upvalues : _ENV
  local item = (self.progressItem)[id]
  if item ~= nil then
    item:OnRecycle()
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.progressItem)[id] = nil
    ;
    (table.insert)(self.progressItemPool, item)
  end
end

UIOasisBuildingCanvas.RecycleUI = function(self, id)
  -- function num : 0_10
  self:RecycleNameItem(id)
  self:RecycleProcessItem(id)
end

UIOasisBuildingCanvas.OnDelete = function(self)
  -- function num : 0_11 , upvalues : _ENV, base
  for k,v in pairs(self.nameItems) do
    v:OnDelete()
  end
  self.nameItems = {}
  for k,v in pairs(self.progressItem) do
    v:OnDelete()
  end
  self.progressItem = {}
  for k,v in ipairs(self.progressItemPool) do
    v:OnDelete()
  end
  self.progressItemPool = {}
  ;
  (base.OnDelete)(self)
end

return UIOasisBuildingCanvas


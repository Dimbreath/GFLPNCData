-- params : ...
-- function num : 0 , upvalues : _ENV
local UIItemPool = class("UIItemPool")
UIItemPool.ctor = function(self, uiClass, uiPrefab)
  -- function num : 0_0
  self.uiClass = uiClass
  self.uiPrefab = uiPrefab
  self.listItem = {}
  self.poolItem = {}
end

UIItemPool.HideAll = function(self)
  -- function num : 0_1 , upvalues : _ENV
  while #self.listItem > 0 do
    local item = (table.remove)(self.listItem, #self.listItem)
    item:Hide()
    ;
    (table.insert)(self.poolItem, item)
  end
end

UIItemPool.HideOne = function(self, item)
  -- function num : 0_2 , upvalues : _ENV
  item:Hide()
  ;
  (table.removebyvalue)(self.listItem, item, false)
  ;
  (table.insert)(self.poolItem, item)
end

UIItemPool.GetOne = function(self, isShow)
  -- function num : 0_3 , upvalues : _ENV
  if (isShow == nil and true) or #self.poolItem > 0 then
    local item = (table.remove)(self.poolItem, #self.poolItem)
    if isShow then
      item:Show()
    end
    ;
    (item.transform):SetAsLastSibling()
    ;
    (table.insert)(self.listItem, item)
    return item
  else
    do
      local item = ((self.uiClass).New)()
      local go = (self.uiPrefab):Instantiate()
      if isShow then
        go:SetActive(true)
      end
      item:Init(go)
      ;
      (table.insert)(self.listItem, item)
      do return item end
    end
  end
end

UIItemPool.DeleteAll = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self:HideAll()
  for k,v in ipairs(self.poolItem) do
    v:Delete()
  end
  self.poolItem = {}
end

return UIItemPool


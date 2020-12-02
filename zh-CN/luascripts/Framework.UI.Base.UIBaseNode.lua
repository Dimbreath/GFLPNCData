-- params : ...
-- function num : 0 , upvalues : _ENV
UIBaseNode = class("UIBaseNode")
-- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

UIBaseNode.ctor = function(self)
  -- function num : 0_0
  self.gameObject = nil
  self.transform = nil
  self.name = nil
  self.__inited = false
  self.active = false
  self.ui = {}
end

-- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

UIBaseNode.IsNull = function(self)
  -- function num : 0_1 , upvalues : _ENV
  return IsNull(self.gameObject)
end

-- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

UIBaseNode.Init = function(self, root)
  -- function num : 0_2 , upvalues : _ENV
  if IsNull(root) or self.__inited then
    return 
  end
  self.__inited = true
  self.transform = root.transform
  self.gameObject = root.gameObject
  self.name = (self.gameObject).name
  self.active = (self.gameObject).activeSelf
  self:OnInit()
  if self.active then
    self:OnShow()
  end
end

-- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

UIBaseNode.Show = function(self)
  -- function num : 0_3
  if self.active then
    return 
  end
  self.active = true
  ;
  (self.gameObject):SetActive(true)
  self:OnShow()
end

-- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

UIBaseNode.Hide = function(self)
  -- function num : 0_4
  if not self.active then
    return 
  end
  self.active = false
  ;
  (self.gameObject):SetActive(false)
  self:OnHide()
end

-- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

UIBaseNode.Delete = function(self)
  -- function num : 0_5
  if self.active then
    self:OnHide()
  end
  self:OnDelete()
end

-- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

UIBaseNode.OnInit = function(self)
  -- function num : 0_6
end

-- DECOMPILER ERROR at PC27: Confused about usage of register: R0 in 'UnsetPending'

UIBaseNode.OnShow = function(self)
  -- function num : 0_7
end

-- DECOMPILER ERROR at PC30: Confused about usage of register: R0 in 'UnsetPending'

UIBaseNode.OnHide = function(self)
  -- function num : 0_8
end

-- DECOMPILER ERROR at PC33: Confused about usage of register: R0 in 'UnsetPending'

UIBaseNode.OnDelete = function(self)
  -- function num : 0_9 , upvalues : _ENV
  DestroyUnityObject(self.gameObject)
  self.gameObject = nil
  self.transform = nil
  self.active = false
  self.ui = nil
end

-- DECOMPILER ERROR at PC36: Confused about usage of register: R0 in 'UnsetPending'

UIBaseNode.FindComponent = function(self, path, ctype)
  -- function num : 0_10
  return (self.transform):FindComponent(path, ctype)
end

return UIBaseNode


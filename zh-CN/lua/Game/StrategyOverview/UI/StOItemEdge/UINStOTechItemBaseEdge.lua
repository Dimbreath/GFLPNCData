local UINStOTechItemBaseEdge = class("UINStOTechItemBaseEdge", UIBaseNode)
local base = UIBaseNode
UINStOTechItemBaseEdge.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINStOTechItemBaseEdge.SetPreData = function(self, edgeType, edgeScale)
  -- function num : 0_1
  self.edgeType = edgeType
  self.edgeScale = edgeScale
end

UINStOTechItemBaseEdge.InitEdge = function(self, techItem)
  -- function num : 0_2 , upvalues : _ENV
  local scaleGroup = (techItem.ui).scaleGroup
  ;
  (self.transform):SetParent(techItem.transform)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.transform).localPosition = Vector3.zero
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.transform).localScale = Vector3.one
  ;
  (self.transform):SetAsFirstSibling()
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (scaleGroup.transform).localScale = (Vector3.New)(self.edgeScale, self.edgeScale, self.edgeScale)
end

UINStOTechItemBaseEdge.SetState = function(self, level, isUnlock)
  -- function num : 0_3
end

UINStOTechItemBaseEdge.GetUpPointPos = function(self)
  -- function num : 0_4
  return (((self.ui).upPoint).transform).anchoredPosition
end

UINStOTechItemBaseEdge.GetDownPointPos = function(self)
  -- function num : 0_5
  return (((self.ui).downPoint).transform).anchoredPosition
end

UINStOTechItemBaseEdge.TryGetFxRoot = function(self)
  -- function num : 0_6
  if (self.ui).fXRoot ~= nil then
    return (self.ui).fXRoot
  end
  return nil
end

UINStOTechItemBaseEdge.GetEdgeType = function(self)
  -- function num : 0_7
  return self.edgeType
end

return UINStOTechItemBaseEdge


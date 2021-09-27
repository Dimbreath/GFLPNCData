local UINStOTechLineItem = class("UINStOTechLineItem", UIBaseNode)
local base = UIBaseNode
UINStOTechLineItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINStOTechLineItem.InitStOTechLineItem = function(self, startPos, endPos)
  -- function num : 0_1 , upvalues : _ENV
  local diffVec = endPos - startPos
  local x = (math.abs)(startPos.x - endPos.x)
  local y = ((math.abs)(startPos.y - endPos.y))
  local sizeDelta, pivot = nil, nil
  if y < x then
    if endPos.x >= startPos.x or not (Vector2.New)(1, 0.5) then
      pivot = (Vector2.New)(0, 0.5)
    end
    sizeDelta = (Vector2.New)(x, 4)
  else
    if endPos.y >= startPos.y or not (Vector2.New)(0.5, 1) then
      pivot = (Vector2.New)(0.5, 0)
    end
    sizeDelta = (Vector2.New)(4, y)
  end
  -- DECOMPILER ERROR at PC64: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self.transform).pivot = pivot
  -- DECOMPILER ERROR at PC66: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self.transform).sizeDelta = sizeDelta
end

UINStOTechLineItem.RefreshStOTechLineItem = function(self, valid)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  if not valid or not Color.white then
    ((self.ui).img).color = Color.gray
  end
end

UINStOTechLineItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINStOTechLineItem


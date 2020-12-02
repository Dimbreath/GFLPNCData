-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDormFntItem = class("UIDormFntItem", UIBaseNode)
local base = UIBaseNode
UIDormFntItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).rootBtn, self, self.OnClickFntRoot)
end

UIDormFntItem.InitUIFntItem = function(self, fntEntity, clickEvent)
  -- function num : 0_1 , upvalues : _ENV
  self.fntEntity = fntEntity
  self.fntData = fntEntity.fntData
  self._clickEvent = clickEvent
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite((self.fntData):GetFntIcon())
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (self.fntData):GetName()
  ;
  ((self.ui).tex_Type):SetIndex((self.fntData):GetFntType())
end

UIDormFntItem.OnClickFntRoot = function(self)
  -- function num : 0_2
  if self._clickEvent ~= nil then
    (self._clickEvent)(self.fntEntity)
  end
end

UIDormFntItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UIDormFntItem


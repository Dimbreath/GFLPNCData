-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDormInteract = class("UIDormInteract", UIBaseWindow)
local base = UIDormInteract
UIDormInteract.OnInit = function(self)
  -- function num : 0_0
end

UIDormInteract.OnDelete = function(self)
  -- function num : 0_1 , upvalues : base
  (base.OnDelete)(self)
end

return UIDormInteract


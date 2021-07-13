-- params : ...
-- function num : 0 , upvalues : _ENV
local UINDormComfort = class("UINDormComfort", UIBaseNode)
local base = UIBaseNode
UINDormComfort.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).rootBtn, self, self.OnClickDormComfortRoot)
end

UINDormComfort.InitDormComfort = function(self, comfort, comfortLimit)
  -- function num : 0_1 , upvalues : _ENV
  ((self.ui).tex_ComfortNum):SetIndex(0, tostring(comfort), tostring(comfortLimit))
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_ComfortProgress).fillAmount = comfort / comfortLimit
end

UINDormComfort.OnClickDormComfortRoot = function(self)
  -- function num : 0_2
end

UINDormComfort.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINDormComfort


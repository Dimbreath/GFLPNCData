local UINEpBuffDetail = class("UINEpBuffDetail", UIBaseNode)
local base = UIBaseNode
UINEpBuffDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINEpBuffDetail.InitEpBuffDetail = function(self, dynEpBuffData)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).img_Icon).sprite = dynEpBuffData:GetEpBuffIcon()
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = dynEpBuffData:GetEpBuffName()
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Desc).text = dynEpBuffData:GetEpBuffDescribe()
end

UINEpBuffDetail.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINEpBuffDetail


local UINAthTableGridState = class("UINAthTableGridState", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
UINAthTableGridState.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self._OnClickRoot)
end

UINAthTableGridState.InitAthGridState = function(self, position, stateIndex)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.transform).anchoredPosition = position
  ;
  ((self.ui).img_State):SetIndex(stateIndex)
  self.unlock = stateIndex == 1
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.ui).img_State).image).raycastTarget = true
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINAthTableGridState._OnClickRoot = function(self)
  -- function num : 0_2 , upvalues : cs_MessageCommon, _ENV
  if self.unlock then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(4004))
  else
    ;
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(4005))
  end
end

UINAthTableGridState.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthTableGridState


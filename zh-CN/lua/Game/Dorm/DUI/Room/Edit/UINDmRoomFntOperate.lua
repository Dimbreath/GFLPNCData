local UINDmRoomFntOperate = class("UINDmRoomFntOperate", UIBaseNode)
local base = UIBaseNode
UINDmRoomFntOperate.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Recycle, self, self._OnClickRecycle)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Reset, self, self._OnClickReset)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Rote, self, self._OnClickRotate)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self._OnClickConfirm)
end

UINDmRoomFntOperate.InitDmRoomFntOperate = function(self, dormRoomCtrl, fntName, showRotBtn, showRecycleBtn)
  -- function num : 0_1
  self.dormRoomCtrl = dormRoomCtrl
  self:SetDmRoomFntOpFnt(fntName)
  ;
  (((self.ui).btn_Rote).gameObject):SetActive(showRotBtn)
  ;
  (((self.ui).btn_Recycle).gameObject):SetActive(showRecycleBtn)
end

UINDmRoomFntOperate.SetDmRoomFntOpFnt = function(self, fntName)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_itemName).text = fntName
end

UINDmRoomFntOperate.UpdDmRoomFntOpPos = function(self, transform)
  -- function num : 0_3 , upvalues : _ENV
  if self.active then
    local x, y = UIManager:World2UIPositionOut(transform)
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self.transform).localPosition = (Vector3.New)(x, y, 0)
  end
end

UINDmRoomFntOperate._OnClickRecycle = function(self)
  -- function num : 0_4
  (self.dormRoomCtrl):RecycleFntSelect()
end

UINDmRoomFntOperate._OnClickReset = function(self)
  -- function num : 0_5
  (self.dormRoomCtrl):ResetFntEntity()
end

UINDmRoomFntOperate._OnClickRotate = function(self)
  -- function num : 0_6
  (self.dormRoomCtrl):RotateFnt()
end

UINDmRoomFntOperate._OnClickConfirm = function(self)
  -- function num : 0_7
  (self.dormRoomCtrl):DeselectFntEntity()
end

UINDmRoomFntOperate.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnDelete)(self)
end

return UINDmRoomFntOperate


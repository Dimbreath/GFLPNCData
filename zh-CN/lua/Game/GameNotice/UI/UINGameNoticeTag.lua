local UINGameNoticeTag = class("UINGameNoticeTag", UIBaseNode)
local base = UIBaseNode
UINGameNoticeTag.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_NoticeItem, self, self._OnValueChange)
end

UINGameNoticeTag.SetNoticeTagClickCallback = function(self, callback)
  -- function num : 0_1
  self._onClickCallback = callback
end

UINGameNoticeTag.RefreshGameNoticeTag = function(self, index, gameNoticData, callback)
  -- function num : 0_2 , upvalues : _ENV
  self._idx = index
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = gameNoticData.name
  self:SetNoticeTagClickCallback(callback)
  local timeDate = TimestampToDate(gameNoticData.startTimeStamp)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Date).text = timeDate.month .. "/" .. timeDate.day
  local ctrl = ControllerManager:GetController(ControllerTypeId.GameNotice)
  self:SetNewUICorner(ctrl:ContainGameNoticeIsNew(gameNoticData.idx))
end

UINGameNoticeTag.SetNewUICorner = function(self, active)
  -- function num : 0_3
  ((self.ui).obj_New):SetActive(active)
end

UINGameNoticeTag.SetNoticeTagIsOn = function(self, isOn)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tog_NoticeItem).isOn = isOn
end

UINGameNoticeTag._OnValueChange = function(self, bool)
  -- function num : 0_5
  ;
  ((self.ui).img_OnSelect):SetIndex(bool and 1 or 0)
  if not bool then
    return 
  end
  self:SetNewUICorner(false)
  if self._onClickCallback ~= nil then
    (self._onClickCallback)(self._idx)
  end
end

UINGameNoticeTag.OnHide = function(self)
  -- function num : 0_6
  self:SetNoticeTagIsOn(false)
end

UINGameNoticeTag.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnDelete)(self)
end

return UINGameNoticeTag


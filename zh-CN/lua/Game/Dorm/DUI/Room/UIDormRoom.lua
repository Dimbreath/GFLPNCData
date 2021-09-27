local UIDormRoom = class("UIDormRoom", UIBaseWindow)
local base = UIBaseWindow
local UINDmRoomEdit = require("Game.Dorm.DUI.Room.Edit.UINDmRoomEdit")
local DormEnum = require("Game.Dorm.DormEnum")
local JumpManager = require("Game.Jump.JumpManager")
local ShopEnum = require("Game.Shop.ShopEnum")
local cs_DoTween = ((CS.DG).Tweening).DOTween
local cs_Ease = ((CS.DG).Tweening).Ease
UIDormRoom.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINDmRoomEdit
  (UIUtil.AddButtonListener)((self.ui).btn_Edit, self, self._OnClickEditRoom)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_hero, self, self._OnClickCheckIn)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_HideUI, self, self._OnClickHideUI)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_buy, self, self._OnClickBuy)
  self.dmRoomEditNode = (UINDmRoomEdit.New)()
  ;
  (self.dmRoomEditNode):Init((self.ui).editorNode)
  ;
  (self.dmRoomEditNode):Hide()
  self.__OnDormRoomEditDataChange = BindCallback(self, self.OnDormRoomEditDataChange)
  MsgCenter:AddListener(eMsgEventId.DormRoomEditDataChange, self.__OnDormRoomEditDataChange)
  self:_SetEditorBtnGroup(false)
  self:_InitDormRoomSequene()
end

UIDormRoom.InitUIDormRoom = function(self, dormRoomCtrl)
  -- function num : 0_1
  self.roomCtrl = dormRoomCtrl
  self:RefreshDormRoomBaseInfo()
end

UIDormRoom.RefreshDormRoomBaseInfo = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local roomData = ((self.roomCtrl).roomEntity).roomData
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_ComfortPoint).text = tostring(roomData:GetComfort())
end

UIDormRoom.OnDormRoomEditDataChange = function(self)
  -- function num : 0_3
  self:RefreshDormRoomBaseInfo()
end

UIDormRoom._OnClickEditRoom = function(self)
  -- function num : 0_4
  (self.roomCtrl):EnterDormRoomEdit()
end

UIDormRoom._OnClickCheckIn = function(self)
  -- function num : 0_5 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.DormCheckIn, function(window)
    -- function num : 0_5_0 , upvalues : self
    if window == nil then
      return 
    end
    window:InitByParam(((self.roomCtrl).roomEntity).spos)
  end
)
end

UIDormRoom._OnClickHideUI = function(self)
  -- function num : 0_6 , upvalues : _ENV
  self:Hide()
  UIManager:HideWindow(UIWindowTypeID.DormInput)
  UIManager:HideWindow(UIWindowTypeID.TopStatus)
  UIManager:HideWindow(UIWindowTypeID.DormInteract)
end

UIDormRoom._OnClickBuy = function(self)
  -- function num : 0_7 , upvalues : JumpManager, ShopEnum
  JumpManager:DirectShowShop(nil, nil, (ShopEnum.ShopId).dormFnt, true)
end

UIDormRoom.OnDRoomEidtMode = function(self, isEnter)
  -- function num : 0_8
  self:_SetEditorBtnGroup(isEnter)
  if isEnter then
    (self.dmRoomEditNode):Show()
    ;
    (self.dmRoomEditNode):InitDmRoomtEdit(self.roomCtrl)
  else
    ;
    (self.dmRoomEditNode):Hide()
  end
end

UIDormRoom._SetEditorBtnGroup = function(self, isEditor)
  -- function num : 0_9
  (((self.ui).btn_Edit).gameObject):SetActive(not isEditor)
  ;
  (((self.ui).btn_hero).gameObject):SetActive(not isEditor)
  ;
  (((self.ui).btn_HideUI).gameObject):SetActive(not isEditor)
  ;
  (((self.ui).btn_buy).gameObject):SetActive(isEditor)
end

UIDormRoom._InitDormRoomSequene = function(self)
  -- function num : 0_10 , upvalues : cs_DoTween, _ENV, cs_Ease, base
  local seq = (cs_DoTween.Sequence)()
  seq:SetAutoKill(false)
  seq:SetUpdate(true)
  seq:Append(((((self.transform):DOSizeDelta((Vector2.New)(0, 500), 0.25)):From()):SetRelative(true)):SetEase(cs_Ease.Linear))
  seq:Join(((((self.ui).canvasGroup):DOFade(0, 0.25)):From()):SetEase(cs_Ease.Linear))
  seq:OnRewind(function()
    -- function num : 0_10_0 , upvalues : base, self
    (base.Hide)(self)
  end
)
  self._winSeq = seq
end

UIDormRoom.Hide = function(self)
  -- function num : 0_11
  (self._winSeq):Complete()
  ;
  (self._winSeq):PlayBackwards()
end

UIDormRoom.OnShow = function(self)
  -- function num : 0_12 , upvalues : base
  (base.OnShow)(self)
  ;
  (self._winSeq):PlayForward()
end

UIDormRoom.OnDelete = function(self)
  -- function num : 0_13 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.DormRoomEditDataChange, self.__OnDormRoomEditDataChange)
  ;
  (self.dmRoomEditNode):Delete()
  if self._winSeq ~= nil then
    (self._winSeq):Kill()
    self._winSeq = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIDormRoom


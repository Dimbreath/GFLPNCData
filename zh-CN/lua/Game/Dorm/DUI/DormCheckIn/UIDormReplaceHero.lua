local UIDormReplaceHero = class("UIDormReplaceHero", UIBaseWindow)
local base = UIBaseWindow
local DormUtil = require("Game.Dorm.DormUtil")
UIDormReplaceHero.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, function()
    -- function num : 0_0_0 , upvalues : self
    self:Delete()
  end
)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Cancel, self, function()
    -- function num : 0_0_1 , upvalues : self
    self:Delete()
  end
)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnClickConfirm)
end

UIDormReplaceHero.InitInfo = function(self, elseroomdata, HeroID, roomdata)
  -- function num : 0_1 , upvalues : _ENV, DormUtil
  self.heroid = HeroID
  local fragmentID = ((ConfigData.hero_data)[HeroID]).fragment
  local HeadIconName = ((ConfigData.item)[fragmentID]).icon
  local sprite = CRH:GetSprite(HeadIconName, CommonAtlasType.HeroHeadIcon)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).img_Hero).sprite = sprite
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).Text_BeforName).text = elseroomdata.RoomName
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).Text_AfterName).text = roomdata.RoomName
  local imgposx, imgposy = (DormUtil.RoomCoordToXY)(elseroomdata.RoomPos)
  local pos = (Vector2.New)(imgposx, imgposy)
  local uipos = (DormUtil.ToRectTransformPos)(pos)
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R11 in 'UnsetPending'

  ;
  (((self.ui).img_beforepos).transform).localPosition = {0; x = uipos.x, y = uipos.y}
  imgposx = (DormUtil.RoomCoordToXY)(roomdata.RoomPos)
  pos.x = imgposx
  pos.y = imgposy
  uipos = (DormUtil.ToRectTransformPos)(pos)
  -- DECOMPILER ERROR at PC69: Confused about usage of register: R11 in 'UnsetPending'

  ;
  (((self.ui).img_afterpos).transform).localPosition = {0; x = uipos.x, y = uipos.y}
  self.elseroomdata = elseroomdata
  self.HeroID = HeroID
  self.roomdata = roomdata
end

UIDormReplaceHero.OnClickConfirm = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local checkinWindow = UIManager:GetWindow(UIWindowTypeID.DormCheckIn)
  local data = {}
  data.heroid = self.HeroID
  data.bind = false
  checkinWindow:UpdateDetailInfo(self.elseroomdata, nil, data)
  local data2 = {}
  data2.heroid = self.HeroID
  data2.bind = true
  checkinWindow:UpdateDetailInfo(self.roomdata, nil, data2)
  self:Delete()
end

UIDormReplaceHero.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UIDormReplaceHero


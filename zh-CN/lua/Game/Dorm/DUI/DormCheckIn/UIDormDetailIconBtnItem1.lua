local UIDormDetailIconBtnItem1 = class("UIDormDetailIconBtnItem1", UIBaseNode)
local DormUtil = require("Game.Dorm.DormUtil")
local base = UIBaseNode
UIDormDetailIconBtnItem1.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_IconBtn, self, self.OnClickBtn)
end

UIDormDetailIconBtnItem1.InitIconBtnItem = function(self, data, roomdata)
  -- function num : 0_1 , upvalues : DormUtil, _ENV
  local x, y = (DormUtil.RoomCoordToXY)(roomdata.RoomPos)
  self.RoomIndex = (DormUtil.GetRoomIndexByRoomposToxy)(x, y)
  self.checkinWindow = UIManager:GetWindow(UIWindowTypeID.DormCheckIn)
  self.dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).btn_IconBtn).interactable = false
  self.heroId = data.param
  self.roomdata = roomdata
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_tir).enabled = false
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_can).enabled = false
  if data.param == -1 then
    (((self.ui).HeroAvator).gameObject):SetActive(false)
    ;
    (((self.ui).addOrEmpty).gameObject):SetActive(true)
    ;
    ((self.ui).addOrEmpty):SetIndex(1)
    return 
  end
  if data.param == 0 then
    (((self.ui).HeroAvator).gameObject):SetActive(false)
    ;
    (((self.ui).addOrEmpty).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC70: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).img_tir).enabled = true
    -- DECOMPILER ERROR at PC73: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).tex_can).enabled = true
    ;
    ((self.ui).addOrEmpty):SetIndex(0)
    return 
  end
  if data.param ~= 0 and data.param ~= -1 then
    (((self.ui).HeroAvator).gameObject):SetActive(true)
    ;
    (((self.ui).addOrEmpty).gameObject):SetActive(false)
    local heroData = PlayerDataCenter:GetHeroData(data.param)
    -- DECOMPILER ERROR at PC111: Confused about usage of register: R6 in 'UnsetPending'

    if heroData ~= nil then
      ((self.ui).img_HeroIcon).sprite = CRH:GetHeroSkinSprite(heroData.dataId, heroData.skinId)
    end
    -- DECOMPILER ERROR at PC114: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).btn_IconBtn).interactable = true
  end
end

UIDormDetailIconBtnItem1.OnClickBtn = function(self)
  -- function num : 0_2
  if self.heroId ~= -1 and self.heroId ~= 0 then
    local data = {}
    data.heroid = self.heroId
    data.bind = false
    ;
    (self.checkinWindow):UpdateDetailInfo(self.roomdata, nil, data)
  end
end

return UIDormDetailIconBtnItem1


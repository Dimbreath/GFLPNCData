local UIDormIconBtnItem = class("UIDormIconBtnItem", UIBaseNode)
local DormUtil = require("Game.Dorm.DormUtil")
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
UIDormIconBtnItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_IconBtn, self, self.OnClickBtn)
end

UIDormIconBtnItem.InitIconBtnItem = function(self, data, roomdata, callback)
  -- function num : 0_1 , upvalues : _ENV
  self.callback = callback
  if data.param == -1 then
    (((self.ui).HeroAvator).gameObject):SetActive(false)
    ;
    (((self.ui).addOrEmpty).gameObject):SetActive(true)
    ;
    ((self.ui).addOrEmpty):SetIndex(1)
  end
  if data.param == 0 then
    (((self.ui).HeroAvator).gameObject):SetActive(false)
    ;
    (((self.ui).addOrEmpty).gameObject):SetActive(true)
    ;
    ((self.ui).addOrEmpty):SetIndex(0)
  end
  if data.param > 0 then
    (((self.ui).HeroAvator).gameObject):SetActive(true)
    ;
    (((self.ui).addOrEmpty).gameObject):SetActive(false)
    local heroData = PlayerDataCenter:GetHeroData(data.param)
    -- DECOMPILER ERROR at PC69: Confused about usage of register: R5 in 'UnsetPending'

    if heroData ~= nil then
      ((self.ui).img_HeroIcon).sprite = CRH:GetHeroSkinSprite(heroData.dataId, heroData.skinId)
    end
  end
  do
    self.roomdata = roomdata
    self.param = data.param
  end
end

UIDormIconBtnItem.OnClickBtn = function(self)
  -- function num : 0_2 , upvalues : cs_MessageCommon, _ENV, DormUtil
  if self.param == -1 then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(2025))
    return 
  end
  if self.param ~= -1 then
    if self.callback ~= nil then
      (self.callback)()
    else
      error("callback nil")
    end
    local checkinWindow = UIManager:GetWindow(UIWindowTypeID.DormCheckIn)
    local x, y = (DormUtil.RoomCoordToXY)((self.roomdata).RoomPos)
    checkinWindow:SetRoomIndex((DormUtil.GetRoomIndexByRoomposToxy)(x, y))
    checkinWindow:UpdateDetailInfo(self.roomdata, true)
    return 
  end
end

return UIDormIconBtnItem


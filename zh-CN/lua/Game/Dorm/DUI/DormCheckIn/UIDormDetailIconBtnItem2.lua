local UIDormDetailIconBtnItem2 = class("UIDormDetailIconBtnItem2", UIBaseNode)
local DormUtil = require("Game.Dorm.DormUtil")
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
UIDormDetailIconBtnItem2.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_IconBtn, self, self.OnClickBtn)
end

UIDormDetailIconBtnItem2.InitIconBtnItem = function(self, listdata, roomdata, paramlist)
  -- function num : 0_1 , upvalues : DormUtil, _ENV
  if listdata == nil then
    return 
  end
  local x, y = (DormUtil.RoomCoordToXY)(roomdata.RoomPos)
  self.RoomIndex = (DormUtil.GetRoomIndexByRoomposToxy)(x, y)
  self.checkinWindow = UIManager:GetWindow(UIWindowTypeID.DormCheckIn)
  ;
  ((self.ui).trans_select):SetActive(false)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).Text_Des).text = ConfigData:GetTipContent(2022)
  local heroData = PlayerDataCenter:GetHeroData(listdata.heroId)
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R7 in 'UnsetPending'

  if heroData ~= nil then
    ((self.ui).img_HeroIcon).sprite = CRH:GetHeroSkinSprite(heroData.dataId, heroData.skinId)
  end
  local State = listdata.state
  self:SetState(State)
  self.HeroID = listdata.heroId
  self.roomdata = roomdata
  self.paramlist = paramlist
end

UIDormDetailIconBtnItem2.OnClickBtn = function(self)
  -- function num : 0_2 , upvalues : _ENV, DormUtil, cs_MessageCommon
  if self.HeroID > 0 then
    local BindHerocount = 0
    local CannotBindCount = 0
    do
      for key,value in pairs(self.paramlist) do
        if value.param > 0 and value.fntindex ~= nil then
          BindHerocount = BindHerocount + 1
        else
          if value.param == -1 then
            CannotBindCount = CannotBindCount + 1
          end
        end
      end
    end
    if BindHerocount == DormUtil:GetBedCount() - (CannotBindCount) then
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(2028))
      return 
    end
    local checkinWindow = UIManager:GetWindow(UIWindowTypeID.DormCheckIn)
    if checkinWindow:IsHeroBindOnElseRoom(self.HeroID, self.roomdata) then
      local elseroomdata = checkinWindow:GetElseRoomData(self.roomdata, self.HeroID)
      UIManager:ShowWindowAsync(UIWindowTypeID.DormReplaceHero, function(window)
    -- function num : 0_2_0 , upvalues : elseroomdata, self
    if window == nil then
      return 
    end
    window:InitInfo(elseroomdata, self.HeroID, self.roomdata)
  end
)
      return 
    end
  end
  do
    local data = {}
    data.heroid = self.HeroID
    data.bind = true
    ;
    (self.checkinWindow):UpdateDetailInfo(self.roomdata, nil, data)
  end
end

UIDormDetailIconBtnItem2.SetState = function(self, State)
  -- function num : 0_3
  if State == 0 then
    ((self.ui).obj_self):SetActive(false)
  end
  -- DECOMPILER ERROR at PC15: Unhandled construct in 'MakeBoolean' P1

  if State ~= 1 or State == 2 then
    ((self.ui).trans_select):SetActive(true)
  end
end

return UIDormDetailIconBtnItem2


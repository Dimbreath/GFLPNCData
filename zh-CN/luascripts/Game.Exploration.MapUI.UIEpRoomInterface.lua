-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEpRoomInterface = class("UIEpRoomInterface", UIBaseNode)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
UIEpRoomInterface.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIEpRoomInterface.InitRoomInterface = function(self, roomData)
  -- function num : 0_1
  self.roomData = roomData
end

UIEpRoomInterface.SetInterfaceRightPass = function(self, isPass, color)
  -- function num : 0_2 , upvalues : _ENV
  if isPass then
    ((self.ui).img_Right):SetIndex(1)
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (((self.ui).img_Right).image).color = color
  else
    ;
    ((self.ui).img_Right):SetIndex(0)
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (((self.ui).img_Right).image).color = Color.white
  end
end

UIEpRoomInterface.SetInterfaceLeftPass = function(self, isPass, color)
  -- function num : 0_3 , upvalues : _ENV
  if isPass then
    ((self.ui).img_Left):SetIndex(1)
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (((self.ui).img_Left).image).color = color
  else
    ;
    ((self.ui).img_Left):SetIndex(0)
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (((self.ui).img_Left).image).color = Color.white
  end
end

UIEpRoomInterface.SetAllInterfacePass = function(self, isPass, color)
  -- function num : 0_4
  self:SetInterfaceLeftPass(isPass, color)
  self:SetInterfaceRightPass(isPass, color)
end

UIEpRoomInterface.SetRoomUIAlpha = function(self, alphaValue)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).EpInterfaceAlpha).alpha = alphaValue
end

return UIEpRoomInterface


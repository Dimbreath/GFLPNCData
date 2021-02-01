-- params : ...
-- function num : 0 , upvalues : _ENV
local UIN3DFactoryCanvas = class("UIN3DFactoryCanvas", UIBaseNode)
local base = UIBaseNode
local UIN3DFactoryRoomInfo = require("Game.Factory.UI3D.UIN3DFactoryRoomInfo")
UIN3DFactoryCanvas.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIN3DFactoryRoomInfo
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.roomInfoPool = (UIItemPool.New)(UIN3DFactoryRoomInfo, (self.ui).obj_factoryRoomInfo)
  self.roomItemDic = {}
  ;
  ((self.ui).obj_factoryRoomInfo):SetActive(false)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_background, self, self.OnClickBackground)
end

UIN3DFactoryCanvas.GenRoomInfo = function(self, roomIndex, roomTramsform, roomEntityType, unlockDes)
  -- function num : 0_1 , upvalues : _ENV
  local item = (self.roomInfoPool):GetOne()
  local pos = (Vector3.__mul)(roomTramsform.position, 1 / (self.ui).canvasScale)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (item.transform).localPosition = pos
  item:InitRoomInfo(roomIndex, roomEntityType, unlockDes)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (self.roomItemDic)[roomIndex] = item
  return item
end

UIN3DFactoryCanvas.SetRoomInfoSate = function(self, roomIndex, roomEntityType)
  -- function num : 0_2
  local uiRoomInfo = (self.roomItemDic)[roomIndex]
  uiRoomInfo:SetRoomStateImage(roomEntityType)
end

UIN3DFactoryCanvas.SetClickBackgroundCallback = function(self, clickBGCallback)
  -- function num : 0_3
  self.clickBGCallback = clickBGCallback
end

UIN3DFactoryCanvas.OnClickBackground = function(self)
  -- function num : 0_4
  if self.clickBGCallback ~= nil then
    (self.clickBGCallback)()
  end
end

UIN3DFactoryCanvas.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (self.roomInfoPool):DeleteAll()
  self.roomItemDic = nil
  ;
  (base.OnDelete)(self)
end

return UIN3DFactoryCanvas


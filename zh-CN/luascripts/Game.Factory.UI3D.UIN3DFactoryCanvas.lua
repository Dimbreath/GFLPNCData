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

UIN3DFactoryCanvas.GenRoomInfo = function(self, roomIndex, roomTramsform)
  -- function num : 0_1 , upvalues : _ENV
  local item = (self.roomInfoPool):GetOne()
  local pos = (Vector3.__mul)(roomTramsform.position, 1 / (self.ui).canvasScale)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (item.transform).localPosition = pos
  item:InitRoomInfo(roomIndex)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.roomItemDic)[roomIndex] = item
end

UIN3DFactoryCanvas.RefreshRoomEnergy = function(self, roomIndex, value, ceiling, speed)
  -- function num : 0_2
  if (self.roomItemDic)[roomIndex] ~= nil then
    ((self.roomItemDic)[roomIndex]):RefreshEnergy(value, ceiling, speed)
  end
end

UIN3DFactoryCanvas.RefreshAllRoomEnergy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  for _,item in ipairs((self.roomInfoPool).listItem) do
    item:RefreshEnergy()
  end
end

UIN3DFactoryCanvas.RefreshRoomEnterHero = function(self, roomIndex)
  -- function num : 0_4
  if (self.roomItemDic)[roomIndex] ~= nil then
    ((self.roomItemDic)[roomIndex]):RefreshEnteredHeroNum()
  end
end

UIN3DFactoryCanvas.RefreshAllRoomEnterHero = function(self)
  -- function num : 0_5 , upvalues : _ENV
  for _,item in ipairs((self.roomInfoPool).listItem) do
    item:RefreshEnteredHeroNum()
  end
end

UIN3DFactoryCanvas.SetClickBackgroundCallback = function(self, clickBGCallback)
  -- function num : 0_6
  self.clickBGCallback = clickBGCallback
end

UIN3DFactoryCanvas.OnClickBackground = function(self)
  -- function num : 0_7
  if self.clickBGCallback ~= nil then
    (self.clickBGCallback)()
  end
end

UIN3DFactoryCanvas.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  (self.roomInfoPool):DeleteAll()
  self.roomItemDic = nil
  ;
  (base.OnDelete)(self)
end

return UIN3DFactoryCanvas


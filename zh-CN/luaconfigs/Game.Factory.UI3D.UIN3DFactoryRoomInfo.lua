-- params : ...
-- function num : 0 , upvalues : _ENV
local UIN3DFactoryRoomInfo = class("UIN3DFactoryRoomInfo", UIBaseNode)
local base = UIBaseNode
local eRoomType = (require("Game.Factory.FactoryEnum")).eRoomType
UIN3DFactoryRoomInfo.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIN3DFactoryRoomInfo.InitRoomInfo = function(self, index, roomEntityType, unlockDes)
  -- function num : 0_1 , upvalues : eRoomType, _ENV
  self.index = index
  if roomEntityType == eRoomType.locked then
    ((self.ui).obj_name):SetActive(false)
    ;
    ((self.ui).obj_unopen):SetActive(false)
    ;
    ((self.ui).obj_lock):SetActive(true)
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_RoomLookName).text = (LanguageUtil.GetLocaleText)(((ConfigData.factory)[self.index]).name)
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_Condition).text = unlockDes
  else
    if roomEntityType == eRoomType.notOpen then
      ((self.ui).obj_name):SetActive(false)
      ;
      ((self.ui).obj_unopen):SetActive(true)
      ;
      ((self.ui).obj_lock):SetActive(false)
    else
      ;
      ((self.ui).obj_name):SetActive(true)
      ;
      ((self.ui).obj_unopen):SetActive(false)
      ;
      ((self.ui).obj_lock):SetActive(false)
      -- DECOMPILER ERROR at PC78: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).tex_RoomName).text = (LanguageUtil.GetLocaleText)(((ConfigData.factory)[self.index]).name)
      self:SetRoomSeleced(false)
    end
  end
end

UIN3DFactoryRoomInfo.RefreshEnergy = function(self, value, ceiling, speed)
  -- function num : 0_2
end

UIN3DFactoryRoomInfo.RefreshEnteredHeroNum = function(self)
  -- function num : 0_3
end

UIN3DFactoryRoomInfo.SetRoomStateImage = function(self, roomEntityType)
  -- function num : 0_4 , upvalues : eRoomType
  if roomEntityType == eRoomType.locked then
    ((self.ui).img_RoomState):SetIndex(1)
  else
    if roomEntityType == eRoomType.notOpen then
      ((self.ui).img_RoomState):SetIndex(2)
    else
      ;
      ((self.ui).img_RoomState):SetIndex(0)
    end
  end
end

UIN3DFactoryRoomInfo.SetRoomSeleced = function(self, bool)
  -- function num : 0_5
  (((self.ui).img_RoomState).gameObject):SetActive(bool)
end

UIN3DFactoryRoomInfo.OnDelete = function(self)
  -- function num : 0_6 , upvalues : _ENV, base
  if self.lineNode ~= nil then
    RedDotController:RemoveListener((self.lineNode).nodePath, self.updateRedDot)
    self.lineNode = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIN3DFactoryRoomInfo


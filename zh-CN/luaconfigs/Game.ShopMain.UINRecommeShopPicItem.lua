-- params : ...
-- function num : 0 , upvalues : _ENV
local UINRecommeShopPicItem = class("UINRecommeShopPicItem", UIBaseNode)
local base = UIBaseNode
local JumpManager = require("Game.Jump.JumpManager")
UINRecommeShopPicItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.__couldClick = true
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_jump, self, self.OnClickRecommePicJump)
end

UINRecommeShopPicItem.InitRecommeShopPic = function(self, recommeCfg, resloader)
  -- function num : 0_1 , upvalues : _ENV
  self.recommeCfg = recommeCfg
  local textureName = (self.recommeCfg).imgIcon
  resloader:LoadABAssetAsync(PathConsts:GetShopRecommendPath(textureName), function(texture)
    -- function num : 0_1_0 , upvalues : _ENV, self
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

    if not IsNull(texture) then
      ((self.ui).img_Banner).texture = texture
      ;
      (((self.ui).img_Banner).gameObject):SetActive(false)
      ;
      (((self.ui).img_Banner).gameObject):SetActive(true)
    end
  end
)
end

UINRecommeShopPicItem.__GetIsSouldOut = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.recommeCfg == nil or (self.recommeCfg).jump_arg == nil then
    return false
  end
  local jumpTargetShopId = ((self.recommeCfg).jump_arg)[1]
  local jumpTargetShelfId = ((self.recommeCfg).jump_arg)[2]
  if jumpTargetShopId == nil or jumpTargetShelfId == nil then
    return false
  end
  local ShopController = ControllerManager:GetController(ControllerTypeId.Shop, true)
  return ShopController:GetShelfIsSouldOut(jumpTargetShopId, jumpTargetShelfId)
end

UINRecommeShopPicItem.UpdateSouldOut = function(self, getOneCallback, recycleOneCallback)
  -- function num : 0_3 , upvalues : _ENV
  if self:__GetIsSouldOut() then
    self.__couldClick = false
    do
      if self.souldGo == nil then
        local souldGo = getOneCallback()
        self.souldGo = souldGo
        ;
        ((self.souldGo).transform):SetParent(self.transform)
      end
      -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.souldGo).transform).anchoredPosition = Vector2.zero
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.souldGo).transform).sizeDelta = Vector2.zero
      ;
      (self.souldGo):Show()
      self.__couldClick = true
      if self.souldGo ~= nil then
        recycleOneCallback(self.souldGo)
      end
    end
  end
end

UINRecommeShopPicItem.OnClickRecommePicJump = function(self)
  -- function num : 0_4 , upvalues : JumpManager
  if not self.__couldClick then
    return 
  end
  if (self.recommeCfg).jump_target ~= nil and (self.recommeCfg).jump_target > 0 then
    JumpManager:Jump((self.recommeCfg).jump_target, nil, nil, (self.recommeCfg).jump_arg)
  end
end

return UINRecommeShopPicItem


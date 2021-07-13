-- params : ...
-- function num : 0 , upvalues : _ENV
local UINRoleHeadItem = class("UINRoleHeadItem", UIBaseNode)
local base = UIBaseNode
UINRoleHeadItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self.__OnClickRoot)
end

UINRoleHeadItem.InitRoleHeadItem = function(self, roleData, resloader, clickEvent, belongPlayer)
  -- function num : 0_1 , upvalues : _ENV
  self.roleData = roleData
  self.clickEvent = clickEvent
  self.isCommander = false
  if not belongPlayer or not PathConsts:GetCharacterPicPath(roleData:GetResPicName()) then
    local path = PathConsts:GetCharacterSmallPicPath(roleData:GetResPicName())
  end
  ;
  (((self.ui).img_HeroPic).gameObject):SetActive(belongPlayer)
  ;
  (((self.ui).img_MonsterPic).gameObject):SetActive(not belongPlayer)
  resloader:LoadABAssetAsync(path, function(texture)
    -- function num : 0_1_0 , upvalues : self, roleData, belongPlayer
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

    if self.roleData == roleData then
      if belongPlayer then
        ((self.ui).img_HeroPic).texture = texture
      else
        -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

        ;
        ((self.ui).img_MonsterPic).texture = texture
      end
    end
  end
)
  ;
  ((self.ui).career):SetActive(true)
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_Career).sprite = CRH:GetSprite(roleData:GetCarrerIcon(), CommonAtlasType.CareerCamp)
end

UINRoleHeadItem.InitCommanderHeadItem = function(self, resloader, clickEvent)
  -- function num : 0_2 , upvalues : _ENV
  self.roleData = nil
  self.clickEvent = clickEvent
  self.isCommander = true
  ;
  (((self.ui).img_HeroPic).gameObject):SetActive(false)
  ;
  (((self.ui).img_MonsterPic).gameObject):SetActive(true)
  resloader:LoadABAssetAsync(ResConsts.cmderHead, function(texture)
    -- function num : 0_2_0 , upvalues : self
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

    if self.isCommander then
      ((self.ui).img_MonsterPic).texture = texture
    end
  end
)
  ;
  ((self.ui).career):SetActive(false)
end

UINRoleHeadItem.AlphaRoleHeadItem = function(self, transparent)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).canvasGroup).alpha = transparent and (self.ui).transparentValue or 1
end

UINRoleHeadItem.__OnClickRoot = function(self)
  -- function num : 0_4
  if self.clickEvent ~= nil then
    (self.clickEvent)(self.roleData, self.isCommander)
  end
end

UINRoleHeadItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINRoleHeadItem


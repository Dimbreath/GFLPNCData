local UINGameNoticeBannerItem = class("UINGameNoticeBannerItem", UIBaseNode)
local base = UIBaseNode
UINGameNoticeBannerItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).button, self, self.__OnClick)
end

UINGameNoticeBannerItem.UpdateGNBanner = function(self, gameNoticeData, onClickCallback)
  -- function num : 0_1
  self.gameNoticeData = gameNoticeData
  self._onClickCallback = onClickCallback
  self:Show()
  self:LoadBannerTexture(gameNoticeData)
end

UINGameNoticeBannerItem.LoadBannerTexture = function(self, gameNoticeData)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).img_advItem).enabled = false
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).button).interactable = false
  local ctrl = ControllerManager:GetController(ControllerTypeId.GameNotice)
  ctrl:GetNoticPicFromHTTP(gameNoticeData.targetUrl, gameNoticeData.picName, function(texture)
    -- function num : 0_2_0 , upvalues : _ENV, self
    if IsNull(self.gameObject) then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_advItem).texture = texture
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_advItem).enabled = true
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).button).interactable = true
  end
)
end

UINGameNoticeBannerItem.__OnClick = function(self)
  -- function num : 0_3
  if self._onClickCallback ~= nil then
    (self._onClickCallback)(self.gameNoticeData)
  end
end

UINGameNoticeBannerItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : _ENV, base
  DestroyUnityObject(((self.ui).img_advItem).texture)
  ;
  (base.OnDelete)(self)
end

return UINGameNoticeBannerItem


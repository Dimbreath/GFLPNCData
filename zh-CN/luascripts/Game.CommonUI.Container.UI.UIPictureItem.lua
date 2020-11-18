-- params : ...
-- function num : 0 , upvalues : _ENV
local UIPictureItem = class("UIPictureItem", UIBaseNode)
UIPictureItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.img_Pic = (self.ui).advItem
  ;
  (UIUtil.AddButtonListener)((self.ui).button, self, self.OnClick)
  self.__OnOpenUrl = BindCallback(self, self.OnOpenUrl)
end

UIPictureItem.InitPictureItem = function(self, index, resPath, resloader, url)
  -- function num : 0_1 , upvalues : _ENV
  self.url = url
  self.index = index
  resloader:LoadABAssetAsync(resPath, function(picture)
    -- function num : 0_1_0 , upvalues : _ENV, self, index
    if IsNull(picture) then
      return 
    end
    if self.index ~= index then
      return 
    end
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self.img_Pic).texture = picture
  end
)
end

UIPictureItem.OnClick = function(self)
  -- function num : 0_2 , upvalues : _ENV
  ((CS.MessageCommon).ShowMessageBox)(ConfigData:GetTipContent(TipContent.bannerJumpMention), ConfigData:GetTipContent(TipContent.commonConfirm), ConfigData:GetTipContent(TipContent.commonCancle), self.__OnOpenUrl, nil)
end

UIPictureItem.OnOpenUrl = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (((CS.UnityEngine).Application).OpenURL)(self.url)
end

return UIPictureItem


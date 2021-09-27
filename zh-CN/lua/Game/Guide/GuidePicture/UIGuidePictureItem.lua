local UIGuidePictureItem = class("UIGuidePictureItem", UIBaseNode)
UIGuidePictureItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.img_Pic = (self.transform):FindComponent("Img_Pic", eUnityComponentID.RawImage)
end

UIGuidePictureItem.InitPictureItem = function(self, index, resPath, resloader)
  -- function num : 0_1 , upvalues : _ENV
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

return UIGuidePictureItem


local UIHPreviewItem = class("UIHPreviewItem", UIBaseNode)
local base = UIBaseNode
local previewType = (require("Game.Hero.NewUI.UpgradeStar.eHeroStarUpEnum")).previewType
UIHPreviewItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_PreItem, self, self.__OnClickPreItem)
end

UIHPreviewItem.InitPreviewItem = function(self, index, preData, clickAction)
  -- function num : 0_1 , upvalues : previewType
  self.index = index
  self.clickAction = clickAction
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = preData.name
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

  if preData.preType == previewType.normal then
    ((self.ui).btn_PreItem).interactable = false
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).img_special).color = (self.ui).col_Normal
    ;
    ((self.ui).img_CanClick):SetActive(false)
  else
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).btn_PreItem).interactable = true
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).img_special).color = (self.ui).col_Special
    ;
    ((self.ui).img_CanClick):SetActive(true)
  end
end

UIHPreviewItem.__OnClickPreItem = function(self)
  -- function num : 0_2
  if self.clickAction ~= nil then
    (self.clickAction)(self.index)
  end
end

UIHPreviewItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UIHPreviewItem


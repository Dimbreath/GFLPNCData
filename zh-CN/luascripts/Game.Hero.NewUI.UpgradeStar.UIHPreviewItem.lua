-- params : ...
-- function num : 0 , upvalues : _ENV
local UIHPreviewItem = class("UIHPreviewItem", UIBaseNode)
local base = UIBaseNode
UIHPreviewItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_PreItem, self, self.__OnClickPreItem)
end

UIHPreviewItem.InitPreviewItem = function(self, index, preData, clickAction)
  -- function num : 0_1
  self.index = index
  self.clickAction = clickAction
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = preData.name
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

  if preData.preType == 2 then
    ((self.ui).btn_PreItem).interactable = true
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).img_special).color = (self.ui).col_Special
    ;
    ((self.ui).img_CanClick):SetActive(true)
  else
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).btn_PreItem).interactable = false
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).img_special).color = (self.ui).col_Normal
    ;
    ((self.ui).img_CanClick):SetActive(false)
  end
end

UIHPreviewItem.__OnClickPreItem = function(self)
  -- function num : 0_2
  if self.clickAction ~= nil then
    (self.clickAction)(self.index)
  end
end

UIHPreviewItem.OnDelect = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UIHPreviewItem


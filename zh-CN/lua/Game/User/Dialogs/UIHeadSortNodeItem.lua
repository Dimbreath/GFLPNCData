local UIHeadSortNodeItem = class("UIHeadSortNodeItem", UIBaseNode)
local base = UIBaseNode
UIHeadSortNodeItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_SortItem, self, self.OnSwitchValueChange)
  self.portrait_types = (ConfigData.portrait).types
  self.portrait_frame_types = (ConfigData.portrait_frame).types
end

UIHeadSortNodeItem.InitNodeItem = function(self, name, id)
  -- function num : 0_1
  ((self.ui).img_IsSelect):SetActive(false)
end

UIHeadSortNodeItem.InitNodeItemCId = function(self, id, isHead)
  -- function num : 0_2 , upvalues : _ENV
  self.isHead = isHead
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  if isHead then
    ((self.ui).tex_Types).text = (LanguageUtil.GetLocaleText)((self.portrait_types)[id])
    self.typeId = id
    ;
    ((self.ui).img_IsSelect):SetActive(false)
  else
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Types).text = (LanguageUtil.GetLocaleText)((self.portrait_frame_types)[id])
    self.typeId = id
    ;
    ((self.ui).img_IsSelect):SetActive(false)
  end
end

UIHeadSortNodeItem.SelectActivityTag = function(self, typeId)
  -- function num : 0_3
  if self.typeId == typeId then
    self:OnSwitchValueChange(true)
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tog_SortItem).isOn = true
  else
    self:OnSwitchValueChange(false)
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tog_SortItem).isOn = false
  end
end

UIHeadSortNodeItem.OnSwitchValueChange = function(self, flag)
  -- function num : 0_4
  if flag then
    ((self.ui).img_IsSelect):SetActive(true)
    if self.changeValueFunc ~= nil then
      (self.changeValueFunc)(self.typeId, ((self.ui).tex_Types).text)
    end
  else
    ;
    ((self.ui).img_IsSelect):SetActive(false)
  end
end

UIHeadSortNodeItem.OnDelte = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UIHeadSortNodeItem


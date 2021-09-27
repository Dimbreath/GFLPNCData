local UINCSTreeTogItem = class("UINCSTreeTogItem", UIBaseNode)
local base = UIBaseNode
UINCSTreeTogItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self._OnClickRoot)
end

UINCSTreeTogItem.InitCSTreeTogItem = function(self, treeData, clickFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.treeData = treeData
  self.clickFunc = clickFunc
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(treeData:GetName())
  self:SetCSTreeTogItemSelect(false)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

  if treeData:IsCmdTreeUnlock() then
    ((self.ui).img_lock).color = (self.ui).col_normal
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).color = (self.ui).col_normal
    ;
    (((self.ui).img_lock).gameObject):SetActive(false)
  else
    ;
    (((self.ui).img_lock).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_lock).color = (self.ui).col_lockImg
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).color = (self.ui).col_lockText
  end
end

UINCSTreeTogItem.SetCSTreeTogItemSelect = function(self, select)
  -- function num : 0_2
  ((self.ui).obj_Select):SetActive(select)
end

UINCSTreeTogItem._OnClickRoot = function(self)
  -- function num : 0_3
  if self.clickFunc ~= nil then
    (self.clickFunc)((self.treeData).treeId)
  end
end

UINCSTreeTogItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINCSTreeTogItem


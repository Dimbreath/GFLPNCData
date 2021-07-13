-- params : ...
-- function num : 0 , upvalues : _ENV
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

UINCSTreeTogItem.RefreshCSTreeTogItemBlueDot = function(self)
  -- function num : 0_4
  ((self.ui).obj_RedDot):SetActive(false)
end

UINCSTreeTogItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINCSTreeTogItem


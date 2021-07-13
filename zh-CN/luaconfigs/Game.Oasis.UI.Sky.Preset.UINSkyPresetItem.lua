-- params : ...
-- function num : 0 , upvalues : _ENV
local UINSkyPresetItem = class("UINSkyPresetItem", UIBaseNode)
local base = UIBaseNode
UINSkyPresetItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Root, self, self._OnTogValueChange)
end

UINSkyPresetItem.InitSkyPresetItem = function(self, index, name, selectFunc)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R4 in 'UnsetPending'

  if index ~= 0 then
    ((self.ui).tex_Name).text = name
  end
  self.index = index
  self.selectFunc = selectFunc
end

UINSkyPresetItem.SetSkyPresetItemTogOn = function(self)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).tog_Root).isOn = true
end

UINSkyPresetItem._OnTogValueChange = function(self, isOn)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  if not isOn or not Color.black then
    ((self.ui).tex_Name).color = Color.white
    if isOn and self.selectFunc ~= nil then
      (self.selectFunc)(self.index)
    end
  end
end

UINSkyPresetItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINSkyPresetItem


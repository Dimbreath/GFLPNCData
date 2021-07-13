-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthListSuitPartTog = class("UINAthListSuitPartTog", UIBaseNode)
local base = UIBaseNode
UINAthListSuitPartTog.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Root, self, self._OnClickToggleRoot)
end

UINAthListSuitPartTog.InitAthListSuitPartTog = function(self, partId, selectPartFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.partId = partId
  self.selectPartFunc = selectPartFunc
  if partId == 0 then
    ((self.ui).tex_Name):SetIndex(1)
  else
    ;
    ((self.ui).tex_Name):SetIndex(0, tostring(partId))
  end
end

UINAthListSuitPartTog.SetAthListSuitPartTogIsOn = function(self)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).tog_Root).isOn = true
end

UINAthListSuitPartTog._OnClickToggleRoot = function(self, isOn)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  if isOn then
    (((self.ui).tex_Name).text).color = Color.black
    if self.selectPartFunc ~= nil then
      (self.selectPartFunc)(self.partId)
    end
  else
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self.ui).tex_Name).text).color = (self.ui).color_Normal
  end
end

UINAthListSuitPartTog.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthListSuitPartTog


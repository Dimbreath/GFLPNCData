-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthInfoTogItem = class("UINAthInfoTogItem", UIBaseNode)
local base = UIBaseNode
UINAthInfoTogItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Root, self, self._OnTogValuieChange)
end

UINAthInfoTogItem.InitAthInfoTogItem = function(self, index, selectTogFunc)
  -- function num : 0_1
  self.index = index
  self.selectTogFunc = selectTogFunc
end

UINAthInfoTogItem.SetAthInfoTogOn = function(self)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).tog_Root).isOn = true
end

UINAthInfoTogItem._OnTogValuieChange = function(self, isOn)
  -- function num : 0_3 , upvalues : _ENV
  if isOn then
    if self.selectTogFunc ~= nil then
      (self.selectTogFunc)(self.index)
    end
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).text).color = Color.black
  else
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).text).color = (self.ui).color_Normal
  end
end

UINAthInfoTogItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthInfoTogItem


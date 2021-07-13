-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCurrentChipCareerItem = class("UINCurrentChipCareerItem", UIBaseNode)
local base = UIBaseNode
UINCurrentChipCareerItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINCurrentChipCareerItem.InitCareerTag = function(self, careerId, count, OnValueChangeFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.careerId = careerId
  self.count = count
  self.onValueChangeFunc = OnValueChangeFunc
  ;
  ((self.ui).img_Icon):SetIndex(self.careerId)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Count).text = tostring(count)
  local careerCfg = (ConfigData.career)[self.careerId]
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R5 in 'UnsetPending'

  if careerCfg == nil then
    ((self.ui).tex_Name).text = ConfigData:GetTipContent(5003)
  else
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(careerCfg.name)
  end
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_careerItem, self, self.OnValueChange)
end

UINCurrentChipCareerItem.Select = function(self, flag)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tog_careerItem).isOn = true
end

UINCurrentChipCareerItem.OnValueChange = function(self, flag)
  -- function num : 0_3
  if self.onValueChangeFunc ~= nil then
    (self.onValueChangeFunc)(self, flag)
  end
end

UINCurrentChipCareerItem.SetSelectState = function(self)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  if not ((self.ui).tog_careerItem).isOn or not (self.ui).color_selected_name then
    ((self.ui).tex_Name).color = (self.ui).color_unselect_name
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

    if not ((self.ui).tog_careerItem).isOn or not (self.ui).color_selected_texCount then
      ((self.ui).tex_Count).color = (self.ui).color_unselect_texCount
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

      if not ((self.ui).tog_careerItem).isOn or not (self.ui).color_selected_imgCount then
        ((self.ui).img_count).color = (self.ui).color_unselect_imgCount
        ;
        ((self.ui).img_careerItem):SetIndex(((self.ui).tog_careerItem).isOn and 0 or 1)
      end
    end
  end
end

return UINCurrentChipCareerItem


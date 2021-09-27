local UINAthListAreaTog = class("UINAthListAreaTog", UIBaseNode)
local base = UIBaseNode
UINAthListAreaTog.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Root, self, self._OnClickToggleRoot)
end

UINAthListAreaTog.InitAthListAreaTog = function(self, areaId, selectAreaFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.areaId = areaId
  self.selectAreaFunc = selectAreaFunc
  ;
  ((self.ui).img_Icon):SetIndex(areaId)
  if areaId == 0 then
    ((self.ui).tex_Name):SetIndex(0)
  else
    local areaCfg = (ConfigData.ath_area)[areaId]
    if areaCfg == nil then
      error("Can\'t find ath areaCfg, areaId = " .. tostring(areaId))
      return 
    end
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (((self.ui).tex_Name).text).text = (LanguageUtil.GetLocaleText)(areaCfg.name2)
  end
end

UINAthListAreaTog.SetAthListAreaTogIsOn = function(self)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).tog_Root).isOn = true
end

UINAthListAreaTog._OnClickToggleRoot = function(self, isOn)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  if isOn then
    (((self.ui).img_Icon).image).color = Color.black
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self.ui).tex_Name).text).color = Color.black
    if self.selectAreaFunc ~= nil then
      (self.selectAreaFunc)(self.areaId)
    end
  else
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self.ui).img_Icon).image).color = (self.ui).color_Normal
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self.ui).tex_Name).text).color = (self.ui).color_Normal
  end
end

UINAthListAreaTog.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthListAreaTog


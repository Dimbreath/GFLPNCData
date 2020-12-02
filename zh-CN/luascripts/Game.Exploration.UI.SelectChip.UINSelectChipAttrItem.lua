-- params : ...
-- function num : 0 , upvalues : _ENV
local UINSelectChipAttrItem = class("UINSelectChipAttrItem", UIBaseNode)
UINSelectChipAttrItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  (self.ui).tex_AttrName = (self.transform):FindComponent("Tex_AttrName", eUnityComponentID.ExText)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).tex_Num = (self.transform):FindComponent("Tex_Num", eUnityComponentID.ExText)
end

UINSelectChipAttrItem.InitChipAttrItem = function(self, attrId, initValue, increaseValue, count)
  -- function num : 0_1 , upvalues : _ENV
  local attibuteCfg = (ConfigData.attribute)[attrId]
  if attibuteCfg == nil then
    error("Can\'t find attibuteCfg, id = " .. tostring(attrId))
    return 
  end
  if not count then
    count = 1
  end
  local atrName = (LanguageUtil.GetLocaleText)(attibuteCfg.name)
  local isRatio = attibuteCfg.num_type == 2
  local value = initValue + (increaseValue or 0) * (count - 1)
  if not isRatio or not tostring(FormatNum(value / 10)) .. "%" then
    local valueStr = (tostring(value))
  end
  local sign = nil
  if value < 0 then
    sign = ""
  else
    sign = "+"
  end
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R11 in 'UnsetPending'

  ;
  ((self.ui).tex_AttrName).text = atrName
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R11 in 'UnsetPending'

  ;
  ((self.ui).tex_Num).text = sign .. valueStr
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

return UINSelectChipAttrItem


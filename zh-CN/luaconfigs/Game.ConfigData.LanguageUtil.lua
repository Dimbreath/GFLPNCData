-- params : ...
-- function num : 0 , upvalues : _ENV
LanguageUtil = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

LanguageUtil.GetLocaleText = function(idx)
  -- function num : 0_0 , upvalues : _ENV
  if type(idx) ~= "number" then
    return idx
  end
  return (ConfigData.locale_text)[idx]
end

local cn_Rule = {
{unitStr = 147, num = 10000}
}
-- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

LanguageUtil.GetNum2UnitStr = function(num, n)
  -- function num : 0_1 , upvalues : _ENV, cn_Rule
  local finStr = ""
  local float = nil
  for k,v in ipairs(cn_Rule) do
    if v.num <= num then
      float = GetPreciseDecimalStr(num / v.num, n)
      finStr = float .. ConfigData:GetTipContent(v.unitStr)
    else
      finStr = tostring(num)
    end
  end
  return tostring(finStr)
end



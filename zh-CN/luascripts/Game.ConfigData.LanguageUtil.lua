-- params : ...
-- function num : 0 , upvalues : _ENV
LanguageUtil = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

LanguageUtil.GetLocaleText = function(idx)
    -- function num : 0_0 , upvalues : _ENV
    if type(idx) ~= "number" then return idx end
    return (ConfigData.locale_text)[idx]
end


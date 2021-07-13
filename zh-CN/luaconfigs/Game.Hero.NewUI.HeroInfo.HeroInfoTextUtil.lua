-- params : ...
-- function num : 0 , upvalues : _ENV
local HeroInfoTextUtil = class("HeroInfoTextUtil")
local CS_LanguageGlobal = CS.LanguageGlobal
HeroInfoTextUtil.textCfgDic = nil
HeroInfoTextUtil.GetArchiveText = function(heroId, textKey)
  -- function num : 0_0 , upvalues : _ENV, HeroInfoTextUtil, CS_LanguageGlobal
  local heroCfg = (ConfigData.hero_data)[heroId]
  if heroCfg == nil then
    error("Cant get hero_data, heroId = " .. tostring(heroId))
    return 
  end
  local resCfg = (ConfigData.resource_model)[heroCfg.src_id]
  if resCfg == nil then
    error("resource model Cfg is null,id:" .. tostring(heroCfg.src_id))
    return 
  end
  if HeroInfoTextUtil.textCfgDic == nil then
    HeroInfoTextUtil.textCfgDic = {}
  end
  local textCfg = (HeroInfoTextUtil.textCfgDic)[heroId]
  if textCfg == nil then
    local lang = (CS_LanguageGlobal.GetLanguageStr)()
    do
      local langPath = "CharacterTextConfig." .. resCfg.res_Name .. "_" .. lang
      local ok, err = pcall(function()
    -- function num : 0_0_0 , upvalues : textCfg, _ENV, langPath
    textCfg = require(langPath)
    textCfg.cfgPath = langPath
    return true
  end
)
      if not ok then
        error("Can\'t get textCfg, path = " .. langPath .. ",\n" .. err)
        return 
      end
      -- DECOMPILER ERROR at PC57: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (HeroInfoTextUtil.textCfgDic)[heroId] = textCfg
    end
  end
  do
    local text = textCfg[textKey]
    if (string.IsNullOrEmpty)(text) then
      error("Can\'t get Language, heroId = " .. tostring(heroId) .. ", textKey = " .. tostring(textKey))
      return 
    end
    return text
  end
end

HeroInfoTextUtil.RemoveArchiveText = function(heroId)
  -- function num : 0_1 , upvalues : HeroInfoTextUtil, _ENV
  local textCfg = (HeroInfoTextUtil.textCfgDic)[heroId]
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  if textCfg ~= nil then
    (package.loaded)[textCfg.cfgPath] = nil
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (HeroInfoTextUtil.textCfgDic)[heroId] = nil
    collectgarbage()
  end
end

HeroInfoTextUtil.RemoveAllArchiveText = function()
  -- function num : 0_2 , upvalues : HeroInfoTextUtil, _ENV
  if HeroInfoTextUtil.textCfgDic ~= nil then
    for k,textCfg in pairs(HeroInfoTextUtil.textCfgDic) do
      -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

      (package.loaded)[textCfg.cfgPath] = nil
    end
  end
  do
    HeroInfoTextUtil.textCfgDic = nil
    collectgarbage()
  end
end

HeroInfoTextUtil.Delete = function()
  -- function num : 0_3 , upvalues : HeroInfoTextUtil
  (HeroInfoTextUtil.RemoveAllArchiveText)()
end

return HeroInfoTextUtil


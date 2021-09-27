local JumpStrBuilder = {}
local JumpManager = require("Game.Jump.JumpManager")
local getDesDic = {[(JumpManager.eJumpTarget).fragDungeon] = function(eJumpTarget, args, oringinalStr)
  -- function num : 0_0 , upvalues : _ENV
  local heroname = nil
  local heroId = args[1]
  local cfg = (ConfigData.hero_data)[heroId]
  if cfg == nil then
    error("can\'t read heroname with dungeonId" .. tostring(heroId))
    heroname = ""
  else
    heroname = (LanguageUtil.GetLocaleText)(cfg.name)
  end
  return (string.format)(oringinalStr, heroname)
end
, [(JumpManager.eJumpTarget).resourceDungeon] = function(eJumpTarget, args, oringinalStr)
  -- function num : 0_1 , upvalues : _ENV
  local name = nil
  local dungeonId = args[1]
  local cfg = (ConfigData.material_dungeon)[dungeonId]
  if cfg == nil then
    error("can\'t read dungeonCfg with dungeonId" .. tostring(dungeonId))
    name = ""
  else
    name = (LanguageUtil.GetLocaleText)(cfg.name)
  end
  return (string.format)(oringinalStr, name)
end
, [(JumpManager.eJumpTarget).ATHDungeon] = function(eJumpTarget, args, oringinalStr)
  -- function num : 0_2 , upvalues : _ENV
  local name = nil
  local dungeonId = args[1]
  local cfg = (ConfigData.material_dungeon)[dungeonId]
  if cfg == nil then
    error("can\'t read dungeonCfg with dungeonId" .. tostring(dungeonId))
    name = ""
  else
    name = (LanguageUtil.GetLocaleText)(cfg.name)
  end
  return (string.format)(oringinalStr, name)
end
, [(JumpManager.eJumpTarget).DynShop] = function(eJumpTarget, args, oringinalStr)
  -- function num : 0_3 , upvalues : _ENV
  local shopName = nil
  local shopId = args[1]
  local shopCfg = (ConfigData.shop)[shopId]
  if shopCfg == nil then
    error("can\'t read shopCfg with shopId" .. tostring(shopId))
    shopName = ""
  else
    shopName = (LanguageUtil.GetLocaleText)(shopCfg.name)
  end
  return (string.format)(oringinalStr, shopName)
end
, [(JumpManager.eJumpTarget).ShopBase] = function(eJumpTarget, args, oringinalStr)
  -- function num : 0_4 , upvalues : _ENV
  local shopName = nil
  local shopId = args[1]
  local shopCfg = (ConfigData.shop)[shopId]
  if shopCfg == nil then
    error("can\'t read shopCfg with shopId" .. tostring(shopId))
    shopName = ""
  else
    shopName = (LanguageUtil.GetLocaleText)(shopCfg.name)
  end
  return (string.format)(oringinalStr, shopName)
end
}
JumpStrBuilder.GetDes = function(eJumpTarget, args, oringinalStr)
  -- function num : 0_5 , upvalues : getDesDic
  local func = getDesDic[eJumpTarget]
  if func ~= nil then
    return func(eJumpTarget, args, oringinalStr)
  else
    return oringinalStr
  end
end

return JumpStrBuilder


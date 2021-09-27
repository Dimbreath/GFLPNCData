local FactoryHelper = class("FactoryHelper")
FactoryHelper.GetFactoryTime2EnergyCost = function(time)
  -- function num : 0_0 , upvalues : _ENV
  local constant = (ConfigData.game_config).factoryEnergy2TimeCons
  return (math.ceil)(time / constant)
end

FactoryHelper.ConvertTime2DisplayMode = function(time)
  -- function num : 0_1 , upvalues : _ENV
  local str = "%02d:%02d:%02d"
  local hour = (math.floor)(time // 3600)
  local min = (math.floor)(time % 3600 / 60)
  local second = (math.floor)(time % 60)
  return (string.format)(str, hour, min, second)
end

return FactoryHelper


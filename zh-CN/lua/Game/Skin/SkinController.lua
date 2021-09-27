local SkinController = class("SkinController", ControllerBase)
local base = ControllerBase
local SkinConditionFunc = require("Game.Skin.SkinConditionFunc")
SkinController.GetHeroId = function(self, skinId)
  -- function num : 0_0 , upvalues : _ENV
  local cfg = (ConfigData.skin)[skinId]
  if cfg == nil then
    return nil
  end
  return cfg.heroId
end

SkinController.GetResModel = function(self, heroId, skinId)
  -- function num : 0_1 , upvalues : _ENV
  local heroCfg = (ConfigData.hero_data)[heroId]
  local cfg = nil
  if heroCfg ~= nil then
    cfg = (ConfigData.resource_model)[heroCfg.src_id]
  else
    error("hero_data is NULL  id:" .. tostring(heroId))
    return 
  end
  if cfg == nil then
    error("resource_model is NULL  id:" .. tostring(heroCfg.src_id))
    return 
  end
  return self:UpdateResModel(cfg, skinId)
end

SkinController.UpdateResModel = function(self, resmodelCfg, skinId)
  -- function num : 0_2 , upvalues : _ENV
  local cfg = (setmetatable({}, {__index = resmodelCfg}))
  local skinCfg = nil
  if skinId or 0 ~= 0 then
    skinCfg = (ConfigData.skin)[skinId]
  end
  if skinCfg == nil or skinCfg.skin_locked then
    cfg.src_id_pic = resmodelCfg.res_Name
    cfg.src_id_model = resmodelCfg.res_Name
  else
    if not (string.IsNullOrEmpty)(skinCfg.src_id_pic) or not resmodelCfg.res_Name then
      cfg.src_id_pic = skinCfg.src_id_pic
      if not (string.IsNullOrEmpty)(skinCfg.src_id_model) or not resmodelCfg.res_Name then
        cfg.src_id_model = skinCfg.src_id_model
        return cfg
      end
    end
  end
end

SkinController.CheckSourceValid = function(self, skinId)
  -- function num : 0_3 , upvalues : _ENV, SkinConditionFunc
  if skinId == nil or not (PlayerDataCenter.skinData):IsUseful(skinId) then
    return false
  end
  local skinCfg = (ConfigData.skin)[skinId]
  if skinCfg == nil or skinCfg.condition == nil then
    return false
  end
  local func = SkinConditionFunc[skinCfg.condition]
  if func == nil then
    return false
  end
  return func(skinCfg)
end

return SkinController


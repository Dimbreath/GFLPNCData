-- params : ...
-- function num : 0 , upvalues : _ENV
AtlasUtil = {}
local cs_FilePathHelper = (CS.FilePathHelper).Instance
-- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

AtlasUtil.GetSpriteFromAtlas = function(atlasName, sName, resloader)
  -- function num : 0_0 , upvalues : cs_FilePathHelper, _ENV
  local atlas = resloader:LoadABAsset(cs_FilePathHelper:GetAtlasAssetPath(atlasName))
  if IsNull(atlas) then
    return nil
  end
  local sprite = atlas:GetSprite(sName)
  if IsNull(sprite) then
    return nil
  end
  return sprite
end



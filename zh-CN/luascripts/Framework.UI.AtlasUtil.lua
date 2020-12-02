-- params : ...
-- function num : 0 , upvalues : _ENV
AtlasUtil = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

AtlasUtil.GetSpriteFromAtlas = function(atlasName, sName, resloader)
  -- function num : 0_0 , upvalues : _ENV
  local atlas = resloader:LoadABAsset(PathConsts:GetAtlasAssetPath(atlasName))
  if IsNull(atlas) then
    return nil
  end
  local sprite = atlas:GetSprite(sName)
  if IsNull(sprite) then
    return nil
  end
  return sprite
end



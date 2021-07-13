-- params : ...
-- function num : 0 , upvalues : _ENV
local CommonResHelper = {}
local AtlasResName = {"CommonIcon", "CompanyCareer", "ExplorationIcon", "SkillIcon", "BaseItemQuality", "HeroHeadIcon"}
CommonResHelper.Init = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._resloader = ((CS.ResLoader).Create)()
  self._commonAtlas = {}
end

CommonResHelper.LoadCommonAtlas = function(self, cs_DownloadWindow, progress)
  -- function num : 0_1 , upvalues : AtlasResName, _ENV
  local atlasCount = #AtlasResName
  local atlasProgress = progress / atlasCount
  local maxProgress = cs_DownloadWindow:GetCurrentProgress() + progress
  for index,resName in ipairs(AtlasResName) do
    local atlasWait = (self._resloader):LoadABAssetAsyncAwait(PathConsts:GetSpriteAtlasPath(resName))
    ;
    (coroutine.yield)(atlasWait)
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R12 in 'UnsetPending'

    ;
    (self._commonAtlas)[index - 1] = atlasWait.Result
    cs_DownloadWindow:AddProgress(atlasProgress, progress)
  end
  self.atlasCount = (table.count)(self._commonAtlas)
end

CommonResHelper.GetSprite = function(self, spriteName, atlasType)
  -- function num : 0_2 , upvalues : _ENV
  if atlasType == nil or type(atlasType) ~= "number" then
    atlasType = 0
  end
  local atlas = (self._commonAtlas)[atlasType]
  if self.atlasCount <= atlasType or IsNull(atlas) then
    return nil
  end
  local sp = atlas:GetSprite(spriteName)
  return sp
end

return CommonResHelper


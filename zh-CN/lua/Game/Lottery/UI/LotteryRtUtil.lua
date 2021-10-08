local LotteryRtUtil = {}
local cs_UnityEngine = CS.UnityEngine
local cs_RenderTexture = cs_UnityEngine.RenderTexture
local cs_SystemInfo = cs_UnityEngine.SystemInfo
local cs_RenderTextureFormat = cs_UnityEngine.RenderTextureFormat
LotteryRtUtil.GetARGBHalfRtTemporary = function(w, h, depthBufferBits)
  -- function num : 0_0 , upvalues : cs_UnityEngine, cs_RenderTextureFormat, cs_RenderTexture
  local rtDesc = (cs_UnityEngine.RenderTextureDescriptor)(w, h, cs_RenderTextureFormat.ARGBHalf, depthBufferBits)
  local texture = (cs_RenderTexture.GetTemporary)(rtDesc)
  return texture
end

LotteryRtUtil.ReleaseTemporaryAndDestory = function(texture)
  -- function num : 0_1 , upvalues : cs_RenderTexture, cs_UnityEngine
  (cs_RenderTexture.ReleaseTemporary)(texture)
  ;
  ((cs_UnityEngine.GameObject).Destroy)(texture)
end

LotteryRtUtil.SupportsRenderTextures = function(RenderTextureFormat)
  -- function num : 0_2 , upvalues : cs_SystemInfo
  return (cs_SystemInfo.SupportsRenderTextureFormat)(RenderTextureFormat)
end

return LotteryRtUtil


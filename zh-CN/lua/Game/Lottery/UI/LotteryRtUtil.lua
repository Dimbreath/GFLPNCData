local LotteryRtUtil = {}
local cs_UnityEngine = CS.UnityEngine
LotteryRtUtil.GetARGBHalfRtTemporary = function(w, h, depthBufferBits)
  -- function num : 0_0 , upvalues : cs_UnityEngine
  local rtDesc = (cs_UnityEngine.RenderTextureDescriptor)(w, h, (cs_UnityEngine.RenderTextureFormat).ARGBHalf, depthBufferBits)
  local texture = ((cs_UnityEngine.RenderTexture).GetTemporary)(rtDesc)
  return texture
end

LotteryRtUtil.ReleaseTemporaryAndDestory = function(texture)
  -- function num : 0_1 , upvalues : cs_UnityEngine
  ((cs_UnityEngine.RenderTexture).ReleaseTemporary)(texture)
  ;
  ((cs_UnityEngine.GameObject).Destroy)(texture)
end

return LotteryRtUtil


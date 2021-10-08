local AvgPostProcess = class("AvgPostProcess")
local CS_ppColorGrading = (((CS.UnityEngine).Rendering).PostProcessing).ColorGrading
local CS_ppDepthOfField = (((CS.UnityEngine).Rendering).PostProcessing).DepthOfField
local CS_DOTween = ((CS.DG).Tweening).DOTween
local cs_Ease = ((CS.DG).Tweening).Ease
local CS_RenderTextureFormat = (CS.UnityEngine).RenderTextureFormat
local CS_SystemInfo = (CS.UnityEngine).SystemInfo
local eTweenName = {cg_saturation = 1, dof_focusDistance = 2}
local tweenDuration = 0.5
local avgBlurTweenEndValue = 5
AvgPostProcess.ctor = function(self, avgSystem)
  -- function num : 0_0
  self.avgSystem = avgSystem
  self.tweenDic = {}
end

AvgPostProcess.InitAvgPP = function(self, ppProfile)
  -- function num : 0_1 , upvalues : _ENV, CS_ppColorGrading, CS_ppDepthOfField
  (UIManager.csUIManager):EnableUIPPVolume(ppProfile)
  local ppVolume = (UIManager.csUIManager).UICamPPVolume
  local ok, ppColorGrading = (ppVolume:GetProfile()):TryGetSettings(typeof(CS_ppColorGrading))
  if ok then
    self.__ppColorGrading = ppColorGrading
  else
    error("Cant get ColorGrading")
  end
  local ok, ppDepthOfField = (ppVolume:GetProfile()):TryGetSettings(typeof(CS_ppDepthOfField))
  if ok then
    self.__ppDepthOfField = ppDepthOfField
    ;
    ((self.__ppDepthOfField).enabled):Override(false)
  else
    error("Cant get DepthOfField")
  end
end

AvgPostProcess.ChangeAvgPP = function(self, ppCfg)
  -- function num : 0_2 , upvalues : eTweenName, CS_DOTween, tweenDuration
  if ppCfg == nil then
    return 
  end
  local colorGradient = ppCfg.cg
  do
    if colorGradient ~= nil and self.__ppColorGrading ~= nil and colorGradient.saturation ~= nil then
      local tween = (self.tweenDic)[eTweenName.cg_saturation]
      if tween ~= nil then
        tween:Kill()
      end
      tween = (CS_DOTween.To)(function()
    -- function num : 0_2_0 , upvalues : self
    return ((self.__ppColorGrading).saturation).value
  end
, function(value)
    -- function num : 0_2_1 , upvalues : self
    ((self.__ppColorGrading).saturation):Override(value)
  end
, colorGradient.saturation, tweenDuration)
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (self.tweenDic)[eTweenName.cg_saturation] = tween
      tween:OnComplete(function()
    -- function num : 0_2_2 , upvalues : self, eTweenName
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    (self.tweenDic)[eTweenName.cg_saturation] = nil
    self:_OnTweenComplete()
  end
)
      tween:SetUpdate((self.avgSystem):AvgIgnoreTimeScale())
    end
    self:AvgBlurTween(ppCfg)
  end
end

AvgPostProcess.AvgBlurTween = function(self, ppCfg)
  -- function num : 0_3 , upvalues : eTweenName, CS_SystemInfo, CS_RenderTextureFormat, CS_DOTween, avgBlurTweenEndValue, cs_Ease
  local depthOfFieldTweenCfg = ppCfg.dofTween
  if depthOfFieldTweenCfg ~= nil and self.__ppDepthOfField ~= nil then
    local tween = (self.tweenDic)[eTweenName.dof_focusDistance]
    if tween ~= nil then
      tween:Kill()
    end
    if (CS_SystemInfo.SupportsRenderTextureFormat)(CS_RenderTextureFormat.ARGBHalf) then
      ((self.__ppDepthOfField).enabled):Override(true)
    end
    tween = (CS_DOTween.To)(function()
    -- function num : 0_3_0 , upvalues : depthOfFieldTweenCfg, avgBlurTweenEndValue
    local startValue = (1 - depthOfFieldTweenCfg.startValue) * avgBlurTweenEndValue
    return startValue
  end
, function(value)
    -- function num : 0_3_1 , upvalues : self
    ((self.__ppDepthOfField).focusDistance):Override(value)
  end
, avgBlurTweenEndValue, depthOfFieldTweenCfg.duration)
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self.tweenDic)[eTweenName.dof_focusDistance] = tween
    tween:OnComplete(function()
    -- function num : 0_3_2 , upvalues : self, eTweenName
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    (self.tweenDic)[eTweenName.dof_focusDistance] = nil
    ;
    ((self.__ppDepthOfField).enabled):Override(false)
    self:_OnTweenComplete()
  end
)
    ;
    (tween:SetUpdate((self.avgSystem):AvgIgnoreTimeScale())):SetEase(cs_Ease.InQuad)
  end
end

AvgPostProcess.SkipAvgPPV = function(self)
  -- function num : 0_4 , upvalues : _ENV
  for k,tween in pairs(self.tweenDic) do
    tween:Complete()
  end
end

AvgPostProcess._OnTweenComplete = function(self)
  -- function num : 0_5
  (self.avgSystem):OnAvgPPVTweenComplete()
end

AvgPostProcess.Delete = function(self)
  -- function num : 0_6 , upvalues : _ENV
  for k,tween in pairs(self.tweenDic) do
    if tween ~= nil then
      tween:Kill()
    end
  end
end

return AvgPostProcess


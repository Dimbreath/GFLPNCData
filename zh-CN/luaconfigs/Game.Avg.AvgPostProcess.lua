-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgPostProcess = class("AvgPostProcess")
local CS_ppColorGrading = (((CS.UnityEngine).Rendering).PostProcessing).ColorGrading
local CS_DOTween = ((CS.DG).Tweening).DOTween
local eTweenName = {cg_saturation = 1}
local tweenDuration = 0.5
AvgPostProcess.ctor = function(self, avgSystem)
  -- function num : 0_0
  self.avgSystem = avgSystem
  self.tweenDic = {}
end

AvgPostProcess.InitAvgPP = function(self, ppProfile)
  -- function num : 0_1 , upvalues : _ENV, CS_ppColorGrading
  (UIManager.csUIManager):EnableUIPPVolume(ppProfile)
  local ppVolume = (UIManager.csUIManager).UICamPPVolume
  local ok, ppColorGrading = (ppVolume:GetProfile()):TryGetSettings(typeof(CS_ppColorGrading))
  if ok then
    self.__ppColorGrading = ppColorGrading
  else
    error("Cant get ColorGrading")
  end
end

AvgPostProcess.ChangeAvgPP = function(self, ppCfg)
  -- function num : 0_2 , upvalues : eTweenName, CS_DOTween, tweenDuration
  if ppCfg == nil then
    return 
  end
  local colorGradient = ppCfg.cg
  if colorGradient ~= nil and colorGradient.saturation ~= nil then
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
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self.tweenDic)[eTweenName.cg_saturation] = tween
    tween:OnComplete(function()
    -- function num : 0_2_2 , upvalues : self, eTweenName
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    (self.tweenDic)[eTweenName.cg_saturation] = nil
  end
)
    tween:SetUpdate((self.avgSystem):AvgIgnoreTimeScale())
  end
end

AvgPostProcess.Delete = function(self)
  -- function num : 0_3 , upvalues : _ENV
  for k,tween in pairs(self.tweenDic) do
    if tween ~= nil then
      tween:Kill()
    end
  end
end

return AvgPostProcess


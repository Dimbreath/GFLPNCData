local UINFormationChioceCareerTog = class("UINFormationChioceCareerTog", UIBaseNode)
local base = UIBaseNode
UINFormationChioceCareerTog.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Filtrate, self, self.OnValueChangeCareer)
end

UINFormationChioceCareerTog.InitCareerTog = function(self, careerId, onValueChange)
  -- function num : 0_1 , upvalues : _ENV
  self._OnValueChange = onValueChange
  self.careerId = careerId
  ;
  ((self.ui).obj_HasEvaluation):SetActive(false)
  local careerCfg = (ConfigData.career)[self.careerId]
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R4 in 'UnsetPending'

  if careerCfg ~= nil then
    ((self.ui).img_Icon).sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_Naem).text = (LanguageUtil.GetLocaleText)(careerCfg.name)
  end
end

UINFormationChioceCareerTog.SetEvaluation = function(self, isAdvantage)
  -- function num : 0_2
  ((self.ui).obj_HasEvaluation):SetActive(isAdvantage)
end

UINFormationChioceCareerTog.OnValueChangeCareer = function(self, flag)
  -- function num : 0_3 , upvalues : _ENV
  if flag and self._OnValueChange ~= nil then
    if not self._notClickTog then
      if self.careerId == 0 then
        AudioManager:PlayAudioById(4100)
      else
        local careerCfg = (ConfigData.career)[self.careerId]
        AudioManager:PlayAudioById(careerCfg.click_audio)
      end
    end
    do
      ;
      (self._OnValueChange)(self.careerId, self)
    end
  end
end

UINFormationChioceCareerTog.SetTogState = function(self, flag)
  -- function num : 0_4
  if ((self.ui).tog_Filtrate).isOn == flag then
    self._notClickTog = true
    self:OnValueChangeCareer(flag)
    self._notClickTog = false
  else
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tog_Filtrate).isOn = flag
  end
end

return UINFormationChioceCareerTog


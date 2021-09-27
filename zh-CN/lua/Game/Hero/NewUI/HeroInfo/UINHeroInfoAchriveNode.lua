local UINHeroInfoAchriveNode = class("UINHeroInfoAchriveNode", UIBaseNode)
local base = UIBaseNode
local cs_DoTween = ((CS.DG).Tweening).DOTween
UINHeroInfoAchriveNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.lastInitHeroId = nil
end

UINHeroInfoAchriveNode.InitUsefulData = function(self, heroData, HeroInfoTextUtil, resloader)
  -- function num : 0_1
  self.heroData = heroData
  self.HeroInfoTextUtil = HeroInfoTextUtil
  self.resloader = resloader
end

UINHeroInfoAchriveNode.InitHeroInfoNode = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.lastInitHeroId == (self.heroData).dataId then
    return 
  end
  self.lastInitHeroId = (self.heroData).dataId
  local heroName = (self.heroData):GetName()
  local campName = (LanguageUtil.GetLocaleText)(((self.heroData):GetCampCfg()).name)
  local battleCareerName = (LanguageUtil.GetLocaleText)(((self.heroData):GetCareerCfg()).name)
  local birthday, model, cv, archives_career = (self.heroData):GetHeroArchiveInfo()
  local campIcon = (LanguageUtil.GetLocaleText)(((self.heroData):GetCampCfg()).icon)
  ;
  (self.resloader):LoadABAssetAsync(PathConsts:GetCampPicPath(campIcon), function(texture)
    -- function num : 0_2_0 , upvalues : _ENV, self
    if IsNull(self.transform) then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_buttom).texture = texture
  end
)
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = heroName
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).tex_Career).text = archives_career
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).tex_Type).text = model
  -- DECOMPILER ERROR at PC55: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).tex_Camp).text = campName
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).tex_Birthday).text = birthday
  -- DECOMPILER ERROR at PC61: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).tex_Pos).text = battleCareerName
  local careerText = ((self.HeroInfoTextUtil).GetArchiveText)((self.heroData).dataId, (ConfigData.game_config).heroInfoCareerTextKey)
  -- DECOMPILER ERROR at PC72: Confused about usage of register: R10 in 'UnsetPending'

  ;
  ((self.ui).tex_Record).text = careerText
  self:__InitAchriveTween()
end

UINHeroInfoAchriveNode.__InitAchriveTween = function(self)
  -- function num : 0_3 , upvalues : _ENV, cs_DoTween
  AudioManager:PlayAudioById(1121)
  if self.tweenSeq ~= nil then
    (self.tweenSeq):Restart()
    return 
  end
  local tweenSeq = (cs_DoTween.Sequence)()
  for index,component in ipairs((self.ui).tweenList) do
    tweenSeq:Append(((component:DOFade(0, 0.05)):SetLoops(2)):From())
  end
  tweenSeq:SetAutoKill(false)
  self.tweenSeq = tweenSeq
end

UINHeroInfoAchriveNode.OnTcpLogOut_HeroInfoNode = function(self)
  -- function num : 0_4
end

UINHeroInfoAchriveNode.OnDelete = function(self)
  -- function num : 0_5 , upvalues : _ENV, base
  (self.tweenSeq):Kill()
  self.tweenSeq = nil
  for index,component in ipairs((self.ui).tweenList) do
    component:DOKill()
  end
  ;
  (base.OnDelete)(self)
end

return UINHeroInfoAchriveNode


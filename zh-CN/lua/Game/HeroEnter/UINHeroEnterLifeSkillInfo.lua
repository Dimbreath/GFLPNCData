local UINHeroEnterLifeSkillInfo = class("UINHeroEnterLifeSkillInfo", UIBaseNode)
local base = UIBaseNode
UINHeroEnterLifeSkillInfo.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self:SetNewOneActive(false)
end

UINHeroEnterLifeSkillInfo.SetNewOneActive = function(self, bool)
  -- function num : 0_1
  ((self.ui).image):SetActive(bool)
  ;
  (((self.ui).tex_NewNum).gameObject):SetActive(bool)
  ;
  (((self.ui).new_SkillItem).gameObject):SetActive(bool)
end

UINHeroEnterLifeSkillInfo.InitLifeSkill = function(self, skillCfg, newSkillCfg, resloader)
  -- function num : 0_2 , upvalues : _ENV
  self:SetNewOneActive(true)
  if newSkillCfg == nil then
    (((self.ui).new_SkillItem).gameObject):SetActive(false)
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_NewNum).text = ConfigData:GetTipContent(TipContent.HeroEnter_notHaveLifeSkill)
  else
    ;
    (((self.ui).new_SkillItem).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_NewNum).text = (LanguageUtil.GetLocaleText)(((newSkillCfg.lifeSkillCfg)[newSkillCfg.level]).name)
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).img_new).texture = resloader:LoadABAsset(PathConsts:GetSkillIconPath(newSkillCfg:GetIcon()))
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_newSkillLevel).text = tostring(newSkillCfg.level)
  end
  if skillCfg == nil then
    (((self.ui).old_SkillItem).gameObject):SetActive(false)
    -- DECOMPILER ERROR at PC67: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_OldNum).text = ConfigData:GetTipContent(TipContent.HeroEnter_notHaveLifeSkill)
  else
    ;
    (((self.ui).old_SkillItem).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC84: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_OldNum).text = (LanguageUtil.GetLocaleText)(((skillCfg.lifeSkillCfg)[skillCfg.level]).name)
    -- DECOMPILER ERROR at PC94: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).img_old).texture = resloader:LoadABAsset(PathConsts:GetSkillIconPath(skillCfg:GetIcon()))
    -- DECOMPILER ERROR at PC100: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_oldSkillLevel).text = tostring(skillCfg.level)
  end
end

UINHeroEnterLifeSkillInfo.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINHeroEnterLifeSkillInfo


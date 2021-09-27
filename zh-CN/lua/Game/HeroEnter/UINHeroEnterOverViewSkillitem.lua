local UINHeroEnterOverViewSkillitem = class("UINHeroEnterOverViewSkillitem", UIBaseNode)
local base = UIBaseNode
UINHeroEnterOverViewSkillitem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINHeroEnterOverViewSkillitem.InitLifeSkill = function(self, skillCfg, resloader)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).img_SkillPic).texture = resloader:LoadABAsset(PathConsts:GetSkillIconPath(skillCfg:GetIcon()))
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_SkillLevel).text = tostring(skillCfg.level)
end

UINHeroEnterOverViewSkillitem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINHeroEnterOverViewSkillitem


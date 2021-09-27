local UINSupportHeroSkill = class("UINSupportHeroSkill", UIBaseNode)
local base = UIBaseNode
local UINBaseSkillItem = require("Game.CommonUI.Item.UINBaseSkillItem")
local cs_Edge = ((CS.UnityEngine).RectTransform).Edge
UINSupportHeroSkill.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseSkillItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.skillItem = (UINBaseSkillItem.New)()
  ;
  (self.skillItem):Init((self.ui).uINSkillItem)
  ;
  (((self.ui).btn_ShowIntro).gameObject):SetActive(false)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ShowIntro, self, self.OnShowIntroClick)
end

UINSupportHeroSkill.InitSupportHeroSkill = function(self, skillData, resloader)
  -- function num : 0_1 , upvalues : _ENV
  self.skillData = skillData
  if skillData == nil then
    error("skillData is NIL")
    return 
  end
  ;
  (self.skillItem):InitBaseSkillItem(skillData, resloader)
  ;
  ((self.ui).tex_Type):SetIndex(skillData:GetSkillTag() - 1)
  local skillCD = skillData:GetCurrentSkillCDTime()
  if skillCD == 0 then
    (((((self.ui).tex_CD).transform).parent).gameObject):SetActive(false)
  else
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_CD).text = GetPreciseDecimalStr(skillCD, 1) .. "s"
  end
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = skillData:GetName()
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Descr).text = skillData:GetCurLevelDescribe()
  local isFullLevel = skillData:IsFullLevel()
  if isFullLevel then
    ((self.ui).tex_Lv):SetIndex(1)
  else
    ;
    ((self.ui).tex_Lv):SetIndex(0, tostring(skillData.level))
  end
  ;
  ((self.ui).lock):SetActive(not skillData:GetIsUnlock())
  self:RefreshBtnShowIntro()
end

UINSupportHeroSkill.RefreshBtnShowIntro = function(self)
  -- function num : 0_2
  if self.skillData == nil then
    (((self.ui).btn_ShowIntro).gameObject):SetActive(false)
    return 
  end
  local active = (self.skillData):HaveSkillLabeId()
  ;
  (((self.ui).btn_ShowIntro).gameObject):SetActive(active)
end

UINSupportHeroSkill.UpdateLevelDescribe = function(self)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  if self.skillData ~= nil then
    ((self.ui).tex_Descr).text = (self.skillData):GetCurLevelDescribe()
  end
end

UINSupportHeroSkill.OnShowIntroClick = function(self)
  -- function num : 0_4 , upvalues : _ENV, cs_Edge
  UIManager:ShowWindowAsync(UIWindowTypeID.RichIntro, function(win)
    -- function num : 0_4_0 , upvalues : self, cs_Edge
    if win ~= nil then
      win:ShowIntroBySkillData((self.ui).richIntroHolder, self.skillData)
      win:SetIntroListPosition(cs_Edge.Left, cs_Edge.Top)
    end
  end
)
end

return UINSupportHeroSkill


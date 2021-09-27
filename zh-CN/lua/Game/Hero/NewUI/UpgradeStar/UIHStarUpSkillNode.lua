local UIHStarUpSkillNode = class("UIHStarUpSkillNode", UIBaseNode)
local base = UIBaseNode
local UINBaseSkillItem = require("Game.CommonUI.Item.UINBaseSkillItem")
local UIRichIntroItem = require("Game.CommonUI.RichIntro.UIRichIntroItem")
UIHStarUpSkillNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseSkillItem, UIRichIntroItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.skillItem = (UINBaseSkillItem.New)()
  ;
  (self.skillItem):Init((self.ui).skillItem)
  self.richIntroItemPool = (UIItemPool.New)(UIRichIntroItem, (self.ui).obj_richIntroItem)
  ;
  ((self.ui).obj_richIntroItem):SetActive(false)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Back, self, self.__OnClickBackButton)
end

UIHStarUpSkillNode.InitStarUpSkillNode = function(self, skillData, preUSkilllevel, resloader, unlockAdvance)
  -- function num : 0_1 , upvalues : _ENV
  (self.skillItem):InitBaseSkillItem(skillData, resloader)
  ;
  (self.skillItem):__SetUnlockUI(true)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

  if preUSkilllevel ~= nil then
    ((self.ui).tex_Name).text = skillData:GetName() .. " LV." .. tostring(preUSkilllevel)
  else
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).text = skillData:GetName()
  end
  local intro = nil
  if preUSkilllevel ~= nil then
    intro = skillData:GetLevelDescribe(preUSkilllevel)
  else
    intro = skillData:GetCurLevelDescribe(unlockAdvance)
  end
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Intro).text = intro
  local skillLabeList = skillData:GetSkillLabeIdList(preUSkilllevel or 1)
  ;
  (self.richIntroItemPool):HideAll()
  if skillLabeList ~= nil then
    for i = 1, #skillLabeList do
      local item = (self.richIntroItemPool):GetOne()
      local cfg = (ConfigData.skill_label_info)[skillLabeList[i]]
      if cfg ~= nil then
        item:InitRichIntroItem(cfg)
      end
    end
  end
  do
    ;
    ((self.ui).Ani_Fade):DORestart(false)
  end
end

UIHStarUpSkillNode.__OnClickBackButton = function(self)
  -- function num : 0_2
  self:Hide()
end

UIHStarUpSkillNode.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  ((self.ui).Ani_Fade):DOKill()
  ;
  (base.OnDelete)(self)
end

return UIHStarUpSkillNode


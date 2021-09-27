local UINDungeonInfoHeroDetailSkill = class("UINDungeonInfoHeroDetailSkill", UIBaseNode)
local base = UIBaseNode
local UINBaseSkillItem = require("Game.CommonUI.Item.UINBaseSkillItem")
UINDungeonInfoHeroDetailSkill.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseSkillItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.skillItem = (UINBaseSkillItem.New)()
  ;
  (self.skillItem):Init((self.ui).obj_skillItem)
  ;
  (((self.ui).btn_press).onPressDown):AddListener(BindCallback(self, self.__OnSkillLongPress))
  ;
  (((self.ui).btn_press).onPressUp):AddListener(BindCallback(self, self.__OnSkillPressUp))
end

UINDungeonInfoHeroDetailSkill.InitSkillItem = function(self, skillData, resloader, longPressFunc, pressUpFunc)
  -- function num : 0_1 , upvalues : _ENV
  (self.skillItem):InitBaseSkillItem(skillData, resloader)
  self.skillData = skillData
  self.longPressFunc = longPressFunc
  self.pressUpFunc = pressUpFunc
  if skillData:GetIsUnlock() then
    ((self.ui).tex_SkillName):SetIndex(0, skillData:GetName())
    if skillData:IsFullLevel() and not IsNull(((self.ui).tex_SkillLevel):GetIndex(1)) then
      ((self.ui).tex_SkillLevel):SetIndex(1)
    else
      ;
      ((self.ui).tex_SkillLevel):SetIndex(0, tostring(skillData.level))
    end
  else
    ;
    ((self.ui).tex_SkillName):SetIndex(1)
    ;
    ((self.ui).tex_SkillLevel):SetIndex(0, "0")
  end
end

UINDungeonInfoHeroDetailSkill.__OnSkillLongPress = function(self)
  -- function num : 0_2
  if self.longPressFunc ~= nil then
    (self.longPressFunc)(self, self.skillData)
  end
end

UINDungeonInfoHeroDetailSkill.__OnSkillPressUp = function(self)
  -- function num : 0_3
  if self.pressUpFunc ~= nil then
    (self.pressUpFunc)()
  end
end

UINDungeonInfoHeroDetailSkill.SetSkillClickAction = function(self, action)
  -- function num : 0_4
  self.skillClickFunc = action
end

UINDungeonInfoHeroDetailSkill.__OnSkillClick = function(self)
  -- function num : 0_5
  if self.skillClickFunc ~= nil then
    (self.skillClickFunc)(self.skillData)
  end
end

UINDungeonInfoHeroDetailSkill.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UINDungeonInfoHeroDetailSkill


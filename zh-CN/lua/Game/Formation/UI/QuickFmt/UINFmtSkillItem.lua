local UINFmtSkillItem = class("UINFmtSkillItem", UIBaseNode)
local base = UIBaseNode
local UINBaseSkillItem = require("Game.CommonUI.Item.UINBaseSkillItem")
UINFmtSkillItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseSkillItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (((self.ui).btn_Icon).onPressDown):AddListener(BindCallback(self, self.__OnSkillLongPress))
  ;
  (((self.ui).btn_Icon).onPressUp):AddListener(BindCallback(self, self.__OnSkillPressUp))
  self.baseSkillItem = (UINBaseSkillItem.New)()
  ;
  (self.baseSkillItem):Init((self.ui).uINSkillItem)
  self.oriColor = ((self.ui).img_skillLevel).color
end

UINFmtSkillItem.InitFmtSkillItem = function(self, skillData, resloader, clickEvent, longPressFunc, pressUpFunc, overriodColor)
  -- function num : 0_1 , upvalues : _ENV
  self.skillData = skillData
  self.clickEvent = clickEvent
  self.longPressFunc = longPressFunc
  self.pressUpFunc = pressUpFunc
  ;
  (self.baseSkillItem):InitBaseSkillItem(skillData, resloader)
  if skillData:IsFullLevel() then
    ((self.ui).tex_SkillLevel):SetIndex(1)
  else
    ;
    ((self.ui).tex_SkillLevel):SetIndex(0, tostring(skillData.level))
  end
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R7 in 'UnsetPending'

  if overriodColor ~= nil then
    ((self.ui).img_skillLevel).color = overriodColor
  else
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).img_skillLevel).color = self.oriColor
  end
  self.unlock = skillData:GetIsUnlock()
  if self.unlock then
    ((self.ui).tex_SkillName):SetIndex(1, skillData:GetName())
  else
    ;
    ((self.ui).tex_SkillName):SetIndex(0)
  end
end

UINFmtSkillItem.__OnSkillLongPress = function(self)
  -- function num : 0_2
  if self.longPressFunc ~= nil then
    (self.longPressFunc)(self, self.skillData)
  end
end

UINFmtSkillItem.__OnSkillPressUp = function(self)
  -- function num : 0_3
  if self.pressUpFunc ~= nil then
    (self.pressUpFunc)()
  end
end

return UINFmtSkillItem


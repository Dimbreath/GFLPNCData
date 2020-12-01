-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFmtSkillItem = class("UINFmtSkillItem", UIBaseNode)
local base = UIBaseNode
local UINBaseSkillItem = require("Game.CommonUI.Item.UINBaseSkillItem")
UINFmtSkillItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseSkillItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Icon, self, self.OnClickRoot)
  ;
  (((self.ui).btn_Icon).onPress):AddListener(BindCallback(self, self.__OnSkillLongPress))
  ;
  (((self.ui).btn_Icon).onPressUp):AddListener(BindCallback(self, self.__OnSkillPressUp))
  self.baseSkillItem = (UINBaseSkillItem.New)()
  ;
  (self.baseSkillItem):Init((self.ui).uINSkillItem)
end

UINFmtSkillItem.InitFmtSkillItem = function(self, skillData, resloader, clickEvent, longPressFunc, pressUpFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.skillData = skillData
  self.clickEvent = clickEvent
  self.longPressFunc = longPressFunc
  self.pressUpFunc = pressUpFunc
  ;
  (self.baseSkillItem):InitBaseSkillItem(skillData, resloader)
  ;
  ((self.ui).tex_SkillLevel):SetIndex(0, tostring(skillData.level))
  self.unlock = skillData:GetIsUnlock()
  if self.unlock then
    ((self.ui).tex_SkillName):SetIndex(1, skillData:GetName())
  else
    ;
    ((self.ui).tex_SkillName):SetIndex(0)
  end
end

UINFmtSkillItem.OnClickRoot = function(self)
  -- function num : 0_2
  if self.clickEvent ~= nil then
    (self.clickEvent)(self.skillData)
  end
end

UINFmtSkillItem.__OnSkillLongPress = function(self)
  -- function num : 0_3
  if self.longPressFunc ~= nil then
    (self.longPressFunc)(self, self.skillData)
  end
end

UINFmtSkillItem.__OnSkillPressUp = function(self)
  -- function num : 0_4
  if self.pressUpFunc ~= nil then
    (self.pressUpFunc)()
  end
end

return UINFmtSkillItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFmtSkillItem = class("UINFmtSkillItem", UIBaseNode)
local base = UIBaseNode
local UINBaseSkillItem = require("Game.CommonUI.Item.UINBaseSkillItem")
UINFmtSkillItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINBaseSkillItem
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_Icon, self, self.OnClickRoot);
    (((self.ui).btn_Icon).onPress):AddListener(
        BindCallback(self, self.__OnSkillLongPress));
    (((self.ui).btn_Icon).onPressUp):AddListener(
        BindCallback(self, self.__OnSkillPressUp))
    self.baseSkillItem = (UINBaseSkillItem.New)();
    (self.baseSkillItem):Init((self.ui).uINSkillItem)
end

UINFmtSkillItem.InitFmtSkillItem = function(self, skillData, resloader,
                                            clickEvent, longPressFunc,
                                            pressUpFunc)
    -- function num : 0_1 , upvalues : _ENV
    self.skillData = skillData
    self.clickEvent = clickEvent
    self.longPressFunc = longPressFunc
    self.pressUpFunc = pressUpFunc;
    (self.baseSkillItem):InitBaseSkillItem(skillData, resloader);
    ((self.ui).tex_SkillLevel):SetIndex(0, tostring(skillData.level))
    self.unlock = skillData:GetIsUnlock()
    if self.unlock then
        ((self.ui).tex_SkillName):SetIndex(1, skillData:GetName())
    else

        ((self.ui).tex_SkillName):SetIndex(0)
    end
end

UINFmtSkillItem.OnClickRoot = function(self)
    -- function num : 0_2
    if self.clickEvent ~= nil then (self.clickEvent)(self.skillData) end
end

UINFmtSkillItem.__OnSkillLongPress = function(self)
    -- function num : 0_3
    if self.longPressFunc ~= nil then
        (self.longPressFunc)(self, self.skillData)
    end
end

UINFmtSkillItem.__OnSkillPressUp = function(self)
    -- function num : 0_4
    if self.pressUpFunc ~= nil then (self.pressUpFunc)() end
end

return UINFmtSkillItem


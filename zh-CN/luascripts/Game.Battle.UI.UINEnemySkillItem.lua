-- params : ...
-- function num : 0 , upvalues : _ENV
local UINEnemySkillItem = class("UINEnemySkillItem", UIBaseNode)
local base = UIBaseNode
UINEnemySkillItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).rootBtn, self, self.OnClickEvent)
  ;
  (((self.ui).rootBtn).onPress):AddListener(BindCallback(self, self.__OnSkillLongPress))
  ;
  (((self.ui).rootBtn).onPressUp):AddListener(BindCallback(self, self.__OnSkillPressUp))
end

UINEnemySkillItem.InitEnemySkillItem = function(self, skillData, clickEvent, longPressFunc, pressUpFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.skillData = skillData
  self.__clickEvent = clickEvent
  self.longPressFunc = longPressFunc
  self.pressUpFunc = pressUpFunc
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_SkillIcon).sprite = CRH:GetSprite((self.skillData):GetIcon(), CommonAtlasType.SkillIcon)
  local skillTag = (self.skillData):GetSkillTag()
  ;
  ((self.ui).img_SkillTypeLine):SetIndex(skillTag)
  ;
  ((self.ui).img_SkillType):SetIndex(skillTag)
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (((self.ui).img_SkillType).image).color = eBattleSkillTypeColor[(self.skillData):GetSkillTypeColor()]
end

UINEnemySkillItem.OnClickEvent = function(self)
  -- function num : 0_2
  if self.__clickEvent ~= nil then
    (self.__clickEvent)(self, self.skillData)
  end
end

UINEnemySkillItem.__OnSkillLongPress = function(self)
  -- function num : 0_3
  if self.longPressFunc ~= nil then
    (self.longPressFunc)(self, self.skillData)
  end
end

UINEnemySkillItem.__OnSkillPressUp = function(self)
  -- function num : 0_4
  if self.pressUpFunc ~= nil then
    (self.pressUpFunc)()
  end
end

return UINEnemySkillItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINEnemySkillItem = class("UINEnemySkillItem", UIBaseNode)
local base = UIBaseNode
UINEnemySkillItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).rootBtn, self, self.OnClickEvent);
    (((self.ui).rootBtn).onPress):AddListener(
        BindCallback(self, self.__OnSkillLongPress));
    (((self.ui).rootBtn).onPressUp):AddListener(
        BindCallback(self, self.__OnSkillPressUp))
end

UINEnemySkillItem.InitEnemySkillItem = function(self, skillData, clickEvent,
                                                longPressFunc, pressUpFunc)
    -- function num : 0_1 , upvalues : _ENV
    self.skillData = skillData
    self.__clickEvent = clickEvent
    self.longPressFunc = longPressFunc
    self.pressUpFunc = pressUpFunc -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'
    ;
    ((self.ui).img_SkillIcon).sprite = CRH:GetSprite((self.skillData):GetIcon(),
                                                     CommonAtlasType.SkillIcon)
    local skillTag = (self.skillData):GetSkillTag();
    ((self.ui).img_SkillTypeLine):SetIndex(skillTag);
    ((self.ui).img_SkillType):SetIndex(skillTag) -- DECOMPILER ERROR at PC36: Confused about usage of register: R6 in 'UnsetPending'
    ;
    (((self.ui).img_SkillType).image).color =
        eBattleSkillTypeColor[(self.skillData):GetSkillTypeColor()]
end

UINEnemySkillItem.OnClickEvent = function(self)
    -- function num : 0_2
    if self.__clickEvent ~= nil then
        (self.__clickEvent)(self, self.skillData)
    end
end

UINEnemySkillItem.__OnSkillLongPress = function(self)
    -- function num : 0_3
    if self.longPressFunc ~= nil then
        (self.longPressFunc)(self, self.skillData)
    end
end

UINEnemySkillItem.__OnSkillPressUp = function(self)
    -- function num : 0_4
    if self.pressUpFunc ~= nil then (self.pressUpFunc)() end
end

return UINEnemySkillItem


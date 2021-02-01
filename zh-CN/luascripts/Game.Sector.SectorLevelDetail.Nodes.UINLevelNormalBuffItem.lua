-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLevelNormalBuffItem = class("UINLevelNormalBuffItem", UIBaseNode)
local base = UIBaseNode
UINLevelNormalBuffItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (((self.ui).btn_img_Buff).onPress):AddListener(BindCallback(self, self.__OnSkillLongPress))
  ;
  (((self.ui).btn_img_Buff).onPressUp):AddListener(BindCallback(self, self.__OnSkillPressUp))
end

UINLevelNormalBuffItem.InitBuffByCfg = function(self, buffCfg, longPressFunc, pressUpFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.buffCfg = buffCfg
  self.longPressFunc = longPressFunc
  self.pressUpFunc = pressUpFunc
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_Buff).sprite = CRH:GetSprite(buffCfg.icon, CommonAtlasType.ExplorationIcon)
end

UINLevelNormalBuffItem.__OnSkillLongPress = function(self)
  -- function num : 0_2
  if self.longPressFunc ~= nil then
    (self.longPressFunc)(self, self.buffCfg)
  end
end

UINLevelNormalBuffItem.__OnSkillPressUp = function(self)
  -- function num : 0_3
  if self.pressUpFunc ~= nil then
    (self.pressUpFunc)()
  end
end

UINLevelNormalBuffItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINLevelNormalBuffItem


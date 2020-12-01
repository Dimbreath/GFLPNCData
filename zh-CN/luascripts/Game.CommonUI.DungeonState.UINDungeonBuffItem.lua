-- params : ...
-- function num : 0 , upvalues : _ENV
local UINDungeonBuffItem = class("UINDungeonBuffItem", UIBaseNode)
local base = UIBaseNode
UINDungeonBuffItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (((self.ui).btn_buffItem).onPress):AddListener(BindCallback(self, self.__OnSkillLongPress))
  ;
  (((self.ui).btn_buffItem).onPressUp):AddListener(BindCallback(self, self.__OnSkillPressUp))
end

UINDungeonBuffItem.InitBuffByCfg = function(self, epBuff, buffCfg, longPressFunc, pressUpFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.buffCfg = buffCfg
  self.longPressFunc = longPressFunc
  self.pressUpFunc = pressUpFunc
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite(buffCfg.icon, CommonAtlasType.ExplorationIcon)
  if epBuff.cnt > 0 then
    (((self.ui).tex_buffCount).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).tex_buffCount).text = tostring(epBuff.cnt)
  else
    ;
    (((self.ui).tex_buffCount).gameObject):SetActive(false)
  end
end

UINDungeonBuffItem.__OnSkillLongPress = function(self)
  -- function num : 0_2
  if self.longPressFunc ~= nil then
    (self.longPressFunc)(self, self.buffCfg)
  end
end

UINDungeonBuffItem.__OnSkillPressUp = function(self)
  -- function num : 0_3
  if self.pressUpFunc ~= nil then
    (self.pressUpFunc)()
  end
end

UINDungeonBuffItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINDungeonBuffItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINDungeonBuffItem = class("UINDungeonBuffItem", UIBaseNode)
local base = UIBaseNode
UINDungeonBuffItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (((self.ui).btn_buffItem).onPress):AddListener(
        BindCallback(self, self.__OnSkillLongPress));
    (((self.ui).btn_buffItem).onPressUp):AddListener(
        BindCallback(self, self.__OnSkillPressUp))
end

UINDungeonBuffItem.InitBuffByCfg = function(self, epBuff, buffCfg,
                                            longPressFunc, pressUpFunc)
    -- function num : 0_1 , upvalues : _ENV
    self.buffCfg = buffCfg
    self.longPressFunc = longPressFunc
    self.pressUpFunc = pressUpFunc -- DECOMPILER ERROR at PC11: Confused about usage of register: R5 in 'UnsetPending'
    ;
    ((self.ui).img_Icon).sprite = CRH:GetSprite(buffCfg.icon,
                                                CommonAtlasType.ExplorationIcon)
    if epBuff.cnt > 0 then
        (((self.ui).tex_buffCount).gameObject):SetActive(true) -- DECOMPILER ERROR at PC26: Confused about usage of register: R5 in 'UnsetPending'
        ;
        ((self.ui).tex_buffCount).text = tostring(epBuff.cnt)
    else

        (((self.ui).tex_buffCount).gameObject):SetActive(false)
    end
end

UINDungeonBuffItem.__OnSkillLongPress = function(self)
    -- function num : 0_2
    if self.longPressFunc ~= nil then
        (self.longPressFunc)(self, self.buffCfg)
    end
end

UINDungeonBuffItem.__OnSkillPressUp = function(self)
    -- function num : 0_3
    if self.pressUpFunc ~= nil then (self.pressUpFunc)() end
end

UINDungeonBuffItem.OnDelete = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnDelete)(self)
end

return UINDungeonBuffItem


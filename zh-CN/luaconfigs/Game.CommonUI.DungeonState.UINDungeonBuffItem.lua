-- params : ...
-- function num : 0 , upvalues : _ENV
local UINDungeonBuffItem = class("UINDungeonBuffItem", UIBaseNode)
local base = UIBaseNode
local OnPressScale = (Vector3.New)(1.5, 1.5, 1)
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
  if not IsNull((self.ui).obj_buffNum) then
    if epBuff.cnt > 0 then
      ((self.ui).obj_buffNum):SetActive(true)
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).tex_buffNum).text = tostring(epBuff.cnt)
    else
      ;
      ((self.ui).obj_buffNum):SetActive(false)
    end
  end
end

UINDungeonBuffItem.__OnSkillLongPress = function(self)
  -- function num : 0_2 , upvalues : OnPressScale
  if self.longPressFunc ~= nil then
    (self.longPressFunc)(self, self.buffCfg)
  end
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.transform).localScale = OnPressScale
end

UINDungeonBuffItem.__OnSkillPressUp = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.pressUpFunc ~= nil then
    (self.pressUpFunc)()
  end
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.transform).localScale = Vector3.one
end

UINDungeonBuffItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINDungeonBuffItem


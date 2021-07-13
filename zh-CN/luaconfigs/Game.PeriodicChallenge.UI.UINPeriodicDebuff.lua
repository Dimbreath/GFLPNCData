-- params : ...
-- function num : 0 , upvalues : _ENV
local UINPeriodicDebuff = class("UINPeriodicDebuff", UIBaseNode)
local base = UIBaseNode
UINPeriodicDebuff.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).debuffSelectItem, self, self.OnClickToggle)
end

UINPeriodicDebuff.InitDebuffItem = function(self, buffId, permillage, selectFunc, isSelected, resloader)
  -- function num : 0_1 , upvalues : _ENV
  self.buffItemData = (ConfigData.item)[buffId]
  self.permillage = permillage
  self.selectFunc = selectFunc
  local buffCfg = (ConfigData.exploration_buff)[buffId]
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite(buffCfg.icon, CommonAtlasType.ExplorationIcon)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_Desc).text = (LanguageUtil.GetLocaleText)(buffCfg.describe)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_Permillage).text = tostring((Mathf.Floor)(permillage / 10)) .. "%"
  self:ChangeState(isSelected, false)
end

UINPeriodicDebuff.ChangeState = function(self, isSelected, isCallback)
  -- function num : 0_2
  self.isCallback = isCallback
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).debuffSelectItem).isOn = isSelected
  self.isCallback = true
end

UINPeriodicDebuff.OnClickToggle = function(self, flag)
  -- function num : 0_3
  if not flag then
    ((self.ui).img_Select):SetIndex(0)
  else
    if self.permillage > 0 then
      ((self.ui).img_Select):SetIndex(1)
    else
      ;
      ((self.ui).img_Select):SetIndex(2)
    end
  end
  if self.selectFunc ~= nil and self.isCallback then
    (self.selectFunc)(self.buffItemData, flag)
  end
end

return UINPeriodicDebuff


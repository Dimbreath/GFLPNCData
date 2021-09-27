local UINBuffDescItem = class("UINBuffDescItem", UIBaseNode)
local base = UIBaseNode
UINBuffDescItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINBuffDescItem.InitBuffDescItem = function(self, epBuff)
  -- function num : 0_1 , upvalues : _ENV
  if epBuff == nil then
    return 
  end
  local cfg = epBuff:GetEpBuffCfg()
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_Buff).sprite = CRH:GetSprite(cfg.icon, CommonAtlasType.ExplorationIcon)
  local colIndex = cfg.buff_type + 1
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_Col).color = ((self.ui).array_Col)[colIndex]
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_BuffName).text = (LanguageUtil.GetLocaleText)(cfg.name)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Desc).text = (LanguageUtil.GetLocaleText)(cfg.describe)
end

UINBuffDescItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINBuffDescItem


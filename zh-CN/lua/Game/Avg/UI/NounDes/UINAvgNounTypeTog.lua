local UINAvgNounTypeTog = class("UINAvgNounTypeTog", UIBaseNode)
local base = UIBaseNode
UINAvgNounTypeTog.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_NounType, self, self.OnClickAvgNounTypeTog)
end

UINAvgNounTypeTog.InitAvgNounTypeTog = function(self, cfg, clickCallback, typeId, desId)
  -- function num : 0_1 , upvalues : _ENV
  self.noun_des_typeCfg = cfg
  self.clickCallback = clickCallback
  self.typeId = typeId
  self.desId = desId
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_TypeName).text = (LanguageUtil.GetLocaleText)(cfg.type_name)
end

UINAvgNounTypeTog.OnClickAvgNounTypeTog = function(self, bool)
  -- function num : 0_2
  if self.clickCallback ~= nil then
    (self.clickCallback)(self, bool, self.typeId, self.desId)
  end
end

UINAvgNounTypeTog.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINAvgNounTypeTog


local UIATHSuitDetailNodeSuitItem = class("UIATHSuitDetailNodeSuitItem", UIBaseNode)
local base = UIBaseNode
UIATHSuitDetailNodeSuitItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIATHSuitDetailNodeSuitItem.InitSuitItemInfo = function(self, cfg)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_Effect).text = (LanguageUtil.GetLocaleText)(cfg.describe)
  ;
  ((self.ui).text_suitNum):SetIndex(0, tostring(cfg.num))
end

UIATHSuitDetailNodeSuitItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UIATHSuitDetailNodeSuitItem


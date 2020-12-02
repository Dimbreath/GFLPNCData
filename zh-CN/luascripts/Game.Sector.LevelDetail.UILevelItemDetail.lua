-- params : ...
-- function num : 0 , upvalues : _ENV
local UILevelItemDetail = class("UILevelItemDetail", UIBaseNode)
local base = UIBaseNode
UILevelItemDetail.Create = function(gameObject)
  -- function num : 0_0 , upvalues : UILevelItemDetail
  local node = (UILevelItemDetail.New)()
  node:Init(gameObject)
  return node
end

UILevelItemDetail.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UILevelItemDetail.InitItemDetail = function(self, itemCfg)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).name).text = (LanguageUtil.GetLocaleText)(itemCfg.name)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).description).text = (LanguageUtil.GetLocaleText)(itemCfg.describe)
end

UILevelItemDetail.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UILevelItemDetail


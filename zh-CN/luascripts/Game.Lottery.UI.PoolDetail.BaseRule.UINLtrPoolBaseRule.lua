-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLtrPoolBaseRule = class("UINLtrPoolBaseRule", UIBaseNode)
local base = UIBaseNode
UINLtrPoolBaseRule.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINLtrPoolBaseRule.InitLtrPoolBaseRule = function(self, poolCfg)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_Rules).text = (LanguageUtil.GetLocaleText)(poolCfg.des)
end

UINLtrPoolBaseRule.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINLtrPoolBaseRule

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLtrPoolBaseRule = class("UINLtrPoolBaseRule", UIBaseNode)
local base = UIBaseNode
UINLtrPoolBaseRule.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINLtrPoolBaseRule.InitLtrPoolBaseRule =
    function(self, poolCfg)
        -- function num : 0_1 , upvalues : _ENV
        -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

        ((self.ui).tex_Rules).text = (LanguageUtil.GetLocaleText)(poolCfg.des)
    end

UINLtrPoolBaseRule.OnDelete = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnDelete)(self)
end

return UINLtrPoolBaseRule


-- params : ...
-- function num : 0 , upvalues : _ENV
local UINEnemyTagItem = class("UINEnemyTagItem", UIBaseNode)
local base = UIBaseNode
UINEnemyTagItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINEnemyTagItem.InitEnemyTagItem = function(self, tagTex)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_tag).text = tagTex
end

return UINEnemyTagItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINEnemyTagItem = class("UINEnemyTagItem", UIBaseNode)
local base = UIBaseNode
UINEnemyTagItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINEnemyTagItem.InitEnemyTagItem = function(self, tagTex)
    -- function num : 0_1
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

    ((self.ui).tex_tag).text = tagTex
end

return UINEnemyTagItem


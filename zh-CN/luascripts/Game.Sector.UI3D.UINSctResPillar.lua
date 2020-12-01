-- params : ...
-- function num : 0 , upvalues : _ENV
local UINSctResPillar = class("UINSctResPillar", UIBaseNode)
local base = UIBaseNode
UINSctResPillar.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINSctResPillar.InitUISctResPillar = function(self, sourceTransform)
  -- function num : 0_1
  local source = ((self.ui).posConstraint):GetSource(0)
  source.sourceTransform = sourceTransform
  ;
  ((self.ui).posConstraint):SetSource(0, source)
end

UINSctResPillar.UpdateUISctResPillar = function(self, progress)
  -- function num : 0_2 , upvalues : _ENV
  progress = (math.floor)(progress * 100)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_ResPercent).text = progress
end

UINSctResPillar.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINSctResPillar

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINSctResPillar = class("UINSctResPillar", UIBaseNode)
local base = UIBaseNode
UINSctResPillar.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINSctResPillar.InitUISctResPillar = function(self, sourceTransform)
    -- function num : 0_1
    local source = ((self.ui).posConstraint):GetSource(0)
    source.sourceTransform = sourceTransform;
    ((self.ui).posConstraint):SetSource(0, source)
end

UINSctResPillar.UpdateUISctResPillar = function(self, progress)
    -- function num : 0_2 , upvalues : _ENV
    progress = (math.floor)(progress * 100) -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).tex_ResPercent).text = progress
end

UINSctResPillar.OnDelete = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnDelete)(self)
end

return UINSctResPillar


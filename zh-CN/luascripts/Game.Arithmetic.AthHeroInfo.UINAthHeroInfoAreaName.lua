-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthHeroInfoAreaName = class("UINAthHeroInfoAreaName", UIBaseNode)
local base = UIBaseNode
UINAthHeroInfoAreaName.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINAthHeroInfoAreaName.InitAthHeroInfoAreaName = function(self, name, anchoredPosition, nameIndex)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  if not anchoredPosition then
    (self.transform).anchoredPosition = Vector2.zero
    ;
    ((self.ui).tex_AreaName):SetIndex(nameIndex, name)
  end
end

UINAthHeroInfoAreaName.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthHeroInfoAreaName

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthHeroInfoAreaName = class("UINAthHeroInfoAreaName", UIBaseNode)
local base = UIBaseNode
UINAthHeroInfoAreaName.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINAthHeroInfoAreaName.InitAthHeroInfoAreaName =
    function(self, name, anchoredPosition, nameIndex)
        -- function num : 0_1 , upvalues : _ENV
        -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

        if not anchoredPosition then
            (self.transform).anchoredPosition = Vector2.zero;
            ((self.ui).tex_AreaName):SetIndex(nameIndex, name)
        end
    end

UINAthHeroInfoAreaName.OnDelete = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnDelete)(self)
end

return UINAthHeroInfoAreaName


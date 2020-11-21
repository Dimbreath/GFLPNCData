-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthHeroInfoSuit = class("UINAthHeroInfoSuit", UIBaseNode)
local base = UIBaseNode
UINAthHeroInfoSuit.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINAthHeroInfoSuit.InitAthHeroInfoSuit =
    function(self, suitCfg, curNum, maxNum)
        -- function num : 0_1 , upvalues : _ENV
        -- DECOMPILER ERROR at PC6: Confused about usage of register: R4 in 'UnsetPending'

        ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(suitCfg.name);
        ((self.ui).tex_Count):SetIndex(0, tostring(curNum), tostring(maxNum))
    end

UINAthHeroInfoSuit.OnDelete = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnDelete)(self)
end

return UINAthHeroInfoSuit


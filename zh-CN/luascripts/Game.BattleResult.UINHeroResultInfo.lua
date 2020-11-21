-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroResultInfo = class("UINHeroResultInfo", UIBaseNode)
local base = UIBaseNode
UINHeroResultInfo.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    ((self.ui).chipItem):SetActive(false)
end

UINHeroResultInfo.InitHeroInfo = function(self, heroInfo, resloader)
    -- function num : 0_1 , upvalues : _ENV
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

    ((self.ui).img_Pic).texture = resloader:LoadABAsset(
                                      PathConsts:GetCharacterPicPath(
                                          heroInfo:GetResName())) -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.ui).tex_Damage).text = tostring(heroInfo.totalDamage)
end

UINHeroResultInfo.OnDelete = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnDelete)(self)
end

return UINHeroResultInfo


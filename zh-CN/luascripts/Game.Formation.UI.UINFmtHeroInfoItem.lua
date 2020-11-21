-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFmtHeroInfoItem = class("UINFmtHeroInfoItem", UIBaseNode)
local base = UIBaseNode
UINFmtHeroInfoItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (((self.ui).img_star).gameObject):SetActive(false)
    self.starList = {}
end

UINFmtHeroInfoItem.InitFmtHeroInfo = function(self, heroData)
    -- function num : 0_1 , upvalues : _ENV
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

    ((self.ui).img_Career).sprite = CRH:GetSprite(
                                        (heroData:GetCareerCfg()).icon,
                                        CommonAtlasType.CareerCamp) -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).tex_Name).text = heroData:GetName();
    ((self.ui).tex_HeroLevel):SetIndex(0, tostring(heroData.level))
    for k, v in ipairs(self.starList) do
        (v.gameObject):SetActive(false)
        v:SetIndex(0)
    end
    local star = heroData.star
    local count = (math.ceil)(star / 2)
    local isHalf = star % 2 == 1
    for i = 1, count do
        local star = (self.starList)[i]
        if star == nil then
            star =
                ((((self.ui).img_star).gameObject):Instantiate()):GetComponent(
                    typeof(CS.UiImageItemInfo));
            (table.insert)(self.starList, star)
        end
        (star.gameObject):SetActive(true)
    end
    if isHalf then ((self.starList)[#self.starList]):SetIndex(1) end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UINFmtHeroInfoItem.UpdateFmtHeroInfoPos =
    function(self, position)
        -- function num : 0_2
        -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

        (self.transform).anchoredPosition = position
    end

UINFmtHeroInfoItem.OnDelete = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnDelete)(self)
end

return UINFmtHeroInfoItem


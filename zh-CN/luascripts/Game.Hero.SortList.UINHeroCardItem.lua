-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroCardItem = class("UINHeroCardItem", UIBaseNode)
local base = UIBaseNode
UINHeroCardItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_hero, self, self.OnBtnHeroClicked)
    self:SetSelectActive(false);
    ((self.ui).star):SetActive(false) -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'
    ;
    (self.ui).stars = {}
    for i = 1, (ConfigData.hero_rank).maxStar do
        local go = ((self.ui).star):Instantiate()
        go:SetActive(true);
        (table.insert)((self.ui).stars, go)
    end
end

UINHeroCardItem.InitHeroHeroData = function(self, heroData, resloader,
                                            selectFunc)
    -- function num : 0_1
    self.heroData = heroData
    self.resloader = resloader
    self.selectFunc = selectFunc
    self.freshTexture = true
    self:RefreshHeroHeroData()
end

UINHeroCardItem.GetDataId = function(self)
    -- function num : 0_2
    return self.heroData and (self.heroData).dataId or 0
end

UINHeroCardItem.RefreshHeroHeroData = function(self)
    -- function num : 0_3 , upvalues : _ENV
    if self.heroData == nil then return end
    self:SetStarUI((self.heroData).star) -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).tex_Name).text = (self.heroData):GetName() -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).tex_Level).text = "LV.<Size=20>" ..
                                     tostring((self.heroData).level) ..
                                     "</Size>" -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).img_Color).color = HeroRareColor[(self.heroData).rare] -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).img_Career).sprite = CRH:GetSprite(
                                        ((self.heroData):GetCareerCfg()).icon,
                                        CommonAtlasType.CareerCamp)
    if self.freshTexture then
        self.freshTexture = false;
        (self.resloader):LoadABAssetAsync(
            PathConsts:GetCharacterPicPath((self.heroData):GetResName()),
            function(texture)
                -- function num : 0_3_0 , upvalues : _ENV, self
                if IsNull(self.transform) then return end -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'
                
                ((self.ui).img_Hero).texture = texture
            end)
    end
end

UINHeroCardItem.SetStarUI = function(self, star)
    -- function num : 0_4
    for i = 1, star do (((self.ui).stars)[i]):SetActive(true) end
    for i = star + 1, #(self.ui).stars do
        (((self.ui).stars)[i]):SetActive(false)
    end
end

UINHeroCardItem.OnBtnHeroClicked = function(self)
    -- function num : 0_5
    if self.selectFunc ~= nil then (self.selectFunc)(self.heroData) end
end

UINHeroCardItem.SetSelectActive = function(self, active)
    -- function num : 0_6
    (((self.ui).img_OnClick).gameObject):SetActive(active)
end

UINHeroCardItem.OnDelete = function(self)
    -- function num : 0_7 , upvalues : base
    self.resloader = nil;
    (base.OnDelete)(self)
end

UINHeroCardItem.SetRedDotActive = function(self, active)
    -- function num : 0_8
    ((self.ui).redDotHeroCard):SetActive(active)
end

UINHeroCardItem.SetInFormationActive = function(self, active)
    -- function num : 0_9
    ((self.ui).img_InFormation):SetActive(active)
end

UINHeroCardItem.SetIsWorkingActive = function(self, active)
    -- function num : 0_10
    ((self.ui).tex_IsWork):SetActive(active)
end

UINHeroCardItem.SetIsLuckActive = function(self, active)
    -- function num : 0_11
    ((self.ui).tex_IsLuck):SetActive(active)
end

return UINHeroCardItem


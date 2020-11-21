-- params : ...
-- function num : 0 , upvalues : _ENV
local UIGetHero = class("UIGetHero", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local HeroIdTo4Hex = function(id)
    -- function num : 0_0 , upvalues : _ENV
    local out = (string.format)("%X", id)
    local len = (string.len)(out)
    if len < 4 then
        for i = 1, 4 - len do out = "0" .. out end
    else
        do
            if len > 4 then out = (string.sub)(out, len - 3) end
            return "#" .. out
        end
    end
end

UIGetHero.OnInit = function(self)
    -- function num : 0_1 , upvalues : cs_ResLoader, _ENV
    self.resloader = (cs_ResLoader.Create)()
    self.StarList = {};
    (table.insert)(self.StarList, (self.ui).img_star)
    self.TagList = {};
    (table.insert)(self.TagList, (self.ui).tagItem);
    (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnClickClose)
end

UIGetHero.InitGetHeroList = function(self, heroDataList, withGetHeroSound)
    -- function num : 0_2
    if #heroDataList < 1 then return end
    self.haveNext = true
    self.heroDataList = heroDataList
    self.showIndex = 1
    self.firtTime = true
    self.allOldPos = {}
    self:ShowNext()
    self.withGetHeroSound = withGetHeroSound
end

UIGetHero.ShowNext = function(self)
    -- function num : 0_3
    self:_InitGetHero((self.heroDataList)[self.showIndex])
    self.showIndex = self.showIndex + 1
    if #self.heroDataList < self.showIndex then self.haveNext = false end
end

UIGetHero._InitGetHero = function(self, heroData)
    -- function num : 0_4 , upvalues : _ENV, HeroIdTo4Hex, cs_ResLoader
    if not heroData then error("not have heroData") end
    self:PlayAllTween() -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).tex_HeroID).text = HeroIdTo4Hex(heroData.dataId)
    local campIcon = (LanguageUtil.GetLocaleText)((heroData:GetCampCfg()).icon);
    (self.resloader):LoadABAssetAsync(PathConsts:GetCampPicPath(campIcon),
                                      function(texture)
        -- function num : 0_4_0 , upvalues : _ENV, self
        if IsNull(self.transform) then return end -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'
        
        ((self.ui).img_CampSmall).texture = texture -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'
        ;
        ((self.ui).img_Camp).texture = texture
    end)
    if self.bigImgResloader ~= nil then
        (self.bigImgResloader):Put2Pool()
        self.bigImgResloader = nil
    end
    self.bigImgResloader = (cs_ResLoader.Create)();
    (self.bigImgResloader):LoadABAssetAsync(
        PathConsts:GetCharacterBigImgPrefabPath(heroData:GetResName()),
        function(prefab)
            -- function num : 0_4_1 , upvalues : _ENV, self
            DestroyUnityObject(self.bigImgGameObject)
            self.bigImgGameObject = prefab:Instantiate((self.ui).heroHolder)
            local commonPicCtrl = (self.bigImgGameObject):FindComponent(
                                      eUnityComponentID.CommonPicController)
            commonPicCtrl:SetPosType("HeroList")
        end);
    ((self.ui).img_Carrer):SetIndex(heroData.career - 1) -- DECOMPILER ERROR at PC56: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.ui).tex_Name).text = heroData:GetName()
    self:ShowTags(heroData:GetTag())
    self:ShowStars(heroData.star) -- DECOMPILER ERROR at PC69: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.ui).img_Quality).color = HeroRareColor[heroData.rare];
    ((self.ui).dialogue):SetActive(false)
end

UIGetHero.PlayAllTween = function(self)
    -- function num : 0_5 , upvalues : _ENV
    local allTweens = (self.transform):GetComponentsInChildren(
                          typeof(((CS.DG).Tweening).DOTweenAnimation))
    for i = 0, allTweens.Length - 1 do
        local tween = allTweens[i]
        -- DECOMPILER ERROR at PC21: Confused about usage of register: R7 in 'UnsetPending'

        if self.firtTime then
            (self.allOldPos)[i] = (tween.transform).position
        else
            -- DECOMPILER ERROR at PC36: Confused about usage of register: R7 in 'UnsetPending'


            (tween.transform).position =
                (Vector3.New)(((self.allOldPos)[i]).x, ((self.allOldPos)[i]).y,
                              ((self.allOldPos)[i]).z)
        end
        tween:DOPause()
        tween:DORewind()
        tween:DOPlay()
    end
    if self.firtTime then self.firtTime = false end
end

UIGetHero.ShowStars = function(self, num)
    -- function num : 0_6 , upvalues : _ENV
    for _, starGo in ipairs(self.StarList) do
        (starGo.gameObject):SetActive(false)
    end
    local count = (math.ceil)(num / 2)
    local isHalf = num % 2 == 1
    for i = 1, count do
        if (self.StarList)[i] ~= nil then
            (((self.StarList)[i]).gameObject):SetActive(true);
            ((self.StarList)[i]):SetIndex(0)
        else
            local imgItemInfo =
                (((self.ui).img_star):Instantiate()):GetComponent(
                    typeof(CS.UiImageItemInfo));
            (table.insert)(self.StarList, imgItemInfo);
            (imgItemInfo.gameObject):SetActive(true)
        end
    end
    if isHalf then ((self.StarList)[#self.StarList]):SetIndex(1) end
    if self.withGetHeroSound then
        if count == 1 then
            AudioManager:PlayAudioById(1020)
        elseif count == 2 then
            AudioManager:PlayAudioById(1021)
        elseif count == 3 then
            AudioManager:PlayAudioById(1022)
        end
    end
    -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

UIGetHero.ShowTags = function(self, tagList)
    -- function num : 0_7 , upvalues : _ENV
    for _, starGo in ipairs(self.TagList) do starGo:SetActive(false) end
    for index, tagId in ipairs(tagList) do
        if (self.TagList)[index] ~= nil then
            ((self.TagList)[index]):SetActive(true)
            local textItemInfo = ((self.TagList)[index]):GetComponentInChildren(
                                     typeof(CS.UiTextItemInfo))
            textItemInfo:SetIndex(tagId)
        else
            do
                local item = ((self.ui).tagItem):Instantiate()
                do
                    local textItemInfo =
                        item:GetComponentInChildren(typeof(CS.UiTextItemInfo));
                    (table.insert)(self.TagList, item)
                    textItemInfo:SetIndex(tagId)
                    -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                    -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_STMT

                end
            end
        end
    end
end

UIGetHero.OnClickClose = function(self)
    -- function num : 0_8
    if self.haveNext then
        self:ShowNext()
    else
        self:Delete()
    end
end

UIGetHero.OnDelete = function(self)
    -- function num : 0_9 , upvalues : base
    if self.bigImgResloader ~= nil then
        (self.bigImgResloader):Put2Pool()
        self.bigImgResloader = nil
    end
    if self.resloader ~= nil then
        (self.resloader):Put2Pool()
        self.resloader = nil
    end
    (base.OnDelete)(self)
end

return UIGetHero


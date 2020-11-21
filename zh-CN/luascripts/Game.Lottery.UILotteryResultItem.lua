-- params : ...
-- function num : 0 , upvalues : _ENV
local UILotteryResultItem = class("UILotteryResultItem", UIBaseNode)
local base = UIBaseNode
local cs_ColorUtility = (CS.UnityEngine).ColorUtility
local cs_DoTween = ((CS.DG).Tweening).DOTween
UILotteryResultItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

local repeatNewHeroTable = nil
UILotteryResultItem.SetRepeatTable = function(self, outRepeatNewHeroTable)
    -- function num : 0_1 , upvalues : repeatNewHeroTable
    repeatNewHeroTable = outRepeatNewHeroTable
end

local MinFlipNumFun = nil
UILotteryResultItem.SetFlipFun = function(self, fun)
    -- function num : 0_2 , upvalues : MinFlipNumFun
    MinFlipNumFun = fun
end

local StopAutoFlipCards = nil
UILotteryResultItem.SetStopAutoFlipCards =
    function(self, self, fun)
        -- function num : 0_3 , upvalues : StopAutoFlipCards, _ENV
        StopAutoFlipCards = Bind(self, fun)
    end

UILotteryResultItem.InitLotteryResultItem =
    function(self, itemId, count, resloader)
        -- function num : 0_4 , upvalues : _ENV
        self.resLoader = resloader;
        ((self.ui).image_New):SetActive(false);
        ((self.ui).GameObject_hero):SetActive(false);
        ((self.ui).GameObject_item):SetActive(false);
        ((self.ui).Obj_ConvertToFragment):SetActive(false) -- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'
        ;
        (self.transform).localScale = (Vector3.New)(-1, 1, 1)
        self.isFliped = false
        local itemCfg = (ConfigData.item)[itemId]
        if IsNull(itemCfg) then
            error("Can\'t find item, id = " .. tostring(itemId))
        end
        self.isHero = false
        self.isFragment = false
        if itemCfg.action_type == eItemActionType.HeroCard then
            self.isHero = true
            self.heroId = (itemCfg.arg)[1]
            local heroData = (PlayerDataCenter.heroDic)[self.heroId]
            self.heroCfg = (ConfigData.hero_data)[self.heroId]
            local heroResCfg =
                (ConfigData.resource_model)[(self.heroCfg).src_id]
            local rankCfg = (ConfigData.hero_rank)[(self.heroCfg).rank]
            if rankCfg == nil then
                error("Can\'t find rankCfg,id = " ..
                          tostring((self.heroCfg).rank))
                return
            end
            self.heroRankCfg = rankCfg
            resloader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(
                                           heroResCfg.res_Name),
                                       function(texture)
                -- function num : 0_4_0 , upvalues : self
                -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

                ((self.ui).img_Hero).texture = texture
            end) -- DECOMPILER ERROR at PC101: Confused about usage of register: R8 in 'UnsetPending'
            ;
            ((self.ui).tex_HeroName).text =
                (LanguageUtil.GetLocaleText)((self.heroCfg).name);
            ((self.ui).tex_HeroLevel):SetIndex(0, tostring(1)) -- DECOMPILER ERROR at PC116: Confused about usage of register: R8 in 'UnsetPending'
            ;
            ((self.ui).img_HeroColor).color =
                HeroRareColor[(self.heroRankCfg).rare] -- DECOMPILER ERROR at PC130: Confused about usage of register: R8 in 'UnsetPending'
            ;
            ((self.ui).img_HeroCareer).sprite =
                CRH:GetSprite(((ConfigData.career)[(self.heroCfg).career]).icon,
                              CommonAtlasType.CareerCamp)
            if self.stars == nil then
                self.stars = {};
                (table.insert)(self.stars, (self.ui).heroStar)
                for i = 1, (ConfigData.hero_rank).maxStar do
                    local go = ((self.ui).heroStar):Instantiate()
                    go:SetActive(true);
                    (table.insert)(self.stars, go)
                end
            end
            do
                local starNum = (self.heroRankCfg).star
                for i = 1, starNum do
                    ((self.stars)[i]):SetActive(true)
                end
                for i = starNum + 1, #self.stars do
                    ((self.stars)[i]):SetActive(false)
                end
                if heroData ~= nil then
                    local fragId = (self.heroCfg).fragment
                    local fragCount = (self.heroRankCfg).repeat_frag_trans
                    self.isFragment = true;
                    ((self.ui).tex_ConvertToFragment):SetIndex(0, tostring(
                                                                   fragCount))
                end
                do
                    local action_type = itemCfg.action_type
                    if action_type == eItemActionType.HeroCardFrag then
                        local heroId = (itemCfg.arg)[0]
                        local heroResCfg = itemCfg:GetHeroResCfg()
                        if heroResCfg ~= nil then
                            resloader:LoadABAssetAsync(
                                PathConsts:GetCharacterPicPath(
                                    heroResCfg.res_Name), function(texture)
                                    -- function num : 0_4_1 , upvalues : self
                                    ((self.ui).OBJ_imgItemPic):SetActive(false);
                                    ((self.ui).OBJ_rawImageHeroPic):SetActive(
                                        true) -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'
                                    ;
                                    ((self.ui).rawImage_HeroPic).texture =
                                        texture
                                end)
                        end
                    else
                        do

                            ((self.ui).OBJ_imgItemPic):SetActive(true);
                            ((self.ui).OBJ_rawImageHeroPic):SetActive(false) -- DECOMPILER ERROR at PC235: Confused about usage of register: R6 in 'UnsetPending'
                            ;
                            ((self.ui).img_ItemPic).sprite =
                                CRH:GetSprite(itemCfg.icon) -- DECOMPILER ERROR at PC242: Confused about usage of register: R6 in 'UnsetPending'
                            ;
                            ((self.ui).tex_itemName).text =
                                (LanguageUtil.GetLocaleText)(itemCfg.name) -- DECOMPILER ERROR at PC245: Confused about usage of register: R6 in 'UnsetPending'
                            ;
                            ((self.ui).tex_ItemNumber).text = count
                        end
                    end
                end
            end
        end
    end

UILotteryResultItem.FlipSelf = function(self)
    -- function num : 0_5 , upvalues : cs_DoTween, _ENV, repeatNewHeroTable, StopAutoFlipCards, MinFlipNumFun
    if not self.isFliped then
        self.isFliped = true
        self.sequence = (((((cs_DoTween.Sequence)()):Append(
                            (((self.transform):DOScale((Vector3.New)(0, 1, 1),
                                                       0.3)):SetEase(
                                (((CS.DG).Tweening).Ease).InBack)):OnComplete(
                                function()
                    -- function num : 0_5_0 , upvalues : self, repeatNewHeroTable, StopAutoFlipCards, _ENV
                    if self.isHero then
                        ((self.ui).GameObject_hero):SetActive(true)
                        if not self.isFragment or
                            not repeatNewHeroTable[self.heroId] then
                            StopAutoFlipCards()
                            repeatNewHeroTable[self.heroId] = true;
                            ((self.ui).image_New):SetActive(true)
                        else
                            local fragId = (self.heroCfg).fragment
                            local fragCount =
                                (self.heroRankCfg).repeat_frag_trans;
                            ((self.ui).tex_ConvertToFragment):SetIndex(0,
                                                                       tostring(
                                                                           fragCount))
                            self.isFragment = true
                        end
                    else
                        do

                            ((self.ui).GameObject_item):SetActive(true)
                        end
                    end
                end))):Append((((self.transform):DOScale((Vector3.New)(1, 1, 1),
                                                         0.2)):SetEase(
                                  (((CS.DG).Tweening).Ease).OutQuart)):OnComplete(
                                  function()
                -- function num : 0_5_1 , upvalues : self, _ENV
                if self.isHero and not self.isFragment then
                    UIManager:ShowWindowAsync(UIWindowTypeID.GetHero,
                                              function(window)
                        -- function num : 0_5_1_0 , upvalues : _ENV, self
                        if window == nil then return end
                        local heroData = (PlayerDataCenter.heroDic)[self.heroId]
                        window:InitGetHeroList({heroData})
                    end)
                end
            end))):Append((self.transform):DOScale((Vector3.New)(0.9, 1, 1),
                                                   0.05))):Append(
                            (self.transform):DOScale((Vector3.New)(1, 1, 1), 0.1))
        MinFlipNumFun()
    end
end

UILotteryResultItem.OnDelete = function(self)
    -- function num : 0_6 , upvalues : base
    (base.OnDelete)(self)
end

return UILotteryResultItem


-- params : ...
-- function num : 0 , upvalues : _ENV
local UICarouselContainer = class("UICarouselBanner", UIBaseNode)
local base = UIBaseNode
local ContainerData = require("Game.CommonUI.Container.Model.ContainerData")
local UIPictureItem = require("Game.CommonUI.Container.UI.UIPictureItem")
local ImgSelectWidth = 33
UICarouselContainer.InitialWithData = function(self, dataList, bannerList,
                                               uiPictureIns, resLoader,
                                               selectWidth)
    -- function num : 0_0 , upvalues : _ENV, UIPictureItem
    self.containerDataList = dataList
    self.pageCount = #dataList
    self.bannerList = bannerList
    self.picItemPool = (UIItemPool.New)(UIPictureItem, uiPictureIns);
    (self.bannerList):onPageIndexChanged("+", BindCallback(self,
                                                           self.OnPageIndexChanged))
    self.curPageNum = 1
    self.resLoader = resLoader
    self.selectWidth = selectWidth
    if (ConfigData.game_config).BannerAutoDragInterval ~= nil then
        bannerList:SetInterval((ConfigData.game_config).BannerAutoDragInterval)
    end
    self:InitSelectUI()
    self:__InitPic()
end

UICarouselContainer.InjectSelectObj = function(self, selectCountTrans,
                                               selectTrans, bannerSelectWidth)
    -- function num : 0_1
    self.selectCountTrans = selectCountTrans
    self.selectTrans = selectTrans
    self.bannerSelectWidth = bannerSelectWidth
end

UICarouselContainer.InitSelectUI = function(self)
    -- function num : 0_2 , upvalues : _ENV
    local width = self.bannerSelectWidth * self.pageCount -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'
    ;
    (self.selectCountTrans).anchoredPosition3D =
        (Vector3.New)(-width / 2,
                      ((self.selectCountTrans).anchoredPosition3D).y,
                      ((self.selectCountTrans).anchoredPosition3D).z) -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'
    ;
    (self.selectCountTrans).sizeDelta = (Vector3.New)(width,
                                                      ((self.selectCountTrans).sizeDelta).y) -- DECOMPILER ERROR at PC34: Confused about usage of register: R2 in 'UnsetPending'
    ;
    (self.selectTrans).anchoredPosition3D =
        (Vector3.New)(21 + self.bannerSelectWidth * (self.curPageNum - 1))
end

UICarouselContainer.__InitPic = function(self)
    -- function num : 0_3 , upvalues : _ENV
    if self.pageCount <= 0 then return end
    if self.resLoader == nil then return end
    (self.picItemPool):HideAll()
    for index = 1, self.pageCount do
        local picData = (self.containerDataList)[index]
        local resPath = PathConsts:GetBannerPicPath(picData.imgPath)
        local picItem = (self.picItemPool):GetOne()
        picItem:InitPictureItem(index, resPath, self.resLoader, picData.urlValue)
    end
    (self.bannerList):InitPosList()
    self:OnPageIndexChanged(0)
end

UICarouselContainer.OnPageIndexChanged =
    function(self, pageIndex)
        -- function num : 0_4 , upvalues : _ENV
        local page = pageIndex + 1
        self.curPageNum = page -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'
        ;
        (self.selectTrans).anchoredPosition3D =
            (Vector3.New)(21 + self.bannerSelectWidth * (self.curPageNum - 1))
    end

UICarouselContainer.EnterCurrentPage = function(self)
    -- function num : 0_5
    (self.bannerList):SetPageIndex(self.curPageNum - 1)
end

UICarouselContainer.OnDelete = function(self)
    -- function num : 0_6 , upvalues : base
    (base.OnDelete)(self)
end

return UICarouselContainer


-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHomeBanner = class("UICarouselBanner", UIBaseNode)
local base = UIBaseNode
local ImgSelectWidth = 22
local HomeBannerManager = require("Game.Home.Banner.HomeBannerManager")
local UINHomeBannerLoopList = require("Game.Home.Banner.UINHomeBannerLoopList")
UINHomeBanner.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHomeBannerLoopList, ImgSelectWidth
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.bannerLoopList = (UINHomeBannerLoopList.New)()
  ;
  (self.bannerLoopList):Init((self.ui).obj_advList)
  self.__OnPageIndexChanged = BindCallback(self, self.OnPageIndexChanged)
  self.bannerSelectWidth = (self.ui).float_bannerSelectWidth or ImgSelectWidth
end

UINHomeBanner.InitialHomeBanner = function(self, bannerDataList, oldDataId)
  -- function num : 0_1 , upvalues : _ENV
  self.bannerDataList = bannerDataList
  self.pageCount = #bannerDataList
  self.curPageNum = 1
  local width = self.bannerSelectWidth * self.pageCount
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).trans_indexCount).sizeDelta = (Vector3.New)(width, (((self.ui).trans_indexCount).sizeDelta).y)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).trans_indexItem).anchoredPosition3D = (Vector3.New)(self.bannerSelectWidth * (self.curPageNum - 1))
  local initIndex = nil
  for index,value in ipairs(bannerDataList) do
    if value.id == oldDataId then
      initIndex = index
      break
    end
  end
  do
    if initIndex == nil then
      initIndex = 1
    end
    ;
    (self.bannerLoopList):SetLoopBannerDataList(bannerDataList, initIndex, self.__OnPageIndexChanged)
    ;
    (self.bannerLoopList):SetInterval(((self.bannerDataList)[initIndex]).delay)
  end
end

UINHomeBanner.RefreshAllBannerData = function(self)
  -- function num : 0_2 , upvalues : HomeBannerManager
  HomeBannerManager:RefreshBannerDataList(function(bannerDataList)
    -- function num : 0_2_0 , upvalues : self
    if bannerDataList ~= nil and #bannerDataList > 0 then
      local oldCurDataId = ((self.bannerDataList)[self.curPageNum]).id
      self:InitialHomeBanner(bannerDataList, oldCurDataId)
      self:Show()
    else
      do
        self:Hide()
      end
    end
  end
)
end

UINHomeBanner.OnPageIndexChanged = function(self, pageIndex)
  -- function num : 0_3 , upvalues : _ENV
  local page = pageIndex
  self.curPageNum = page
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).trans_indexItem).anchoredPosition3D = (Vector3.New)(self.bannerSelectWidth * (self.curPageNum - 1))
  ;
  (self.bannerLoopList):SetInterval(((self.bannerDataList)[self.curPageNum]).delay)
  if ((self.bannerDataList)[self.curPageNum]):GetBannerIsOutOfData() or ((self.bannerDataList)[self.curPageNum]):GetIsLotteryOrShopItemClosed() then
    self:RefreshAllBannerData()
  end
  self:__UpdateBannerLeftTime()
end

UINHomeBanner.__UpdateBannerLeftTime = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if not ((self.bannerDataList)[self.curPageNum]):GetBannerIsShowLeftTime() then
    (((self.ui).tex_AdvContent).gameObject):SetActive(false)
    return 
  end
  ;
  (((self.ui).tex_AdvContent).gameObject):SetActive(true)
  -- DECOMPILER ERROR at PC26: Overwrote pending register: R3 in 'AssignReg'

  local d, h, m, s = TimestampToTimeInter((((self.bannerDataList)[self.curPageNum]):GetBannerLeftTime())), true
  if d > 0 then
    ((self.ui).tex_AdvContent):SetIndex(0, tostring(d), tostring(h))
  else
    if h > 0 then
      ((self.ui).tex_AdvContent):SetIndex(1, tostring(h))
    else
      ;
      ((self.ui).tex_AdvContent):SetIndex(1, tostring(1))
    end
  end
end

UINHomeBanner.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (self.bannerLoopList):Delete()
  ;
  (base.OnDelete)(self)
end

return UINHomeBanner


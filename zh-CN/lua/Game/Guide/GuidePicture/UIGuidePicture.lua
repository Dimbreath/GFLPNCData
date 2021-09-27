local UIGuidePicture = class("UIGuidePicture", UIBaseWindow)
local base = UIBaseWindow
local UIGuidePictureItem = require("Game.Guide.GuidePicture.UIGuidePictureItem")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
UIGuidePicture.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, eDynConfigData, UIGuidePictureItem
  ConfigData:LoadDynCfg(eDynConfigData.tips)
  ;
  (UIUtil.HideTopStatus)()
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnBtnCloseClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Last, self, self.OnLastPageClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Next, self, self.OnNextPageClicked)
  ;
  ((self.ui).picItem):SetActive(false)
  self.picItemPool = (UIItemPool.New)(UIGuidePictureItem, (self.ui).picItem)
  ;
  ((self.ui).picList):onPageIndexChanged("+", BindCallback(self, self.OnPageIndexChanged))
  self._pointWidthUnit = (((self.ui).tran_TotalPoint).rect).width
  self._pointHeightUnit = (((self.ui).tran_TotalPoint).rect).height
end

UIGuidePicture.InitGuidePicture = function(self, guideType, completeAction, finishShowClose)
  -- function num : 0_1 , upvalues : _ENV
  local tipsCfg = (ConfigData.tips)[guideType]
  if tipsCfg == nil then
    error("can\'t read tipsCfg with guideType:" .. tostring(guideType))
    if completeAction ~= nil then
      completeAction()
    end
    self:Delete()
    return 
  end
  self.completeAction = completeAction
  self.__finishShowClose = finishShowClose or false
  self.pageCount = #tipsCfg.content
  self.curPageNum = 1
  if self.__finishShowClose then
    (((self.ui).btn_Close).gameObject):SetActive(false)
  end
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
  end
  self.resloader = ((CS.ResLoader).Create)()
  ;
  (self.picItemPool):HideAll()
  for index,contentName in ipairs(tipsCfg.content) do
    local resPath = PathConsts:GetGuideTipsPath(tipsCfg.path, contentName)
    local picItem = (self.picItemPool):GetOne()
    picItem:InitPictureItem(index, resPath, self.resloader)
  end
  ;
  ((self.ui).picList):InitPosList()
  self:OnPageIndexChanged(0)
  self:_InitPagePointUI(0)
end

UIGuidePicture.__TryShowCloseButton = function(self)
  -- function num : 0_2
  if self.pageCount <= self.curPageNum and self.__finishShowClose then
    self.__finishShowClose = false
    ;
    (((self.ui).btn_Close).gameObject):SetActive(true)
  end
end

UIGuidePicture.OnPageIndexChanged = function(self, pageIndex)
  -- function num : 0_3 , upvalues : _ENV
  local page = pageIndex + 1
  self.curPageNum = page
  ;
  (((self.ui).btn_Last).gameObject):SetActive(page > 1)
  ;
  (((self.ui).btn_Next).gameObject):SetActive(page < self.pageCount)
  ;
  ((self.ui).tex_Page):SetIndex(0, tostring(page), tostring(self.pageCount))
  self:RefreshPagePointUI(pageIndex)
  self:__TryShowCloseButton()
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIGuidePicture.EnterCurrentGuidePage = function(self)
  -- function num : 0_4
  ((self.ui).picList):SetPageIndex(self.curPageNum - 1)
end

UIGuidePicture.OnBtnCloseClicked = function(self)
  -- function num : 0_5
  if self.completeAction ~= nil then
    (self.completeAction)()
  end
  self:Delete()
end

UIGuidePicture.OnLastPageClicked = function(self)
  -- function num : 0_6
  if self.curPageNum <= 1 then
    return 
  end
  self.curPageNum = self.curPageNum - 1
  self:EnterCurrentGuidePage()
end

UIGuidePicture.OnNextPageClicked = function(self)
  -- function num : 0_7
  if self.pageCount <= self.curPageNum then
    return 
  end
  self.curPageNum = self.curPageNum + 1
  self:EnterCurrentGuidePage()
  self:__TryShowCloseButton()
end

UIGuidePicture._InitPagePointUI = function(self, pageIndex)
  -- function num : 0_8 , upvalues : _ENV
  local totalWidth = self._pointWidthUnit * self.pageCount
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tran_TotalPoint).sizeDelta = (Vector2.New)(totalWidth, self._pointHeightUnit)
  self:RefreshPagePointUI(pageIndex)
end

UIGuidePicture.RefreshPagePointUI = function(self, pageIndex)
  -- function num : 0_9 , upvalues : _ENV
  local moveX = pageIndex * self._pointWidthUnit
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_CurPoint).anchoredPosition = (Vector2.New)(moveX, 0, 0)
end

UIGuidePicture.OnDelete = function(self)
  -- function num : 0_10 , upvalues : _ENV, eDynConfigData, base
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  ConfigData:ReleaseDynCfg(eDynConfigData.tips)
  ;
  (UIUtil.ReShowTopStatus)()
  ;
  (base.OnDelete)(self)
end

return UIGuidePicture


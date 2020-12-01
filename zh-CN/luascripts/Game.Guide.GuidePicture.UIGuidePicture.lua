-- params : ...
-- function num : 0 , upvalues : _ENV
local UIGuidePicture = class("UIGuidePicture", UIBaseWindow)
local base = UIBaseWindow
local UIGuidePictureItem = require("Game.Guide.GuidePicture.UIGuidePictureItem")
UIGuidePicture.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIGuidePictureItem
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
end

UIGuidePicture.InitGuidePicture = function(self, picPath, pageCount, completeAction)
  -- function num : 0_1 , upvalues : _ENV
  if pageCount <= 0 then
    return 
  end
  self.picPath = picPath
  self.completeAction = completeAction
  self.pageCount = pageCount
  self.curPageNum = 1
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
  end
  self.resloader = ((CS.ResLoader).Create)()
  ;
  (self.picItemPool):HideAll()
  for index = 1, self.pageCount do
    local resPath = self.picPath .. tostring(index) .. ".png"
    local picItem = (self.picItemPool):GetOne()
    picItem:InitPictureItem(index, resPath, self.resloader)
  end
  ;
  ((self.ui).picList):InitPosList()
  self:OnPageIndexChanged(0)
end

UIGuidePicture.OnPageIndexChanged = function(self, pageIndex)
  -- function num : 0_2 , upvalues : _ENV
  local page = pageIndex + 1
  self.curPageNum = page
  ;
  (((self.ui).btn_Last).gameObject):SetActive(page > 1)
  ;
  (((self.ui).btn_Next).gameObject):SetActive(page < self.pageCount)
  ;
  ((self.ui).tex_Page):SetIndex(0, tostring(page), tostring(self.pageCount))
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIGuidePicture.EnterCurrentGuidePage = function(self)
  -- function num : 0_3
  ((self.ui).picList):SetPageIndex(self.curPageNum - 1)
end

UIGuidePicture.OnBtnCloseClicked = function(self)
  -- function num : 0_4
  if self.completeAction ~= nil then
    (self.completeAction)()
  end
  self:Delete()
end

UIGuidePicture.OnLastPageClicked = function(self)
  -- function num : 0_5
  if self.curPageNum <= 1 then
    return 
  end
  self.curPageNum = self.curPageNum - 1
  self:EnterCurrentGuidePage()
end

UIGuidePicture.OnNextPageClicked = function(self)
  -- function num : 0_6
  if self.pageCount <= self.curPageNum then
    return 
  end
  self.curPageNum = self.curPageNum + 1
  self:EnterCurrentGuidePage()
end

UIGuidePicture.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIGuidePicture

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIGuidePicture = class("UIGuidePicture", UIBaseWindow)
local base = UIBaseWindow
local UIGuidePictureItem = require("Game.Guide.GuidePicture.UIGuidePictureItem")
UIGuidePicture.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UIGuidePictureItem
    (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnBtnCloseClicked);
    (UIUtil.AddButtonListener)((self.ui).btn_Last, self, self.OnLastPageClicked);
    (UIUtil.AddButtonListener)((self.ui).btn_Next, self, self.OnNextPageClicked);
    ((self.ui).picItem):SetActive(false)
    self.picItemPool = (UIItemPool.New)(UIGuidePictureItem, (self.ui).picItem);
    ((self.ui).picList):onPageIndexChanged("+", BindCallback(self,
                                                             self.OnPageIndexChanged))
end

UIGuidePicture.InitGuidePicture = function(self, picPath, pageCount,
                                           completeAction)
    -- function num : 0_1 , upvalues : _ENV
    if pageCount <= 0 then return end
    self.picPath = picPath
    self.completeAction = completeAction
    self.pageCount = pageCount
    self.curPageNum = 1
    if self.resloader ~= nil then (self.resloader):Put2Pool() end
    self.resloader = ((CS.ResLoader).Create)();
    (self.picItemPool):HideAll()
    for index = 1, self.pageCount do
        local resPath = self.picPath .. tostring(index) .. ".png"
        local picItem = (self.picItemPool):GetOne()
        picItem:InitPictureItem(index, resPath, self.resloader)
    end
    ((self.ui).picList):InitPosList()
    self:OnPageIndexChanged(0)
end

UIGuidePicture.OnPageIndexChanged = function(self, pageIndex)
    -- function num : 0_2 , upvalues : _ENV
    local page = pageIndex + 1
    self.curPageNum = page;
    (((self.ui).btn_Last).gameObject):SetActive(page > 1);
    (((self.ui).btn_Next).gameObject):SetActive(page < self.pageCount);
    ((self.ui).tex_Page):SetIndex(0, tostring(page), tostring(self.pageCount))
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIGuidePicture.EnterCurrentGuidePage = function(self)
    -- function num : 0_3
    ((self.ui).picList):SetPageIndex(self.curPageNum - 1)
end

UIGuidePicture.OnBtnCloseClicked = function(self)
    -- function num : 0_4
    if self.completeAction ~= nil then (self.completeAction)() end
    self:Delete()
end

UIGuidePicture.OnLastPageClicked = function(self)
    -- function num : 0_5
    if self.curPageNum <= 1 then return end
    self.curPageNum = self.curPageNum - 1
    self:EnterCurrentGuidePage()
end

UIGuidePicture.OnNextPageClicked = function(self)
    -- function num : 0_6
    if self.pageCount <= self.curPageNum then return end
    self.curPageNum = self.curPageNum + 1
    self:EnterCurrentGuidePage()
end

UIGuidePicture.OnDelete = function(self)
    -- function num : 0_7 , upvalues : base
    if self.resloader ~= nil then
        (self.resloader):Put2Pool()
        self.resloader = nil
    end
    (base.OnDelete)(self)
end

return UIGuidePicture


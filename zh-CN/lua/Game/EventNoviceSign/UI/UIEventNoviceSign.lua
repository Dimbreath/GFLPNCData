local UIEventNoviceSign = class("UIEventNoviceSign", UIBaseWindow)
local base = UIBaseWindow
local UINEventNoviceSign = require("Game.EventNoviceSign.UI.UINEventNoviceSign")
UIEventNoviceSign.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINEventNoviceSign
  self.resloader = ((CS.ResLoader).Create)()
  self.itemPool = (UIItemPool.New)(UINEventNoviceSign, (self.ui).obj_dayItem)
  ;
  ((self.ui).obj_dayItem):SetActive(false)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_close, self, self.Delete)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_backGround, self, self.Delete)
end

UIEventNoviceSign.InitNoviceSign = function(self, id, isShowCloseBtn)
  -- function num : 0_1 , upvalues : _ENV
  ;
  (((self.ui).btn_close).gameObject):SetActive(isShowCloseBtn or false)
  ;
  (((self.ui).btn_backGround).gameObject):SetActive(isShowCloseBtn or false)
  self.data = ((PlayerDataCenter.eventNoviceSignData).dataDic)[id]
  ;
  (self.data):SetPoped()
  local list = {}
  for k,v in pairs((self.data).awardCfg) do
    (table.insert)(list, v)
  end
  ;
  (table.sort)(list, function(a, b)
    -- function num : 0_1_0
    do return a.day < b.day end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self.itemPool):HideAll()
  for k,v in pairs(list) do
    local item = (self.itemPool):GetOne()
    item:InitNoviceSignItem(self.data, v, self.resloader)
  end
  local lastAwardCfg = list[#list]
  local heroId = 0
  for i,v in ipairs(lastAwardCfg.awardIds) do
    local itemCfg = (ConfigData.item)[v]
    if itemCfg.type == eItemType.HeroCard then
      heroId = (itemCfg.arg)[1]
      break
    end
  end
end

UIEventNoviceSign.RefreshNoviceSign = function(self)
  -- function num : 0_2 , upvalues : _ENV
  for i,v in ipairs((self.itemPool).listItem) do
    v:RefreshNoviceSignItem()
  end
end

UIEventNoviceSign.SetCloseCallback = function(self, callback)
  -- function num : 0_3
  self.closeCallback = callback
end

UIEventNoviceSign.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (self.itemPool):DeleteAll()
  if self.data ~= nil then
    (self.data):SetPoped()
  end
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  if self.closeCallback ~= nil then
    (self.closeCallback)()
  end
  ;
  (base.OnDelete)(self)
end

return UIEventNoviceSign


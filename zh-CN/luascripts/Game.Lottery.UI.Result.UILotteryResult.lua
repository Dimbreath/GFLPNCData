-- params : ...
-- function num : 0 , upvalues : _ENV
local UILotteryResult = class("UILotteryResult", UIBaseWindow)
local base = UIBaseWindow
local UINLtrResultHero = require("Game.Lottery.UI.Result.UINLtrResultHero")
local UINLtrResultHeroConvert = require("Game.Lottery.UI.Result.UINLtrResultHeroConvert")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local cs_ResLoader = CS.ResLoader
UILotteryResult.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINLtrResultHero, UINLtrResultHeroConvert, UINBaseItemWithCount, cs_ResLoader
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self._OnClickClose)
  ;
  ((self.ui).heroItem):SetActive(false)
  self.heroPool = (UIItemPool.New)(UINLtrResultHero, (self.ui).heroItem)
  ;
  ((self.ui).changeItem):SetActive(false)
  self.heroConvertPool = (UIItemPool.New)(UINLtrResultHeroConvert, (self.ui).changeItem)
  ;
  ((self.ui).lotteryItem):SetActive(false)
  self.itemPool = (UIItemPool.New)(UINBaseItemWithCount, (self.ui).lotteryItem)
  self.resLoader = (cs_ResLoader.Create)()
end

UILotteryResult.InitLtrResult = function(self, rewardElemList)
  -- function num : 0_1 , upvalues : _ENV
  (self.heroConvertPool):HideAll()
  ;
  (self.heroPool):HideAll()
  for k,elem in ipairs(rewardElemList) do
    if elem.heroData ~= nil then
      local heroItem = (self.heroPool):GetOne()
      heroItem:InitLtrResultHero(elem.heroData, elem.isNewHero, self.resLoader)
      self:_SetItemParent(heroItem.transform, k)
      heroItem:SetStarQualityActive(elem.isNewHero)
      if not elem.isNewHero then
        local rankCfg = (ConfigData.hero_rank)[((elem.heroData).heroCfg).rank]
        if rankCfg == nil then
          error("Can\'t find rankCfg, id = " .. tostring((heroData.heroCfg).rank))
        else
          local convertItem = (self.heroConvertPool):GetOne()
          convertItem:InitLtrResultHeroConvert(rankCfg.repeat_extra_trans_id, rankCfg.repeat_extra_trans_num)
          ;
          (convertItem.transform):SetParent(heroItem.transform)
        end
      end
    else
      do
        do
          local item = (self.itemPool):GetOne()
          item:InitItemWithCount(elem.itemCfg, elem.num)
          self:_SetItemParent(item.transform, k)
          -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

UILotteryResult.BindLotteryResultExit = function(self, exitAction)
  -- function num : 0_2
  self.__exitAction = exitAction
end

UILotteryResult._SetItemParent = function(self, transform, index)
  -- function num : 0_3
  if index <= 5 then
    transform:SetParent((self.ui).heroList_Up)
  else
    transform:SetParent((self.ui).heroList_Low)
  end
end

UILotteryResult._OnClickClose = function(self)
  -- function num : 0_4
  self:Delete()
  if self.__exitAction ~= nil then
    (self.__exitAction)()
  end
end

UILotteryResult.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (self.heroPool):DeleteAll()
  ;
  (self.heroConvertPool):DeleteAll()
  ;
  (self.itemPool):DeleteAll()
  ;
  (self.resLoader):Put2Pool()
  self.resLoader = nil
  ;
  (base.OnDelete)(self)
end

return UILotteryResult

-- params : ...
-- function num : 0 , upvalues : _ENV
local UILotteryResult = class("UILotteryResult", UIBaseWindow)
local base = UIBaseWindow
local UINLtrResultHero = require("Game.Lottery.UI.Result.UINLtrResultHero")
local UINLtrResultHeroConvert = require(
                                    "Game.Lottery.UI.Result.UINLtrResultHeroConvert")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local cs_ResLoader = CS.ResLoader
UILotteryResult.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINLtrResultHero, UINLtrResultHeroConvert, UINBaseItemWithCount, cs_ResLoader
    (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self._OnClickClose);
    ((self.ui).heroItem):SetActive(false)
    self.heroPool = (UIItemPool.New)(UINLtrResultHero, (self.ui).heroItem);
    ((self.ui).changeItem):SetActive(false)
    self.heroConvertPool = (UIItemPool.New)(UINLtrResultHeroConvert,
                                            (self.ui).changeItem);
    ((self.ui).lotteryItem):SetActive(false)
    self.itemPool =
        (UIItemPool.New)(UINBaseItemWithCount, (self.ui).lotteryItem)
    self.resLoader = (cs_ResLoader.Create)()
end

UILotteryResult.InitLtrResult = function(self, rewardElemList)
    -- function num : 0_1 , upvalues : _ENV
    (self.heroConvertPool):HideAll();
    (self.heroPool):HideAll()
    for k, elem in ipairs(rewardElemList) do
        if elem.heroData ~= nil then
            local heroItem = (self.heroPool):GetOne()
            heroItem:InitLtrResultHero(elem.heroData, elem.isNewHero,
                                       self.resLoader)
            self:_SetItemParent(heroItem.transform, k)
            heroItem:SetStarQualityActive(elem.isNewHero)
            if not elem.isNewHero then
                local rankCfg =
                    (ConfigData.hero_rank)[((elem.heroData).heroCfg).rank]
                if rankCfg == nil then
                    error("Can\'t find rankCfg, id = " ..
                              tostring((heroData.heroCfg).rank))
                else
                    local convertItem = (self.heroConvertPool):GetOne()
                    convertItem:InitLtrResultHeroConvert(
                        rankCfg.repeat_extra_trans_id,
                        rankCfg.repeat_extra_trans_num);
                    (convertItem.transform):SetParent(heroItem.transform)
                end
            end
        else
            do
                do
                    local item = (self.itemPool):GetOne()
                    item:InitItemWithCount(elem.itemCfg, elem.num)
                    self:_SetItemParent(item.transform, k)
                    -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                    -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out IF_STMT

                end
            end
        end
    end
end

UILotteryResult.BindLotteryResultExit = function(self, exitAction)
    -- function num : 0_2
    self.__exitAction = exitAction
end

UILotteryResult._SetItemParent = function(self, transform, index)
    -- function num : 0_3
    if index <= 5 then
        transform:SetParent((self.ui).heroList_Up)
    else
        transform:SetParent((self.ui).heroList_Low)
    end
end

UILotteryResult._OnClickClose = function(self)
    -- function num : 0_4
    self:Delete()
    if self.__exitAction ~= nil then (self.__exitAction)() end
end

UILotteryResult.OnDelete = function(self)
    -- function num : 0_5 , upvalues : base
    (self.heroPool):DeleteAll();
    (self.heroConvertPool):DeleteAll();
    (self.itemPool):DeleteAll();
    (self.resLoader):Put2Pool()
    self.resLoader = nil;
    (base.OnDelete)(self)
end

return UILotteryResult


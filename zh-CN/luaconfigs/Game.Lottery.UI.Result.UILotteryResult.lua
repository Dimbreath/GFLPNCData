-- params : ...
-- function num : 0 , upvalues : _ENV
local UILotteryResult = class("UILotteryResult", UIBaseWindow)
local base = UIBaseWindow
local UINLtrResultHero = require("Game.Lottery.UI.Result.UINLtrResultHero")
local UINLtrResultHeroConvert = require("Game.Lottery.UI.Result.UINLtrResultHeroConvert")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local cs_ResLoader = CS.ResLoader
local cs_DoTween = ((CS.DG).Tweening).DOTween
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
  self.heroItemList = {}
end

UILotteryResult.InitLtrResult = function(self, rewardElemList)
  -- function num : 0_1 , upvalues : _ENV
  (self.heroConvertPool):HideAll()
  ;
  (self.heroPool):HideAll()
  self:_InitShowTween()
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
          (convertItem.transform):SetParent(((heroItem.ui).root).transform)
        end
      end
      do
        do
          self:_JoinItemTween((heroItem.ui).root, k)
          ;
          (table.insert)(self.heroItemList, heroItem)
          do
            local item = (self.itemPool):GetOne()
            item:InitItemWithCount(elem.itemCfg, elem.num)
            self:_SetItemParent(item.transform, k)
            self:_JoinItemTween((item.ui).root, k)
            -- DECOMPILER ERROR at PC92: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC92: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC92: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC92: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

UILotteryResult._InitShowTween = function(self)
  -- function num : 0_2 , upvalues : cs_DoTween
  (((self.ui).btn_Close).gameObject):SetActive(false)
  local sequence = (cs_DoTween.Sequence)()
  sequence:Insert(0, (((self.ui).upper):DOAnchorPosX((((self.ui).upper).anchoredPosition).x - 300, 1)):From())
  sequence:Insert(0, (((self.ui).lowerArrow):DOAnchorPosX((((self.ui).lowerArrow).anchoredPosition).x - 300, 1.2)):From())
  sequence:Insert(0, (((self.ui).upperArrow):DOAnchorPosX((((self.ui).upperArrow).anchoredPosition).x + 300, 1.2)):From())
  sequence:Insert(0, (((self.ui).lowerRight):DOAnchorPosX((((self.ui).lowerRight).anchoredPosition).x + 300, 1)):From())
  sequence:InsertCallback(1.3, function()
    -- function num : 0_2_0 , upvalues : self
    (((self.ui).btn_Close).gameObject):SetActive(true)
  end
)
  self.showSeq = sequence
end

UILotteryResult._JoinItemTween = function(self, canvasGroup, index)
  -- function num : 0_3 , upvalues : _ENV
  local tween, deplay = nil, nil
  if index <= 5 then
    deplay = (index - 1) * 0.1
    tween = (((canvasGroup.transform):DOLocalMoveY(150, 0.15)):From()):SetDelay(deplay)
  else
    deplay = (10 - index) * 0.1
    tween = (((canvasGroup.transform):DOLocalMoveY(-150, 0.15)):From()):SetDelay(deplay)
  end
  tween.onComplete = function()
    -- function num : 0_3_0 , upvalues : self, index, _ENV
    local item = (self.heroItemList)[index]
    if not IsNull(item) then
      item:ShowFlashFx()
    end
  end

  ;
  (self.showSeq):Insert(0, tween)
  canvasGroup.alpha = 0
  ;
  (self.showSeq):Insert(0, (canvasGroup:DOFade(1, 0.6)):SetDelay(deplay))
end

UILotteryResult.BindLotteryResultExit = function(self, exitAction)
  -- function num : 0_4
  self.__exitAction = exitAction
end

UILotteryResult._SetItemParent = function(self, transform, index)
  -- function num : 0_5
  if index <= 5 then
    transform:SetParent((self.ui).heroList_Up)
  else
    transform:SetParent((self.ui).heroList_Low)
  end
end

UILotteryResult._OnClickClose = function(self)
  -- function num : 0_6
  self:Delete()
  if self.__exitAction ~= nil then
    (self.__exitAction)()
  end
end

UILotteryResult.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (self.heroPool):DeleteAll()
  ;
  (self.heroConvertPool):DeleteAll()
  ;
  (self.itemPool):DeleteAll()
  ;
  (self.resLoader):Put2Pool()
  self.resLoader = nil
  if self.showSeq ~= nil then
    (self.showSeq):Kill()
    self.showSeq = nil
  end
  ;
  (base.OnDelete)(self)
end

return UILotteryResult


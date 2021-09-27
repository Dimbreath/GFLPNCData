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
  self.isOnce = #rewardElemList == 1
  self:_RefreshLotteryResultUI(self.isOnce)
  self:_InitShowTween(self.isOnce)
  local allCoverDic = {}
  for k,elem in ipairs(rewardElemList) do
    if elem.heroData ~= nil then
      local heroItem = (self.heroPool):GetOne()
      heroItem:InitLtrResultHero(elem.heroData, elem.isNewHero, self.resLoader)
      self:_SetItemParent(heroItem.transform, k)
      heroItem:SetStarQualityActive(elem.isNewHero)
      if not elem.isNewHero then
        do
          local convertList = heroItem:GetRepeatExtraItemList()
          if convertList ~= nil and #convertList > 0 then
            local convertItem = (self.heroConvertPool):GetOne()
            ;
            (convertItem.transform):SetParent(((heroItem.ui).root).transform)
            convertItem:HideAllChild()
            for _,data in ipairs(convertList) do
              convertItem:GetOneChlid(data.itemCfg, data.num)
              local count = allCoverDic[data.itemCfg]
              if count == nil then
                count = 0
              end
              allCoverDic[data.itemCfg] = count + data.num
            end
            self:_JoinItemTween((heroItem.ui).root, k)
            ;
            (table.insert)(self.heroItemList, heroItem)
          end
          do
            local item = (self.itemPool):GetOne()
            item:InitItemWithCount(elem.itemCfg, elem.num)
            self:_SetItemParent(item.transform, k)
            self:_JoinItemTween((item.ui).root, k)
            -- DECOMPILER ERROR at PC108: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC108: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC108: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC108: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC108: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  local baseInsert = #rewardElemList * 0.1
  ;
  (self.showSeq):InsertCallback(baseInsert + 0.3, function()
    -- function num : 0_1_0 , upvalues : self
    (((self.ui).btn_Close).gameObject):SetActive(true)
  end
)
  self:_RefreshConverTotalCount(baseInsert, allCoverDic)
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

UILotteryResult._RefreshLotteryResultUI = function(self, isOnce)
  -- function num : 0_2 , upvalues : _ENV
  ((self.ui).obj_isOnce):SetActive(isOnce)
  if not isOnce or not (self.ui).onceTotalParent then
    local totalChangeParent = (self.ui).tenTotalParent
  end
  ;
  ((self.ui).rect_totalChange):SetParent(totalChangeParent)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).rect_totalChange).localPosition = Vector3.zero
  ;
  ((self.ui).obj_isTen):SetActive(not isOnce)
end

UILotteryResult._RefreshConverTotalCount = function(self, baseInsert, allCoverDic)
  -- function num : 0_3 , upvalues : _ENV
  self.__isShowFragChanged = false
  ;
  (self.showSeq):InsertCallback(baseInsert + 0.15, function()
    -- function num : 0_3_0 , upvalues : self, _ENV, allCoverDic
    (((self.ui).rect_totalChange).gameObject):SetActive(false)
    for cfg,count in pairs(allCoverDic) do
      -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

      if cfg.id == 1006 then
        ((self.ui).tex_totalItemCount).text = count
        -- DECOMPILER ERROR at PC22: Confused about usage of register: R5 in 'UnsetPending'

        ;
        ((self.ui).img_totalItemPic).sprite = CRH:GetSprite(cfg.icon)
        ;
        (((self.ui).rect_totalChange).gameObject):SetActive(true)
        self.__isShowFragChanged = true
        GuideManager:TryTriggerGuide(eGuideCondition.InLotteryFragChanged)
        break
      end
    end
  end
)
end

UILotteryResult.IsLotteryFragChanged = function(self)
  -- function num : 0_4
  return self.__isShowFragChanged
end

UILotteryResult.GetLotteryFragChangeUI = function(self)
  -- function num : 0_5
  return (self.ui).rect_totalChange
end

UILotteryResult._InitShowTween = function(self, isOnce)
  -- function num : 0_6 , upvalues : cs_DoTween
  (((self.ui).btn_Close).gameObject):SetActive(false)
  local sequence = (cs_DoTween.Sequence)()
  if not isOnce then
    sequence:Insert(0, (((self.ui).upper):DOAnchorPosX((((self.ui).upper).anchoredPosition).x - 300, 1)):From())
    sequence:Insert(0, (((self.ui).lowerArrow):DOAnchorPosX((((self.ui).lowerArrow).anchoredPosition).x - 300, 1.2)):From())
    sequence:Insert(0, (((self.ui).upperArrow):DOAnchorPosX((((self.ui).upperArrow).anchoredPosition).x + 300, 1.2)):From())
    sequence:Insert(0, (((self.ui).lowerRight):DOAnchorPosX((((self.ui).lowerRight).anchoredPosition).x + 300, 1)):From())
  end
  self.showSeq = sequence
end

UILotteryResult._JoinItemTween = function(self, canvasGroup, index)
  -- function num : 0_7 , upvalues : _ENV
  local tween, deplay = nil, nil
  if not self.isOnce then
    if index <= 5 then
      deplay = (index - 1) * 0.1
      tween = (((canvasGroup.transform):DOLocalMoveY(150, 0.15)):From()):SetDelay(deplay)
    else
      deplay = (10 - index) * 0.1
      tween = (((canvasGroup.transform):DOLocalMoveY(-150, 0.15)):From()):SetDelay(deplay)
    end
  else
    deplay = 0.2
    tween = (((canvasGroup.transform):DOLocalMoveY(150, 0.15)):From()):SetDelay(deplay)
  end
  tween.onComplete = function()
    -- function num : 0_7_0 , upvalues : self, index, _ENV
    local item = (self.heroItemList)[index]
    if not IsNull(item) then
      item:ShowFlashFx()
    end
    for _,convertItem in ipairs((self.heroConvertPool).listItem) do
      convertItem:ShowHeroConvertFx()
    end
  end

  ;
  (self.showSeq):Insert(0, tween)
  canvasGroup.alpha = 0
  ;
  (self.showSeq):Insert(0, (canvasGroup:DOFade(1, 0.6)):SetDelay(deplay))
end

UILotteryResult.BindLotteryResultExit = function(self, exitAction)
  -- function num : 0_8
  self.__exitAction = exitAction
end

UILotteryResult._SetItemParent = function(self, transform, index)
  -- function num : 0_9
  if self.isOnce then
    transform:SetParent(((self.ui).obj_isOnce).transform)
    return 
  end
  if index <= 5 then
    transform:SetParent((self.ui).heroList_Up)
  else
    transform:SetParent((self.ui).heroList_Low)
  end
end

UILotteryResult._OnClickClose = function(self)
  -- function num : 0_10
  self:Delete()
  if self.__exitAction ~= nil then
    (self.__exitAction)()
  end
end

UILotteryResult.OnDelete = function(self)
  -- function num : 0_11 , upvalues : base
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


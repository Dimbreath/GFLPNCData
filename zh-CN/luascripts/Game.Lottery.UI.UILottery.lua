-- params : ...
-- function num : 0 , upvalues : _ENV
local UILottery = class("UILottery", UIBaseWindow)
local base = UIBaseWindow
local LotteryEnum = require("Game.Lottery.LotteryEnum")
local UINLtrPoolItem = require("Game.Lottery.UI.UINLtrPoolItem")
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UINLtrHeroItem = require("Game.Lottery.UI.UINLtrHeroItem")
local UINLtrPoolDetail = require("Game.Lottery.UI.PoolDetail.UINLtrPoolDetail")
local CheckerTypeId, CheckerGlobalConfig = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local cs_ResLoader = CS.ResLoader
local cs_MovieManager_ins = (CS.MovieManager).Instance
local cs_EventTriggerListener = CS.EventTriggerListener
UILottery.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, cs_EventTriggerListener, UINResourceGroup, cs_ResLoader, UINLtrPoolItem, UINLtrHeroItem, UINLtrPoolDetail
  (UIUtil.CreateTopBtnGroup)((self.ui).topButtonGroup, self, self.__OnClickClose)
  self.__onSelectLtrPoolItem = BindCallback(self, self.SelectLtrPoolItem)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Once, self, self.__OnClickDrawOne)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Ten, self, self.__OnClickDrawTen)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_PoolDetail, self, self.__OnClickPoolDetail)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_bg, self, self.__OnClickBg)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_LeftArrow, self, self.__OnClickLeftArrow)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_RightArrow, self, self.__OnClickRightArrow)
  local eventTrigger = (cs_EventTriggerListener.Get)(((self.ui).infoScroll).gameObject)
  eventTrigger:onEndDrag("+", BindCallback(self, self.__OnEndDrag))
  self.resourceGroup = (UINResourceGroup.New)()
  ;
  (self.resourceGroup):Init((self.ui).gameResourceGroup)
  self.resLoader = (cs_ResLoader.Create)()
  ;
  ((self.ui).infoItem):SetActive(false)
  self.ltrPoolItemPool = (UIItemPool.New)(UINLtrPoolItem, (self.ui).infoItem)
  self.poolItemWidth = ((((self.ui).infoItem).transform).sizeDelta).x + ((self.ui).scrollLayoutGroup).spacing
  self.heroL = (UINLtrHeroItem.New)()
  ;
  (self.heroL):Init((self.ui).subHeroItem)
  self.heroR = (UINLtrHeroItem.New)()
  ;
  (self.heroR):Init((self.ui).mainHeroItem)
  self.poolDetailNode = (UINLtrPoolDetail.New)()
  ;
  (self.poolDetailNode):Init((self.ui).showGachaRateNode)
  ;
  (self.poolDetailNode):Hide()
end

UILottery.InitUILottery = function(self, ltrCtrl, poolIdList, poolIndex)
  -- function num : 0_1 , upvalues : _ENV
  self.ltrCtrl = ltrCtrl
  self.poolIdList = poolIdList
  self.poolItemDic = {}
  ;
  (self.ltrPoolItemPool):HideAll()
  for k,poolId in ipairs(self.poolIdList) do
    local poolItem = (self.ltrPoolItemPool):GetOne()
    local poolCfg = (ConfigData.gashapon_para)[poolId]
    poolItem:InitLtrPoolItem(k, poolCfg, self.resLoader, self.__onSelectLtrPoolItem)
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (self.poolItemDic)[poolId] = poolItem
  end
  self:SelectLtrUIPool(poolIndex)
end

UILottery.RefreshLtrPoolUI = function(self, poolIdList, poolIndex)
  -- function num : 0_2 , upvalues : _ENV
  local curIdDic = {}
  for k,poolId in ipairs(poolIdList) do
    curIdDic[poolId] = true
    local poolItem = (self.poolItemDic)[poolId]
    if poolItem == nil then
      poolItem = (self.ltrPoolItemPool):GetOne()
      local poolCfg = (ConfigData.gashapon_para)[poolId]
      poolItem:InitLtrPoolItem(k, poolCfg, self.resLoader, self.__onSelectLtrPoolItem)
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (self.poolItemDic)[poolId] = poolItem
    end
    do
      do
        ;
        (poolItem.transform):SetAsLastSibling()
        -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  for poolId,poolItem in pairs(self.poolItemDic) do
    if curIdDic[poolId] == nil then
      (self.ltrPoolItemPool):HideOne(poolItem)
    end
  end
  self:SelectLtrUIPool(poolIndex)
end

UILottery.SelectLtrUIPool = function(self, poolIndex)
  -- function num : 0_3
  local poolId = (self.poolIdList)[poolIndex]
  local poolItem = (self.poolItemDic)[poolId]
  self:SelectLtrPoolItem(poolItem)
end

UILottery.SelectLtrPoolItem = function(self, poolItem)
  -- function num : 0_4 , upvalues : _ENV
  AudioManager:PlayAudioById(1041)
  ;
  ((self.ui).img_Select):SetParent(poolItem.transform)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_Select).anchoredPosition = Vector2.zero
  if self.poolItem ~= poolItem then
    ((self.ui).ani_Pic):DORestart()
    self.poolItem = poolItem
  end
  local changedPool = false
  if self.curPoolCfg ~= poolItem.poolCfg then
    changedPool = true
  end
  self.curPoolCfg = poolItem.poolCfg
  local poolId = (self.curPoolCfg).gashapon_id
  ;
  (self.ltrCtrl):SelectLtrPool(poolId)
  self.poolIndex = poolItem.index
  self:RefreshCurLtrUI(changedPool)
end

UILottery.RefreshCurLtrUI = function(self, changedPool)
  -- function num : 0_5 , upvalues : cs_ResLoader, cs_MovieManager_ins, _ENV, CheckerTypeId
  (((self.ui).btn_LeftArrow).gameObject):SetActive(self.poolIndex ~= 1)
  ;
  (((self.ui).btn_RightArrow).gameObject):SetActive(self.poolIndex ~= #self.poolIdList)
  ;
  (self.resourceGroup):SetResourceIds({(self.curPoolCfg).costId1})
  if changedPool and self.tempResLoader ~= nil then
    (self.tempResLoader):Put2Pool()
    self.tempResLoader = nil
  end
  if self.tempResLoader == nil then
    self.tempResLoader = (cs_ResLoader.Create)()
  end
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_Pic).enabled = false
  if (self.curPoolCfg).bg_type == 1 then
    if self.moviePlayer ~= nil then
      (self.moviePlayer):StopVideo()
      cs_MovieManager_ins:ReturnMoviePlayer(self.moviePlayer)
      self.moviePlayer = nil
    end
    local path = PathConsts:GetLotteryPicPath("MainPicture/" .. (self.curPoolCfg).bg_path)
    ;
    (self.tempResLoader):LoadABAssetAsync(path, function(texture)
    -- function num : 0_5_0 , upvalues : self
    if texture == nil then
      return 
    end
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Pic).texture = texture
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Pic).enabled = true
  end
)
  elseif (self.curPoolCfg).bg_type == 2 then
    if self.moviePlayer == nil then
      self.moviePlayer = cs_MovieManager_ins:GetMoviePlayer()
    end
    ;
    (self.moviePlayer):SetVideoRender((self.ui).img_Video)
    local path = "Lottery/" .. (self.curPoolCfg).bg_path
    ;
    (self.moviePlayer):PlayVideo(path, nil, 1, true)
  else
    error("gashapon_para.bg_type error : " .. tostring((self.curPoolCfg).bg_type))
  end
  -- DECOMPILER ERROR at PC113: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_SubImage).enabled = false
  do
    if not (string.IsNullOrEmpty)((self.curPoolCfg).bg1_path) then
      local path = PathConsts:GetLotteryPicPath("SubPicture/" .. (self.curPoolCfg).bg1_path)
      ;
      (self.tempResLoader):LoadABAssetAsync(path, function(texture)
    -- function num : 0_5_1 , upvalues : self
    if texture == nil then
      return 
    end
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_SubImage).texture = texture
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_SubImage).enabled = true
  end
)
    end
    -- DECOMPILER ERROR at PC135: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_Tile).enabled = false
    local introPath = PathConsts:GetLotteryPicPath("Tile/" .. (self.curPoolCfg).intro_path)
    ;
    (self.tempResLoader):LoadABAssetAsync(introPath, function(texture)
    -- function num : 0_5_2 , upvalues : self
    if texture == nil then
      return 
    end
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Tile).texture = texture
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Tile).enabled = true
  end
)
    if (self.curPoolCfg).up_reward1 == 0 then
      (self.heroL):Hide()
    else
      (self.heroL):Show()
      ;
      (self.heroL):InitLtrHeroItem((self.curPoolCfg).up_reward1, self.tempResLoader, (self.curPoolCfg).up_hero1_para)
    end
    if (self.curPoolCfg).up_reward2 == 0 then
      (self.heroR):Hide()
    else
      (self.heroR):Show()
      ;
      (self.heroR):InitLtrHeroItem((self.curPoolCfg).up_reward2, self.tempResLoader, (self.curPoolCfg).up_hero2_para)
    end
    -- DECOMPILER ERROR at PC192: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_PayOnce).text = tostring((self.curPoolCfg).costNum1)
    -- DECOMPILER ERROR at PC199: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_PayTen).text = tostring((self.curPoolCfg).costNum2)
    -- DECOMPILER ERROR at PC211: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_PayIcon_Once).sprite = CRH:GetSprite(((ConfigData.item)[(self.curPoolCfg).costId1]).small_icon)
    -- DECOMPILER ERROR at PC223: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_PayIcon_Ten).sprite = CRH:GetSprite(((ConfigData.item)[(self.curPoolCfg).costId2]).small_icon)
    local startTime, endTime = nil, nil
    for k,v in ipairs((self.curPoolCfg).pre_condition) do
      if v == CheckerTypeId.TimeRange then
        startTime = ((self.curPoolCfg).pre_para1)[k]
        endTime = ((self.curPoolCfg).pre_para2)[k]
        break
      end
    end
    -- DECOMPILER ERROR at PC246: Confused about usage of register: R5 in 'UnsetPending'

    if startTime == -1 then
      ((self.ui).tex_StarTime).text = nil
    else
      -- DECOMPILER ERROR at PC255: Confused about usage of register: R5 in 'UnsetPending'

      ((self.ui).tex_StarTime).text = (os.date)("%m/%d %H:%M", startTime)
    end
    -- DECOMPILER ERROR at PC260: Confused about usage of register: R5 in 'UnsetPending'

    if endTime == -1 then
      ((self.ui).tex_EndTime).text = nil
    else
      -- DECOMPILER ERROR at PC269: Confused about usage of register: R5 in 'UnsetPending'

      ((self.ui).tex_EndTime).text = (os.date)("%m/%d %H:%M", endTime)
    end
    ;
    ((self.ui).time):SetActive(startTime ~= nil and endTime ~= nil)
    -- DECOMPILER ERROR: 22 unprocessed JMP targets
  end
end

UILottery.__OnEndDrag = function(self)
  -- function num : 0_6 , upvalues : _ENV
  ((self.ui).infoScroll):StopMovement()
  local hPos = ((self.ui).infoScroll).horizontalNormalizedPosition
  if hPos <= 0 or hPos >= 1 then
    return 
  end
  local paddingLeft = (((self.ui).scrollLayoutGroup).padding).left
  local curPosX = ((((self.ui).infoScroll).content).localPosition).x + paddingLeft
  local count = (math.floor)((math.abs)(curPosX) / self.poolItemWidth)
  local tarPos = -count * self.poolItemWidth
  if count * self.poolItemWidth + self.poolItemWidth / 2 < (math.abs)(curPosX) then
    tarPos = -(count + 1) * self.poolItemWidth
  end
  if count > 0 then
    tarPos = tarPos + ((self.ui).scrollLayoutGroup).spacing
  end
  self:__ClearScrollTween()
  self.__scrollTween = (((self.ui).infoScroll).content):DOLocalMoveX(tarPos, 0.2)
end

UILottery.__ClearScrollTween = function(self)
  -- function num : 0_7
  if self.__scrollTween ~= nil then
    (self.__scrollTween):Kill()
    self.__scrollTween = nil
  end
end

UILottery.__OnClickDrawOne = function(self)
  -- function num : 0_8
  (self.ltrCtrl):LtrDrawOne()
end

UILottery.__OnClickDrawTen = function(self)
  -- function num : 0_9
  (self.ltrCtrl):LtrDrawTen()
end

UILottery.__OnClickPoolDetail = function(self)
  -- function num : 0_10 , upvalues : LotteryEnum
  if (self.ltrCtrl):CheckLtrPoolExpired() then
    return 
  end
  ;
  (self.ltrCtrl):ChangeLotteryState((LotteryEnum.eLotteryState).PoolDetail)
  ;
  (self.poolDetailNode):InitLtrPoolDetail(self.curPoolCfg, function()
    -- function num : 0_10_0 , upvalues : self, LotteryEnum
    (self.ltrCtrl):ChangeLotteryState((LotteryEnum.eLotteryState).Normal)
  end
)
end

UILottery.__OnClickBg = function(self)
  -- function num : 0_11
  (self.ltrCtrl):CheckLtrPoolExpired()
end

UILottery.__OnClickLeftArrow = function(self)
  -- function num : 0_12
  self:__ChangePoolIndex(false)
end

UILottery.__OnClickRightArrow = function(self)
  -- function num : 0_13
  self:__ChangePoolIndex(true)
end

UILottery.__ChangePoolIndex = function(self, isAdd)
  -- function num : 0_14 , upvalues : _ENV
  local index = self.poolIndex
  if isAdd then
    index = index + 1
  else
    index = index - 1
  end
  index = (math.clamp)(index, 1, #self.poolIdList)
  if index == self.poolIndex then
    return 
  end
  self:SelectLtrUIPool(index)
  local curPosX = ((((self.ui).infoScroll).content).localPosition).x + (((self.ui).scrollLayoutGroup).padding).left
  local count = (math.floor)((math.abs)(curPosX) / self.poolItemWidth)
  if count * self.poolItemWidth + self.poolItemWidth / 2 < (math.abs)(curPosX) then
    count = count + 1
  end
  local curIndex = index - 1
  if curIndex < count then
    count = curIndex
  else
    if count + 2 < curIndex then
      count = curIndex - 2
    else
      return 
    end
  end
  local tarPos = -(count) * self.poolItemWidth
  if count > 0 then
    tarPos = tarPos + ((self.ui).scrollLayoutGroup).spacing
  end
  self:__ClearScrollTween()
  self.__scrollTween = (((self.ui).infoScroll).content):DOLocalMoveX(tarPos, 0.2)
end

UILottery.__OnClickClose = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeWin ~= nil then
    homeWin:BackFromOtherWin()
  end
  ControllerManager:DeleteController(ControllerTypeId.Lottery)
end

UILottery.OnHide = function(self)
  -- function num : 0_16 , upvalues : base
  (base.OnHide)(self)
end

UILottery.OnDelete = function(self)
  -- function num : 0_17 , upvalues : cs_MovieManager_ins, base
  ((self.ui).ani_Pic):DOKill()
  ;
  (self.resourceGroup):Delete()
  ;
  (self.ltrPoolItemPool):DeleteAll()
  if self.tempResLoader ~= nil then
    (self.tempResLoader):Put2Pool()
    self.tempResLoader = nil
  end
  if self.moviePlayer ~= nil then
    cs_MovieManager_ins:ReturnMoviePlayer(self.moviePlayer)
    self.moviePlayer = nil
  end
  self:__ClearScrollTween()
  ;
  (self.resLoader):Put2Pool()
  self.resLoader = nil
  ;
  (self.poolDetailNode):Delete()
  ;
  (base.OnDelete)(self)
end

return UILottery

-- params : ...
-- function num : 0 , upvalues : _ENV
local UILottery = class("UILottery", UIBaseWindow)
local base = UIBaseWindow
local LotteryEnum = require("Game.Lottery.LotteryEnum")
local UINLtrPoolItem = require("Game.Lottery.UI.UINLtrPoolItem")
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UINLtrHeroItem = require("Game.Lottery.UI.UINLtrHeroItem")
local UINLtrPoolDetail = require("Game.Lottery.UI.PoolDetail.UINLtrPoolDetail")
local CheckerTypeId, CheckerGlobalConfig =
    (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local cs_ResLoader = CS.ResLoader
local cs_MovieManager_ins = (CS.MovieManager).Instance
local cs_EventTriggerListener = CS.EventTriggerListener
UILottery.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, cs_EventTriggerListener, UINResourceGroup, cs_ResLoader, UINLtrPoolItem, UINLtrHeroItem, UINLtrPoolDetail
    (UIUtil.CreateTopBtnGroup)((self.ui).topButtonGroup, self,
                               self.__OnClickClose)
    self.__onSelectLtrPoolItem = BindCallback(self, self.SelectLtrPoolItem);
    (UIUtil.AddButtonListener)((self.ui).btn_Once, self, self.__OnClickDrawOne);
    (UIUtil.AddButtonListener)((self.ui).btn_Ten, self, self.__OnClickDrawTen);
    (UIUtil.AddButtonListener)((self.ui).btn_PoolDetail, self,
                               self.__OnClickPoolDetail);
    (UIUtil.AddButtonListener)((self.ui).btn_bg, self, self.__OnClickBg);
    (UIUtil.AddButtonListener)((self.ui).btn_LeftArrow, self,
                               self.__OnClickLeftArrow);
    (UIUtil.AddButtonListener)((self.ui).btn_RightArrow, self,
                               self.__OnClickRightArrow)
    local eventTrigger = (cs_EventTriggerListener.Get)(
                             ((self.ui).infoScroll).gameObject)
    eventTrigger:onEndDrag("+", BindCallback(self, self.__OnEndDrag))
    self.resourceGroup = (UINResourceGroup.New)();
    (self.resourceGroup):Init((self.ui).gameResourceGroup)
    self.resLoader = (cs_ResLoader.Create)();
    ((self.ui).infoItem):SetActive(false)
    self.ltrPoolItemPool = (UIItemPool.New)(UINLtrPoolItem, (self.ui).infoItem)
    self.poolItemWidth = ((((self.ui).infoItem).transform).sizeDelta).x +
                             ((self.ui).scrollLayoutGroup).spacing
    self.heroL = (UINLtrHeroItem.New)();
    (self.heroL):Init((self.ui).subHeroItem)
    self.heroR = (UINLtrHeroItem.New)();
    (self.heroR):Init((self.ui).mainHeroItem)
    self.poolDetailNode = (UINLtrPoolDetail.New)();
    (self.poolDetailNode):Init((self.ui).showGachaRateNode);
    (self.poolDetailNode):Hide()
end

UILottery.InitUILottery = function(self, ltrCtrl, poolIdList, poolIndex)
    -- function num : 0_1 , upvalues : _ENV
    self.ltrCtrl = ltrCtrl
    self.poolIdList = poolIdList
    self.poolItemDic = {};
    (self.ltrPoolItemPool):HideAll()
    for k, poolId in ipairs(self.poolIdList) do
        local poolItem = (self.ltrPoolItemPool):GetOne()
        local poolCfg = (ConfigData.gashapon_para)[poolId]
        poolItem:InitLtrPoolItem(k, poolCfg, self.resLoader,
                                 self.__onSelectLtrPoolItem) -- DECOMPILER ERROR at PC24: Confused about usage of register: R11 in 'UnsetPending'
        ;
        (self.poolItemDic)[poolId] = poolItem
    end
    self:SelectLtrUIPool(poolIndex)
end

UILottery.RefreshLtrPoolUI = function(self, poolIdList, poolIndex)
    -- function num : 0_2 , upvalues : _ENV
    local curIdDic = {}
    for k, poolId in ipairs(poolIdList) do
        curIdDic[poolId] = true
        local poolItem = (self.poolItemDic)[poolId]
        if poolItem == nil then
            poolItem = (self.ltrPoolItemPool):GetOne()
            local poolCfg = (ConfigData.gashapon_para)[poolId]
            poolItem:InitLtrPoolItem(k, poolCfg, self.resLoader,
                                     self.__onSelectLtrPoolItem) -- DECOMPILER ERROR at PC24: Confused about usage of register: R11 in 'UnsetPending'
            ;
            (self.poolItemDic)[poolId] = poolItem
        end
        do
            do

                (poolItem.transform):SetAsLastSibling()
                -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out DO_STMT

            end
        end
    end
    for poolId, poolItem in pairs(self.poolItemDic) do
        if curIdDic[poolId] == nil then
            (self.ltrPoolItemPool):HideOne(poolItem)
        end
    end
    self:SelectLtrUIPool(poolIndex)
end

UILottery.SelectLtrUIPool = function(self, poolIndex)
    -- function num : 0_3
    local poolId = (self.poolIdList)[poolIndex]
    local poolItem = (self.poolItemDic)[poolId]
    self:SelectLtrPoolItem(poolItem)
end

UILottery.SelectLtrPoolItem = function(self, poolItem)
    -- function num : 0_4 , upvalues : _ENV
    AudioManager:PlayAudioById(1041);
    ((self.ui).img_Select):SetParent(poolItem.transform) -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).img_Select).anchoredPosition = Vector2.zero
    if self.poolItem ~= poolItem then
        ((self.ui).ani_Pic):DORestart()
        self.poolItem = poolItem
    end
    local changedPool = false
    if self.curPoolCfg ~= poolItem.poolCfg then changedPool = true end
    self.curPoolCfg = poolItem.poolCfg
    local poolId = (self.curPoolCfg).gashapon_id;
    (self.ltrCtrl):SelectLtrPool(poolId)
    self.poolIndex = poolItem.index
    self:RefreshCurLtrUI(changedPool)
end

UILottery.RefreshCurLtrUI = function(self, changedPool)
    -- function num : 0_5 , upvalues : cs_ResLoader, cs_MovieManager_ins, _ENV, CheckerTypeId
    (((self.ui).btn_LeftArrow).gameObject):SetActive(self.poolIndex ~= 1);
    (((self.ui).btn_RightArrow).gameObject):SetActive(
        self.poolIndex ~= #self.poolIdList);
    (self.resourceGroup):SetResourceIds({(self.curPoolCfg).costId1})
    if changedPool and self.tempResLoader ~= nil then
        (self.tempResLoader):Put2Pool()
        self.tempResLoader = nil
    end
    if self.tempResLoader == nil then
        self.tempResLoader = (cs_ResLoader.Create)()
    end -- DECOMPILER ERROR at PC46: Confused about usage of register: R2 in 'UnsetPending'
    
    ((self.ui).img_Pic).enabled = false
    if (self.curPoolCfg).bg_type == 1 then
        if self.moviePlayer ~= nil then
            (self.moviePlayer):StopVideo()
            cs_MovieManager_ins:ReturnMoviePlayer(self.moviePlayer)
            self.moviePlayer = nil
        end
        local path = PathConsts:GetLotteryPicPath(
                         "MainPicture/" .. (self.curPoolCfg).bg_path);
        (self.tempResLoader):LoadABAssetAsync(path, function(texture)
            -- function num : 0_5_0 , upvalues : self
            if texture == nil then return end -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'
            
            ((self.ui).img_Pic).texture = texture -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'
            ;
            ((self.ui).img_Pic).enabled = true
        end)
    elseif (self.curPoolCfg).bg_type == 2 then
        if self.moviePlayer == nil then
            self.moviePlayer = cs_MovieManager_ins:GetMoviePlayer()
        end
        (self.moviePlayer):SetVideoRender((self.ui).img_Video)
        local path = "Lottery/" .. (self.curPoolCfg).bg_path;
        (self.moviePlayer):PlayVideo(path, nil, 1, true)
    else
        error("gashapon_para.bg_type error : " ..
                  tostring((self.curPoolCfg).bg_type))
    end -- DECOMPILER ERROR at PC113: Confused about usage of register: R2 in 'UnsetPending'
    
    ((self.ui).img_SubImage).enabled = false
    do
        if not (string.IsNullOrEmpty)((self.curPoolCfg).bg1_path) then
            local path = PathConsts:GetLotteryPicPath(
                             "SubPicture/" .. (self.curPoolCfg).bg1_path);
            (self.tempResLoader):LoadABAssetAsync(path, function(texture)
                -- function num : 0_5_1 , upvalues : self
                if texture == nil then return end -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'
                
                ((self.ui).img_SubImage).texture = texture -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'
                ;
                ((self.ui).img_SubImage).enabled = true
            end)
        end -- DECOMPILER ERROR at PC135: Confused about usage of register: R2 in 'UnsetPending'
        
        ((self.ui).img_Tile).enabled = false
        local introPath = PathConsts:GetLotteryPicPath(
                              "Tile/" .. (self.curPoolCfg).intro_path);
        (self.tempResLoader):LoadABAssetAsync(introPath, function(texture)
            -- function num : 0_5_2 , upvalues : self
            if texture == nil then return end -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'
            
            ((self.ui).img_Tile).texture = texture -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'
            ;
            ((self.ui).img_Tile).enabled = true
        end)
        if (self.curPoolCfg).up_reward1 == 0 then
            (self.heroL):Hide()
        else
            (self.heroL):Show();
            (self.heroL):InitLtrHeroItem((self.curPoolCfg).up_reward1,
                                         self.tempResLoader,
                                         (self.curPoolCfg).up_hero1_para)
        end
        if (self.curPoolCfg).up_reward2 == 0 then
            (self.heroR):Hide()
        else
            (self.heroR):Show();
            (self.heroR):InitLtrHeroItem((self.curPoolCfg).up_reward2,
                                         self.tempResLoader,
                                         (self.curPoolCfg).up_hero2_para)
        end -- DECOMPILER ERROR at PC192: Confused about usage of register: R3 in 'UnsetPending'
        
        ((self.ui).tex_PayOnce).text = tostring((self.curPoolCfg).costNum1) -- DECOMPILER ERROR at PC199: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).tex_PayTen).text = tostring((self.curPoolCfg).costNum2) -- DECOMPILER ERROR at PC211: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).img_PayIcon_Once).sprite =
            CRH:GetSprite(
                ((ConfigData.item)[(self.curPoolCfg).costId1]).small_icon) -- DECOMPILER ERROR at PC223: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).img_PayIcon_Ten).sprite =
            CRH:GetSprite(
                ((ConfigData.item)[(self.curPoolCfg).costId2]).small_icon)
        local startTime, endTime = nil, nil
        for k, v in ipairs((self.curPoolCfg).pre_condition) do
            if v == CheckerTypeId.TimeRange then
                startTime = ((self.curPoolCfg).pre_para1)[k]
                endTime = ((self.curPoolCfg).pre_para2)[k]
                break
            end
        end
        -- DECOMPILER ERROR at PC246: Confused about usage of register: R5 in 'UnsetPending'

        if startTime == -1 then
            ((self.ui).tex_StarTime).text = nil
        else
            -- DECOMPILER ERROR at PC255: Confused about usage of register: R5 in 'UnsetPending'

            ((self.ui).tex_StarTime).text = (os.date)("%m/%d %H:%M", startTime)
        end
        -- DECOMPILER ERROR at PC260: Confused about usage of register: R5 in 'UnsetPending'

        if endTime == -1 then
            ((self.ui).tex_EndTime).text = nil
        else
            -- DECOMPILER ERROR at PC269: Confused about usage of register: R5 in 'UnsetPending'

            ((self.ui).tex_EndTime).text = (os.date)("%m/%d %H:%M", endTime)
        end
        ((self.ui).time):SetActive(startTime ~= nil and endTime ~= nil)
        -- DECOMPILER ERROR: 22 unprocessed JMP targets
    end
end

UILottery.__OnEndDrag = function(self)
    -- function num : 0_6 , upvalues : _ENV
    ((self.ui).infoScroll):StopMovement()
    local hPos = ((self.ui).infoScroll).horizontalNormalizedPosition
    if hPos <= 0 or hPos >= 1 then return end
    local paddingLeft = (((self.ui).scrollLayoutGroup).padding).left
    local curPosX = ((((self.ui).infoScroll).content).localPosition).x +
                        paddingLeft
    local count = (math.floor)((math.abs)(curPosX) / self.poolItemWidth)
    local tarPos = -count * self.poolItemWidth
    if count * self.poolItemWidth + self.poolItemWidth / 2 < (math.abs)(curPosX) then
        tarPos = -(count + 1) * self.poolItemWidth
    end
    if count > 0 then tarPos = tarPos + ((self.ui).scrollLayoutGroup).spacing end
    self:__ClearScrollTween()
    self.__scrollTween = (((self.ui).infoScroll).content):DOLocalMoveX(tarPos,
                                                                       0.2)
end

UILottery.__ClearScrollTween = function(self)
    -- function num : 0_7
    if self.__scrollTween ~= nil then
        (self.__scrollTween):Kill()
        self.__scrollTween = nil
    end
end

UILottery.__OnClickDrawOne = function(self)
    -- function num : 0_8
    (self.ltrCtrl):LtrDrawOne()
end

UILottery.__OnClickDrawTen = function(self)
    -- function num : 0_9
    (self.ltrCtrl):LtrDrawTen()
end

UILottery.__OnClickPoolDetail = function(self)
    -- function num : 0_10 , upvalues : LotteryEnum
    if (self.ltrCtrl):CheckLtrPoolExpired() then return end
    (self.ltrCtrl):ChangeLotteryState((LotteryEnum.eLotteryState).PoolDetail);
    (self.poolDetailNode):InitLtrPoolDetail(self.curPoolCfg, function()
        -- function num : 0_10_0 , upvalues : self, LotteryEnum
        (self.ltrCtrl):ChangeLotteryState((LotteryEnum.eLotteryState).Normal)
    end)
end

UILottery.__OnClickBg = function(self)
    -- function num : 0_11
    (self.ltrCtrl):CheckLtrPoolExpired()
end

UILottery.__OnClickLeftArrow = function(self)
    -- function num : 0_12
    self:__ChangePoolIndex(false)
end

UILottery.__OnClickRightArrow = function(self)
    -- function num : 0_13
    self:__ChangePoolIndex(true)
end

UILottery.__ChangePoolIndex = function(self, isAdd)
    -- function num : 0_14 , upvalues : _ENV
    local index = self.poolIndex
    if isAdd then
        index = index + 1
    else
        index = index - 1
    end
    index = (math.clamp)(index, 1, #self.poolIdList)
    if index == self.poolIndex then return end
    self:SelectLtrUIPool(index)
    local curPosX = ((((self.ui).infoScroll).content).localPosition).x +
                        (((self.ui).scrollLayoutGroup).padding).left
    local count = (math.floor)((math.abs)(curPosX) / self.poolItemWidth)
    if count * self.poolItemWidth + self.poolItemWidth / 2 < (math.abs)(curPosX) then
        count = count + 1
    end
    local curIndex = index - 1
    if curIndex < count then
        count = curIndex
    else
        if count + 2 < curIndex then
            count = curIndex - 2
        else
            return
        end
    end
    local tarPos = -(count) * self.poolItemWidth
    if count > 0 then tarPos = tarPos + ((self.ui).scrollLayoutGroup).spacing end
    self:__ClearScrollTween()
    self.__scrollTween = (((self.ui).infoScroll).content):DOLocalMoveX(tarPos,
                                                                       0.2)
end

UILottery.__OnClickClose = function(self)
    -- function num : 0_15 , upvalues : _ENV
    local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
    if homeWin ~= nil then homeWin:BackFromOtherWin() end
    ControllerManager:DeleteController(ControllerTypeId.Lottery)
end

UILottery.OnHide = function(self)
    -- function num : 0_16 , upvalues : base
    (base.OnHide)(self)
end

UILottery.OnDelete = function(self)
    -- function num : 0_17 , upvalues : cs_MovieManager_ins, base
    ((self.ui).ani_Pic):DOKill();
    (self.resourceGroup):Delete();
    (self.ltrPoolItemPool):DeleteAll()
    if self.tempResLoader ~= nil then
        (self.tempResLoader):Put2Pool()
        self.tempResLoader = nil
    end
    if self.moviePlayer ~= nil then
        cs_MovieManager_ins:ReturnMoviePlayer(self.moviePlayer)
        self.moviePlayer = nil
    end
    self:__ClearScrollTween();
    (self.resLoader):Put2Pool()
    self.resLoader = nil;
    (self.poolDetailNode):Delete();
    (base.OnDelete)(self)
end

return UILottery


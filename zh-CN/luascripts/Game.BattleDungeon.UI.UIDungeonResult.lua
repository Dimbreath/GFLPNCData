-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDungeonResult = class("UIDungeonResult", UIBaseWindow)
local base = UIBaseWindow
local ItemData = require("Game.PlayerData.Item.ItemData")
local UIRewardItem = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UICharacterItem = require("Game.BattleResult.UIBattleResultCharacterItem")
local UIBattleSkadaPage = require("Game.BattleResult.Skada.UIBattleSkadaPage")
local cs_ResLoader = CS.ResLoader
local cs_BattleStatistics = (CS.BattleStatistics).Instance
local cs_GameObject = (CS.UnityEngine).GameObject
local cs_DOTween = ((CS.DG).Tweening).DOTween
local cs_MessageCommon = CS.MessageCommon
UIDungeonResult.OnInit = function(self)
  -- function num : 0_0 , upvalues : cs_ResLoader, _ENV, UIRewardItem, UICharacterItem
  self.resloader = (cs_ResLoader.Create)()
  self.rewardItemPool = (UIItemPool.New)(UIRewardItem, (self.ui).obj_rewardItem)
  self.heroHeadItemPool = (UIItemPool.New)(UICharacterItem, (self.ui).obj_heroHeadItem)
  ;
  (((self.ui).tex_levelName).gameObject):SetActive(false)
  ;
  (((self.ui).btn_skada).gameObject):SetActive(false)
  ;
  ((self.ui).obj_rewardItem):SetActive(false)
  ;
  ((self.ui).obj_heroHeadItem):SetActive(false)
  ;
  ((self.ui).obj_userSkillNode):SetActive(false)
  ;
  ((self.ui).obj_globalExpNode):SetActive(false)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_continue, self, self.__OnBtnContinueClick)
  self.__updateHandle = BindCallback(self, self.Update)
  UpdateManager:AddUpdate(self.__updateHandle)
  self.__playAnim = BindCallback(self, self.StartExpAnimation)
  MsgCenter:AddListener(eMsgEventId.OnShowBattleResultComplete, self.__playAnim)
  self:__ToFackCameraCanvas()
end

UIDungeonResult.__ToFackCameraCanvas = function(self)
  -- function num : 0_1 , upvalues : cs_GameObject, _ENV
  local fakeCameraBattle = ((cs_GameObject.Find)("FakeCameraBattle")):FindComponent(eUnityComponentID.Camera)
  self:AlignToFakeCamera(fakeCameraBattle)
end

UIDungeonResult.CompleteDungeon = function(self, rewardMsg, resultData, mvpGrade, dungeonType, ATHRewardInfo, hasDailyDouble)
  -- function num : 0_2 , upvalues : _ENV
  self._auBack = AudioManager:PlayAudioById(3009, function()
    -- function num : 0_2_0 , upvalues : self
    self._auBack = nil
  end
)
  local rewardList = {}
  self.dungeonType = dungeonType
  self.ATHRewardInfo = ATHRewardInfo
  self.hasDailyDouble = hasDailyDouble
  do
    if rewardMsg ~= nil then
      local exp = rewardMsg.totalExp
      if rewardMsg.innerRewards ~= nil then
        self:_mergeReward(rewardList, rewardMsg.innerRewards)
      end
      if rewardMsg.overRewards ~= nil then
        self:_mergeReward(rewardList, rewardMsg.overRewards)
      end
      if rewardMsg.firstClear ~= nil then
        self:_mergeReward(rewardList, rewardMsg.firstClear)
      end
    end
    self:__InitBattleReward(rewardList)
    self:__InitCharacterExp(resultData.lastHeroList)
    self:__InitMvpHeroPic(resultData.playerRoleList, mvpGrade)
  end
end

UIDungeonResult._mergeReward = function(self, table, rewards)
  -- function num : 0_3 , upvalues : _ENV
  for key,value in pairs(rewards) do
    table[key] = (table[key] or 0) + value
  end
end

UIDungeonResult.__InitBattleReward = function(self, rewardDic)
  -- function num : 0_4 , upvalues : _ENV, cs_DOTween
  self.rewardDic = rewardDic
  local rewardList = {}
  local hasRandomAth = false
  for id,num in pairs(rewardDic) do
    do
      if (id >= 8000 and id < 8100) or ((ConfigData.item)[id]).type == eItemType.Arithmetic then
        hasRandomAth = true
      else
        local itemCfg = (ConfigData.item)[id]
        if itemCfg == nil then
          error("can\'t read itemCfg with id=" .. id)
        else
          do
            ;
            (table.insert)(rewardList, {id = id, count = num, itemCfg = itemCfg})
            -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  if hasRandomAth then
    if PlayerDataCenter.lastAthDiff ~= nil then
      for _,athData in ipairs(PlayerDataCenter.lastAthDiff) do
        (table.insert)(rewardList, {id = athData.id, count = 1, itemCfg = athData.itemCfg, isAth = true, athData = athData})
      end
    end
    do
      -- DECOMPILER ERROR at PC68: Confused about usage of register: R4 in 'UnsetPending'

      PlayerDataCenter.lastAthDiff = nil
      ;
      (table.sort)(rewardList, function(data1, data2)
    -- function num : 0_4_0
    local cfg1 = data1.itemCfg
    local cfg2 = data2.itemCfg
    if data1.id >= data2.id then
      do return cfg1.quality ~= cfg2.quality end
      do return cfg2.quality < cfg1.quality end
      do return false end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
      for k,v in ipairs(rewardList) do
        local rewardItem = (self.rewardItemPool):GetOne()
        if v.isAth then
          rewardItem:InitItemWithCount(v.itemCfg, v.count, function()
    -- function num : 0_4_1 , upvalues : _ENV, v
    UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
      -- function num : 0_4_1_0 , upvalues : v
      if win ~= nil then
        win:InitAthDetail(v.itemCfg, v.athData)
      end
    end
)
  end
)
        else
          rewardItem:InitItemWithCount(v.itemCfg, v.count)
        end
      end
      local rewardSequence = (cs_DOTween.Sequence)()
      for index,item in ipairs((self.rewardItemPool).listItem) do
        item:SetFade(0)
        rewardSequence:Append((item:GetFade()):DOFade(1, 0.2))
      end
      rewardSequence:SetDelay(0.5)
      rewardSequence:SetAutoKill(false)
      rewardSequence:Pause()
      if self.rewardSequence ~= nil then
        (self.rewardSequence):Kill()
      end
      self.rewardSequence = rewardSequence
      local hasReward = #rewardList > 0
      -- DECOMPILER ERROR at PC157: Confused about usage of register: R6 in 'UnsetPending'

      if not hasReward or not (Color.New)(1, 1, 1, 0.9) then
        ((self.ui).img_rewardBg).color = (Color.New)(0, 0, 0, 0.4)
        ;
        ((self.ui).obj_rewardText):SetActive(hasReward)
        local showDouble = false
        if (self.ATHRewardInfo).haveDouble <= 0 then
          showDouble = not self.dungeonType or self.dungeonType ~= 12 or not self.ATHRewardInfo
          if showDouble then
            ((self.ui).tex_DropCount):SetIndex(0, tostring((self.ATHRewardInfo).haveDouble - 1), tostring((self.ATHRewardInfo).double))
            ;
            ((self.ui).obj_DropCount):SetActive(showDouble)
          end
          showDouble = self.hasDailyDouble
          ;
          ((self.ui).obj_DropUPTips):SetActive(showDouble)
          -- DECOMPILER ERROR: 6 unprocessed JMP targets
        end
      end
    end
  end
end

UIDungeonResult.__InitCharacterExp = function(self, lastHeroList)
  -- function num : 0_5 , upvalues : _ENV
  local heroList = ((BattleDungeonManager.dungeonCtrl).dynPlayer).heroList
  local levelupRoleIdDic = {}
  local hasLevelup = false
  self.heroHeadDic = {}
  local heroItem = nil
  for k,dynHero in ipairs(heroList) do
    heroItem = (self.heroHeadDic)[k]
    if heroItem == nil then
      heroItem = (self.heroHeadItemPool):GetOne()
    end
    heroItem:InitCharacterItem(dynHero, self.resloader, nil)
    heroItem:RefershExpData(lastHeroList[k - 1])
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (self.heroHeadDic)[k] = heroItem
    local oldLevel = (lastHeroList[k - 1]).level
    if dynHero:GetLevel() < oldLevel then
      levelupRoleIdDic[dynHero.dataId] = true
      hasLevelup = true
    end
  end
end

UIDungeonResult.StartExpAnimation = function(self)
  -- function num : 0_6 , upvalues : _ENV, cs_MessageCommon
  self.__animationStart = true
  local containAth = false
  for id,num in pairs(self.rewardDic) do
    local itemCfg = (ConfigData.item)[id]
    if itemCfg ~= nil and itemCfg.type == eItemType.Arithmetic then
      containAth = true
      break
    end
  end
  do
    if containAth and (ConfigData.game_config).athMaxNum <= #(PlayerDataCenter.allAthData):GetAllAthList() then
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
    end
    if self.rewardSequence ~= nil then
      (self.rewardSequence):Restart()
    end
  end
end

UIDungeonResult.Update = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if not self.__animationStart then
    return 
  end
  for k,heroItem in pairs(self.heroHeadDic) do
    heroItem:UpdateExp()
  end
end

UIDungeonResult.__InitMvpHeroPic = function(self, playerRoleList, mvpGrade)
  -- function num : 0_8 , upvalues : _ENV
  local heroData = ((mvpGrade.role).character).heroData
  ;
  ((self.ui).tex_heroMvp):SetIndex(mvpGrade.MvpType)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_heroMvp).color = ((self.ui).color_MVP)[mvpGrade.MvpType + 1]
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_mvpName).text = tostring((LanguageUtil.GetLocaleText)((heroData.heroCfg).name))
  ;
  ((self.ui).tex_mvpDesc):SetIndex(mvpGrade.MvpType)
end

UIDungeonResult.SetContinueCallback = function(self, callback)
  -- function num : 0_9
  self.continueCallback = callback
end

UIDungeonResult.__OnBtnContinueClick = function(self)
  -- function num : 0_10
  if self.continueCallback ~= nil then
    (self.continueCallback)()
  end
  self:Delete()
end

UIDungeonResult.OnDelete = function(self)
  -- function num : 0_11 , upvalues : _ENV, base
  if self._auBack ~= nil then
    AudioManager:StopAudioByBack(self._auBack)
    self._auBack = nil
  end
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  if self.rewardSequence ~= nil then
    (self.rewardSequence):Kill()
    self.rewardSequence = nil
  end
  UpdateManager:RemoveUpdate(self.__updateHandle)
  MsgCenter:RemoveListener(eMsgEventId.OnShowBattleResultComplete, self.__playAnim)
  ;
  (base.OnDelete)(self)
end

return UIDungeonResult


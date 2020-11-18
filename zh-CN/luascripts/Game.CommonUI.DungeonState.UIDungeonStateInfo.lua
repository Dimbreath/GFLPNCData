-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDungeonStateInfo = class("UIDungeonStateInfo", UIBaseWindow)
local base = UIBaseWindow
local CS_ResLoader = CS.ResLoader
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local UINDungeonChipList = require("Game.CommonUI.DungeonState.UINDungeonChipList")
local UINDungeonHeroList = require("Game.CommonUI.DungeonState.UINDungeonHeroList")
local UINDungeonBuffList = require("Game.CommonUI.DungeonState.UINDungeonBuffList")
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local CS_DOTween = ((CS.DG).Tweening).DOTween
local ScrambleMode = ((CS.DG).Tweening).ScrambleMode
UIDungeonStateInfo.OnInit = function(self)
  -- function num : 0_0 , upvalues : CS_ResLoader, UINDungeonChipList, UINDungeonHeroList, UINDungeonBuffList, _ENV, UINChipItem
  self.resloader = (CS_ResLoader.Create)()
  self.chipList = (UINDungeonChipList.New)()
  ;
  (self.chipList):Init((self.ui).obj_ChipList)
  self.heroList = (UINDungeonHeroList.New)()
  ;
  (self.heroList):Init((self.ui).obj_heroInfo)
  self.buffList = (UINDungeonBuffList.New)()
  ;
  (self.buffList):Init((self.ui).obj_BuffList)
  self.getChipOriginScale = (((self.ui).getChipItem).transform).localScale
  ;
  ((self.ui).getChipItem):SetActive(false)
  self.getChipPool = (UIItemPool.New)(UINChipItem, (self.ui).getChipItem)
  self.getChipAniCache = {}
  self.__onMoneyChange = BindCallback(self, self.RefreshMoney)
  MsgCenter:AddListener(eMsgEventId.EpMoneyChange, self.__onMoneyChange)
  self.__DungeonHeroListActiveSet = BindCallback(self, self.DungeonHeroListActiveSet)
  MsgCenter:AddListener(eMsgEventId.DungeonHeroListActiveSet, self.__DungeonHeroListActiveSet)
end

UIDungeonStateInfo.InitHeroAndChip = function(self, dynPlayer)
  -- function num : 0_1
  (self.heroList):InitHeroList(dynPlayer.heroList, self.resloader, (self.chipList).selectHeroCallback, dynPlayer:GetEpBuffList())
  ;
  (self.chipList):InitChipList(dynPlayer:GetChipList(), (self.heroList).selectWithChipIdCallback, dynPlayer:GetChipLimitInfo())
  ;
  (self.buffList):InitBuffList(dynPlayer:GetEpBuffList())
  self:RefreshMoney(true)
end

UIDungeonStateInfo.DungeonHeroListActiveSet = function(self, active)
  -- function num : 0_2 , upvalues : _ENV
  do
    if active then
      local win = UIManager:GetWindow(UIWindowTypeID.EpChipDiscard)
      if win ~= nil and win.active then
        self:SetHeroListActive(false)
        return 
      end
    end
    self:SetHeroListActive(active)
  end
end

UIDungeonStateInfo.SetHeroListActive = function(self, isActive)
  -- function num : 0_3
  if isActive then
    (self.heroList):SetHpBarActive(true)
  end
  ;
  (self.heroList):SetDeployStation(not isActive)
end

UIDungeonStateInfo.SetHeroListHpBar = function(self, isActive)
  -- function num : 0_4
  (self.heroList):SetHpBarActive(isActive)
end

UIDungeonStateInfo.RefreshHeroListHp = function(self, isActive)
  -- function num : 0_5
  (self.heroList):RefreshHeroHp()
end

UIDungeonStateInfo.ShowHero = function(self, hero)
  -- function num : 0_6 , upvalues : _ENV
  if hero == nil then
    (self.heroList):Hide()
    return 
  end
  ;
  (self.heroList):Show()
  for index,value in ipairs(((self.heroList).itemPool).listItem) do
    if (value.dynHeroData).dataId == hero.dataId then
      (self.heroList):OnHeroClick((((self.heroList).itemPool).listItem)[index])
      break
    end
  end
end

UIDungeonStateInfo.SetMoneyActive = function(self, active)
  -- function num : 0_7
  ((self.ui).obj_money):SetActive(active)
end

UIDungeonStateInfo.RefreshMoney = function(self, isInit)
  -- function num : 0_8 , upvalues : _ENV, ScrambleMode
  local money = 0
  local dynplayer = nil
  if ExplorationManager ~= nil then
    dynplayer = ExplorationManager:GetDynPlayer()
    if dynplayer ~= nil then
      local theMoney = dynplayer:GetMoneyCount()
      if theMoney ~= nil then
        money = theMoney
      end
    end
  end
  do
    self.texMoneyTween = ((self.ui).tex_Money):DOText(tostring(money), 1, true, ScrambleMode.Numerals)
    if isInit ~= true and self.active then
      AudioManager:PlayAudioById(1007)
    end
    if self.LoadMoneyIcon == nil and dynplayer ~= nil then
      local icon = dynplayer:GetMoneyIconId()
      -- DECOMPILER ERROR at PC49: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).img_Money).sprite = CRH:GetSprite(icon)
      self.LoadMoneyIcon = true
    end
  end
end

UIDungeonStateInfo.Show = function(self)
  -- function num : 0_9 , upvalues : base, _ENV
  if self.active then
    return 
  end
  ;
  (base.Show)(self)
  ;
  (self.chipList):ReFillList()
  self:__ClearFadeTween()
  self.__fadeTween = UIManager:PlayDoFade((self.ui).canvasGroup, 0, 1, 0.5)
end

UIDungeonStateInfo.Hide = function(self, withTween)
  -- function num : 0_10 , upvalues : base, _ENV
  if not self.active then
    return 
  end
  ;
  (base.Hide)(self)
  local win = UIManager:GetWindow(UIWindowTypeID.DungeonInfoDetail)
  if win ~= nil then
    win:OnClickRetreat()
  end
  if withTween then
    self:__ClearFadeTween()
    self.__fadeTween = UIManager:PlayDoFade((self.ui).canvasGroup, 1, 0, 0.5)
  end
end

UIDungeonStateInfo.__ClearFadeTween = function(self)
  -- function num : 0_11
  if self.__fadeTween ~= nil then
    (self.__fadeTween):Kill()
    self.__fadeTween = nil
  end
end

UIDungeonStateInfo.OnHide = function(self)
  -- function num : 0_12
  self.__startGetChipAni = false
  if self.getChipTween ~= nil then
    (self.getChipTween):Kill()
    self.getChipTween = nil
  end
  self.getChipAniCache = {}
  ;
  (((self.ui).eff_GetItem).gameObject):SetActive(false)
  ;
  (self.getChipPool):HideAll()
  ;
  (self.chipList):SetListBlocksRaycasts(true)
  ;
  (self.chipList):SetChipGetEffectEnable(false)
end

UIDungeonStateInfo.ShowGetChipAni = function(self, chipData, position, scale)
  -- function num : 0_13 , upvalues : _ENV
  if not ((self.chipList).gameObject).activeInHierarchy then
    return 
  end
  ;
  (table.insert)(self.getChipAniCache, {chipData = chipData, position = position, scale = scale})
  if not self.__startGetChipAni then
    self:__StartShowGetChipAni()
  end
end

UIDungeonStateInfo.__StartShowGetChipAni = function(self)
  -- function num : 0_14 , upvalues : _ENV, CS_DOTween
  if #self.getChipAniCache == 0 then
    self.__startGetChipAni = false
    ;
    (self.chipList):SetListBlocksRaycasts(true)
    return 
  end
  ;
  (self.chipList):SetListBlocksRaycasts(false)
  self.__startGetChipAni = true
  local getChipData = (table.remove)(self.getChipAniCache, 1)
  local chipData, position, scale = getChipData.chipData, getChipData.position, getChipData.scale
  if not (self.chipList):ListContainChip(chipData.dataId) then
    self:__StartShowGetChipAni()
  end
  ;
  (self.chipList):ScrollChipItemInScreen(chipData, function(chipItem)
    -- function num : 0_14_0 , upvalues : self, chipData, position, scale, CS_DOTween, _ENV
    if chipItem ~= nil then
      (self.chipList):SetChipGetEffectEnable(true)
      local destPosition = (self.transform):InverseTransformPoint(chipItem:GetChipItemWorldPos())
      do
        local chipItem = (self.getChipPool):GetOne()
        chipItem:InitChipItem(chipData)
        chipItem:Show()
        -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (chipItem.transform).localPosition = position
        local curScale = scale or self.getChipOriginScale
        -- DECOMPILER ERROR at PC27: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (chipItem.transform).localScale = curScale
        ;
        (((self.ui).eff_GetItem).gameObject):SetActive(true)
        -- DECOMPILER ERROR at PC37: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (((self.ui).eff_GetItem).transform).localPosition = destPosition
        ;
        (((self.ui).eff_GetItem).material):SetFloat("_UI_Player", 0)
        local sequence = (CS_DOTween.Sequence)()
        sequence:Append((chipItem.transform):DOLocalMove(destPosition, (ConfigData.game_config).getChipMoveTime))
        sequence:Join((chipItem.transform):DOScale(self.getChipOriginScale, (ConfigData.game_config).getChipMoveTime))
        sequence:AppendCallback(function()
      -- function num : 0_14_0_0 , upvalues : self, chipItem
      (self.getChipPool):HideOne(chipItem)
    end
)
        sequence:Append((((self.ui).eff_GetItem).material):DOFloat(1, "_UI_Player", (ConfigData.game_config).getChipEffectTime))
        sequence:AppendCallback(function()
      -- function num : 0_14_0_1 , upvalues : self
      (self.chipList):SetChipGetEffectEnable(false)
      self.getChipTween = nil
      ;
      (((self.ui).eff_GetItem).gameObject):SetActive(false)
      self:__StartShowGetChipAni()
    end
)
        self.getChipTween = sequence
        AudioManager:PlayAudioById(1009)
      end
    else
      do
        self:__StartShowGetChipAni()
      end
    end
  end
)
end

UIDungeonStateInfo.ChipListWeakenTween = function(self, weaken)
  -- function num : 0_15
  if weaken then
    ((self.ui).topWeakenTween):DORestart()
  else
    ;
    ((self.ui).topWeakenTween):DOPlayBackwards()
  end
end

UIDungeonStateInfo.OnlyShowChipList = function(self, oblyShow)
  -- function num : 0_16
  if oblyShow then
    self:Show()
    self:DungeonHeroListActiveSet(false)
    self:SetHeroListHpBar(false)
    self:SetMoneyActive(false)
  else
    self:DungeonHeroListActiveSet(true)
    self:SetHeroListHpBar(true)
    self:SetMoneyActive(true)
  end
end

UIDungeonStateInfo.CheckChipListBgShow = function(self, check)
  -- function num : 0_17
  (self.chipList):CheckChipListBgShow(check)
end

UIDungeonStateInfo.OnDelete = function(self)
  -- function num : 0_18 , upvalues : _ENV, base
  self:__ClearFadeTween()
  if self.getChipTween ~= nil then
    (self.getChipTween):Kill()
    self.getChipTween = nil
  end
  if self.texMoneyTween ~= nil then
    (self.texMoneyTween):Kill()
    self.texMoneyTween = nil
  end
  ;
  (self.resloader):Put2Pool()
  self.resloader = nil
  ;
  (self.chipList):Delete()
  ;
  (self.heroList):Delete()
  ;
  (self.buffList):Delete()
  MsgCenter:RemoveListener(eMsgEventId.EpMoneyChange, self.__onMoneyChange)
  MsgCenter:RemoveListener(eMsgEventId.DungeonHeroListActiveSet, self.__DungeonHeroListActiveSet)
  ;
  (base.OnDelete)(self)
end

return UIDungeonStateInfo


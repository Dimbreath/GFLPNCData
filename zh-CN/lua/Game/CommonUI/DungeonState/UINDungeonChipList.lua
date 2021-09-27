local UINDungeonChipList = class("UINDungeonChipList", UIBaseNode)
local base = UIBaseNode
local UINDungeonChipItem = require("Game.CommonUI.DungeonState.UINDungeonChipItem")
local UINDungeonChipUseSkillEffect = require("Game.CommonUI.DungeonState.UINDungeonChipUseSkillEffect")
local CS_DOTween = ((CS.DG).Tweening).DOTween
UINDungeonChipList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINDungeonChipItem, UINDungeonChipUseSkillEffect
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ChipSuitSelect, self, self._OnClickSelectSuit)
  self.FakeLeftChipItem = (UINDungeonChipItem.New)()
  ;
  (self.FakeLeftChipItem):Init((self.ui).obj_epChipItemLeft)
  self.FakeRightChipItem = (UINDungeonChipItem.New)()
  ;
  (self.FakeRightChipItem):Init((self.ui).obj_epChipItemRight)
  self.chipUnitWidth = 126
  self.chipNum = 0
  self.maxNumInRect = 0
  self.itemDic = {}
  self.chipDataList = {}
  self.selectHeroWithChipIdCallback = nil
  self.chipUseSkillEffectPool = (UIItemPool.New)(UINDungeonChipUseSkillEffect, (self.ui).eff_UseChip)
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).chipList).onInstantiateItem = BindCallback(self, self.__InitItem)
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).chipList).onChangeItem = BindCallback(self, self.__OnItemChange)
  ;
  (((self.ui).chipList).onValueChanged):AddListener(BindCallback(self, self.__TestOnValueChange))
  self.__onChipListChange = BindCallback(self, self.OnChipListUpdata)
  MsgCenter:AddListener(eMsgEventId.OnEpChipListChange, self.__onChipListChange)
  self.__OnUseChipSkill = BindCallback(self, self.OnUseChipSkill)
  MsgCenter:AddListener(eMsgEventId.OnPlayChipEffect, self.__OnUseChipSkill)
  self.__RefreshLimit = BindCallback(self, self.RefreshLimit)
  MsgCenter:AddListener(eMsgEventId.OnChipLimitChange, self.__RefreshLimit)
  self.__DeselectAllItem = BindCallback(self, self.DeselectAllItem)
  self.__SelectItem = BindCallback(self, self.SelectItem)
  self.selectHeroCallback = BindCallback(self, self.OnSelectHero)
  self.__ChipItemClickFunc = BindCallback(self, self.ChipItemClickFunc)
  self.__HideUseChipSkillEffect = BindCallback(self, self.HideUseChipSkillEffect)
  ;
  (((self.ui).img_Adapter).gameObject):SetActive(false)
  self.__startCacheChipUpdate = false
  self.__cacheChipList = nil
  self:InitChipLimitSequence()
  ;
  (((self.ui).fX_UI_DungeonStateInfo1).gameObject):SetActive(false)
  ;
  ((self.ui).drawMask):SetActive(false)
  ;
  ((self.ui).lineStart):SetActive(false)
  self.fX_UI_DungeonStateInfo1Scale = ((((self.ui).fX_UI_DungeonStateInfo1).transform).localScale).x
end

UINDungeonChipList.InitChipList = function(self, chipList, selectHeroWithChipIdCallback, chipLimitInfo)
  -- function num : 0_1
  self.selectHeroWithChipIdCallback = selectHeroWithChipIdCallback
  self.chipLimitInfo = chipLimitInfo
  self:__ChipListUpdateInternal(chipList)
end

UINDungeonChipList.ShowDungeonChipListSuitSelectBtn = function(self, show)
  -- function num : 0_2
  (((self.ui).btn_ChipSuitSelect).gameObject):SetActive(show)
end

UINDungeonChipList.OnChipListUpdata = function(self, chipList)
  -- function num : 0_3
  if self.__startCacheChipUpdate then
    self.__cacheChipList = chipList
  else
    self:__ChipListUpdateInternal(chipList)
  end
  self:CheckChipListContainerShow()
end

UINDungeonChipList.__ChipListUpdateInternal = function(self, chipList)
  -- function num : 0_4 , upvalues : _ENV
  if #chipList < #self.chipDataList then
    self.chipDataList = {}
  end
  for index,value in ipairs(chipList) do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R7 in 'UnsetPending'

    (self.chipDataList)[index] = value
  end
  for _,chipData in pairs(chipList) do
    if chipData:IsShowTemp() and not chipData.showedTemp then
      chipData.showedTemp = true
      ;
      ((CS.MessageCommon).ShowMessageTips)((string.format)(ConfigData:GetTipContent(TipContent.CampFetter_AchieveTempChip), chipData:GetName()), true)
    end
  end
  self:RefreshLimit()
  self:ReFillList()
end

UINDungeonChipList.ReFillList = function(self)
  -- function num : 0_5
  self:__SortChips(self.chipDataList)
  self:__ReFillList()
end

UINDungeonChipList.__ReFillList = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local listWidth = (((self.ui).rect_chipList).rect).width
  self.maxNumInRect = (math.ceil)(listWidth / self.chipUnitWidth)
  self.chipNum = #self.chipDataList
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).chipList).totalCount = self.chipNum
  if self.maxNumInRect < self.chipNum then
    local realChipNum = 0
    for index,chipData in ipairs(self.chipDataList) do
      realChipNum = realChipNum + chipData:GetCount()
    end
  end
  do
    if self.maxNumInRect >= self.chipNum or not 1 then
      local index = not (BattleUtil.IsInDailyDungeon)() or 0
    end
    ;
    ((self.ui).img_ChipSuitSelect):SetIndex(index)
    local hasChip = self.chipNum > 0
    -- DECOMPILER ERROR at PC65: Confused about usage of register: R4 in 'UnsetPending'

    if not hasChip or not ((self.ui).img_ChipSuitSelect).image then
      do
        ((self.ui).btn_ChipSuitSelect).targetGraphic = (self.ui).img_NoChip
        ;
        (((self.ui).img_NoChip).gameObject):SetActive(not hasChip)
        ;
        ((self.ui).chipList):RefillCells()
        -- DECOMPILER ERROR: 4 unprocessed JMP targets
      end
    end
  end
end

UINDungeonChipList.InitChipLimitSequence = function(self)
  -- function num : 0_7 , upvalues : _ENV, CS_DOTween
  local obj_Limit_SizeDelta = (((self.ui).obj_Limit).transform).sizeDelta
  local obj_chipCountLimit_SizeDelta = (((self.ui).obj_chipCountLimit).transform).sizeDelta
  local small_Limit_SizeDelta = (Vector2.New)(0, obj_Limit_SizeDelta.y)
  local small_chipCountLimit_SizeDelta = (Vector2.New)(obj_chipCountLimit_SizeDelta.x - obj_Limit_SizeDelta.x, obj_chipCountLimit_SizeDelta.y)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((self.ui).obj_Limit).transform).sizeDelta = small_Limit_SizeDelta
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((self.ui).obj_chipCountLimit).transform).sizeDelta = small_chipCountLimit_SizeDelta
  self.chipLimitSequence = ((((((((CS_DOTween.Sequence)()):Append(((((self.ui).obj_Limit).transform):DOSizeDelta(obj_Limit_SizeDelta, 0.5)):SetDelay(0))):Join(((((self.ui).obj_chipCountLimit).transform):DOSizeDelta(obj_chipCountLimit_SizeDelta, 0.5)):SetDelay(0))):Append(((((self.ui).obj_Limit).transform):DOSizeDelta(small_Limit_SizeDelta, 0.5)):SetDelay(2.5))):Join((((self.ui).obj_chipCountLimit).transform):DOSizeDelta(small_chipCountLimit_SizeDelta, 0.5))):AppendCallback(function()
    -- function num : 0_7_0 , upvalues : self
    (self.chipLimitSequence):Rewind()
  end
)):Pause()):SetAutoKill(false)
end

UINDungeonChipList._InitChipSellSequence = function(self)
  -- function num : 0_8 , upvalues : _ENV, CS_DOTween
  local obj_Sell_SizeDelta = (((self.ui).obj_Sell).transform).sizeDelta
  local small_Sell_SizeDelta = (Vector2.New)(0, obj_Sell_SizeDelta.y)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.ui).obj_Sell).transform).sizeDelta = small_Sell_SizeDelta
  local obj_chipSell_SizeDelta = (((self.ui).obj_chipSell).transform).sizeDelta
  local small_chipSell_SizeDelta = (Vector2.New)(obj_chipSell_SizeDelta.x - obj_Sell_SizeDelta.x, obj_chipSell_SizeDelta.y)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((self.ui).obj_chipSell).transform).sizeDelta = small_chipSell_SizeDelta
  self.chipSellSequence = (((((((CS_DOTween.Sequence)()):Append(((((self.ui).obj_Sell).transform):DOSizeDelta(obj_Sell_SizeDelta, 0.5)):SetDelay(0))):Join(((((self.ui).obj_chipSell).transform):DOSizeDelta(obj_chipSell_SizeDelta, 0.5)):SetDelay(0))):Append(((((self.ui).obj_Sell).transform):DOSizeDelta(small_Sell_SizeDelta, 0.5)):SetDelay(2.5))):Join((((self.ui).obj_chipSell).transform):DOSizeDelta(small_chipSell_SizeDelta, 0.5))):Pause()):SetAutoKill(false)
end

UINDungeonChipList.RefreshLimit = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local num = (self.chipLimitInfo).count
  local limit = (self.chipLimitInfo).limit
  ;
  ((self.ui).texInfo_LimitChip):SetIndex(0, tostring(num), tostring(limit))
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  if num <= limit then
    (self.chipLimitInfo).firstLimit = true
    ;
    ((self.ui).obj_limitBackground):SetActive(false)
    ;
    ((self.ui).obj_Limit):SetActive(false)
  else
    if (self.chipLimitInfo).firstLimit then
      if self.chipLimitSequence ~= nil then
        (self.chipLimitSequence):PlayForward()
      end
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self.chipLimitInfo).firstLimit = false
    end
    ;
    ((self.ui).obj_limitBackground):SetActive(true)
    ;
    ((self.ui).obj_Limit):SetActive(true)
  end
end

UINDungeonChipList.ShowDungeonChipListSellTween = function(self, show)
  -- function num : 0_10
  if show then
    if self.chipSellSequence == nil then
      self:_InitChipSellSequence()
    end
    ;
    (self.chipSellSequence):Restart()
  end
  ;
  ((self.ui).obj_chipSell):SetActive(show)
end

UINDungeonChipList.TryPlayDungeonChipListSellCloseTween = function(self)
  -- function num : 0_11
  if self.chipSellSequence == nil then
    return 
  end
  if (self.chipSellSequence):IsPlaying() and (self.chipSellSequence).position < 3 then
    (self.chipSellSequence):Goto(3, true)
  end
end

UINDungeonChipList.__InitItem = function(self, go)
  -- function num : 0_12 , upvalues : UINDungeonChipItem
  local chipItem = (UINDungeonChipItem.New)()
  chipItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.itemDic)[go] = chipItem
end

UINDungeonChipList.__OnItemChange = function(self, go, index)
  -- function num : 0_13 , upvalues : _ENV
  local item = (self.itemDic)[go]
  if item == nil then
    error("Can\'t find Item by gameObject")
    return 
  end
  local chipData = (self.chipDataList)[index + 1]
  if chipData == nil then
    error("Can\'t find chipData by index, index = " .. tonumber(index))
  end
  item:InitChipItem(chipData, index, self.__ChipItemClickFunc)
  if index == self.selectedIndex then
    item:SetSelect(true)
  else
    item:SetSelect(false)
  end
  if self.__enableHighlightChipItem then
    if index + 1 == self.__highlightChipIndex then
      item:SetDungeonChipItemShowAlpha(1)
    else
      item:SetDungeonChipItemShowAlpha(0.5)
    end
  else
    item:SetDungeonChipItemShowAlpha(1)
  end
end

UINDungeonChipList.ChipItemClickFunc = function(self, index)
  -- function num : 0_14 , upvalues : _ENV
  self:SelectItem(index)
  local win = UIManager:ShowWindow(UIWindowTypeID.DungeonInfoDetail)
  win:ShowChipDetail(self.chipDataList, index + 1, self.__DeselectAllItem, self.__SelectItem)
  win:SetSwitchBtnActive(true)
end

UINDungeonChipList.__GetItemByIndex = function(self, index)
  -- function num : 0_15
  local go = ((self.ui).chipList):GetCellByIndex(index)
  if go ~= nil then
    return (self.itemDic)[go]
  end
  return nil
end

UINDungeonChipList.DeselectAllItem = function(self)
  -- function num : 0_16 , upvalues : _ENV
  self.selectedIndex = nil
  self.selectItem = nil
  for key,item in pairs(self.itemDic) do
    item:SetSelect(false)
    item:SetTransplanet(false)
  end
  self:FakeChipOgj(false)
  if self.selectHeroWithChipIdCallback ~= nil then
    (self.selectHeroWithChipIdCallback)()
  end
  if self.isHideHero then
    (self.heroList):Hide()
  end
end

UINDungeonChipList.SelectItem = function(self, index)
  -- function num : 0_17 , upvalues : _ENV
  self:DeselectAllItem()
  self.selectedIndex = index
  self.selectItem = self:__GetItemByIndex(index)
  if self.selectItem ~= nil then
    (self.selectItem):SetSelect(true)
  end
  if self.selectHeroWithChipIdCallback ~= nil then
    local chipId = ((self.chipDataList)[index + 1]).dataId
    local chipColor = ItemQualityColor[((self.chipDataList)[index + 1]):GetQuality()]
    ;
    (self.selectHeroWithChipIdCallback)(chipId, chipColor)
  end
  do
    if self.isHideHero then
      (self.heroList):Show()
    end
  end
end

UINDungeonChipList.HighlightChipItem = function(self, chipData)
  -- function num : 0_18 , upvalues : _ENV
  if not (self.gameObject).activeInHierarchy then
    warn("UINDungeonChipList is inactive, can\'t Highlight.")
    return 
  end
  self.__enableHighlightChipItem = true
  local hilightChipData, needScrollIndex = nil, nil
  for k,v in ipairs(self.chipDataList) do
    if hilightChipData == nil and v.dataId == chipData.dataId and not v:IsCopyItem() then
      hilightChipData = v
      self.__highlightChipIndex = k
      needScrollIndex = k - 1
      local item = self:__GetItemByIndex(k - 1)
      if item ~= nil then
        item:SetDungeonChipItemShowAlpha(1)
      end
    else
      do
        do
          local item = self:__GetItemByIndex(k - 1)
          if item ~= nil then
            item:SetDungeonChipItemShowAlpha(0.5)
          end
          -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  if needScrollIndex ~= nil then
    needScrollIndex = (math.max)(needScrollIndex - 4, 0)
    ;
    ((self.ui).chipList):SrollToCell(needScrollIndex, 5000)
  end
end

UINDungeonChipList.CancelHighlightChipItem = function(self)
  -- function num : 0_19 , upvalues : _ENV
  if not self.__enableHighlightChipItem then
    return 
  end
  self.__enableHighlightChipItem = false
  self.__highlightChipIndex = nil
  for k,v in ipairs(self.chipDataList) do
    local item = self:__GetItemByIndex(k - 1)
    if item ~= nil then
      item:SetDungeonChipItemShowAlpha(1)
    end
  end
end

UINDungeonChipList.__TestOnValueChange = function(self, pos)
  -- function num : 0_20 , upvalues : _ENV
  local listFrontPos, listRarePos = nil, nil
  listFrontPos = ((self.ui).frontPoint).position
  listRarePos = ((self.ui).endPoint).position
  if (((self.ui).img_Adapter).gameObject).activeInHierarchy then
    local fistHeroItemFrontPos, lastHeroItemRarePos = nil, nil
    for i = 0, self.chipNum - 1 do
      local go = ((self.ui).chipList):GetCellByIndex(i)
      if go ~= nil then
        fistHeroItemFrontPos = ((((self.itemDic)[go]).ui).frontPoint).position
        break
      end
    end
    do
      for i = self.heroChipNum - 1, 0, -1 do
        local go = ((self.ui).chipList):GetCellByIndex(i)
        if go ~= nil then
          lastHeroItemRarePos = ((((self.itemDic)[go]).ui).endPoint).position
          break
        end
      end
      do
        local oldpos = ((self.ui).img_Adapter).position
        -- DECOMPILER ERROR at PC67: Confused about usage of register: R7 in 'UnsetPending'

        ;
        ((self.ui).img_Adapter).position = (Vector3.New)((math.max)(listFrontPos.x, fistHeroItemFrontPos.x), oldpos.y, oldpos.z)
        local uiCoordinateStart = nil
        if fistHeroItemFrontPos.x < listFrontPos.x then
          uiCoordinateStart = (UIManager:World2UIPosition(listFrontPos, nil, nil, UIManager.UICamera)).x
        else
          uiCoordinateStart = (UIManager:World2UIPosition(fistHeroItemFrontPos, nil, nil, UIManager.UICamera)).x
        end
        local uiCoordinateEnd = nil
        if lastHeroItemRarePos == nil then
          uiCoordinateEnd = uiCoordinateStart
          ;
          ((self.ui).obj_adapterBelow):SetActive(false)
        else
          ;
          ((self.ui).obj_adapterBelow):SetActive(true)
          if listRarePos.x < lastHeroItemRarePos.x then
            uiCoordinateEnd = (UIManager:World2UIPosition(listRarePos, nil, nil, UIManager.UICamera)).x
          else
            uiCoordinateEnd = (UIManager:World2UIPosition(lastHeroItemRarePos, nil, nil, UIManager.UICamera)).x
          end
        end
        local width = uiCoordinateEnd - uiCoordinateStart
        local oldSize = ((self.ui).img_Adapter).sizeDelta
        -- DECOMPILER ERROR at PC136: Confused about usage of register: R11 in 'UnsetPending'

        ;
        ((self.ui).img_Adapter).sizeDelta = Vector2(width, oldSize.y)
      end
    end
  end
end

UINDungeonChipList.FakeChipOgj = function(self, switch, isLeft)
  -- function num : 0_21
  if switch then
    if isLeft then
      (self.FakeLeftChipItem):Show()
      ;
      (self.FakeLeftChipItem):InitChipItem((self.selectItem).chipData)
    else
      ;
      (self.FakeRightChipItem):Show()
      ;
      (self.FakeRightChipItem):InitChipItem((self.selectItem).chipData)
    end
  else
    ;
    (self.FakeLeftChipItem):Hide()
    ;
    (self.FakeRightChipItem):Hide()
  end
end

UINDungeonChipList.__SortChips = function(self, chipList)
  -- function num : 0_22 , upvalues : _ENV
  (table.sort)(chipList, function(a, b)
    -- function num : 0_22_0
    local c1 = a:IsConsumeSkillChip()
    local c2 = b:IsConsumeSkillChip()
    if c1 ~= c2 then
      return c2
    end
    local aQuality = a:GetQuality()
    local bQuality = b:GetQuality()
    if a.dataId >= b.dataId then
      do return aQuality ~= bQuality end
      do return bQuality < aQuality end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
end

UINDungeonChipList.OnSelectHero = function(self, heroItem)
  -- function num : 0_23 , upvalues : _ENV
  self.selectedIndex = nil
  self.selectItem = nil
  if heroItem == nil then
    (((self.ui).img_Adapter).gameObject):SetActive(false)
    self:__SortChips(self.chipDataList)
    ;
    ((self.ui).chipList):RefillCells()
    return 
  end
  local heroChips = (heroItem.dynHeroData):GetOwnedChips()
  local heroChipIDDic = {}
  for heroChip,_ in pairs(heroChips) do
    heroChipIDDic[heroChip.dataId] = true
  end
  self:__SortChipsWithHeroChipList(self.chipDataList, heroChipIDDic)
  ;
  ((self.ui).chipList):RefillCells()
  ;
  (((self.ui).img_Adapter).gameObject):SetActive(true)
  self.heroChipNum = (table.count)(heroChips)
  if self.heroChipNum == 0 then
    (((self.ui).img_Adapter).gameObject):SetActive(false)
    return 
  end
  local oldSize = ((self.ui).img_Adapter).sizeDelta
  local num = 0
  if self.maxNumInRect < self.heroChipNum then
    num = self.maxNumInRect
  else
    num = self.heroChipNum
  end
  -- DECOMPILER ERROR at PC77: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_Adapter).sizeDelta = Vector2(self.chipUnitWidth * num, oldSize.y)
  ;
  ((self.ui).obj_adapterBelow):SetActive(true)
end

UINDungeonChipList.__SortChipsWithHeroChipList = function(self, chipList, heroChipIDDic)
  -- function num : 0_24 , upvalues : _ENV
  (table.sort)(chipList, function(a, b)
    -- function num : 0_24_0 , upvalues : heroChipIDDic
    local aInDic = heroChipIDDic[a.dataId] ~= nil
    local bInDic = heroChipIDDic[b.dataId] ~= nil
    if aInDic ~= bInDic then
      return aInDic
    end
    local c1 = a:IsConsumeSkillChip()
    local c2 = b:IsConsumeSkillChip()
    if c1 ~= c2 then
      return c2
    end
    local aQuality = a:GetQuality()
    local bQuality = b:GetQuality()
    if a.dataId >= b.dataId then
      do return aQuality ~= bQuality end
      do return bQuality < aQuality end
      -- DECOMPILER ERROR: 8 unprocessed JMP targets
    end
  end
)
end

UINDungeonChipList.ScrollChipItemInScreen = function(self, chipData, action)
  -- function num : 0_25 , upvalues : _ENV
  local needScrollIndex, chipItemIndex = nil, nil
  for k,v in ipairs(self.chipDataList) do
    if v.dataId == chipData.dataId and not v:IsCopyItem() then
      needScrollIndex = k - 1
      chipItemIndex = k
      break
    end
  end
  do
    if needScrollIndex ~= nil then
      ((self.ui).chipList):SrollToCell(needScrollIndex, 20000, function()
    -- function num : 0_25_0 , upvalues : self, chipItemIndex, action
    local item = self:__GetItemByIndex(chipItemIndex - 1)
    if action ~= nil then
      action(item)
    end
  end
)
    else
      if action ~= nil then
        action(nil)
      end
    end
  end
end

UINDungeonChipList.ListContainChip = function(self, id)
  -- function num : 0_26 , upvalues : _ENV
  for _,chipData in ipairs(self.chipDataList) do
    if not chipData:IsCopyItem() and chipData.dataId == id then
      return true
    end
  end
  return false
end

UINDungeonChipList.SetListBlocksRaycasts = function(self, active)
  -- function num : 0_27
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).cg_ChipList).blocksRaycasts = active
end

UINDungeonChipList.SetChipGetEffectEnable = function(self, enable)
  -- function num : 0_28
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).chipList).enabled = not enable
  if enable then
    self.__startCacheChipUpdate = true
    ;
    ((self.ui).chipList):StopMovement()
  else
    self.__startCacheChipUpdate = false
    if self.__cacheChipList ~= nil then
      self:__ChipListUpdateInternal(self.__cacheChipList)
      self.__cacheChipList = nil
    end
  end
end

UINDungeonChipList.OnUseChipSkill = function(self, table)
  -- function num : 0_29 , upvalues : _ENV
  if table.belong == eBattleRoleBelong.player then
    local chipItem = nil
    for _,item in pairs(self.itemDic) do
      if (item.chipData).dataId == table.skillId then
        chipItem = item
      end
    end
    if chipItem ~= nil and not chipItem.isPlayingUsingEffect then
      chipItem.isPlayingUsingEffect = true
      self:GetAndPlayUseChipSkillEffect(chipItem)
    end
  end
end

UINDungeonChipList.GetAndPlayUseChipSkillEffect = function(self, chipItem)
  -- function num : 0_30
  local effectItem = (self.chipUseSkillEffectPool):GetOne(true)
  effectItem.onPlayEndCallBack = self.__HideUseChipSkillEffect
  effectItem:PlayEffect(chipItem)
end

UINDungeonChipList.HideUseChipSkillEffect = function(self, effectItem)
  -- function num : 0_31
  (self.chipUseSkillEffectPool):HideOne(effectItem)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  if effectItem.chipItem ~= nil then
    (effectItem.chipItem).isPlayingUsingEffect = nil
  end
  if effectItem ~= nil and effectItem.transform ~= nil then
    (effectItem.transform):SetParent(((self.ui).obj_effList).transform, false)
  end
end

UINDungeonChipList.StopAllUseChipEffect = function(self)
  -- function num : 0_32 , upvalues : _ENV
  for _,effectItem in pairs((self.chipUseSkillEffectPool).listItem) do
    effectItem:Hide()
  end
end

UINDungeonChipList.CheckChipListContainerShow = function(self, check)
  -- function num : 0_33 , upvalues : _ENV
  if check ~= nil then
    self.check = check
  end
  if not self.check then
    self:Show()
    return 
  end
  if BattleDungeonManager:InBattleDungeon() then
    local dungeonId = (BattleDungeonManager.dungeonCtrl).dungeonId
    local dungeonStageCfg = (ConfigData.battle_dungeon)[dungeonId]
    if dungeonStageCfg == nil then
      error("找不到对应的副本配置，battle_dungeon,id:" .. dungeonId)
      self:Hide()
      return 
    end
    if dungeonStageCfg.show_function then
      self:Show()
      if (BattleUtil.IsInDailyDungeon)() then
        ((self.ui).obj_chipCountLimit):SetActive(false)
      end
    else
      self:Hide()
    end
  else
    do
      if #self.chipDataList > 0 then
        self:Show()
      else
        self:Hide()
      end
    end
  end
end

UINDungeonChipList._OnClickSelectSuit = function(self)
  -- function num : 0_34 , upvalues : _ENV
  if BattleDungeonManager.dungeonCtrl == nil then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.SelectChipSuit, function(win)
    -- function num : 0_34_0 , upvalues : _ENV
    if win == nil then
      return 
    end
    local dungeonCfg = (BattleDungeonManager.dungeonCtrl).dungeonCfg
    local material_dungeonCfg = (ConfigData.material_dungeon)[dungeonCfg.module_id]
    if material_dungeonCfg == nil then
      return 
    end
    win:InitSelectChipSuit(material_dungeonCfg)
  end
)
end

UINDungeonChipList.PlayDepolyEft = function(self)
  -- function num : 0_35 , upvalues : _ENV, CS_DOTween
  if self.deployEftTween ~= nil then
    (self.deployEftTween):Kill()
    self.deployEftTween = nil
  end
  local CS_LayoutRebuilder = ((CS.UnityEngine).UI).LayoutRebuilder
  ;
  (CS_LayoutRebuilder.ForceRebuildLayoutImmediate)(self.transform)
  local width = ((UIManager.csUIManager).BackgroundStretchSize).x
  local oriWidth = 1920 - ((self.transform).offsetMin).x + ((self.transform).offsetMax).x
  local nowWidth = width - ((self.transform).offsetMin).x + ((self.transform).offsetMax).x
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((self.ui).fX_UI_DungeonStateInfo1).transform).localScale = (Vector3.New)(nowWidth / oriWidth * self.fX_UI_DungeonStateInfo1Scale, 1, 1)
  local particleCount = ((((self.ui).chipList).transform).rect).width // (((self.ui).rect_gridGroup).cellSize).x
  local chipShowCount = (math.min)(#self.chipDataList, particleCount)
  local time_fX_Intervial = (self.ui).time_fXChip_totalTime / particleCount
  local tempChipItemList = {}
  for i = 1, chipShowCount do
    local data = (self.chipDataList)[i]
    do
      for k,item in pairs(self.itemDic) do
        if item.chipData == data then
          (table.insert)(tempChipItemList, item)
          break
        end
      end
    end
  end
  ;
  (((self.ui).fX_UI_DungeonStateInfo1).gameObject):SetActive(false)
  ;
  ((self.ui).drawMask):SetActive(true)
  local sequence = CS_DOTween:Sequence()
  sequence:AppendInterval((self.ui).time_fX_playDelayTime)
  sequence:AppendCallback(function()
    -- function num : 0_35_0 , upvalues : self
    (((self.ui).fX_UI_DungeonStateInfo1).gameObject):SetActive(true)
  end
)
  sequence:AppendInterval((self.ui).time_fXChip_startTime)
  if chipShowCount < particleCount then
    sequence:AppendInterval((particleCount - chipShowCount) * time_fX_Intervial)
  end
  for i = chipShowCount, 1, -1 do
    sequence:AppendCallback(function()
    -- function num : 0_35_1 , upvalues : self, tempChipItemList, i
    self:GetAndPlayUseChipSkillEffect(tempChipItemList[i])
  end
)
    sequence:AppendInterval(time_fX_Intervial)
  end
  sequence:AppendCallback(function()
    -- function num : 0_35_2 , upvalues : self
    ((self.ui).drawMask):SetActive(false)
  end
)
  self.deployEftTween = sequence
  ;
  (self.deployEftTween):SetAutoKill(false)
end

UINDungeonChipList.StopDepolyEft = function(self)
  -- function num : 0_36
  (((self.ui).fX_UI_DungeonStateInfo1).gameObject):SetActive(false)
  ;
  ((self.ui).drawMask):SetActive(false)
  if self.deployEftTween ~= nil then
    (self.deployEftTween):Kill()
    self.deployEftTween = nil
  end
end

UINDungeonChipList.GetEftLineStartPos = function(self)
  -- function num : 0_37
  return (((self.ui).lineStart).transform).position
end

UINDungeonChipList.OnHide = function(self)
  -- function num : 0_38 , upvalues : base
  (base.OnHide)(self)
  self:StopDepolyEft()
end

UINDungeonChipList.OnDelete = function(self)
  -- function num : 0_39 , upvalues : _ENV, base
  if self.chipLimitSequence ~= nil then
    (self.chipLimitSequence):Kill()
    self.chipLimitSequence = nil
  end
  if self.chipSellSequence ~= nil then
    (self.chipSellSequence):Kill()
    self.chipSellSequence = nil
  end
  ;
  (self.chipUseSkillEffectPool):DeleteAll()
  MsgCenter:RemoveListener(eMsgEventId.OnEpChipListChange, self.__onChipListChange)
  MsgCenter:RemoveListener(eMsgEventId.OnPlayChipEffect, self.__OnUseChipSkill)
  MsgCenter:RemoveListener(eMsgEventId.OnChipLimitChange, self.__RefreshLimit)
  ;
  (base.OnDelete)(self)
end

return UINDungeonChipList


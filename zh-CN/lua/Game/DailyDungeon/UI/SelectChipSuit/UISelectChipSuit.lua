local UISelectChipSuit = class("UISelectChipSuit", UIBaseNode)
local base = UIBaseNode
local UINSelectChipSuitList = require("Game.DailyDungeon.UI.SelectChipSuit.List.UINSelectChipSuitList")
local UINSelectChipSuitItem = require("Game.DailyDungeon.UI.SelectChipSuit.UINSelectChipSuitItem")
local DynChipSuit = require("Game.Exploration.Data.ChipSuit.DynChipSuit")
local cs_Ease = ((CS.DG).Tweening).Ease
UISelectChipSuit.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINSelectChipSuitList, UINSelectChipSuitItem
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self._OnClickConfirm)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Back, self, self._OnClickBack)
  self.selectChipSuitList = (UINSelectChipSuitList.New)(self)
  ;
  (self.selectChipSuitList):Init((self.ui).suitDetailScroll)
  ;
  ((self.ui).suitItem):SetActive(false)
  self.suitItemPool = (UIItemPool.New)(UINSelectChipSuitItem, (self.ui).suitItem)
  ;
  ((self.ui).fX_UINBaseItem):SetActive(false)
  local roteX = (((self.ui).modifier).rotation).x
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).fX_UINBaseItem).transform).rotation = (Quaternion.Euler)(roteX, 0, 0)
  self._onListItemClick = BindCallback(self, self._OnListItemClick)
  self._onSuitItemClick = BindCallback(self, self._OnSuitItemClick)
end

UISelectChipSuit.InitSelectChipSuit = function(self, material_dungeonCfg)
  -- function num : 0_1
  self:_InitData(material_dungeonCfg)
  local selectMaxNum = material_dungeonCfg.chip_select_max
  self.selectMaxNum = selectMaxNum
  ;
  (self.selectChipSuitList):InitSelectChipSuitList(self.seChipSuitDataList, self.lastSelectedSuitDic, selectMaxNum, self._onListItemClick, self.lastChipSuitIdList)
  ;
  (self.suitItemPool):HideAll()
  for i = 1, selectMaxNum do
    (self.suitItemPool):GetOne()
  end
  self:UpdSelectedChipSuit()
end

UISelectChipSuit._InitData = function(self, material_dungeonCfg)
  -- function num : 0_2 , upvalues : _ENV, DynChipSuit
  local seChipSuitDataList = {}
  local seChipSuitDataDic = {}
  local dungeonDyncElem = (PlayerDataCenter.dungeonDyncData):GetDailyDungeonDyncData()
  if dungeonDyncElem == nil then
    return 
  end
  self.dungeonDyncElem = dungeonDyncElem
  self.lastSelectedSuitDicOrigin = dungeonDyncElem.lastChipGroup
  self.lastSelectedSuitDic = {}
  for suitTagId,v in pairs(dungeonDyncElem.lastChipGroup) do
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R10 in 'UnsetPending'

    (self.lastSelectedSuitDic)[suitTagId] = v
  end
  local lastChipSuitIdList = {}
  for suitId,index in pairs(self.lastSelectedSuitDic) do
    (table.insert)(lastChipSuitIdList, suitId)
  end
  ;
  (table.sort)(lastChipSuitIdList, function(a, b)
    -- function num : 0_2_0 , upvalues : self
    do return (self.lastSelectedSuitDic)[a] < (self.lastSelectedSuitDic)[b] end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  self.lastChipSuitIdList = lastChipSuitIdList
  for k,chipTagId in ipairs(material_dungeonCfg.chip_pool) do
    local dynChipSuitData = (DynChipSuit.New)(chipTagId, 1)
    dynChipSuitData:SetChipSuitCount(dynChipSuitData:GetChipSuitMaxCount())
    local seChipSuitData = {dynChipSuitData = dynChipSuitData, selectNumMax = (material_dungeonCfg.chip_num)[k], selectNumCur = (dungeonDyncElem.selectedChipGroup)[chipTagId] or 0, chipQuality = material_dungeonCfg.chip_quality}
    ;
    (table.insert)(seChipSuitDataList, seChipSuitData)
    seChipSuitDataDic[chipTagId] = dynChipSuitData
  end
  self.seChipSuitDataDic = seChipSuitDataDic
  self.seChipSuitDataList = seChipSuitDataList
end

UISelectChipSuit.UpdSelectedChipSuit = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self.itemDic = {}
  if ((self.ui).fX_UINBaseItem).activeSelf then
    ((self.ui).fX_UINBaseItem):SetActive(false)
  end
  local emptyIndex = 0
  for k = 1, self.selectMaxNum do
    local id = (self.lastChipSuitIdList)[k]
    local suitItem = ((self.suitItemPool).listItem)[k]
    local dynChipSuitData = nil
    if id ~= nil then
      dynChipSuitData = (self.seChipSuitDataDic)[id]
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self.itemDic)[id] = suitItem
    else
      if emptyIndex == 0 then
        emptyIndex = k
      end
    end
    suitItem:InitSelectChipSuitItem(dynChipSuitData, self._onSuitItemClick)
  end
  if (BattleUtil.IsInDailyDungeon)() then
    local emptyItem = ((self.suitItemPool).listItem)[emptyIndex]
    local hasEmptyItem = emptyItem ~= nil and true or false
    ;
    (((self.ui).tran_TriHolder).gameObject):SetActive(hasEmptyItem)
    if emptyItem ~= nil then
      ((self.ui).tran_TriHolder):SetParent(emptyItem:GetEmptyTransform())
      -- DECOMPILER ERROR at PC70: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).tran_TriHolder).localPosition = Vector3.zero
      -- DECOMPILER ERROR at PC75: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).tran_TriHolder).anchoredPosition = Vector2.zero
      ;
      ((self.ui).ani_Tri):DORestart()
    end
  end
end

UISelectChipSuit._OnClickConfirm = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if (table.count)(self.lastSelectedSuitDicOrigin) == (table.count)(self.lastSelectedSuitDic) then
    local allSame = true
    for suitTagId,v in pairs(self.lastSelectedSuitDicOrigin) do
      if (self.lastSelectedSuitDic)[suitTagId] ~= v then
        allSame = false
        break
      end
    end
    do
      do
        if allSame then
          self:Hide()
          return 
        end
        local chipTagDic = self.lastSelectedSuitDic
        ;
        (NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon)):CS_BATTLE_SelectChipGroup(chipTagDic, function()
    -- function num : 0_4_0 , upvalues : self, chipTagDic, _ENV
    (self.dungeonDyncElem):SetDgDyncElemLastChipGroup(chipTagDic)
    self:Hide()
    local uiBattle = UIManager:GetWindow(UIWindowTypeID.Battle)
    if uiBattle ~= nil then
      uiBattle:EndChipEft()
      uiBattle:StartChipEft()
    end
    MsgCenter:Broadcast(eMsgEventId.OnEpChipSuitUpdate)
  end
)
      end
    end
  end
end

UISelectChipSuit._OnListItemClick = function(self, chipTagId)
  -- function num : 0_5 , upvalues : _ENV, cs_Ease
  local item = (self.itemDic)[chipTagId]
  do
    if self.oldItem ~= nil then
      local oldIcon = (self.oldItem):GetSelectChipSuitIcon()
      ;
      (oldIcon.transform):DOKill()
    end
    if item ~= nil then
      self.oldItem = item
      ;
      (((self.ui).fX_UINBaseItem).transform):SetParent(item.transform)
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (((self.ui).fX_UINBaseItem).transform).anchoredPosition = Vector2.zero
      ;
      ((self.ui).fX_UINBaseItem):SetActive(true)
      local icon = item:GetSelectChipSuitIcon()
      -- DECOMPILER ERROR at PC36: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (icon.transform).localScale = Vector3.one
      ;
      (((icon.transform):DOScale((Vector3.New)(0.5, 0.5, 1), 0.8)):From()):SetEase(cs_Ease.OutElastic)
    end
  end
end

UISelectChipSuit._OnSuitItemClick = function(self, dynChipSuitData)
  -- function num : 0_6
  if dynChipSuitData == nil then
    return 
  end
  ;
  (self.selectChipSuitList):TrySelectChipSuitItem(dynChipSuitData.tagId, false)
  ;
  (self.selectChipSuitList):RefreshSelectChipSuitList()
end

UISelectChipSuit._OnClickBack = function(self)
  -- function num : 0_7
  self:Hide()
end

UISelectChipSuit.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  do
    if self.oldItem ~= nil then
      local oldIcon = (self.oldItem):GetSelectChipSuitIcon()
      ;
      (oldIcon.transform):DOKill()
    end
    ;
    (self.selectChipSuitList):Delete()
    ;
    (self.suitItemPool):DeleteAll()
    ;
    ((self.ui).ani_Tri):DOKill()
    ;
    (base.OnDelete)(self)
  end
end

return UISelectChipSuit


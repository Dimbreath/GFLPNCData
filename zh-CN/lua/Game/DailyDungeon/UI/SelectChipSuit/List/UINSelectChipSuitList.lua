local UINSelectChipSuitList = class("UINSelectChipSuitList", UIBaseNode)
local base = UIBaseNode
local UINSelectChipSuitListItem = require("Game.DailyDungeon.UI.SelectChipSuit.List.UINSelectChipSuitListItem")
UINSelectChipSuitList.ctor = function(self, selectChipSuitRoot)
  -- function num : 0_0
  self.selectChipSuitRoot = selectChipSuitRoot
end

UINSelectChipSuitList.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onChangeItem = BindCallback(self, self.__OnChangeItem)
  self._itemDic = {}
  self._showSuitIntroDic = {}
end

UINSelectChipSuitList.InitSelectChipSuitList = function(self, chipSuitDataList, lastSelectedSuitDic, selectMaxNum, itemClickCallback, lastChipSuitIdList)
  -- function num : 0_2
  self.chipSuitDataList = chipSuitDataList
  self.lastChipSuitIdList = lastChipSuitIdList
  self._selectedSuitDic = lastSelectedSuitDic
  self.selectMaxNum = selectMaxNum
  self._itemClickCallback = itemClickCallback
  self:_RefillScrollRect()
end

UINSelectChipSuitList._RefillScrollRect = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (table.sort)(self.chipSuitDataList, function(a, b)
    -- function num : 0_3_0
    local hasNumA = a.selectNumCur < a.selectNumMax
    local hasNumB = b.selectNumCur < b.selectNumMax
    if hasNumA ~= hasNumB then
      return hasNumA
    end
    local influenceIdA = (a.dynChipSuitData):GetSuitChipInfluence()
    local influenceIdB = (b.dynChipSuitData):GetSuitChipInfluence()
    if influenceIdA >= influenceIdB then
      do return influenceIdA == influenceIdB end
      do return (a.dynChipSuitData).tagId < (b.dynChipSuitData).tagId end
      -- DECOMPILER ERROR: 6 unprocessed JMP targets
    end
  end
)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).totalCount = #self.chipSuitDataList
  ;
  ((self.ui).scrollRect):RefillCells()
end

UINSelectChipSuitList.__OnNewItem = function(self, go)
  -- function num : 0_4 , upvalues : UINSelectChipSuitListItem
  local item = (UINSelectChipSuitListItem.New)(self)
  item:Init(go)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._itemDic)[go] = item
end

UINSelectChipSuitList.__OnChangeItem = function(self, go, index)
  -- function num : 0_5 , upvalues : _ENV
  local item = (self._itemDic)[go]
  if item == nil then
    error("Can\'t find item by gameObject")
    return 
  end
  local chipSuitData = (self.chipSuitDataList)[index + 1]
  if chipSuitData == nil then
    error("Can\'t find chipSuitData by index, index = " .. tonumber(index))
  end
  local tagId = (chipSuitData.dynChipSuitData).tagId
  local showIntro = (self._showSuitIntroDic)[tagId]
  local selected = (self._selectedSuitDic)[tagId] ~= nil
  item:InitSelectChipSuitListItem(chipSuitData, showIntro, selected)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINSelectChipSuitList.RecordSeChipSuitListItemIntroState = function(self, chipTagId, showIntro)
  -- function num : 0_6
  if showIntro == false then
    showIntro = nil
  end
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._showSuitIntroDic)[chipTagId] = showIntro
end

UINSelectChipSuitList.TrySelectChipSuitItem = function(self, chipTagId, selected)
  -- function num : 0_7 , upvalues : _ENV
  if selected and self.selectMaxNum <= (table.count)(self._selectedSuitDic) then
    AudioManager:PlayAudioById(1107)
    return false
  end
  if selected == false then
    (table.removebyvalue)(self.lastChipSuitIdList, chipTagId)
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._selectedSuitDic)[chipTagId] = nil
  else
    ;
    (table.insert)(self.lastChipSuitIdList, chipTagId)
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._selectedSuitDic)[chipTagId] = #self.lastChipSuitIdList
  end
  ;
  (self.selectChipSuitRoot):UpdSelectedChipSuit()
  if selected and self._itemClickCallback ~= nil then
    (self._itemClickCallback)(chipTagId)
  end
  return true
end

UINSelectChipSuitList.RefreshSelectChipSuitList = function(self)
  -- function num : 0_8
  ((self.ui).scrollRect):RefreshCells()
end

UINSelectChipSuitList.OnDelete = function(self)
  -- function num : 0_9 , upvalues : _ENV, base
  for k,v in pairs(self._itemDic) do
    v:Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UINSelectChipSuitList


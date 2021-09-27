local UINDailyDgLvList = class("UINDailyDgLvList", UIBaseNode)
local base = UIBaseNode
local UINDailyDgLvListItemHolder = require("Game.DailyDungeon.UI.LevelSelect.Level.UINDailyDgLvListItemHolder")
local UINDailyDgLvListItem = require("Game.DailyDungeon.UI.LevelSelect.Level.UINDailyDgLvListItem")
UINDailyDgLvList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINDailyDgLvListItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onChangeItem = BindCallback(self, self.__OnChangeItem)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onReturnItem = BindCallback(self, self.__onReturnItem)
  self._itemDic = {}
  ;
  ((self.ui).levelItem):SetActive(false)
  self.normalLvItemPool = (UIItemPool.New)(UINDailyDgLvListItem, (self.ui).levelItem)
  ;
  ((self.ui).bossLevelItem):SetActive(false)
  self.bossLvItemPool = (UIItemPool.New)(UINDailyDgLvListItem, (self.ui).bossLevelItem)
end

UINDailyDgLvList.InitDailyDgLvList = function(self, levelNum, curLvIdx, inDungeon, matDungeonCfg, resloader, clickItemFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.curLvIdx = curLvIdx
  self.clickItemFunc = clickItemFunc
  self.inDungeon = inDungeon
  self.matDungeonCfg = matDungeonCfg
  self.resloader = resloader
  local lvIndexList = {}
  for i = 1, levelNum do
    (table.insert)(lvIndexList, i)
  end
  self.lvIndexList = lvIndexList
  self:_RefillScrollRect()
end

UINDailyDgLvList._RefillScrollRect = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local allNum = #self.lvIndexList
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).totalCount = allNum
  local leftPad = (((self.ui).layout_rect).padding).left
  local rightPad = (((self.ui).layout_rect).padding).right
  local spacing = ((self.ui).layout_rect).spacing
  local itemNum = (math.max)(self.curLvIdx - 1, 0)
  local normalItemSize = ((((self.ui).levelItem).transform).rect).width
  local bossItemSize = ((((self.ui).bossLevelItem).transform).rect).width
  local offset = 0
  if itemNum > 0 then
    offset = leftPad + itemNum * normalItemSize + (itemNum - 0.5) * spacing
    local maxOffset = leftPad + (allNum - 1) * (normalItemSize + spacing) + bossItemSize + rightPad - ((((self.ui).scrollRect).transform).rect).width
    offset = (math.min)(offset, maxOffset)
  end
  do
    ;
    ((self.ui).scrollRect):RefillCells(0, (math.floor)(offset))
  end
end

UINDailyDgLvList.__OnNewItem = function(self, go)
  -- function num : 0_3 , upvalues : UINDailyDgLvListItemHolder
  local item = (UINDailyDgLvListItemHolder.New)(self)
  item:Init(go)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._itemDic)[go] = item
end

UINDailyDgLvList.__OnChangeItem = function(self, go, index)
  -- function num : 0_4 , upvalues : _ENV
  local item = (self._itemDic)[go]
  if item == nil then
    error("Can\'t find item by gameObject")
    return 
  end
  local lvIndex = (self.lvIndexList)[index + 1]
  if lvIndex == nil then
    error("Can\'t find lvIndex by index, index = " .. tonumber(index))
  end
  local isBoss = lvIndex == #self.lvIndexList
  local needCreatNewItem, returnLvItem = item:CheckNewReturnDailyDgLvListItem(isBoss)
  if returnLvItem ~= nil then
    self:_ReturnLvItem(returnLvItem, not isBoss)
  end
  do
    if needCreatNewItem then
      local lvItem = nil
      if isBoss then
        lvItem = (self.bossLvItemPool):GetOne()
      else
        lvItem = (self.normalLvItemPool):GetOne()
      end
      item:SetDailyDgLvListItem(lvItem)
    end
    local isComplete = lvIndex <= self.curLvIdx
    local isLock = self.curLvIdx + 1 < lvIndex
    if self.inDungeon and lvIndex == 1 then
      isLock = false
    end
    local isCurrent = not self.inDungeon or self.curLvIdx + 1 == lvIndex
    local bossId = nil
    if isBoss then
      bossId = (self.matDungeonCfg).boss_id
    end
    item:InitDailyDgLvListItemHolder(lvIndex, bossId, isComplete, isLock, isCurrent, self.resloader, self.clickItemFunc)
    -- DECOMPILER ERROR: 11 unprocessed JMP targets
  end
end

UINDailyDgLvList.__onReturnItem = function(self, go)
  -- function num : 0_5 , upvalues : _ENV
  local item = (self._itemDic)[go]
  if item == nil then
    error("Can\'t find item by gameObject")
    return 
  end
  local lvItem, isBoss = item:ReturnDailyDgLvListItem()
  self:_ReturnLvItem(lvItem, isBoss)
end

UINDailyDgLvList._ReturnLvItem = function(self, lvItem, isBoss)
  -- function num : 0_6
  if lvItem == nil then
    return 
  end
  ;
  (lvItem.transform):SetParent((self.ui).prefabHolder)
  if isBoss then
    (self.bossLvItemPool):HideOne(lvItem)
  else
    ;
    (self.normalLvItemPool):HideOne(lvItem)
  end
end

UINDailyDgLvList.OnDelete = function(self)
  -- function num : 0_7 , upvalues : _ENV, base
  (self.bossLvItemPool):DeleteAll()
  ;
  (self.normalLvItemPool):DeleteAll()
  for k,v in pairs(self._itemDic) do
    v:Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UINDailyDgLvList


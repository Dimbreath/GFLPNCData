-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthListSuit = class("UINAthListSuit", UIBaseNode)
local base = UIBaseNode
local UINAthListSuitItem = require("Game.Arithmetic.AthList.Suit.UINAthListSuitItem")
UINAthListSuit.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self._OnClickSuitItemFunc = BindCallback(self, self._OnClickSuitItem)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.suitItemDic = {}
  self._isInit = true
end

UINAthListSuit.InitAthListSuit = function(self, athListRoot, resLoader)
  -- function num : 0_1
  self.athListRoot = athListRoot
  self.resLoader = resLoader
end

UINAthListSuit.SetAthListSuitArea = function(self, areaId)
  -- function num : 0_2
  self.areaId = areaId
  self:RefreshAthListSuit(true)
end

UINAthListSuit.RefreshAthListSuit = function(self, refill)
  -- function num : 0_3
  self:_RefreshAthListSuitData()
  self:_RefillScrollRect(refill)
end

UINAthListSuit._RefreshAthListSuitData = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self.curSuitIdList = {}
  if self.areaId == nil then
    for suitId,v in pairs(ConfigData.ath_suit) do
      (table.insert)(self.curSuitIdList, suitId)
    end
  else
    do
      if not ((ConfigData.arithmetic).areaSuitDic)[self.areaId] then
        local suitIdDic = table.emptytable
      end
      for suitId,v in pairs(suitIdDic) do
        (table.insert)(self.curSuitIdList, suitId)
      end
      do
        local allAthIdNumDic = (PlayerDataCenter.allAthData):GetAllAthIdNumDic()
        local suitAthNumDic = (table.GetDefaulValueTable)(0)
        for k,suitId in ipairs(self.curSuitIdList) do
          local suitCfltDic = ((ConfigData.arithmetic).suitDic)[suitId]
          if suitCfltDic == nil then
            error("Cant find suitCfltDic, suitId = " .. tostring(suitId))
          else
            for k2,suitAthIdList in pairs(suitCfltDic) do
              for k3,athId in ipairs(suitAthIdList) do
                suitAthNumDic[suitId] = suitAthNumDic[suitId] + allAthIdNumDic[athId]
              end
            end
          end
        end
        self.suitAthNumDic = suitAthNumDic
        ;
        (table.sort)(self.curSuitIdList, function(suitIdA, suitIdB)
    -- function num : 0_4_0 , upvalues : suitAthNumDic
    local hasA = suitAthNumDic[suitIdA] > 0
    local hasB = suitAthNumDic[suitIdB] > 0
    if suitIdA >= suitIdB then
      do return hasA ~= hasB end
      do return hasA end
      -- DECOMPILER ERROR: 5 unprocessed JMP targets
    end
  end
)
      end
    end
  end
end

UINAthListSuit._RefillScrollRect = function(self, refill)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).scrollRect).totalCount = #self.curSuitIdList
  if self._isInit or refill or self._nextFill then
    ((self.ui).scrollRect):RefillCells()
    self._isInit = false
    self._nextFill = not (((self.ui).scrollRect).gameObject).activeInHierarchy
  else
    ;
    ((self.ui).scrollRect):RefreshCells()
  end
end

UINAthListSuit.__OnNewItem = function(self, go)
  -- function num : 0_6 , upvalues : UINAthListSuitItem
  local item = (UINAthListSuitItem.New)()
  item:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.suitItemDic)[go] = item
end

UINAthListSuit.__OnChangeItem = function(self, go, index)
  -- function num : 0_7 , upvalues : _ENV
  local item = (self.suitItemDic)[go]
  if item == nil then
    error("Can\'t find item by gameObject")
    return 
  end
  local suitId = (self.curSuitIdList)[index + 1]
  if suitId == nil then
    error("Can\'t find suitId by index, index = " .. tonumber(index))
  end
  local curCount = (self.suitAthNumDic)[suitId]
  item:InitAthListSuitItem(suitId, self._OnClickSuitItemFunc, self.resLoader, curCount)
end

UINAthListSuit._OnClickSuitItem = function(self, suitId)
  -- function num : 0_8
  if (self.suitAthNumDic)[suitId] > 0 then
    (self.athListRoot):ShowAthListSuitAth(suitId)
  end
end

UINAthListSuit.OnDelete = function(self)
  -- function num : 0_9 , upvalues : _ENV, base
  for k,suitItem in pairs(self.suitItemDic) do
    suitItem:Delete()
  end
  self.suitItemDic = nil
  ;
  (base.OnDelete)(self)
end

return UINAthListSuit


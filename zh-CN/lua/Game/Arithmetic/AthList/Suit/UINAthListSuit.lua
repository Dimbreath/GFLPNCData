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
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onReturnItem = BindCallback(self, self.__OnReturnItem)
  self.suitItemDic = {}
  self._isInit = true
end

UINAthListSuit.InitAthListSuit = function(self, athListRoot, resLoader)
  -- function num : 0_1
  self.athListRoot = athListRoot
  self.resLoader = resLoader
end

UINAthListSuit.SetAthListSuitSelectedSuitId = function(self, athSuitId)
  -- function num : 0_2
  self.selectedAthSuitId = athSuitId
  ;
  (((self.ui).img_Select).transform):SetParent((self.ui).prefabHolder)
  if athSuitId == nil then
    return 
  end
  if self._suitSelSeq ~= nil then
    (self._suitSelSeq):Restart()
    return 
  end
  self:_InitSuitSelectSeq()
end

UINAthListSuit.SetAthListSuitArea = function(self, areaId)
  -- function num : 0_3
  self.areaId = areaId
  self:RefreshAthListSuit(true)
end

UINAthListSuit.RefreshAthListSuit = function(self, refill, targetSuitId)
  -- function num : 0_4
  local refillIdx = self:_RefreshAthListSuitData(targetSuitId)
  if targetSuitId == nil then
    self:SetAthListSuitSelectedSuitId(nil)
  end
  self:_RefillScrollRect(refill, refillIdx)
end

UINAthListSuit._RefreshAthListSuitData = function(self, targetSuitId)
  -- function num : 0_5 , upvalues : _ENV
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
    -- function num : 0_5_0 , upvalues : suitAthNumDic
    local hasA = suitAthNumDic[suitIdA] > 0
    local hasB = suitAthNumDic[suitIdB] > 0
    if suitIdA >= suitIdB then
      do return hasA ~= hasB end
      do return hasA end
      -- DECOMPILER ERROR: 5 unprocessed JMP targets
    end
  end
)
        if targetSuitId ~= nil then
          for k,suitId in ipairs(self.curSuitIdList) do
            if targetSuitId == suitId then
              return k - 1
            end
          end
        end
      end
    end
  end
end

UINAthListSuit._RefillScrollRect = function(self, refill, refillIdx)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).scrollRect).totalCount = #self.curSuitIdList
  if not refillIdx then
    ((self.ui).scrollRect):RefillCells(not self._isInit and not refill and not self._nextFill or 0)
    self._isInit = false
    self._nextFill = not (((self.ui).scrollRect).gameObject).activeInHierarchy
    ;
    ((self.ui).scrollRect):RefreshCells()
  end
end

UINAthListSuit.__OnNewItem = function(self, go)
  -- function num : 0_7 , upvalues : UINAthListSuitItem
  local item = (UINAthListSuitItem.New)()
  item:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.suitItemDic)[go] = item
end

UINAthListSuit.__OnChangeItem = function(self, go, index)
  -- function num : 0_8 , upvalues : _ENV
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
  if self.selectedAthSuitId == suitId then
    (((self.ui).img_Select).transform):SetParent(item.transform)
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (((self.ui).img_Select).transform).anchoredPosition = (Vector2.New)(-3, 3)
  end
end

UINAthListSuit.__OnReturnItem = function(self, go)
  -- function num : 0_9 , upvalues : _ENV
  local item = (self.suitItemDic)[go]
  if item == nil then
    error("Can\'t find item by gameObject")
    return 
  end
  if self.selectedAthSuitId ~= nil and item.suitId == self.selectedAthSuitId then
    (((self.ui).img_Select).transform):SetParent((self.ui).prefabHolder)
  end
end

UINAthListSuit._OnClickSuitItem = function(self, suitId, curCount)
  -- function num : 0_10
  if (self.suitAthNumDic)[suitId] > 0 then
    (self.athListRoot):ShowAthListSuitAth(suitId, curCount)
  end
end

UINAthListSuit._InitSuitSelectSeq = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local cs_DoTween = ((CS.DG).Tweening).DOTween
  local seq = (cs_DoTween.Sequence)()
  seq:Append(((((self.ui).img_Select):DOColor(Color.white, 0.25)):From()):SetLoops(3))
  seq:Append((((self.ui).img_Select):DOFade(0, 0.25)):SetDelay(0.25))
  seq:SetAutoKill(false)
  seq:OnComplete(function()
    -- function num : 0_11_0 , upvalues : self
    self:SetAthListSuitSelectedSuitId(nil)
  end
)
  self._suitSelSeq = seq
end

UINAthListSuit.OnDelete = function(self)
  -- function num : 0_12 , upvalues : _ENV, base
  for k,suitItem in pairs(self.suitItemDic) do
    suitItem:Delete()
  end
  self.suitItemDic = nil
  if self._suitSelSeq ~= nil then
    (self._suitSelSeq):Kill()
    self._suitSelSeq = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINAthListSuit


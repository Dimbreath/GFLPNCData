-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthDecompose = class("UINAthDecompose", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UINAthSortCondition = require("Game.Arithmetic.AthSortList.SortCondition.UINAthSortCondition")
local AthFilterEnum = require("Game.Arithmetic.AthSortList.AthFilterEnum")
local cs_MessageCommon = CS.MessageCommon
UINAthDecompose.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Dismantle, self, self._OnClickDecompose)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_AutoSelect, self, self._OnClickAutoSelect)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.__OnClickAthItemFunc = BindCallback(self, self._OnClickAthItem)
  self.athItemGoDic = {}
  self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
  ;
  ((self.ui).resItem):SetActive(false)
  self.shardItemPool = (UIItemPool.New)(UINBaseItemWithCount, (self.ui).resItem)
end

UINAthDecompose.InitAthDeco = function(self, sortListNode)
  -- function num : 0_1
  self.athSelectedDic = {}
  self.sortListNode = sortListNode
  ;
  (self.sortListNode):SetAthListEfccSortFunc()
  ;
  (self.sortListNode):SetCustomSiftFunc(function(athDataS)
    -- function num : 0_1_0
    do return athDataS.bindInfo == nil end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self.sortListNode):SetAthListMultSeletedUidDic(self.athSelectedDic)
  ;
  (self.sortListNode):InitAthSortListNode(nil, false, self.__OnClickAthItemFunc)
  self:_RefreshSelectedList()
end

UINAthDecompose._RefreshSelectedList = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local shardItemDic = (table.GetDefaulValueTable)(0)
  local shardItemIdList = {}
  local curSelectedAthList = {}
  self.curSelectedAthList = curSelectedAthList
  for uid,v in pairs(self.athSelectedDic) do
    local athData = ((PlayerDataCenter.allAthData).athDic)[uid]
    local quality = athData:GetAthQuality()
    local size = athData:GetAthSize()
    local shardQCfg = (ConfigData.ath_shard)[quality]
    if shardQCfg == nil then
      error("Cant get ath_shard, quality = " .. tostring(quality))
    else
      local shardCfg = shardQCfg[size]
      if shardCfg == nil then
        error((string.format)("Cant get ath_shard, quality: %s, size: %s", quality, size))
      else
        for index,itemId in ipairs(shardCfg.shardIdList) do
          local itemNum = (shardCfg.shardNumList)[index]
          if shardItemDic[itemId] == 0 then
            (table.insert)(shardItemIdList, itemId)
          end
          shardItemDic[itemId] = shardItemDic[itemId] + itemNum
        end
        ;
        (table.insert)(curSelectedAthList, athData)
      end
    end
  end
  ;
  (table.sort)(curSelectedAthList, function(a, b)
    -- function num : 0_2_0
    do return (a.itemCfg).id < (b.itemCfg).id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local selectedNum = #curSelectedAthList
  local canDecompose = selectedNum > 0
  ;
  ((self.ui).empty):SetActive(not canDecompose)
  -- DECOMPILER ERROR at PC87: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).btn_Dismantle).interactable = canDecompose
  -- DECOMPILER ERROR at PC90: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).totalCount = selectedNum
  ;
  ((self.ui).scrollRect):RefillCells()
  ;
  (table.sort)(shardItemIdList)
  ;
  (self.shardItemPool):HideAll()
  for k,itemId in ipairs(shardItemIdList) do
    local itemCfg = (ConfigData.item)[itemId]
    if itemCfg == nil then
      error("Can`t find ItemCfg:ID = " .. tostring(itemId))
      return 
    end
    local num = shardItemDic[itemId]
    local item = (self.shardItemPool):GetOne()
    item:InitItemWithCount(itemCfg, num)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UINAthDecompose._OnClickAutoSelect = function(self)
  -- function num : 0_3 , upvalues : UINAthSortCondition, AthFilterEnum, _ENV
  do
    if self.siftCondition == nil then
      local SiftConditionPage = (UINAthSortCondition.New)()
      SiftConditionPage:Init((self.ui).sortConditionNode)
      SiftConditionPage:InitAthSortCondition(AthFilterEnum.eKindType, AthFilterEnum.eKindMaxCount, BindCallback(self, self.OnFilterConfirmAction))
      self.siftCondition = SiftConditionPage
    end
    ;
    (self.siftCondition):Show()
  end
end

UINAthDecompose.OnFilterConfirmAction = function(self, filtData)
  -- function num : 0_4
  self.filtData = filtData
  self:_OnAutoSelect()
end

UINAthDecompose._OnAutoSelect = function(self)
  -- function num : 0_5 , upvalues : _ENV, AthFilterEnum
  self.athSelectedDic = {}
  local tempList = (PlayerDataCenter.allAthData):GetAllAthList(nil, true)
  for k,athData in ipairs(tempList) do
    if not athData.lockUnlock then
      local athArea = athData:GetAthAreaType()
      local qualityConfig = (self.filtData)[(AthFilterEnum.eKindType).Area]
      if not qualityConfig.nocondition then
        local areaOk = (qualityConfig.selectIndexs)[athArea]
      end
      if areaOk then
        local athQualityId = athData:GetAthQuality()
        local qualityConfig = (self.filtData)[(AthFilterEnum.eKindType).Quality]
        if not qualityConfig.nocondition then
          local qualityOk = (qualityConfig.selectIndexs)[(AthFilterEnum.GetQualityIndex)(athQualityId)]
        end
        if qualityOk then
          local attrIdx = nil
          local attrId = athData:GetAthMainAttrId()
          for k,id in ipairs(AthFilterEnum.eAttribute) do
            if attrId == id then
              attrIdx = k
            end
          end
          local attrConfig = (self.filtData)[(AthFilterEnum.eKindType).Attribute]
          if not attrConfig.nocondition then
            local attrOk = (attrConfig.selectIndexs)[attrIdx]
          end
          if attrOk then
            local subAttrConfig = (self.filtData)[(AthFilterEnum.eKindType).SubAttribute]
            local subAttrOk = subAttrConfig.nocondition
            if not subAttrOk then
              local subAttrList = athData:GetAthSubAttrIdList()
              for k,subAttrId in ipairs(subAttrList) do
                local subAttrIdx = (AthFilterEnum.GetAttrIndex)(subAttrId)
                subAttrOk = (subAttrConfig.selectIndexs)[subAttrIdx]
              end
            end
            do
              do
                -- DECOMPILER ERROR at PC93: Confused about usage of register: R19 in 'UnsetPending'

                if subAttrOk or subAttrOk then
                  (self.athSelectedDic)[athData.uid] = true
                end
                -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      end
    end
  end
  ;
  (self.sortListNode):SetAthListMultSeletedUidDic(self.athSelectedDic)
  ;
  (self.sortListNode):RefillCurAthSortList()
  self:_RefreshSelectedList()
end

UINAthDecompose._OnClickDecompose = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.__OnDecomposeCompleteFunc == nil then
    self.__OnDecomposeCompleteFunc = BindCallback(self, self._OnDecomposeComplete)
  end
  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  ;
  (self.athNetwork):CS_ATH_OneKeyDeco(self.athSelectedDic, self.__OnDecomposeCompleteFunc)
end

UINAthDecompose._OnDecomposeComplete = function(self, objList)
  -- function num : 0_7 , upvalues : _ENV
  if objList.Count ~= 1 then
    error("objList.Count error:" .. tostring(objList.Count))
    return 
  end
  local resDic = objList[0]
  local rewardIds = {}
  local rewardNums = {}
  for id,num in pairs(resDic) do
    (table.insert)(rewardIds, id)
    ;
    (table.insert)(rewardNums, num)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_7_0 , upvalues : rewardIds, rewardNums, self
    if window == nil then
      return 
    end
    window:InitRewardsItem(rewardIds, rewardNums, self._heroIdSnapShoot)
  end
)
  self:_ResetDeco()
end

UINAthDecompose._ResetDeco = function(self)
  -- function num : 0_8
  self.athSelectedDic = {}
  self:_RefreshSelectedList()
end

UINAthDecompose._OnClickAthItem = function(self, athItem)
  -- function num : 0_9 , upvalues : cs_MessageCommon, _ENV
  local athData = athItem:GetAthItemData()
  if athData.lockUnlock then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Ath_CantSelectLockAth))
    return 
  end
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

  if (self.athSelectedDic)[athData.uid] == nil then
    (self.athSelectedDic)[athData.uid] = true
    athItem:SetAthItemSelect(true, true)
  else
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.athSelectedDic)[athData.uid] = nil
    athItem:SetAthItemSelect(false)
  end
  ;
  (self.sortListNode):SetAthListMultSeletedUidDic(self.athSelectedDic)
  self:_RefreshSelectedList()
end

UINAthDecompose.__OnNewItem = function(self, go)
  -- function num : 0_10 , upvalues : UINBaseItemWithCount
  local item = (UINBaseItemWithCount.New)()
  item:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.athItemGoDic)[go] = item
end

UINAthDecompose.__OnChangeItem = function(self, go, index)
  -- function num : 0_11 , upvalues : _ENV
  local item = (self.athItemGoDic)[go]
  if item == nil then
    error("Can\'t find item by gameObject")
    return 
  end
  local athData = (self.curSelectedAthList)[index + 1]
  if athData == nil then
    error("Can\'t find athData by index, index = " .. tonumber(index))
  end
  item:InitItemWithCount(athData.itemCfg, nil, function()
    -- function num : 0_11_0
  end
)
end

UINAthDecompose.OnDelete = function(self)
  -- function num : 0_12 , upvalues : base
  (self.shardItemPool):DeleteAll()
  if self.siftCondition ~= nil then
    (self.siftCondition):Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UINAthDecompose


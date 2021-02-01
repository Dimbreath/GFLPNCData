-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthDecompose = class("UIAthDecompose", UIBaseWindow)
local base = UIBaseWindow
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UINAthList = require("Game.Arithmetic.AthList.UINAthList")
local cs_MessageCommon = CS.MessageCommon
UIAthDecompose.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount, UINAthList
  (UIUtil.SetTopStatus)(self, self.Delete)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Cancel, self, self._OnClickCancel)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self._OnClickDecompose)
  self.__OnClickAthItemFunc = BindCallback(self, self._OnClickAthItem)
  self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
  ;
  ((self.ui).baseItemWithCount):SetActive(false)
  self.shardItemPool = (UIItemPool.New)(UINBaseItemWithCount, (self.ui).baseItemWithCount)
  self.athListNode = (UINAthList.New)()
  ;
  (self.athListNode):Init((self.ui).aTHListNode)
end

UIAthDecompose.InitAthDecompose = function(self, resLoader, closeFunc)
  -- function num : 0_1
  self.closeFunc = closeFunc
  self.athSelectedDic = {}
  ;
  ((self.athListNode).athListArea):SetAthListAreaMultSeletedUidDic(self.athSelectedDic)
  ;
  (self.athListNode):InitAthListNode(nil, resLoader, false, self.__OnClickAthItemFunc, nil, nil, nil, true)
  ;
  (self.athListNode):ShowAthListDecomposeBtn(false)
  self:_RefreshSelectedList()
end

UIAthDecompose._RefreshSelectedList = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local shardItemDic = (table.GetDefaulValueTable)(0)
  local shardItemIdList = {}
  local curSelectedAthList = {}
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
  local selectedNum = #curSelectedAthList
  local canDecompose = selectedNum > 0
  -- DECOMPILER ERROR at PC76: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).btn_Confirm).interactable = canDecompose
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

UIAthDecompose._OnClickDecompose = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.__OnDecomposeCompleteFunc == nil then
    self.__OnDecomposeCompleteFunc = BindCallback(self, self._OnDecomposeComplete)
  end
  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  ;
  (self.athNetwork):CS_ATH_OneKeyDeco(self.athSelectedDic, self.__OnDecomposeCompleteFunc)
end

UIAthDecompose._OnDecomposeComplete = function(self, objList)
  -- function num : 0_4 , upvalues : _ENV
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
    -- function num : 0_4_0 , upvalues : rewardIds, rewardNums, self
    if window == nil then
      return 
    end
    window:InitRewardsItem(rewardIds, rewardNums, self._heroIdSnapShoot)
  end
)
  self:_ResetDeco()
end

UIAthDecompose._ResetDeco = function(self)
  -- function num : 0_5
  self.athSelectedDic = {}
  ;
  ((self.athListNode).athListArea):SetAthListAreaMultSeletedUidDic(self.athSelectedDic)
  ;
  (self.athListNode):RefillCurAthSortList(true)
  self:_RefreshSelectedList()
end

UIAthDecompose._OnClickCancel = function(self)
  -- function num : 0_6
  self:_ResetDeco()
end

UIAthDecompose._OnClickAthItem = function(self, athItem)
  -- function num : 0_7 , upvalues : cs_MessageCommon, _ENV
  local athData = athItem:GetAthItemData()
  if athData.lockUnlock then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Ath_CantSelectLockAth))
    return 
  end
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

  if (self.athSelectedDic)[athData.uid] == nil then
    (self.athSelectedDic)[athData.uid] = true
    athItem:SetAthItemSelect(true, true)
    UIManager:ShowWindowAsync(UIWindowTypeID.AthItemDetailFloat, function(window)
    -- function num : 0_7_0 , upvalues : athData
    if window == nil then
      return 
    end
    window:InitAthDetailFloat(athData)
  end
)
  else
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.athSelectedDic)[athData.uid] = nil
    athItem:SetAthItemSelect(false)
  end
  ;
  ((self.athListNode).athListArea):SetAthListAreaMultSeletedUidDic(self.athSelectedDic)
  self:_RefreshSelectedList()
end

UIAthDecompose.OnDelete = function(self)
  -- function num : 0_8 , upvalues : _ENV, base
  if self.closeFunc ~= nil then
    (self.closeFunc)()
  end
  ;
  (self.shardItemPool):DeleteAll()
  UIManager:HideWindow(UIWindowTypeID.AthItemDetailFloat)
  ;
  (self.athListNode):Delete()
  ;
  (base.OnDelete)(self)
end

return UIAthDecompose


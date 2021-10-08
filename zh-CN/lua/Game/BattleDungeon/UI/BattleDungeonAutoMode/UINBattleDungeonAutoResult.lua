local UINBattleDungeonAutoResult = class("UINBattleDungeonAutoResult", UIBaseNode)
local base = UIBaseNode
local UICommonRewardItem = require("Game.CommonUI.Item.UICommonRewardItem")
local ItemData = require("Game.PlayerData.Item.ItemData")
UINBattleDungeonAutoResult.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnClickConfirm)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loopScrollRect).onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loopScrollRect).onChangeItem = BindCallback(self, self.__OnChangeItem)
end

UINBattleDungeonAutoResult.InitAutoResult = function(self, dungeonCfg, count, rewardDic, athDic, callback)
  -- function num : 0_1 , upvalues : _ENV
  self.callback = callback
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R6 in 'UnsetPending'

  if dungeonCfg ~= nil then
    ((self.ui).tex_DungeonName).text = (LanguageUtil.GetLocaleText)(dungeonCfg.name)
  else
    error("dungeonCfg is NIL")
  end
  ;
  ((self.ui).tex_Times):SetIndex(0, tostring(count))
  local itemDataList = {}
  for rewardId,rewardCount in pairs(rewardDic) do
    local itemCfg = (ConfigData.item)[rewardId]
    if itemCfg ~= nil and itemCfg.drop_type ~= 4 and itemCfg.type ~= eItemType.Arithmetic then
      (table.insert)(itemDataList, {id = rewardId, itemCfg = itemCfg, count = rewardCount})
    end
  end
  for uid,_ in pairs(athDic) do
    local athData = ((PlayerDataCenter.allAthData).athDic)[uid]
    if athData ~= nil then
      (table.insert)(itemDataList, {id = athData.id, count = 1, itemCfg = athData.itemCfg, isAth = true, athData = athData})
    end
  end
  ExplorationManager:RewardSort(itemDataList)
  self.itemDic = {}
  self.itemDataList = itemDataList
  -- DECOMPILER ERROR at PC85: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).loopScrollRect).totalCount = #self.itemDataList
  ;
  ((self.ui).loopScrollRect):RefillCells()
end

UINBattleDungeonAutoResult.__OnInstantiateItem = function(self, go)
  -- function num : 0_2 , upvalues : UICommonRewardItem
  local item = (UICommonRewardItem.New)()
  item:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.itemDic)[go] = item
end

UINBattleDungeonAutoResult.__OnChangeItem = function(self, go, index)
  -- function num : 0_3 , upvalues : _ENV
  local item = (self.itemDic)[go]
  if item == nil then
    error("UINBattleDungeonAutoResult error:Can\'t find item")
  end
  local data = (self.itemDataList)[index + 1]
  if data == nil then
    error("UINBattleDungeonAutoResult error:Can\'t find data")
  end
  item:InitCommonRewardItem(data.itemCfg, data.count, false, function()
    -- function num : 0_3_0 , upvalues : _ENV, self, index
    UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
      -- function num : 0_3_0_0 , upvalues : self, index
      if win ~= nil then
        win:InitListDetail(self.itemDataList, index + 1, true)
      end
    end
)
  end
)
end

UINBattleDungeonAutoResult.OnClickConfirm = function(self)
  -- function num : 0_4
  if self.callback == nil then
    return 
  end
  ;
  (self.callback)()
end

return UINBattleDungeonAutoResult


local UINBattleDungeonAutoResult = class("UINBattleDungeonAutoResult", UIBaseNode)
local base = UIBaseNode
local UICommonRewardItem = require("Game.CommonUI.Item.UICommonRewardItem")
local ItemData = require("Game.PlayerData.Item.ItemData")
UINBattleDungeonAutoResult.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UICommonRewardItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnClickConfirm)
  self.rewardPool = (UIItemPool.New)(UICommonRewardItem, (self.ui).itemNode)
  ;
  ((self.ui).itemNode):SetActive(false)
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
    do
      local itemCfg = (ConfigData.item)[rewardId]
      if itemCfg ~= nil and itemCfg.drop_type ~= 4 and itemCfg.type ~= eItemType.Arithmetic then
        do
          (table.insert)(itemDataList, {id = rewardId, itemCfg = itemCfg, count = rewardCount})
          -- DECOMPILER ERROR at PC48: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC48: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  for uid,_ in pairs(athDic) do
    local athData = ((PlayerDataCenter.allAthData).athDic)[uid]
    if athData ~= nil then
      (table.insert)(itemDataList, {id = athData.id, count = 1, itemCfg = athData.itemCfg, isAth = true, athData = athData})
    end
  end
  ExplorationManager:RewardSort(itemDataList)
  ;
  (self.rewardPool):HideAll()
  for index,itemData in ipairs(itemDataList) do
    if itemData.itemCfg ~= nil then
      local item = (self.rewardPool):GetOne(true)
      ;
      (item.transform):SetParent(((self.ui).itemParent).transform)
      item:InitCommonRewardItem(itemData.itemCfg, itemData.count, false, function()
    -- function num : 0_1_0 , upvalues : _ENV, itemDataList, index
    UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
      -- function num : 0_1_0_0 , upvalues : itemDataList, index
      if win ~= nil then
        win:InitListDetail(itemDataList, index, true)
      end
    end
)
  end
)
    end
  end
end

UINBattleDungeonAutoResult.OnClickConfirm = function(self)
  -- function num : 0_2
  if self.callback == nil then
    return 
  end
  ;
  (self.callback)()
end

return UINBattleDungeonAutoResult


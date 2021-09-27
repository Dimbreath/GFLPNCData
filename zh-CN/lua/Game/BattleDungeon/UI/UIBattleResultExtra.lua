local UIBattleResultExtra = class("UIBattleResultExtra", UIBaseWindow)
local base = UIBaseWindow
local UINBattleResultExtraItem = require("Game.BattleDungeon.UI.UINBattleResultExtraItem")
UIBattleResultExtra.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_background, self, self.OnCloseClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnCloseClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnCloseClicked)
  self.rewardItemDic = {}
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).rewardScroll).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).rewardScroll).onChangeItem = BindCallback(self, self.__OnChangeItem)
end

UIBattleResultExtra.InitBattleResultExtra = function(self, rewardDic)
  -- function num : 0_1 , upvalues : _ENV
  local ids = {}
  for id,num in pairs(rewardDic) do
    (table.insert)(ids, id)
  end
  ;
  (table.sort)(ids)
  self.__rewardDic = rewardDic
  self.__rewardIds = ids
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).rewardScroll).totalCount = #ids
  ;
  ((self.ui).rewardScroll):RefillCells()
end

UIBattleResultExtra.__OnNewItem = function(self, go)
  -- function num : 0_2 , upvalues : UINBattleResultExtraItem
  local rewardItem = (UINBattleResultExtraItem.New)()
  rewardItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.rewardItemDic)[go] = rewardItem
end

UIBattleResultExtra.__OnChangeItem = function(self, go, index)
  -- function num : 0_3 , upvalues : _ENV
  local rewardItem = (self.rewardItemDic)[go]
  if rewardItem == nil then
    error("Can\'t find rewardItem by gameObject")
    return 
  end
  local rewardId = (self.__rewardIds)[index + 1]
  if rewardId == nil then
    return 
  end
  local itemCfg = (ConfigData.item)[rewardId]
  local num = (self.__rewardDic)[rewardId]
  rewardItem:InitBattleExtraReward(itemCfg, num, nil)
end

UIBattleResultExtra.OnCloseClicked = function(self)
  -- function num : 0_4
  self:Delete()
end

UIBattleResultExtra.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UIBattleResultExtra


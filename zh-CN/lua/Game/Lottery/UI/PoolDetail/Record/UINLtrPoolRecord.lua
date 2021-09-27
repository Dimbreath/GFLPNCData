local UINLtrPoolRecord = class("UINLtrPoolRecord", UIBaseNode)
local base = UIBaseNode
local UINLtrPoolRecordItem = require("Game.Lottery.UI.PoolDetail.Record.UINLtrPoolRecordItem")
UINLtrPoolRecord.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.itemDic = {}
end

UINLtrPoolRecord.InitLtrPoolRecord = function(self, poolCfg)
  -- function num : 0_1 , upvalues : _ENV
  self.ltrRecords = (PlayerDataCenter.allLtrData).ltrRecords
  self.ltrSpecial = (PlayerDataCenter.allLtrData).ltrSpecial
  local num = (self.ltrSpecial)[poolCfg.pool_type] or 0
  local total = ((ConfigData.lottery_para).special_dic)[poolCfg.pool_type]
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_GachaCount).text = tostring(num) .. "/" .. tostring(total)
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_title).text = ConfigData:GetTipContent(316)
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).list_record).onInstantiateItem = BindCallback(self, self._OnInstantiateItem)
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).list_record).onChangeItem = BindCallback(self, self._OnChangeItem)
  local hasData = #self.ltrRecords > 0
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R5 in 'UnsetPending'

  if hasData then
    ((self.ui).list_record).totalCount = #self.ltrRecords
    ;
    ((self.ui).list_record):RefillCells()
  end
  ;
  ((self.ui).obj_listNode):SetActive(hasData)
  ;
  ((self.ui).obj_empty):SetActive(not hasData)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINLtrPoolRecord._OnInstantiateItem = function(self, go)
  -- function num : 0_2 , upvalues : UINLtrPoolRecordItem
  local item = (UINLtrPoolRecordItem.New)()
  item:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.itemDic)[go] = item
end

UINLtrPoolRecord._OnChangeItem = function(self, go, index)
  -- function num : 0_3
  local item = (self.itemDic)[go]
  local records = (self.ltrRecords)[index + 1]
  item:InitItem(records)
end

UINLtrPoolRecord.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINLtrPoolRecord


-- params : ...
-- function num : 0 , upvalues : _ENV
local DynChipSuitMgr = class("DynChipSuitMgr")
local DynChipSuit = require("Game.Exploration.Data.ChipSuit.DynChipSuit")
DynChipSuitMgr.ctor = function(self, dynplayer)
  -- function num : 0_0
  self.__chipSuitDic = {}
  self.__chipSuitList = {}
  self.__dynplayer = dynplayer
end

local ChipSuitSortFunc = function(suit1, suit2)
  -- function num : 0_1
  local c1 = suit1:GetChipSuitCount()
  local c2 = suit2:GetChipSuitCount()
  if c2 >= c1 then
    do return c1 == c2 end
    do return suit1.tagId < suit2.tagId end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

DynChipSuitMgr.UpdateAllChipSuit = function(self, chipList)
  -- function num : 0_2 , upvalues : _ENV, DynChipSuit, ChipSuitSortFunc
  for k,chipSuit in pairs(self.__chipSuitDic) do
    chipSuit:ClearChipSuitEffector(self.__dynplayer)
  end
  self.__chipSuitDic = {}
  self.__chipSuitList = {}
  local tagDic = {}
  for _,chipData in pairs(chipList) do
    local tags = chipData:GetChipFuncTag()
    for _,tagId in pairs(tags) do
      tagDic[tagId] = (tagDic[tagId] or 0) + 1
    end
  end
  for tagId,count in pairs(tagDic) do
    local chipSuit = (DynChipSuit.New)(tagId, count)
    chipSuit:UpdateChipSuitEffector(self.__dynplayer)
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self.__chipSuitDic)[tagId] = chipSuit
    ;
    (table.insert)(self.__chipSuitList, chipSuit)
  end
  ;
  (table.sort)(self.__chipSuitList, ChipSuitSortFunc)
  MsgCenter:Broadcast(eMsgEventId.OnEpChipSuitUpdate)
end

DynChipSuitMgr.UpdateChipSuitDiff = function(self, chipDel, chipAdd)
  -- function num : 0_3 , upvalues : _ENV, DynChipSuit, ChipSuitSortFunc
  local updateTag = {}
  for chipId,_ in pairs(chipDel) do
    local chipCfg = (ConfigData.chip)[chipId]
    for _,tagId in pairs(chipCfg.fun_tag) do
      local chipSuit = (self.__chipSuitDic)[tagId]
      chipSuit:AddChipSuitCount(-1)
      updateTag[tagId] = true
    end
  end
  for chipId,_ in pairs(chipAdd) do
    local chipCfg = (ConfigData.chip)[chipId]
    for _,tagId in pairs(chipCfg.fun_tag) do
      local chipSuit = (self.__chipSuitDic)[tagId]
      if chipSuit == nil then
        chipSuit = (DynChipSuit.New)(tagId, 1)
        -- DECOMPILER ERROR at PC43: Confused about usage of register: R16 in 'UnsetPending'

        ;
        (self.__chipSuitDic)[tagId] = chipSuit
      else
        chipSuit:AddChipSuitCount(1)
      end
      updateTag[tagId] = true
    end
  end
  for tagId,_ in pairs(updateTag) do
    local chipSuit = (self.__chipSuitDic)[tagId]
    if chipSuit:GetChipSuitCount() > 0 then
      chipSuit:UpdateChipSuitEffector(self.__dynplayer)
    else
      chipSuit:ClearChipSuitEffector(self.__dynplayer)
      -- DECOMPILER ERROR at PC71: Confused about usage of register: R10 in 'UnsetPending'

      ;
      (self.__chipSuitDic)[tagId] = nil
    end
  end
  do
    while #self.__chipSuitList > 0 do
      (table.remove)(self.__chipSuitList)
    end
    for tagId,chipSuit in pairs(self.__chipSuitDic) do
      (table.insert)(self.__chipSuitList, chipSuit)
    end
    ;
    (table.sort)(self.__chipSuitList, ChipSuitSortFunc)
    MsgCenter:Broadcast(eMsgEventId.OnEpChipSuitUpdate)
  end
end

DynChipSuitMgr.ExecuteAllSuitChipForList = function(self, heroList)
  -- function num : 0_4 , upvalues : _ENV
  for k,chipSuit in pairs(self.__chipSuitDic) do
    chipSuit:ExecuteSuitChipForList(heroList)
  end
end

DynChipSuitMgr.GetChipSuitListData = function(self)
  -- function num : 0_5
  return self.__chipSuitList
end

DynChipSuitMgr.GetChipTagIdCount = function(self, tagId)
  -- function num : 0_6 , upvalues : _ENV
  local chipSuit = (self.__chipSuitDic)[tagId]
  if chipSuit ~= nil then
    return chipSuit:GetChipSuitCount(), chipSuit:GetChipSuitMaxCount()
  end
  local chipTagCfg = (ConfigData.chip_tag)[tagId]
  return 0, chipTagCfg.chip_max_count
end

return DynChipSuitMgr


-- params : ...
-- function num : 0 , upvalues : _ENV
local UINSiftCondition = class("UINSiftCondition", UIBaseNode)
local base = UIBaseNode
local UINSortKindItem = require("Game.Hero.NewUI.SortList.UINSortKindItem")
local HeroFilterEnum = require("Game.Hero.NewUI.HeroFilterEnum")
UINSiftCondition.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.__OnConfirmClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Reset, self, self.__OnResetClick)
  self.sortKindData = {}
  ;
  ((self.ui).obj_labelItem):SetActive(false)
  ;
  ((self.ui).obj_kindItem):SetActive(false)
end

UINSiftCondition.InitSiftCondition = function(self, eKindType, eKindMaxCount, onConfirmAction, itemSelectFunc)
  -- function num : 0_1 , upvalues : _ENV, HeroFilterEnum, UINSortKindItem
  self.eKindType = eKindType
  self.eKindMaxCount = eKindMaxCount
  self.onConfirmAction = onConfirmAction
  local orderedTypes = {}
  for key,index in pairs(eKindType) do
    orderedTypes[index] = key
  end
  for index,key in ipairs(orderedTypes) do
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R11 in 'UnsetPending'

    (self.sortKindData)[index] = {}
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R11 in 'UnsetPending'

    ;
    ((self.sortKindData)[index]).kindItems = {}
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R11 in 'UnsetPending'

    ;
    ((self.sortKindData)[index]).selectIndexs = {}
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R11 in 'UnsetPending'

    ;
    ((self.sortKindData)[index]).nocondition = true
    local parentGo = ((self.ui).obj_labelItem):Instantiate()
    local tileName = parentGo:FindComponent("Tex_Type", eUnityComponentID.TextItemInfo)
    tileName:SetIndex(index)
    parentGo:SetActive(true)
    local temp = 0
    for i = 1, eKindMaxCount[index] do
      -- DECOMPILER ERROR at PC60: Unhandled construct in 'MakeBoolean' P1

      if index == (HeroFilterEnum.eKindType).Rank and i % 2 == 0 then
        temp = (math.ceil)(i / 2)
        temp = i
        local go = ((self.ui).obj_kindItem):Instantiate(parentGo.transform)
        go:SetActive(true)
        local kindItem = (UINSortKindItem.New)()
        kindItem:Init(go.transform)
        kindItem:InitSortKindItem(index, temp, itemSelectFunc)
        ;
        (table.insert)(((self.sortKindData)[index]).kindItems, kindItem)
      end
    end
  end
end

UINSiftCondition.__OnConfirmClick = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local selectCount = 0
  for k,v in pairs(self.eKindType) do
    local noCondition = true
    for i = 1, (self.eKindMaxCount)[v] do
      local kindItem = (((self.sortKindData)[v]).kindItems)[i]
      if kindItem ~= nil then
        local isSelect = kindItem.select
        if isSelect then
          noCondition = false
          selectCount = selectCount + 1
        end
        -- DECOMPILER ERROR at PC25: Confused about usage of register: R14 in 'UnsetPending'

        ;
        (((self.sortKindData)[v]).selectIndexs)[i] = isSelect
      end
    end
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.sortKindData)[v]).nocondition = noCondition
  end
  if self.onConfirmAction ~= nil then
    (self.onConfirmAction)(self.sortKindData)
  end
  self:Hide()
end

UINSiftCondition.__OnResetClick = function(self)
  -- function num : 0_3 , upvalues : _ENV
  for k,v in pairs(self.eKindType) do
    for i = 1, (self.eKindMaxCount)[v] do
      local kindItem = (((self.sortKindData)[v]).kindItems)[i]
      if kindItem ~= nil then
        kindItem.select = false
        kindItem:SetSelectUIActive()
        -- DECOMPILER ERROR at PC21: Confused about usage of register: R11 in 'UnsetPending'

        ;
        (((self.sortKindData)[v]).selectIndexs)[i] = false
      end
    end
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.sortKindData)[v]).nocondition = true
  end
end

UINSiftCondition.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINSiftCondition


-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthSortCondition = class("UINAthSortCondition", UIBaseNode)
local base = UIBaseNode
local UINAthSortKindItem = require("Game.Arithmetic.AthSortList.SortCondition.UINAthSortKindItem")
local AthFilterEnum = require("Game.Arithmetic.AthSortList.AthFilterEnum")
UINAthSortCondition.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.__OnConfirmClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Reset, self, self.__OnResetClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.__OnClickClose)
  self.sortKindData = {}
  ;
  ((self.ui).obj_labelItem):SetActive(false)
  ;
  ((self.ui).obj_kindItem):SetActive(false)
end

UINAthSortCondition.InitAthSortCondition = function(self, eKindType, eKindMaxCount, onConfirmAction, hideTypeDic)
  -- function num : 0_1 , upvalues : _ENV, UINAthSortKindItem
  self.eKindType = eKindType
  self.eKindMaxCount = eKindMaxCount
  self.onConfirmAction = onConfirmAction
  local itemSelectFunc = nil
  local orderedTypes = {}
  for key,index in pairs(eKindType) do
    orderedTypes[index] = key
  end
  for index,_ in ipairs(orderedTypes) do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R12 in 'UnsetPending'

    (self.sortKindData)[index] = {}
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R12 in 'UnsetPending'

    ;
    ((self.sortKindData)[index]).kindItems = {}
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R12 in 'UnsetPending'

    ;
    ((self.sortKindData)[index]).selectIndexs = {}
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R12 in 'UnsetPending'

    ;
    ((self.sortKindData)[index]).nocondition = true
    local parentGo = ((self.ui).obj_labelItem):Instantiate()
    local tileName = parentGo:FindComponent("Tex_Type", eUnityComponentID.TextItemInfo)
    tileName:SetIndex(index)
    if hideTypeDic == nil or hideTypeDic[index] == nil then
      parentGo:SetActive(true)
    else
      parentGo:SetActive(false)
    end
    for i = 1, eKindMaxCount[index] do
      local go = ((self.ui).obj_kindItem):Instantiate(parentGo.transform)
      go:SetActive(true)
      local kindItem = (UINAthSortKindItem.New)()
      kindItem:Init(go.transform)
      kindItem:InitAthSortKindItem(index, i, itemSelectFunc, eKindType)
      ;
      (table.insert)(((self.sortKindData)[index]).kindItems, kindItem)
    end
  end
end

UINAthSortCondition.__OnConfirmClick = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local selectCount = 0
  for k,v in pairs(self.eKindType) do
    local noCondition = true
    for i = 1, (self.eKindMaxCount)[v] do
      local kindItem = (((self.sortKindData)[v]).kindItems)[i]
      local isSelect = kindItem.select
      if isSelect then
        noCondition = false
        selectCount = selectCount + 1
      end
      -- DECOMPILER ERROR at PC23: Confused about usage of register: R14 in 'UnsetPending'

      ;
      (((self.sortKindData)[v]).selectIndexs)[i] = isSelect
    end
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.sortKindData)[v]).nocondition = noCondition
  end
  if self.onConfirmAction ~= nil then
    (self.onConfirmAction)(self.sortKindData)
  end
  self:Hide()
end

UINAthSortCondition.__OnResetClick = function(self)
  -- function num : 0_3 , upvalues : _ENV
  for k,v in pairs(self.eKindType) do
    for i = 1, (self.eKindMaxCount)[v] do
      local kindItem = (((self.sortKindData)[v]).kindItems)[i]
      kindItem.select = false
      kindItem:SetSelectUIActive()
      -- DECOMPILER ERROR at PC19: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (((self.sortKindData)[v]).selectIndexs)[i] = false
    end
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.sortKindData)[v]).nocondition = true
  end
end

UINAthSortCondition.__OnClickClose = function(self)
  -- function num : 0_4
  self:Hide()
end

UINAthSortCondition.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthSortCondition

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthSortCondition = class("UINAthSortCondition", UIBaseNode)
local base = UIBaseNode
local UINAthSortKindItem = require(
                               "Game.Arithmetic.AthSortList.SortCondition.UINAthSortKindItem")
local AthFilterEnum = require("Game.Arithmetic.AthSortList.AthFilterEnum")
UINAthSortCondition.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self,
                               self.__OnConfirmClick);
    (UIUtil.AddButtonListener)((self.ui).btn_Reset, self, self.__OnResetClick);
    (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.__OnClickClose)
    self.sortKindData = {};
    ((self.ui).obj_labelItem):SetActive(false);
    ((self.ui).obj_kindItem):SetActive(false)
end

UINAthSortCondition.InitAthSortCondition =
    function(self, eKindType, eKindMaxCount, onConfirmAction, hideTypeDic)
        -- function num : 0_1 , upvalues : _ENV, UINAthSortKindItem
        self.eKindType = eKindType
        self.eKindMaxCount = eKindMaxCount
        self.onConfirmAction = onConfirmAction
        local itemSelectFunc = nil
        local orderedTypes = {}
        for key, index in pairs(eKindType) do orderedTypes[index] = key end
        for index, _ in ipairs(orderedTypes) do
            -- DECOMPILER ERROR at PC18: Confused about usage of register: R12 in 'UnsetPending'

            (self.sortKindData)[index] = {} -- DECOMPILER ERROR at PC22: Confused about usage of register: R12 in 'UnsetPending'
            ;
            ((self.sortKindData)[index]).kindItems = {} -- DECOMPILER ERROR at PC26: Confused about usage of register: R12 in 'UnsetPending'
            ;
            ((self.sortKindData)[index]).selectIndexs = {} -- DECOMPILER ERROR at PC29: Confused about usage of register: R12 in 'UnsetPending'
            ;
            ((self.sortKindData)[index]).nocondition = true
            local parentGo = ((self.ui).obj_labelItem):Instantiate()
            local tileName = parentGo:FindComponent("Tex_Type",
                                                    eUnityComponentID.TextItemInfo)
            tileName:SetIndex(index)
            if hideTypeDic == nil or hideTypeDic[index] == nil then
                parentGo:SetActive(true)
            else
                parentGo:SetActive(false)
            end
            for i = 1, eKindMaxCount[index] do
                local go = ((self.ui).obj_kindItem):Instantiate(
                               parentGo.transform)
                go:SetActive(true)
                local kindItem = (UINAthSortKindItem.New)()
                kindItem:Init(go.transform)
                kindItem:InitAthSortKindItem(index, i, itemSelectFunc, eKindType);
                (table.insert)(((self.sortKindData)[index]).kindItems, kindItem)
            end
        end
    end

UINAthSortCondition.__OnConfirmClick = function(self)
    -- function num : 0_2 , upvalues : _ENV
    local selectCount = 0
    for k, v in pairs(self.eKindType) do
        local noCondition = true
        for i = 1, (self.eKindMaxCount)[v] do
            local kindItem = (((self.sortKindData)[v]).kindItems)[i]
            local isSelect = kindItem.select
            if isSelect then
                noCondition = false
                selectCount = selectCount + 1
            end -- DECOMPILER ERROR at PC23: Confused about usage of register: R14 in 'UnsetPending'
            
            (((self.sortKindData)[v]).selectIndexs)[i] = isSelect
        end -- DECOMPILER ERROR at PC27: Confused about usage of register: R8 in 'UnsetPending'
        
        ((self.sortKindData)[v]).nocondition = noCondition
    end
    if self.onConfirmAction ~= nil then
        (self.onConfirmAction)(self.sortKindData)
    end
    self:Hide()
end

UINAthSortCondition.__OnResetClick = function(self)
    -- function num : 0_3 , upvalues : _ENV
    for k, v in pairs(self.eKindType) do
        for i = 1, (self.eKindMaxCount)[v] do
            local kindItem = (((self.sortKindData)[v]).kindItems)[i]
            kindItem.select = false
            kindItem:SetSelectUIActive() -- DECOMPILER ERROR at PC19: Confused about usage of register: R11 in 'UnsetPending'
            ;
            (((self.sortKindData)[v]).selectIndexs)[i] = false
        end -- DECOMPILER ERROR at PC23: Confused about usage of register: R6 in 'UnsetPending'
        
        ((self.sortKindData)[v]).nocondition = true
    end
end

UINAthSortCondition.__OnClickClose = function(self)
    -- function num : 0_4
    self:Hide()
end

UINAthSortCondition.OnDelete = function(self)
    -- function num : 0_5 , upvalues : base
    (base.OnDelete)(self)
end

return UINAthSortCondition


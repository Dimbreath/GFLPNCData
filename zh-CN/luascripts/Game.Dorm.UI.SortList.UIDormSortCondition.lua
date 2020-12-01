-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDormSortCondition = class("UIDormSortCondition", UIBaseNode)
local eSortKindType, eSortKindTypeMax = (table.unpack)(require("Game.Dorm.UI.SortList.DormSortKindHelper"))
local UIDormSortKindItem = require("Game.Dorm.UI.SortList.UIDormSortKindItem")
UIDormSortCondition.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_sift, self, self.OnShowSiftClick)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_direction, self, self.__RefreshAscendBtn)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_siftConfirm, self, self.OnSiftConfirmClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_siftReset, self, self.OnSiftResetClick)
  ;
  ((self.ui).fliterItem):SetActive(false)
  ;
  ((self.ui).kindItem):SetActive(false)
  self:__InitDormSortKindItem()
  self:__InitDormSortMannerData()
end

UIDormSortCondition.InitDormSortCondition = function(self, onSortSwiteAction)
  -- function num : 0_1
  ((self.ui).furnitureNode):SetActive(false)
  ;
  ((self.ui).siftNode):SetActive(false)
  ;
  ((self.ui).sortNode):SetActive(false)
  self:__RefreshAscendBtn(false)
  self.onSortSwiteAction = onSortSwiteAction
end

UIDormSortCondition.__InitDormSortKindItem = function(self)
  -- function num : 0_2 , upvalues : eSortKindType, _ENV, eSortKindTypeMax, UIDormSortKindItem
  self.sortKindData = {
[eSortKindType.Star] = {
kindItem = {}
, 
selectIndex = {}
, nocondition = true}
, 
[eSortKindType.KindType] = {
kindItem = {}
, 
selectIndex = {}
, nocondition = true}
, 
[eSortKindType.Interact] = {
kindItem = {}
, 
selectIndex = {}
, nocondition = true}
, 
[eSortKindType.Binding] = {
kindItem = {}
, 
selectIndex = {}
, nocondition = true}
}
  local selectFunc = (BindCallback((self.self).__OnSortKindItemClick))
  local go, child = nil, nil
  local count = 0
  local kindItem = nil
  for k,value in pairs(eSortKindType) do
    go = ((self.ui).fliterItem):Instantiate()
    go:SetActive(true)
    local tileName = go:FindComponent("Tex_FliterName", eUnityComponentID.TextItemInfo)
    tileName:SetIndex(value)
    for i = 1, eSortKindTypeMax[value] do
      child = ((self.ui).kindItem):Instantiate(go)
      child:SetActive(true)
      kindItem = (UIDormSortKindItem.New)()
      kindItem:Init(child.transform)
      kindItem:InitDormSortKindItem(value, i, selectFunc)
      ;
      (table.insert)(((self.sortKindData)[value]).kindItem, kindItem)
    end
  end
end

UIDormSortCondition.__InitDormSortMannerData = function(self)
  -- function num : 0_3
  self.sortMannerData = {AscendFun = function(a, b)
    -- function num : 0_3_0
    do return a.comfort < b.comfort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
, DeclineFun = function(a, b)
    -- function num : 0_3_1
    do return a.comfort < b.comfort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
}
end

UIDormSortCondition.__RefreshAscendBtn = function(self, value)
  -- function num : 0_4
  ((self.ui).img_Up):SetActive(not value)
  ;
  ((self.ui).img_Down):SetActive(value)
  self.isAscend = value
  if value or not (self.sortMannerData).AscendFun then
    self.curFuncSort = (self.sortMannerData).DeclineFun
    if self.onSortSwiteAction ~= nil then
      (self.onSortSwiteAction)(self.curFuncSort, self.__FuncSift)
    end
  end
end

UIDormSortCondition.OnShowSiftClick = function(self)
  -- function num : 0_5
  local activeSelf = ((self.ui).furnitureNode).activeSelf
  ;
  ((self.ui).siftNode):SetActive(not activeSelf)
  if activeSelf then
    self:OnSiftConfirmClick()
  end
end

UIDormSortCondition.OnSiftConfirmClick = function(self)
  -- function num : 0_6 , upvalues : _ENV, eSortKindType, eSortKindTypeMax
  for k,value in pairs(eSortKindType) do
    local sortKindData = (self.sortKindData)[value]
    for k,item in ipairs((eSortKindTypeMax[value]).kindItem) do
      local isSelect = item.isSelect
      -- DECOMPILER ERROR at PC15: Confused about usage of register: R13 in 'UnsetPending'

      if isSelect then
        (sortKindData.selectIndex)[k] = isSelect
      end
    end
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R7 in 'UnsetPending'

    if (table.count)(sortKindData.selectIndex) > 0 then
      (sortKindData[value]).nocondition = false
    end
  end
  if self.onSortSwiteAction ~= nil then
    (self.onSortSwiteAction)(self.curFuncSort, self.__FuncSift)
  end
end

UIDormSortCondition.__FuncSift = function(self, dormData)
  -- function num : 0_7 , upvalues : eSortKindType, eSortKindTypeMax
  local starCfg = (self.sortKindData)[eSortKindType.Star]
  if not starCfg.nocondition then
    local starOk = (starCfg.selectIndexs)[dormData.star]
  end
  local typeCfg = eSortKindTypeMax[eSortKindType.KindType]
  if not typeCfg.nocondition then
    local typeOk = (typeCfg.selectIndexs)[dormData.type]
  end
  local interactCfg = eSortKindTypeMax[eSortKindType.Interact]
  if not interactCfg.nocondition then
    local interactOk = (interactCfg.selectIndexs)[dormData.interact]
  end
  local bindCfg = eSortKindTypeMax[eSortKindType.Binding]
  if not bindCfg.nocondition then
    local bindOk = (bindCfg.selectIndexs)[dormData.binding]
  end
  if starOk and typeOk and interactOk and bindOk then
    return true
  else
    return false
  end
end

UIDormSortCondition.OnSiftResetClick = function(self)
  -- function num : 0_8 , upvalues : _ENV, eSortKindType, eSortKindTypeMax
  for k,value in pairs(eSortKindType) do
    local sortKindData = (self.sortKindData)[value]
    for k,item in ipairs((eSortKindTypeMax[value]).kindItem) do
      -- DECOMPILER ERROR at PC15: Confused about usage of register: R12 in 'UnsetPending'

      if item.isSelect then
        (sortKindData.selectIndex)[k] = nil
        item.isSelect = false
      end
    end
    sortKindData.nocondition = true
  end
  if self.onSortSwiteAction ~= nil then
    (self.onSortSwiteAction)(self.curFuncSort, self.__FuncSift)
  end
end

UIDormSortCondition.RefreshFurnitureCount = function(self, num, total)
  -- function num : 0_9 , upvalues : _ENV
  ((self.ui).furnitureNode):SetActive(true)
  ;
  ((self.ui).tex_FurnitureNum):SetIndex(0, tostring(num), tostring(total))
end

UIDormSortCondition.OnDelete = function(self)
  -- function num : 0_10
end


-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDormSortCondition = class("UIDormSortCondition", UIBaseNode)
local eSortKindType, eSortKindTypeMax = (table.unpack)(
                                            require(
                                                "Game.Dorm.UI.SortList.DormSortKindHelper"))
local UIDormSortKindItem = require("Game.Dorm.UI.SortList.UIDormSortKindItem")
UIDormSortCondition.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_sift, self, self.OnShowSiftClick);
    (UIUtil.AddValueChangedListener)((self.ui).tog_direction, self,
                                     self.__RefreshAscendBtn);
    (UIUtil.AddButtonListener)((self.ui).btn_siftConfirm, self,
                               self.OnSiftConfirmClick);
    (UIUtil.AddButtonListener)((self.ui).btn_siftReset, self,
                               self.OnSiftResetClick);
    ((self.ui).fliterItem):SetActive(false);
    ((self.ui).kindItem):SetActive(false)
    self:__InitDormSortKindItem()
    self:__InitDormSortMannerData()
end

UIDormSortCondition.InitDormSortCondition =
    function(self, onSortSwiteAction)
        -- function num : 0_1
        ((self.ui).furnitureNode):SetActive(false);
        ((self.ui).siftNode):SetActive(false);
        ((self.ui).sortNode):SetActive(false)
        self:__RefreshAscendBtn(false)
        self.onSortSwiteAction = onSortSwiteAction
    end

UIDormSortCondition.__InitDormSortKindItem =
    function(self)
        -- function num : 0_2 , upvalues : eSortKindType, _ENV, eSortKindTypeMax, UIDormSortKindItem
        self.sortKindData = {
            [eSortKindType.Star] = {
                kindItem = {},
                selectIndex = {},
                nocondition = true
            },
            [eSortKindType.KindType] = {
                kindItem = {},
                selectIndex = {},
                nocondition = true
            },
            [eSortKindType.Interact] = {
                kindItem = {},
                selectIndex = {},
                nocondition = true
            },
            [eSortKindType.Binding] = {
                kindItem = {},
                selectIndex = {},
                nocondition = true
            }
        }
        local selectFunc = (BindCallback((self.self).__OnSortKindItemClick))
        local go, child = nil, nil
        local count = 0
        local kindItem = nil
        for k, value in pairs(eSortKindType) do
            go = ((self.ui).fliterItem):Instantiate()
            go:SetActive(true)
            local tileName = go:FindComponent("Tex_FliterName",
                                              eUnityComponentID.TextItemInfo)
            tileName:SetIndex(value)
            for i = 1, eSortKindTypeMax[value] do
                child = ((self.ui).kindItem):Instantiate(go)
                child:SetActive(true)
                kindItem = (UIDormSortKindItem.New)()
                kindItem:Init(child.transform)
                kindItem:InitDormSortKindItem(value, i, selectFunc);
                (table.insert)(((self.sortKindData)[value]).kindItem, kindItem)
            end
        end
    end

UIDormSortCondition.__InitDormSortMannerData =
    function(self)
        -- function num : 0_3
        self.sortMannerData = {
            AscendFun = function(a, b)
                -- function num : 0_3_0
                do return a.comfort < b.comfort end
                -- DECOMPILER ERROR: 1 unprocessed JMP targets
            end,
            DeclineFun = function(a, b)
                -- function num : 0_3_1
                do return a.comfort < b.comfort end
                -- DECOMPILER ERROR: 1 unprocessed JMP targets
            end
        }
    end

UIDormSortCondition.__RefreshAscendBtn =
    function(self, value)
        -- function num : 0_4
        ((self.ui).img_Up):SetActive(not value);
        ((self.ui).img_Down):SetActive(value)
        self.isAscend = value
        if value or not (self.sortMannerData).AscendFun then
            self.curFuncSort = (self.sortMannerData).DeclineFun
            if self.onSortSwiteAction ~= nil then
                (self.onSortSwiteAction)(self.curFuncSort, self.__FuncSift)
            end
        end
    end

UIDormSortCondition.OnShowSiftClick = function(self)
    -- function num : 0_5
    local activeSelf = ((self.ui).furnitureNode).activeSelf;
    ((self.ui).siftNode):SetActive(not activeSelf)
    if activeSelf then self:OnSiftConfirmClick() end
end

UIDormSortCondition.OnSiftConfirmClick =
    function(self)
        -- function num : 0_6 , upvalues : _ENV, eSortKindType, eSortKindTypeMax
        for k, value in pairs(eSortKindType) do
            local sortKindData = (self.sortKindData)[value]
            for k, item in ipairs((eSortKindTypeMax[value]).kindItem) do
                local isSelect = item.isSelect
                -- DECOMPILER ERROR at PC15: Confused about usage of register: R13 in 'UnsetPending'

                if isSelect then
                    (sortKindData.selectIndex)[k] = isSelect
                end
            end
            -- DECOMPILER ERROR at PC25: Confused about usage of register: R7 in 'UnsetPending'

            if (table.count)(sortKindData.selectIndex) > 0 then
                (sortKindData[value]).nocondition = false
            end
        end
        if self.onSortSwiteAction ~= nil then
            (self.onSortSwiteAction)(self.curFuncSort, self.__FuncSift)
        end
    end

UIDormSortCondition.__FuncSift = function(self, dormData)
    -- function num : 0_7 , upvalues : eSortKindType, eSortKindTypeMax
    local starCfg = (self.sortKindData)[eSortKindType.Star]
    if not starCfg.nocondition then
        local starOk = (starCfg.selectIndexs)[dormData.star]
    end
    local typeCfg = eSortKindTypeMax[eSortKindType.KindType]
    if not typeCfg.nocondition then
        local typeOk = (typeCfg.selectIndexs)[dormData.type]
    end
    local interactCfg = eSortKindTypeMax[eSortKindType.Interact]
    if not interactCfg.nocondition then
        local interactOk = (interactCfg.selectIndexs)[dormData.interact]
    end
    local bindCfg = eSortKindTypeMax[eSortKindType.Binding]
    if not bindCfg.nocondition then
        local bindOk = (bindCfg.selectIndexs)[dormData.binding]
    end
    if starOk and typeOk and interactOk and bindOk then
        return true
    else
        return false
    end
end

UIDormSortCondition.OnSiftResetClick = function(self)
    -- function num : 0_8 , upvalues : _ENV, eSortKindType, eSortKindTypeMax
    for k, value in pairs(eSortKindType) do
        local sortKindData = (self.sortKindData)[value]
        for k, item in ipairs((eSortKindTypeMax[value]).kindItem) do
            -- DECOMPILER ERROR at PC15: Confused about usage of register: R12 in 'UnsetPending'

            if item.isSelect then
                (sortKindData.selectIndex)[k] = nil
                item.isSelect = false
            end
        end
        sortKindData.nocondition = true
    end
    if self.onSortSwiteAction ~= nil then
        (self.onSortSwiteAction)(self.curFuncSort, self.__FuncSift)
    end
end

UIDormSortCondition.RefreshFurnitureCount =
    function(self, num, total)
        -- function num : 0_9 , upvalues : _ENV
        ((self.ui).furnitureNode):SetActive(true);
        ((self.ui).tex_FurnitureNum):SetIndex(0, tostring(num), tostring(total))
    end

UIDormSortCondition.OnDelete = function(self)
    -- function num : 0_10
end


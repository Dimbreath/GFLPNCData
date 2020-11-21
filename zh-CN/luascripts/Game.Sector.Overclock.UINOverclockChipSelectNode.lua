-- params : ...
-- function num : 0 , upvalues : _ENV
local UINOverclockChipSelectNode = class("UINOverclockChipSelectNode",
                                         UIBaseNode)
local base = UIBaseNode
local ChipData = require("Game.PlayerData.Item.ChipData")
local UINOverclockChipLableItem = require(
                                      "Game.Sector.Overclock.UINOverclockChipLableItem")
local UINFloatUINode = require("Game.CommonUI.FloatWin.UINFloatUINode")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
UINOverclockChipSelectNode.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINFloatUINode, UINOverclockChipLableItem
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self:Hide()
    self.OverclockCtrl = ControllerManager:GetController(
                             ControllerTypeId.Overclock, false)
    self.chipDetailNode = (UINFloatUINode.New)();
    (self.chipDetailNode):Init((self.ui).obj_popUpWindow)
    self.chipLablePool = (UIItemPool.New)(UINOverclockChipLableItem,
                                          (self.ui).obj_sortLabelItem);
    ((self.ui).obj_sortLabelItem):SetActive(false);
    (((self.ui).trs_chipDetail).gameObject):SetActive(false);
    (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnClickConfirm);
    (UIUtil.AddButtonListener)((self.ui).btn_Cancel, self, self.OnClickCancel);
    (UIUtil.AddButtonListener)((self.ui).btn_closeChipDetail, self,
                               self.HideChipDetail)
    self.__HideChipDetailWittScroll = BindCallback(self,
                                                   self.HideChipDetailWittScroll);
    (((self.ui).scrollList).onValueChanged):AddListener(
        self.__HideChipDetailWittScroll)
    self.selectedChipItem = nil
    self.chipItemDic = {}
end

UINOverclockChipSelectNode.InitChipSelectNode =
    function(self, overclockId, overclockNode)
        -- function num : 0_1
        self.overclockId = overclockId
        self.overclockNode = overclockNode
        self:RefreshChips((self.OverclockCtrl).chipDic)
        self:__ReopenSelect()
    end

UINOverclockChipSelectNode.__ReopenSelect =
    function(self)
        -- function num : 0_2
        local chipId = (self.OverclockCtrl):GetChip2OverClockOption(
                           self.overclockId)
        -- DECOMPILER ERROR at PC12: Unhandled construct in 'MakeBoolean' P1

        if chipId == nil and self.selectedChipItem ~= nil then
            self:SelectedChipItem(self.selectedChipItem, nil)
            return
        end
        local chipItem = (self.chipItemDic)[chipId]
        self:SelectedChipItem(chipItem, nil, true)
    end

UINOverclockChipSelectNode.RefreshChips =
    function(self, chipDic)
        -- function num : 0_3 , upvalues : _ENV
        local lableList = self:ChipDataClassify(chipDic);
        (self.chipLablePool):HideAll()
        self.chipItemDic = {};
        (table.walksort)(lableList, function(lkey, rkey)
            -- function num : 0_3_0
            do return rkey < lkey end
            -- DECOMPILER ERROR: 1 unprocessed JMP targets
        end, function(quality, chipList)
            -- function num : 0_3_1 , upvalues : self, _ENV
            if #chipList > 0 then
                local item = (self.chipLablePool):GetOne(true)
                local lableChipItemDic =
                    item:InitLable(quality, chipList,
                                   BindCallback(self, self.SelectedChipItem));
                (table.merge)(self.chipItemDic, lableChipItemDic)
            end
        end)
    end

UINOverclockChipSelectNode.SelectedChipItem =
    function(self, chipItem, transform, bool)
        -- function num : 0_4
        if not bool then local selectBool = not chipItem.isSelected end
        chipItem:SetSelect(selectBool)
        if selectBool then
            ((self.ui).scrollList):StopMovement()
            if self.selectedChipItem ~= nil and self.selectedChipItem ~=
                chipItem then
                (self.selectedChipItem):SetSelect(false)
                self.selectedChipItem = nil
            end
            self.selectedChipItem = chipItem
            if transform ~= nil then
                self:ShowChipDetail(chipItem, transform)
            end
        else
            self.selectedChipItem = nil
            self:HideChipDetail()
        end
    end

UINOverclockChipSelectNode.ChipDataClassify =
    function(self, chipDic)
        -- function num : 0_5 , upvalues : _ENV, ChipData
        local lableList = {}
        lableList[eItemQualityType.Orange] = {}
        lableList[eItemQualityType.Purple] = {}
        for chipId, _ in pairs(chipDic) do
            local chipData = (ChipData.New)(chipId)
            for quality, chipList in pairs(lableList) do
                if chipData.quality == quality then
                    (table.insert)(chipList, chipData)
                end
            end
        end
        return lableList
    end

UINOverclockChipSelectNode.ShowChipDetail =
    function(self, chipItem, transform)
        -- function num : 0_6 , upvalues : _ENV, HAType, VAType
        local pos = transform.position
        do
            if pos.y < 0 then
                local oldPos = (((self.ui).rect).transform).position -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'
                ;
                (((self.ui).rect).transform).position =
                    (Vector3.__add)(oldPos,
                                    (Vector3.New)(0, (math.abs)(pos.y, 0)))
                pos = (Vector3.__add)(pos,
                                      (Vector3.New)(0, (math.abs)(pos.y, 0)))
            end
            (self.chipDetailNode):FloatTo(transform, HAType.left, VAType.down);
            (((self.ui).trs_chipDetail).gameObject):SetActive(true)
            local name = chipItem:GetName()
            local content = chipItem:GetDes() -- DECOMPILER ERROR at PC57: Confused about usage of register: R6 in 'UnsetPending'
            ;
            ((self.ui).tex_chipDetailName).text = name -- DECOMPILER ERROR at PC60: Confused about usage of register: R6 in 'UnsetPending'
            ;
            ((self.ui).tex_chipDetailContent).text = content
        end
    end

UINOverclockChipSelectNode.HideChipDetailWittScroll =
    function(self, scrollPos)
        -- function num : 0_7 , upvalues : _ENV
        if (math.abs)((((self.ui).scrollList).velocity).y) <= 0.1 then
            return
        end
        self:HideChipDetail()
    end

UINOverclockChipSelectNode.HideChipDetail =
    function(self)
        -- function num : 0_8
        (((self.ui).trs_chipDetail).gameObject):SetActive(false)
    end

UINOverclockChipSelectNode.ScrollToTop =
    function(self)
        -- function num : 0_9
        local temp = ((self.ui).scrollList).verticalNormalizedPosition
    end

UINOverclockChipSelectNode.OnClickConfirm =
    function(self)
        -- function num : 0_10
        if self.selectedChipItem ~= nil then
            (self.OverclockCtrl):SetChip2OverClockOption(self.overclockId,
                                                         ((self.selectedChipItem).data).dataId)
        else

            (self.OverclockCtrl):SetChip2OverClockOption(self.overclockId, nil)
        end
        self:Hide()
    end

UINOverclockChipSelectNode.OnClickCancel =
    function(self)
        -- function num : 0_11
        local chipId = (self.OverclockCtrl):GetChip2OverClockOption(
                           self.overclockId)
        if chipId ~= nil then
            (self.OverclockCtrl):SetChip2OverClockOption(self.overclockId,
                                                         chipId)
        else

            (self.OverclockCtrl):SetChip2OverClockOption(self.overclockId, nil)
        end
        self:Hide()
    end

UINOverclockChipSelectNode.SetTitleCallback =
    function(self, titleCallback)
        -- function num : 0_12
        self.titleCallback = titleCallback
    end

UINOverclockChipSelectNode.OnHide = function(self)
    -- function num : 0_13 , upvalues : base
    if self.titleCallback ~= nil then (self.titleCallback)() end
    self:HideChipDetail()
    if self.overclockNode ~= nil then (self.overclockNode):Show() end
    (base.OnHide)(self)
end

UINOverclockChipSelectNode.OnDelete = function(self)
    -- function num : 0_14 , upvalues : base
    (((self.ui).scrollList).onValueChanged):RemoveListener(self.__HideChipDetail);
    (base.OnDelete)(self)
end

return UINOverclockChipSelectNode


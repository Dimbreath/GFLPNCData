-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthListItem = class("UINAthListItem", UIBaseNode)
local base = UIBaseNode
local UINAthAttrItem = require("Game.Arithmetic.AthSortList.UINAthAttrItem")
local ArthmeticEnum = require("Game.Arithmetic.ArthmeticEnum")
local centerAnchor = (Vector2.New)(0.5, 0.5)
local CS_EventTriggerListener = CS.EventTriggerListener
local CS_UguiPassEvent = CS.UguiPassEvent
UINAthListItem.ctor = function(self, scrollRectRoot)
    -- function num : 0_0
    self.scrollRectRoot = scrollRectRoot
end

UINAthListItem.OnInit = function(self)
    -- function num : 0_1 , upvalues : _ENV, UINAthAttrItem
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self.__OnClickRoot)
    if (self.ui).attriItem ~= nil then
        ((self.ui).attriItem):SetActive(false)
        self.subAttrPool = (UIItemPool.New)(UINAthAttrItem, (self.ui).attriItem)
    end
end

UINAthListItem.InitAthListItem = function(self, athData, clickFunc, resloader,
                                          inAthTable)
    -- function num : 0_2
    self.athData = athData
    self.clickFunc = clickFunc
    self.inAthTable = inAthTable
    self.resloader = resloader
    self:RereshAthItem()
end

UINAthListItem.SetAthItemRootScrollRectRoot =
    function(self, scrollRectRoot)
        -- function num : 0_3
        self.scrollRectRoot = scrollRectRoot
    end

UINAthListItem.RereshAthItem = function(self)
    -- function num : 0_4 , upvalues : _ENV, ArthmeticEnum
    local athData = self.athData -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).tex_Name).text = athData:GetName()
    local qualityColor = athData:GetColor() -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.ui).img_QualityLine).color = qualityColor
    local athColor = athData:GetAthColor() -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'
    ;
    ((self.ui).img_Quality).color = athColor
    local suitId = (athData:GetAthSuit())
    local suitCfg = nil
    if suitId > 0 then
        local suitCfgDic = (ConfigData.ath_suit)[suitId]
        if suitCfgDic ~= nil then
            for k, v in pairs(suitCfgDic) do
                suitCfg = v
                do break end
            end
        end
    end
    do
        -- DECOMPILER ERROR at PC40: Confused about usage of register: R6 in 'UnsetPending'


        ((self.ui).img_Suit).enabled = suitCfg ~= nil
        if suitCfg ~= nil then
            (self.resloader):LoadABAssetAsync(
                PathConsts:GetAtlasAssetPath("AthSuitIcon"),
                function(spriteAtlas)
                    -- function num : 0_4_0 , upvalues : self, suitCfg
                    if spriteAtlas == nil then return end -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'
                    
                    ((self.ui).img_Suit).sprite =
                        spriteAtlas:GetSprite(suitCfg.icon)
                end)
        end
        if #athData.attrList > 0 then
            local athAttr = (athData.attrList)[1]
            local name, valueStr, icon =
                ConfigData:GetAttribute(athAttr.id, athAttr.value) -- DECOMPILER ERROR at PC68: Confused about usage of register: R10 in 'UnsetPending'
            ;
            ((self.ui).img_Icon).sprite = CRH:GetSprite(icon) -- DECOMPILER ERROR at PC71: Confused about usage of register: R10 in 'UnsetPending'
            ;
            ((self.ui).tex_Vlaue).text = valueStr
        end
        if self.subAttrPool ~= nil then
            (self.subAttrPool):HideAll()
            for k, affix in ipairs(athData.affixList) do
                local cfg = (ConfigData.ath_affix_pool)[affix.id]
                if cfg == nil then
                    error("Can\'t find ath_affix_pool, id = " ..
                              tostring(affix.id))
                else
                    local color = nil
                    if affix.quality == (ArthmeticEnum.eAthQualityType).Orange then
                        color = (ArthmeticEnum.AthQualityColor)[affix.quality]
                    end
                    local attrItem = (self.subAttrPool):GetOne()
                    attrItem:InitAthAttrItem(cfg.affix_para, affix.value, color)
                end
            end
        end
        self:RefreshAthItemStateLock()
        self:RefreshAthItemStateInstall()
        self:SetAthItemSelect(false)
        -- DECOMPILER ERROR: 7 unprocessed JMP targets
    end
end

UINAthListItem.SetAthItemSelect = function(self, select, isMultiple)
    -- function num : 0_5
    if select then
        ((self.ui).obj_SingleSel):SetActive(not isMultiple);
        ((self.ui).obj_MultipleSel):SetActive(isMultiple)
    else

        ((self.ui).obj_SingleSel):SetActive(false);
        ((self.ui).obj_MultipleSel):SetActive(false)
    end
end

UINAthListItem.__OnClickRoot = function(self)
    -- function num : 0_6
    if self.clickFunc ~= nil then (self.clickFunc)(self) end
end

UINAthListItem.SetAthItemDragFunc = function(self, dragStartFunc, isInTable)
    -- function num : 0_7 , upvalues : CS_EventTriggerListener, _ENV
    self.dragStartFunc = dragStartFunc
    self.isInTable = isInTable
    do
        if isInTable then
            local eventTigger = (CS_EventTriggerListener.Get)(self.gameObject)
            self.__onBeginDrag = BindCallback(self, self.OnAthItemBeginDrag)
            eventTigger:onBeginDrag("+", self.__onBeginDrag)
        end
        self.enableDrag = true
    end
end

UINAthListItem.OnAthItemBeginDrag = function(self)
    -- function num : 0_8 , upvalues : _ENV
    if not self.enableDrag or self._inDrag then return end
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

    if not IsNull(self.scrollRectRoot) then
        (self.scrollRectRoot).enabled = false
    end
    self._inDrag = true
    self:ClearAthItemDragEndTween()
    self:EnableAthItemRaycast(false)
    if self.dragStartFunc ~= nil then
        (self.dragStartFunc)(self, self.isInTable)
    end
end

UINAthListItem.OnAthItemDragEnd = function(self)
    -- function num : 0_9 , upvalues : _ENV
    self._inDrag = false
    self:EnableAthItemRaycast(true)
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

    if not IsNull(self.scrollRectRoot) then
        (self.scrollRectRoot).enabled = true
        return
    end
end

UINAthListItem.SetAthItemPos = function(self, position)
    -- function num : 0_10
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

    ((self.ui).root).position = position
end

UINAthListItem.AthMoveTweenWithRootParent =
    function(self, anchoredPosition)
        -- function num : 0_11
        -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

        (self.transform).anchoredPosition = anchoredPosition
        self:DragEndTweenAthItem((self.transform).position)
    end

UINAthListItem.DragEndTweenAthItem = function(self, position)
    -- function num : 0_12
    self:ClearAthItemDragEndTween()
    self.__dragEndTween = (((self.ui).root):DOMove(position, 0.2)):OnComplete(
                              function()
            -- function num : 0_12_0 , upvalues : self
            self:SetAthItemRootParent(nil, true)
        end)
    self.__rootPos = position
end

UINAthListItem.ClearAthItemDragEndTween =
    function(self)
        -- function num : 0_13
        if self.__dragEndTween ~= nil then
            (self.__dragEndTween):Kill()
            self.__dragEndTween = nil
        end
    end

UINAthListItem.GetAthItemRootPos = function(self)
    -- function num : 0_14
    if not self._rootPos then return (((self.ui).root).transform).position end
end

UINAthListItem.GetAthItemRoot = function(self)
    -- function num : 0_15
    return (self.ui).root
end

UINAthListItem.EnableAthItemRaycast = function(self, enable)
    -- function num : 0_16
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

    ((self.ui).uiNoDrawRaycast).raycastTarget = enable
end

UINAthListItem.RefreshAthItemStateInstall =
    function(self)
        -- function num : 0_17 , upvalues : _ENV
        local equip = (self.athData).bindInfo ~= nil
        if self.inAthTable then equip = false end
        ((self.ui).obj_Equip):SetActive(equip) -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).tex_Equip).text = nil
        do
            if equip then
                local heroData =
                    (PlayerDataCenter.heroDic)[((self.athData).bindInfo).id]
                -- DECOMPILER ERROR at PC32: Confused about usage of register: R3 in 'UnsetPending'

                if heroData ~= nil then
                    ((self.ui).tex_Equip).text = heroData:GetName()
                end
            end
            local areaId = (self.athData):GetAthAreaType()
            local areaCfg = (ConfigData.ath_area)[areaId]
            -- DECOMPILER ERROR at PC44: Confused about usage of register: R4 in 'UnsetPending'

            if areaCfg ~= nil then
                ((self.ui).tex_Area).text = areaCfg.name1
            else
                error("Can\'t get ath_area cfg, id = " .. areaId)
            end
            -- DECOMPILER ERROR: 5 unprocessed JMP targets
        end
    end

UINAthListItem.RefreshAthItemStateLock =
    function(self)
        -- function num : 0_18
        ((self.ui).obj_Lock):SetActive((self.athData).lockUnlock)
    end

UINAthListItem.GetAthItemData = function(self)
    -- function num : 0_19
    return self.athData
end

UINAthListItem.SetAthItemRootParent = function(self, parent, reset,
                                               withoutSetPos)
    -- function num : 0_20
    if reset then
        ((self.ui).root):SetParent(self.transform)
        -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

        if not withoutSetPos then
            ((self.ui).root).anchoredPosition = self.__rootAnchoredPosition
        end
        if self.__OnResetAthItemRootParent ~= nil then
            (self.__OnResetAthItemRootParent)()
            self.__OnResetAthItemRootParent = nil
        end
    else
        if self.__rootAnchoredPosition == nil then
            self.__rootAnchoredPosition = ((self.ui).root).anchoredPosition
        end
        ((self.ui).root):SetParent(parent)
    end
end

UINAthListItem.SetAthItemRootParentResetFunc =
    function(self, callBack)
        -- function num : 0_21
        self.__OnResetAthItemRootParent = callBack
    end

UINAthListItem.SetAsTransparentAthItem =
    function(self, parent, athData, resloader)
        -- function num : 0_22 , upvalues : _ENV
        (self.transform):SetParent(parent) -- DECOMPILER ERROR at PC7: Confused about usage of register: R4 in 'UnsetPending'
        ;
        (self.transform).position = (parent.transform).position
        self:InitAthListItem(athData, nil, resloader, nil)
        if self.__rootCanvasGroup == nil then
            self.__rootCanvasGroup = (self.gameObject):AddComponent(
                                         typeof((CS.UnityEngine).CanvasGroup)) -- DECOMPILER ERROR at PC27: Confused about usage of register: R4 in 'UnsetPending'
            ;
            (self.__rootCanvasGroup).alpha = 0.5
        end
    end

UINAthListItem.OnDelete = function(self)
    -- function num : 0_23 , upvalues : base
    if self.subAttrPool ~= nil then (self.subAttrPool):DeleteAll() end
    self:ClearAthItemDragEndTween();
    (base.OnDelete)(self)
end

return UINAthListItem


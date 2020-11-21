-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroEnterSlotItem = class("UINHeroEnterSlotItem", UIBaseNode)
local base = UIBaseNode
local staticAllSlots = {}
UINHeroEnterSlotItem.cleanStaticAllSlots =
    function(self)
        -- function num : 0_0 , upvalues : staticAllSlots
        staticAllSlots = {}
    end

UINHeroEnterSlotItem.OnInit = function(self)
    -- function num : 0_1 , upvalues : _ENV
    self.resloader = nil
    self.isUnlock = false
    self.heroId = nil
    self.clickFunc = nil
    self.isSelected = false
    self.slotNum = nil
    self.isShowSelect = false;
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_theSlot, self, self.OnSlotClick);
    ((self.ui).obj_Add):SetActive(false);
    ((self.ui).obj_Hero):SetActive(false);
    ((self.ui).obj_Lock):SetActive(true);
    ((self.ui).obj_select):SetActive(false)
end

UINHeroEnterSlotItem.InitHeroEnterSlot =
    function(self, resloader, isUnlock, heroId, isShowSelect)
        -- function num : 0_2 , upvalues : _ENV, staticAllSlots
        self.resloader = resloader
        self.isUnlock = isUnlock
        self.heroId = heroId
        self.isShowSelect = isShowSelect
        self:RefreshHeroEnterSlot()
        if isShowSelect then
            (table.insert)(staticAllSlots, {
                isUnlock = isUnlock,
                heroID = heroId,
                slotItem = self
            })
            self.slotNum = #staticAllSlots
        end
    end

UINHeroEnterSlotItem.RefreshHeroEnterSlot =
    function(self)
        -- function num : 0_3 , upvalues : _ENV
        ((self.ui).obj_Add):SetActive(false);
        ((self.ui).obj_Hero):SetActive(false);
        ((self.ui).obj_Lock):SetActive(false)
        if self.isUnlock then
            if self.heroId ~= nil then
                ((self.ui).obj_Hero):SetActive(true)
                local heroCfg = (ConfigData.hero_data)[self.heroId]
                local heroResCfg = (ConfigData.resource_model)[heroCfg.src_id];
                (self.resloader):LoadABAssetAsync(
                    PathConsts:GetCharacterPicPath(heroResCfg.res_Name),
                    function(texture)
                        -- function num : 0_3_0 , upvalues : _ENV, self
                        if IsNull(self.transform) then
                            return
                        end -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'
                        
                        ((self.ui).img_Hero).texture = texture
                    end)
            else
                do

                    ((self.ui).obj_Add):SetActive(true);
                    ((self.ui).obj_Lock):SetActive(true);
                    ((self.ui).tex_UnlockMessage):SetIndex(0, "未定义")
                end
            end
        end
    end

UINHeroEnterSlotItem.OnSlotClick = function(self)
    -- function num : 0_4 , upvalues : _ENV, staticAllSlots
    if self.isUnlock and self.isShowSelect then
        for _, value in ipairs(staticAllSlots) do
            if (value.slotItem).isSelected == true then
                (((value.slotItem).ui).obj_select):SetActive(false) -- DECOMPILER ERROR at PC21: Confused about usage of register: R6 in 'UnsetPending'
                ;
                (value.slotItem).isSelected = false
            end
        end
        ((self.ui).obj_select):SetActive(true)
        self.isSelected = true
    end
    if self.clickFunc == nil then
        return
    else

        (self.clickFunc)(self.isUnlock, self.heroId)
    end
end

UINHeroEnterSlotItem.SetSlotClickEvent =
    function(self, event)
        -- function num : 0_5
        self.clickFunc = event
    end

UINHeroEnterSlotItem.OnDelete = function(self)
    -- function num : 0_6 , upvalues : base
    (base.OnDelete)(self)
end

return UINHeroEnterSlotItem


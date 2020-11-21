-- params : ...
-- function num : 0 , upvalues : _ENV
local UICCRProductionItem = class("UICCRProductionItem", UIBaseNode)
local base = UIBaseNode
UICCRProductionItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UICCRProductionItem.InitProductionItem =
    function(self, buildId, resData)
        -- function num : 0_1 , upvalues : _ENV
        self.buildId = buildId
        self.OutputCeiling =
            (ConfigData.game_config).oasisBuildingOutputCeiling or 0
        self:__ShowUI(resData.id, resData.name)
        self:UpdateProductionInfo(resData)
    end

UICCRProductionItem.__ShowUI = function(self, itemId, strName)
    -- function num : 0_2 , upvalues : _ENV
    local itemCfg = (ConfigData.item)[itemId]
    if itemCfg == nil then
        error("Can\'t Find ItemCfg By ID:" .. itemId)
        return
    end -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'
    
    ((self.ui).img_Icon).sprite = CRH:GetSprite(itemCfg.small_icon) -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'
    ;
    ((self.ui).tex_Name).text = strName
    local lineColor = ItemQualityColor[itemCfg.quality] -- DECOMPILER ERROR at PC26: Confused about usage of register: R5 in 'UnsetPending'
    ;
    ((self.ui).img_Period).color = lineColor -- DECOMPILER ERROR at PC36: Confused about usage of register: R5 in 'UnsetPending'
    ;
    ((self.ui).img_Rate).color = (Color.New)(lineColor.r, lineColor.g,
                                             lineColor.b, 0.2)
end

UICCRProductionItem.UpdateProductionInfo =
    function(self, resData)
        -- function num : 0_3 , upvalues : _ENV
        local speed = resData.speed
        local effSpeed = resData.effSpeed
        local countMax = resData.countMax -- DECOMPILER ERROR at PC6: Confused about usage of register: R5 in 'UnsetPending'
        ;
        ((self.ui).img_Period).fillAmount = resData.progress
        local count = resData.count -- DECOMPILER ERROR at PC11: Confused about usage of register: R6 in 'UnsetPending'
        ;
        ((self.ui).img_Rate).fillAmount = count / countMax -- DECOMPILER ERROR at PC17: Confused about usage of register: R6 in 'UnsetPending'
        ;
        ((self.ui).tex_Cur).text = tostring(count);
        ((self.ui).tex_Total):SetIndex(0, tostring(countMax))
        local hourSpeed = (speed + effSpeed) * 36;
        ((self.ui).tex_Speed):SetIndex(0, tostring(hourSpeed))
    end

UICCRProductionItem.GetRingUI = function(self)
    -- function num : 0_4
    return (self.ui).img_Rate
end

UICCRProductionItem.OnDelete = function(self)
    -- function num : 0_5 , upvalues : base
    (base.OnDelete)(self)
end

return UICCRProductionItem


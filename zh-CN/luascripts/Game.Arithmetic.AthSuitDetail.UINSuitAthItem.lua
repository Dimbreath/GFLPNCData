-- params : ...
-- function num : 0 , upvalues : _ENV
local UINSuitAthItem = class("UINSuitAthItem", UIBaseNode)
local base = UIBaseNode
local ArthmeticEnum = require("Game.Arithmetic.ArthmeticEnum")
UINSuitAthItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINSuitAthItem.InitSuitAthItem = function(self, athData, athCfg, resLoader)
    -- function num : 0_1 , upvalues : _ENV, ArthmeticEnum
    self.resLoader = resLoader
    if athData ~= nil then athCfg = athData.athCfg end
    local itemCfg = (ConfigData.item)[athCfg.id]
    if itemCfg == nil then
        error("Can\'t find itemCfg by arithmetic.id, id = " ..
                  tostring(athCfg.id))
        return
    end
    local qualityColor = ItemQualityColor[itemCfg.quality] -- DECOMPILER ERROR at PC23: Confused about usage of register: R6 in 'UnsetPending'
    ;
    ((self.ui).img_Quality).color = qualityColor
    local suitId = athCfg.suit
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
        -- DECOMPILER ERROR at PC47: Confused about usage of register: R8 in 'UnsetPending'


        ((self.ui).img_Icon).enabled = suitCfg ~= nil
        if suitCfg ~= nil then
            (self.resLoader):LoadABAssetAsync(
                PathConsts:GetAtlasAssetPath("AthSuitIcon"),
                function(spriteAtlas)
                    -- function num : 0_1_0 , upvalues : self, suitCfg
                    if spriteAtlas == nil then return end -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'
                    
                    ((self.ui).img_Icon).sprite =
                        spriteAtlas:GetSprite(suitCfg.icon)
                end)
        end
        local areaCfg = (ConfigData.ath_area)[athCfg.area_type]
        if areaCfg == nil then
            error("Can\'t find ath areaCfg by area_type, area_type = " ..
                      tostring(athCfg.area_type))
            return
        end
        ((self.ui).tex_Area):SetIndex(0, areaCfg.name1) -- DECOMPILER ERROR at PC84: Confused about usage of register: R9 in 'UnsetPending'
        ;
        ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(itemCfg.name)
        if athData ~= nil and #athData.attrList > 0 then
            local athAttr = (athData.attrList)[1]
            local name, valueStr, icon =
                ConfigData:GetAttribute(athAttr.id, athAttr.value) -- DECOMPILER ERROR at PC100: Confused about usage of register: R13 in 'UnsetPending'
            ;
            ((self.ui).img_Attri).enabled = true -- DECOMPILER ERROR at PC107: Confused about usage of register: R13 in 'UnsetPending'
            ;
            ((self.ui).img_Attri).sprite = CRH:GetSprite(icon) -- DECOMPILER ERROR at PC110: Confused about usage of register: R13 in 'UnsetPending'
            ;
            ((self.ui).tex_AttriNum).text = valueStr -- DECOMPILER ERROR at PC113: Confused about usage of register: R13 in 'UnsetPending'
            ;
            ((self.ui).tex_AttriName).text = name -- DECOMPILER ERROR at PC116: Confused about usage of register: R13 in 'UnsetPending'
            ;
            ((self.ui).fade).alpha = 1 -- DECOMPILER ERROR at PC121: Confused about usage of register: R13 in 'UnsetPending'
            ;
            ((self.ui).img_AttriQuality).color = (ArthmeticEnum.AthColor)[5]
        else
            -- DECOMPILER ERROR at PC125: Confused about usage of register: R9 in 'UnsetPending'

            ((self.ui).img_Attri).enabled = false -- DECOMPILER ERROR at PC128: Confused about usage of register: R9 in 'UnsetPending'
            ;
            ((self.ui).tex_AttriNum).text = nil -- DECOMPILER ERROR at PC131: Confused about usage of register: R9 in 'UnsetPending'
            ;
            ((self.ui).tex_AttriName).text = nil -- DECOMPILER ERROR at PC134: Confused about usage of register: R9 in 'UnsetPending'
            ;
            ((self.ui).img_AttriQuality).color = nil -- DECOMPILER ERROR at PC137: Confused about usage of register: R9 in 'UnsetPending'
            ;
            ((self.ui).fade).alpha = 0.6
        end
        ((self.ui).notInstall):SetActive(athData == nil)
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
    end
end

UINSuitAthItem.OnDelete = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnDelete)(self)
end

return UINSuitAthItem


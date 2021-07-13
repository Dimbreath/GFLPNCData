-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthStrItem = class("UINAthStrItem", UIBaseNode)
local base = UIBaseNode
UINAthStrItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINAthStrItem.InitAthStrItem = function(self, athData, resLoader)
  -- function num : 0_1 , upvalues : _ENV
  local athCfg = athData.athCfg
  resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("AthSuitIcon"), function(spriteAtlas)
    -- function num : 0_1_0 , upvalues : self, athCfg
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = spriteAtlas:GetSprite(athCfg.icon)
  end
)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_Quality).color = ItemQualityColor[athData:GetAthQuality()]
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_QualityAttr).color = athData:GetAthColor()
  local suitId = athCfg.suit
  local suitParamCfg = ((ConfigData.ath_suit).suitParamDic)[suitId]
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_Suit).enabled = suitParamCfg ~= nil
  if suitParamCfg ~= nil then
    resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("AthSuitIcon"), function(spriteAtlas)
    -- function num : 0_1_1 , upvalues : self, suitParamCfg
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Suit).sprite = spriteAtlas:GetSprite(suitParamCfg.icon)
  end
)
  end
  local areaCfg = (ConfigData.ath_area)[athCfg.area_type]
  if areaCfg == nil then
    error("Can\'t find ath areaCfg by area_type, area_type = " .. tostring(athCfg.area_type))
    return 
  end
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = athData:GetName()
  if #(athData.athMainAttrCfg).attrtibute_id > 0 then
    local attrId = ((athData.athMainAttrCfg).attrtibute_id)[1]
    local attrValue = ((athData.athMainAttrCfg).attrtibute_num)[1]
    local name, valueStr, icon = ConfigData:GetAttribute(attrId, attrValue)
    -- DECOMPILER ERROR at PC78: Confused about usage of register: R12 in 'UnsetPending'

    ;
    ((self.ui).tex_Vlaue).text = valueStr
    -- DECOMPILER ERROR at PC85: Confused about usage of register: R12 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = CRH:GetSprite(icon)
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UINAthStrItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthStrItem


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
  if athData ~= nil then
    athCfg = athData.athCfg
  end
  local itemCfg = (ConfigData.item)[athCfg.id]
  if itemCfg == nil then
    error("Can\'t find itemCfg by arithmetic.id, id = " .. tostring(athCfg.id))
    return 
  end
  local qualityColor = ItemQualityColor[itemCfg.quality]
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_Quality).color = qualityColor
  local suitId = athCfg.suit
  local suitParamCfg = ((ConfigData.ath_suit).suitParamDic)[suitId]
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).enabled = suitParamCfg ~= nil
  if suitParamCfg ~= nil then
    (self.resLoader):LoadABAssetAsync(PathConsts:GetAtlasAssetPath("AthSuitIcon"), function(spriteAtlas)
    -- function num : 0_1_0 , upvalues : self, suitParamCfg
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = spriteAtlas:GetSprite(suitParamCfg.icon)
  end
)
  end
  local areaCfg = (ConfigData.ath_area)[athCfg.area_type]
  if areaCfg == nil then
    error("Can\'t find ath areaCfg by area_type, area_type = " .. tostring(athCfg.area_type))
    return 
  end
  ;
  ((self.ui).tex_Area):SetIndex(0, areaCfg.name1)
  -- DECOMPILER ERROR at PC72: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(itemCfg.name)
  if athData ~= nil and #(athData.athMainAttrCfg).attrtibute_id > 0 then
    local attrId = ((athData.athMainAttrCfg).attrtibute_id)[1]
    local attrValue = ((athData.athMainAttrCfg).attrtibute_num)[1]
    local name, valueStr, icon = ConfigData:GetAttribute(attrId, attrValue)
    -- DECOMPILER ERROR at PC93: Confused about usage of register: R14 in 'UnsetPending'

    ;
    ((self.ui).img_Attri).enabled = true
    -- DECOMPILER ERROR at PC100: Confused about usage of register: R14 in 'UnsetPending'

    ;
    ((self.ui).img_Attri).sprite = CRH:GetSprite(icon)
    -- DECOMPILER ERROR at PC103: Confused about usage of register: R14 in 'UnsetPending'

    ;
    ((self.ui).tex_AttriNum).text = valueStr
    -- DECOMPILER ERROR at PC106: Confused about usage of register: R14 in 'UnsetPending'

    ;
    ((self.ui).tex_AttriName).text = name
    -- DECOMPILER ERROR at PC109: Confused about usage of register: R14 in 'UnsetPending'

    ;
    ((self.ui).fade).alpha = 1
    -- DECOMPILER ERROR at PC114: Confused about usage of register: R14 in 'UnsetPending'

    ;
    ((self.ui).img_AttriQuality).color = (ArthmeticEnum.AthColor)[5]
  else
    -- DECOMPILER ERROR at PC118: Confused about usage of register: R9 in 'UnsetPending'

    ((self.ui).img_Attri).enabled = false
    -- DECOMPILER ERROR at PC121: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((self.ui).tex_AttriNum).text = nil
    -- DECOMPILER ERROR at PC124: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((self.ui).tex_AttriName).text = nil
    -- DECOMPILER ERROR at PC127: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((self.ui).img_AttriQuality).color = nil
    -- DECOMPILER ERROR at PC130: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((self.ui).fade).alpha = 0.6
  end
  ;
  ((self.ui).notInstall):SetActive(athData == nil)
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

UINSuitAthItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINSuitAthItem


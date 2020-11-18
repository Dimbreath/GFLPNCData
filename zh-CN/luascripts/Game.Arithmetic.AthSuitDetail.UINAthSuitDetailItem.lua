-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthSuitDetailItem = class("UINAthSuitDetailItem", UIBaseNode)
local base = UIBaseNode
UINAthSuitDetailItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self.__OnClickRoot)
end

UINAthSuitDetailItem.InitAthSuitDetailItem = function(self, suitId, clickFunc, resLoader, curCount)
  -- function num : 0_1 , upvalues : _ENV
  self.suitId = suitId
  self.clickFunc = clickFunc
  local suitList = (ConfigData.ath_suit)[suitId]
  if suitList == nil then
    error("Cant find ath suitList, suitId = " .. tostring(suitId))
    return 
  end
  local maxCount = 0
  local iconName = nil
  local suitCfg = suitList[#suitList]
  iconName = suitCfg.icon
  maxCount = suitCfg.num
  self:SetAthSuitDetailItemSelect(false)
  resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("AthSuitIcon"), function(spriteAtlas)
    -- function num : 0_1_0 , upvalues : self, iconName
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_SuitIcon).sprite = spriteAtlas:GetSprite(iconName)
  end
)
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R9 in 'UnsetPending'

  if curCount == nil then
    (((self.ui).tex_SuitCount).text).text = nil
  else
    ;
    ((self.ui).tex_SuitCount):SetIndex(0, tostring(curCount), tostring(maxCount))
  end
  -- DECOMPILER ERROR at PC55: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).tex_SuitName).text = (LanguageUtil.GetLocaleText)(suitCfg.name)
end

UINAthSuitDetailItem.SetAthSuitDetailItemSelect = function(self, select)
  -- function num : 0_2
  ((self.ui).img_Select):SetActive(select)
end

UINAthSuitDetailItem.__OnClickRoot = function(self)
  -- function num : 0_3
  if self.clickFunc ~= nil then
    (self.clickFunc)(self)
  end
end

UINAthSuitDetailItem.GetAthSuitDetailItemId = function(self)
  -- function num : 0_4
  return self.suitId
end

UINAthSuitDetailItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthSuitDetailItem


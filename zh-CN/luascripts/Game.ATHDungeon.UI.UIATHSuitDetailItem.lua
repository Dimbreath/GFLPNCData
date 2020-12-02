-- params : ...
-- function num : 0 , upvalues : _ENV
local UIATHSuitDetailItem = class("UIATHSuitDetailItem", UIBaseNode)
local base = UIBaseNode
UIATHSuitDetailItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self.__onClick)
end

UIATHSuitDetailItem.InitWithData = function(self, data, resLoader)
  -- function num : 0_1 , upvalues : _ENV
  self.suitId = data
  self.resLoader = resLoader
  local suitParamCfg = ((ConfigData.ath_suit).suitParamDic)[data]
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

  if suitParamCfg ~= nil then
    ((self.ui).tex_SuitName).text = (LanguageUtil.GetLocaleText)(suitParamCfg.name)
    ;
    (self.resLoader):LoadABAssetAsync(PathConsts:GetAtlasAssetPath("AthSuitIcon"), function(spriteAtlas)
    -- function num : 0_1_0 , upvalues : self, suitParamCfg
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_SuitIcon).sprite = spriteAtlas:GetSprite(suitParamCfg.icon)
  end
)
  end
  ;
  ((self.ui).img_Select):SetActive(false)
end

UIATHSuitDetailItem.__onClick = function(self)
  -- function num : 0_2
  if self.clickEvent ~= nil then
    (self.clickEvent)(self)
  end
end

UIATHSuitDetailItem.GetAthSuitDetailItemId = function(self)
  -- function num : 0_3
  return self.suitId
end

UIATHSuitDetailItem.SetAthSuitDetailItemSelect = function(self, select)
  -- function num : 0_4
  ((self.ui).img_Select):SetActive(select)
end

UIATHSuitDetailItem.OnHide = function(self)
  -- function num : 0_5
  self.onClickAction = nil
  self.suitId = nil
end

UIATHSuitDetailItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UIATHSuitDetailItem


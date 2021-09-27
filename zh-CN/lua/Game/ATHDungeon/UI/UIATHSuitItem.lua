local UIATHSuitItem = class("UIATHSuitItem", UIBaseNode)
local base = UIBaseNode
UIATHSuitItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SuitNode, self, self.__onClick)
end

UIATHSuitItem.InitATHSuitItem = function(self, athSuitId, resLoader)
  -- function num : 0_1 , upvalues : _ENV
  self.athSuitId = athSuitId
  self.resLoader = resLoader
  local suitCfg = nil
  local suitParamCfg = ((ConfigData.ath_suit).suitParamDic)[athSuitId]
  if suitParamCfg ~= nil then
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
    ;
    ((self.ui).tex_SuitName):SetIndex(0, (LanguageUtil.GetLocaleText)(suitParamCfg.name))
  end
end

UIATHSuitItem.__onClick = function(self)
  -- function num : 0_2
  if self.clickEvent ~= nil then
    (self.clickEvent)(self)
  end
end

UIATHSuitItem.OnHide = function(self)
  -- function num : 0_3
  self.clickEvent = nil
  self.athSuitId = nil
end

UIATHSuitItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UIATHSuitItem


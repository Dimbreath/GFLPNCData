-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthSuitItem = class("UINAthSuitItem", UIBaseNode)
local base = UIBaseNode
UINAthSuitItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self.__OnClickRoot)
end

UINAthSuitItem.InitAthSuitItem = function(self, suitData, resLoader, clickFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.suitData = suitData
  self.clickFunc = clickFunc
  ;
  ((self.ui).tex_SuitCount):SetIndex(0, tostring((self.suitData).curCount), tostring((self.suitData).maxCount))
  local suitParamCfg = ((ConfigData.ath_suit).suitParamDic)[(suitData.cfg).id]
  resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("AthSuitIcon"), function(spriteAtlas)
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

UINAthSuitItem.__OnClickRoot = function(self)
  -- function num : 0_2
  if self.clickFunc ~= nil then
    (self.clickFunc)(((self.suitData).cfg).id)
  end
end

UINAthSuitItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthSuitItem


-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthSuitMainItem = class("UINAthSuitMainItem", UIBaseNode)
local base = UIBaseNode
local UINAthSuitColleItem = require("Game.Arithmetic.AthMain.UINAthSuitColleItem")
UINAthSuitMainItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINAthSuitColleItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self.__OnClickRoot)
  ;
  ((self.ui).colleItem):SetActive(false)
  self.colleItemPool = (UIItemPool.New)(UINAthSuitColleItem, (self.ui).colleItem)
end

UINAthSuitMainItem.InitAthSuitMainItem = function(self, suitData, resLoader, clickFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.suitData = suitData
  self.clickFunc = clickFunc
  local suitParamCfg = ((ConfigData.ath_suit).suitParamDic)[(suitData.cfg).id]
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(suitParamCfg.name)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).enabled = false
  resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("AthSuitIcon"), function(spriteAtlas)
    -- function num : 0_1_0 , upvalues : self, suitParamCfg
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = spriteAtlas:GetSprite(suitParamCfg.icon)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).enabled = true
  end
)
  local suitCfg = (ConfigData.ath_suit)[(suitData.cfg).id]
  ;
  (self.colleItemPool):HideAll()
  for k,suitDetailCfg in ipairs(suitCfg) do
    local colleItem = (self.colleItemPool):GetOne()
    local valid = suitDetailCfg.num <= (self.suitData).curCount
    colleItem:InitAthSuitColleItem(suitDetailCfg.num, valid)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINAthSuitMainItem.__OnClickRoot = function(self)
  -- function num : 0_2
  if self.clickFunc ~= nil then
    (self.clickFunc)(((self.suitData).cfg).id)
  end
end

UINAthSuitMainItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthSuitMainItem


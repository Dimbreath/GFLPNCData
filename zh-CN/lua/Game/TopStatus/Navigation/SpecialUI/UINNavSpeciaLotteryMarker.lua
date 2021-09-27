local UINNavSpecialUIBase = require("Game.TopStatus.Navigation.SpecialUI.UINNavSpecialUIBase")
local UINNavSpeciaLotteryMarker = class("UINNavSpeciaLotteryMarker", UINNavSpecialUIBase)
local base = UINNavSpecialUIBase
UINNavSpeciaLotteryMarker.OnInit = function(self)
  -- function num : 0_0 , upvalues : base, _ENV
  (base.OnInit)(self)
  self.__RefreshMarker = BindCallback(self, self.RefreshMarker)
end

UINNavSpeciaLotteryMarker.GetSpecialUI = function(item, go, resloader)
  -- function num : 0_1 , upvalues : base, UINNavSpeciaLotteryMarker
  local specialUI = (base.GetSpecialUI)(UINNavSpeciaLotteryMarker, item, go)
  specialUI.item = item
  specialUI.resloader = resloader
  specialUI:RefreshMarker()
  ;
  (base.__Add2TimerFuncs)(specialUI.__RefreshMarker)
end

UINNavSpeciaLotteryMarker.RefreshMarker = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if not (self.item):GetNBBIsUnlock() then
    (self.gameObject):SetActive(false)
    return 
  else
    ;
    (self.gameObject):SetActive(true)
  end
  local maxNavTag, maxLtrCfg = nil, nil
  local openingLotteryPoolDatas = (PlayerDataCenter.allLtrData):GetOpeningLtrPoolDataList()
  for _,lotteryPoolData in pairs(openingLotteryPoolDatas) do
    local navTag = lotteryPoolData:GetLotteryDataNavTag()
    if navTag ~= nil and navTag ~= 0 and (maxNavTag == nil or maxNavTag < navTag) then
      maxNavTag = navTag
      maxLtrCfg = lotteryPoolData:GetLtrPoolDataCfg()
    end
  end
  if maxLtrCfg ~= nil then
    (self.gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_Tips).text = (LanguageUtil.GetLocaleText)(maxLtrCfg.nav_tagName)
    if not (string.IsNullOrEmpty)(maxLtrCfg.nav_tagIcon) then
      (self.resloader):LoadABAssetAsync(PathConsts:GetAtlasAssetPath("UI_NavigationBar"), function(spriteAtlas)
    -- function num : 0_2_0 , upvalues : self, maxLtrCfg
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = spriteAtlas:GetSprite(maxLtrCfg.nav_tagIcon)
  end
)
    end
  else
    ;
    (self.gameObject):SetActive(false)
  end
end

UINNavSpeciaLotteryMarker.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.__RemoveFromTimerFuncs)(self.__RefreshMarker)
  ;
  (base.OnDelete)(self)
end

return UINNavSpeciaLotteryMarker


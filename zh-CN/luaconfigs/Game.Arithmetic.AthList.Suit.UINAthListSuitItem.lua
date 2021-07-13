-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthListSuitItem = class("UINAthListSuitItem", UIBaseNode)
local base = UIBaseNode
local UINAthSuitColleItem = require("Game.Arithmetic.AthMain.UINAthSuitColleItem")
UINAthListSuitItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINAthSuitColleItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self.__OnClickRoot)
  ;
  ((self.ui).colleItem):SetActive(false)
  self.colleItemPool = (UIItemPool.New)(UINAthSuitColleItem, (self.ui).colleItem)
end

UINAthListSuitItem.InitAthListSuitItem = function(self, suitId, clickFunc, resLoader, curCount)
  -- function num : 0_1 , upvalues : _ENV
  self.suitId = suitId
  self.clickFunc = clickFunc
  local suitList = (ConfigData.ath_suit)[suitId]
  if suitList == nil then
    error("Cant find ath suitList, suitId = " .. tostring(suitId))
    return 
  end
  local suitParamCfg = ((ConfigData.ath_suit).suitParamDic)[suitId]
  local iconName = suitParamCfg.icon
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).enabled = false
  resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("AthSuitIcon"), function(spriteAtlas)
    -- function num : 0_1_0 , upvalues : self, iconName
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = spriteAtlas:GetSprite(iconName)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).enabled = true
  end
)
  ;
  ((self.ui).tex_Own):SetIndex(0, tostring(curCount))
  local own = curCount > 0
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R9 in 'UnsetPending'

  if not own or not (self.ui).ownColor_Tex then
    (((self.ui).tex_Own).text).color = (self.ui).notOwnColor_Tex
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R9 in 'UnsetPending'

    if not own or not (self.ui).ownColor_Bg then
      ((self.ui).img_OwnBg).color = (self.ui).notOwnColor_Bg
      -- DECOMPILER ERROR at PC71: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(suitParamCfg.name)
      ;
      (self.colleItemPool):HideAll()
      local intro = nil
      for k,suitCfg in ipairs(suitList) do
        local colleItem = (self.colleItemPool):GetOne()
        colleItem:InitAthSuitColleItem(suitCfg.num, false)
        if intro == nil then
          intro = (LanguageUtil.GetLocaleText)(suitCfg.describe)
        else
          intro = intro .. "\n" .. (LanguageUtil.GetLocaleText)(suitCfg.describe)
        end
      end
      -- DECOMPILER ERROR at PC106: Confused about usage of register: R10 in 'UnsetPending'

      ;
      ((self.ui).tex_Intro).text = intro
      -- DECOMPILER ERROR: 7 unprocessed JMP targets
    end
  end
end

UINAthListSuitItem.__OnClickRoot = function(self)
  -- function num : 0_2
  if self.clickFunc ~= nil then
    (self.clickFunc)(self.suitId)
  end
end

UINAthListSuitItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (self.colleItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINAthListSuitItem


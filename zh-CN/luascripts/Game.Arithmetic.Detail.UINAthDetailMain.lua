-- params : ...
-- function num : 0 , upvalues : _ENV
local base = require("Game.Arithmetic.Detail.UINAthDetailBase")
local UINAthDetailMain = class("UINAthDetailMain", base)
UINAthDetailMain.OnInit = function(self)
  -- function num : 0_0 , upvalues : base, _ENV
  (base.OnInit)(self)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Change, self, self.OnClickReplace)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Uninstall, self, self.OnClickUninstall)
end

UINAthDetailMain.InitAthDetailNode = function(self, athData, efficiency, heroId, replaceEvent, uninstallEvent)
  -- function num : 0_1 , upvalues : base
  (base.InitAthDetailNode)(self, athData, efficiency)
  self.heroId = heroId
  self.replaceEvent = replaceEvent
  self.uninstallEvent = uninstallEvent
  self:__RefreshSuit(athData, heroId)
end

UINAthDetailMain.RefreshDetail = function(self)
  -- function num : 0_2 , upvalues : base
  (base.InitAthDetailNode)(self, self.athData, self.efficiency)
end

UINAthDetailMain.__RefreshSuit = function(self, athData, heroId)
  -- function num : 0_3 , upvalues : _ENV
  local content = ""
  local suitAthList = ((ConfigData.arithmetic).suitDic)[athData.suit]
  if suitAthList ~= nil then
    local suitAthCount = 0
    for k,athId in ipairs(suitAthList) do
      local athCfg = (ConfigData.arithmetic)[athId]
      local itemCfg = (ConfigData.item)[athId]
      if itemCfg == nil then
        error("Can\'t find itemCfg, id = " .. tostring(athId))
        break
      end
      local slotId = athCfg.area_type
      local installed = (PlayerDataCenter.allAthData):HeroContainAthById(heroId, slotId, athId)
      local textIndex = installed and 0 or 1
      local name = (LanguageUtil.GetLocaleText)(itemCfg.name)
      content = content .. ((self.ui).tex_TierGear):GetIndex(textIndex, name, tostring(slotId))
      if installed then
        suitAthCount = suitAthCount + 1
      end
    end
    do
      local suitCfg = (ConfigData.ath_suit)[athData.suit]
      if suitCfg == nil then
        error("Can\'t find suitCfg, id = " .. tostring(athData.suit))
        return 
      end
      local suitNum = 0
      for k,v in ipairs(suitCfg) do
        if v.num <= suitAthCount then
          suitNum = v.num
        end
      end
      for k,v in ipairs(suitCfg) do
        local textIndex = v.num == suitNum and 2 or 3
        local effectStr = (LanguageUtil.GetLocaleText)(v.describe)
        content = content .. ((self.ui).tex_TierGear):GetIndex(textIndex, tostring(v.num), effectStr)
      end
      do
        ;
        ((self.ui).tex_TierGear):SetText(content)
      end
    end
  end
end

UINAthDetailMain.OnClickReplace = function(self)
  -- function num : 0_4
  if self.replaceEvent ~= nil then
    (self.replaceEvent)()
  end
end

UINAthDetailMain.OnClickUninstall = function(self)
  -- function num : 0_5
  if self.uninstallEvent ~= nil then
    (self.uninstallEvent)((self.athData).uid)
  end
end

UINAthDetailMain.EnableReplace = function(self, enable)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).btn_Change).interactable = enable
end

UINAthDetailMain.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthDetailMain


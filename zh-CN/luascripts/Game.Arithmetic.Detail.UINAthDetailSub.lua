-- params : ...
-- function num : 0 , upvalues : _ENV
local base = require("Game.Arithmetic.Detail.UINAthDetailBase")
local UINAthDetailSub = class("UINAthDetailSub", base)
UINAthDetailSub.OnInit = function(self)
  -- function num : 0_0 , upvalues : base, _ENV
  (base.OnInit)(self)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Install, self, self.OnClickInstall)
end

UINAthDetailSub.InitAthDetailNode = function(self, athData, efficiency, heroId, installEvent)
  -- function num : 0_1 , upvalues : base
  (base.InitAthDetailNode)(self, athData, efficiency)
  self.heroId = heroId
  self.installEvent = installEvent
end

UINAthDetailSub.RefreshSuit = function(self, replaceAthData)
  -- function num : 0_2 , upvalues : _ENV
  local athData = self.athData
  local heroId = self.heroId
  local content = ""
  local suitAthList = ((ConfigData.arithmetic).suitDic)[athData.suit]
  if suitAthList ~= nil then
    local suitAthCount = 0
    local suitAthCountPreview = 0
    for k,athId in ipairs(suitAthList) do
      local athCfg = (ConfigData.arithmetic)[athId]
      local itemCfg = (ConfigData.item)[athId]
      if itemCfg == nil then
        error("Can\'t find itemCfg, id = " .. tostring(athId))
        break
      end
      local slotId = athCfg.area_type
      local installed = nil
      if (replaceAthData ~= nil and replaceAthData.id == athId) or athId == athData.id then
        installed = false
      else
        installed = (PlayerDataCenter.allAthData):HeroContainAthById(heroId, slotId, athId)
      end
      local textIndex = installed and 0 or 2
      if athId == athData.id then
        textIndex = 1
        suitAthCountPreview = suitAthCountPreview + 1
      end
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
      local suitNumPreview = 0
      local suitNumPreview = 0
      for k,v in ipairs(suitCfg) do
        if v.num <= suitAthCount then
          suitNum = v.num
        end
        if v.num <= suitAthCount + (suitAthCountPreview) then
          suitNumPreview = v.num
        end
      end
      for k,v in ipairs(suitCfg) do
        local textIndex = v.num == suitNum and 3 or 5
        if v.num == suitNumPreview then
          textIndex = 4
        end
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

UINAthDetailSub.RefreshDetail = function(self, replaceAthData)
  -- function num : 0_3 , upvalues : base
  (base.InitAthDetailNode)(self, self.athData, self.efficiency)
end

UINAthDetailSub.OnClickInstall = function(self)
  -- function num : 0_4
  if self.installEvent ~= nil then
    (self.installEvent)()
  end
end

UINAthDetailSub.SetInstall = function(self, install)
  -- function num : 0_5
  local index = install and 0 or 1
  ;
  ((self.ui).tex_InstallBtn):SetIndex(index)
end

UINAthDetailSub.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthDetailSub


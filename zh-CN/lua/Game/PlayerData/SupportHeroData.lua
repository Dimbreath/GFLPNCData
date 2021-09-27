local SupportHeroData = class("SupportHeroData")
SupportHeroData.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.cachedData = {}
  self.__isHeroDataChanged = true
  self.__cachedFixCfg = nil
  self.__OnHeroDataUpdate = BindCallback(self, self.OnHeroDataUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__OnHeroDataUpdate)
end

SupportHeroData.SetCachedSupportData = function(self, allSupportHeroDataDic, nextRefreshTm, friendsBanData, userInfoDic)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R5 in 'UnsetPending'

  (self.cachedData).allSupportHeroDataDic = allSupportHeroDataDic
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.cachedData).nextRefreshTm = nextRefreshTm
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.cachedData).friendsBanData = friendsBanData
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.cachedData).userInfoDic = userInfoDic
end

SupportHeroData.GetCachedSupportData = function(self)
  -- function num : 0_2
  return (self.cachedData).allSupportHeroDataDic, (self.cachedData).nextRefreshTm, (self.cachedData).friendsBanData, (self.cachedData).userInfoDic
end

SupportHeroData.GetCurFormationLevelEffectByAllHero = function(self, HeroDatas)
  -- function num : 0_3 , upvalues : _ENV
  if self.__isHeroDataChanged or self.__cachedFixCfg == nil or HeroDatas ~= PlayerDataCenter.heroDic then
    local heightestLevel = {level = 1, potential = 0}
    for heroId,heroData in pairs(HeroDatas) do
      if heightestLevel.level <= heroData.level and heightestLevel.potential <= heroData.potential then
        heightestLevel.level = heroData.level
        heightestLevel.potential = heroData.potential
      end
    end
    local finalCfg = nil
    for id,supportCfg in ipairs(ConfigData.support_fix) do
      if finalCfg == nil then
        finalCfg = supportCfg
      end
      if supportCfg.lv <= heightestLevel.level and supportCfg.potential <= heightestLevel.potential then
        finalCfg = supportCfg
      end
    end
    if HeroDatas == PlayerDataCenter.heroDic then
      self.__cachedFixCfg = finalCfg
      self.__isHeroDataChanged = false
    end
    return finalCfg
  else
    do
      do return self.__cachedFixCfg end
    end
  end
end

SupportHeroData.OnHeroDataUpdate = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self.__isHeroDataChanged = true
  MsgCenter:Broadcast(eMsgEventId.OnSupportHoreNeedFresh)
end

SupportHeroData.CleanCachedSupportData = function(self)
  -- function num : 0_5
  self.cachedData = {}
end

SupportHeroData.Delete = function(self)
  -- function num : 0_6 , upvalues : _ENV
  self:CleanCachedSupportData()
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__OnHeroDataUpdate)
end

return SupportHeroData


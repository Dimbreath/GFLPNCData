local HeroInfoData = class("HeroInfoData")
local HeroData = require("Game.PlayerData.Hero.HeroData")
HeroInfoData.ctor = function(self)
  -- function num : 0_0
end

HeroInfoData.InitData = function(self, heroId)
  -- function num : 0_1 , upvalues : _ENV, HeroData
  self.heroId = heroId
  self.heroCfg = (ConfigData.hero_data)[heroId]
  self.career = (self.heroCfg).career
  self.camp = (self.heroCfg).camp
  local dataDic = {}
  dataDic.basic = {id = self.heroId}
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (dataDic.basic).level = ((ConfigData.hero_level)[#ConfigData.hero_level]).level
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (dataDic.basic).potentialLvl = (ConfigData.hero_potential).maxPotentialLevel
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (dataDic.basic).star = (ConfigData.hero_rank).maxStar
  self.heroData = (HeroData.New)(dataDic)
  self.rankCfg = (self.heroData).rankCfg
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.heroData).isRemoveAllBounce = true
  self:RefreshData()
end

HeroInfoData.RefreshData = function(self)
  -- function num : 0_2
  self:UpdateSkin()
end

HeroInfoData.UpdateSkin = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local skinNums = #(self.heroCfg).skin
  if skinNums > 0 then
    local maxRank = 0
    for _,skinId in ipairs((self.heroCfg).skin) do
      local skinCfg = (ConfigData.skin)[skinId]
      if (skinCfg.needRank or maxRank < skinCfg == nil or skinCfg.skin_locked or skinCfg.condition ~= proto_csmsg_SystemFunctionID.SystemFunctionID_HeroRank or 0) and skinCfg.needRank <= (self.heroData).rank then
        maxRank = skinCfg.needRank
        self.skinId = skinId
      end
    end
  else
    do
      self.skinId = 0
      local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
      self.resCfg = skinCtr:GetResModel(self.heroId, self.skinId)
    end
  end
end

HeroInfoData.GetResPicName = function(self)
  -- function num : 0_4
  if not (self.resCfg).src_id_pic then
    return (self.resCfg).res_Name
  end
end

return HeroInfoData


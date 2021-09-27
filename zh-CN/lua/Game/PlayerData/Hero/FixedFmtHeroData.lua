local base = require("Game.PlayerData.Hero.HeroData")
local FixedFmtHeroData = class("FixedFmtHeroData", base)
FixedFmtHeroData.FixedFmtHeroData = function(heroId, assisLvCfg)
  -- function num : 0_0 , upvalues : _ENV, FixedFmtHeroData
  local msgData = {
basic = {id = heroId, level = assisLvCfg.hero_level, exp = 0, star = assisLvCfg.hero_rank, potentialLvl = assisLvCfg.hero_potential}
, 
skill = {
data = {}
}
}
  local heroCfg = (ConfigData.hero_data)[heroId]
  for k,skilId in ipairs(heroCfg.skill_list) do
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R9 in 'UnsetPending'

    ((msgData.skill).data)[skilId] = assisLvCfg.hero_skill_level
  end
  local heroData = (FixedFmtHeroData.New)(msgData)
  local attrDic = DeepCopy(assisLvCfg.attrDic)
  heroData:_SetAttrDic(attrDic)
  heroData.isFixedFmtHero = true
  return heroData
end

FixedFmtHeroData._SetAttrDic = function(self, attrDic)
  -- function num : 0_1
  self.customeAttrDic = attrDic
end

FixedFmtHeroData.GetAttr = function(self, attrId)
  -- function num : 0_2
  return (self.customeAttrDic)[attrId] or 0
end

return FixedFmtHeroData


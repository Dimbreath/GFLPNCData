local UINLtrPoolUpRateGroup = class("UINLtrPoolUpRateGroup", UIBaseNode)
local base = UIBaseNode
local UINLtrPoolUpHero = require("Game.Lottery.UI.PoolDetail.UpRate.UINLtrPoolUpHero")
UINLtrPoolUpRateGroup.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINLtrPoolUpHero
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).heroItem):SetActive(false)
  self.heroItemPool = (UIItemPool.New)(UINLtrPoolUpHero, (self.ui).heroItem)
  ;
  (((self.ui).img_star).gameObject):SetActive(false)
  self.starItemList = {}
end

UINLtrPoolUpRateGroup.InitLtrPoolUpRateGroup = function(self, rewardDataList, star, ratio, resLoader)
  -- function num : 0_1 , upvalues : _ENV
  self:__HideAllStar()
  self:__UpdateStar(star)
  ;
  ((self.ui).tex_Describe):SetIndex(0, tostring(star // 2), tostring(ratio // 100))
  ;
  (table.sort)(rewardDataList, function(a, b)
    -- function num : 0_1_0
    do return (a.heroCfg).id < (b.heroCfg).id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self.heroItemPool):HideAll()
  for k,v in ipairs(rewardDataList) do
    local heroItem = (self.heroItemPool):GetOne()
    heroItem:InitLtrPoolUpHero(v, resLoader)
  end
end

UINLtrPoolUpRateGroup.__UpdateStar = function(self, starCount)
  -- function num : 0_2
  local twoStarCount = starCount // 2
  local oneStarCount = starCount % 2
  for i = 1, twoStarCount do
    local starItem = self:__GetStar(i)
    starItem:SetIndex(0)
  end
  if oneStarCount ~= 0 then
    local starItem = self:__GetStar(twoStarCount + 1)
    starItem:SetIndex(1)
  end
end

UINLtrPoolUpRateGroup.__GetStar = function(self, index)
  -- function num : 0_3
  local starItem = (self.starItemList)[index]
  if starItem == nil then
    starItem = ((self.ui).img_star):Instantiate()
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.starItemList)[index] = starItem
  end
  ;
  (starItem.gameObject):SetActive(true)
  return starItem
end

UINLtrPoolUpRateGroup.__HideAllStar = function(self)
  -- function num : 0_4 , upvalues : _ENV
  for k,v in pairs(self.starItemList) do
    (v.gameObject):SetActive(false)
  end
end

UINLtrPoolUpRateGroup.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (self.heroItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINLtrPoolUpRateGroup


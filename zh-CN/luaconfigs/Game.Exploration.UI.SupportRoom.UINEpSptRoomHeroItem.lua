-- params : ...
-- function num : 0 , upvalues : _ENV
local UINEpSptRoomHeroItem = class("UINEpSptRoomHeroItem", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")
UINEpSptRoomHeroItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroHeadItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.headItem = (UINHeroHeadItem.New)()
  ;
  (self.headItem):Init((self.ui).obj_heroHeadItem)
  self._clickFunc = BindCallback(self, self._OnClickRoot)
end

UINEpSptRoomHeroItem.InitEpSptRoomHeroItem = function(self, dynHeroData, resloader, clickEvent)
  -- function num : 0_1 , upvalues : _ENV
  self.dynHeroData = dynHeroData
  local heroData = dynHeroData.heroData
  self.clickEvent = clickEvent
  ;
  (self.headItem):InitHeroHeadItem(heroData, resloader, self._clickFunc)
  local half = heroData.rank % 2
  local rankImgIndex = (heroData.rank - half) / 2 - 1
  if rankImgIndex >= 0 then
    (((self.ui).img_Star).gameObject):SetActive(true)
    ;
    ((self.ui).img_Star):SetIndex(rankImgIndex)
    local vec = ((((self.ui).img_Star).image).rectTransform).sizeDelta
    vec.x = (((((self.ui).img_Star).image).sprite).rect).width
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((((self.ui).img_Star).image).rectTransform).sizeDelta = vec
  else
    do
      ;
      (((self.ui).img_Star).gameObject):SetActive(false)
      ;
      (((self.ui).img_Half).gameObject):SetActive(half == 1)
      local hpPer = dynHeroData.hpPer / 10000
      -- DECOMPILER ERROR at PC65: Confused about usage of register: R8 in 'UnsetPending'

      ;
      ((self.ui).img_hP).fillAmount = hpPer
      ;
      ((self.ui).isBench):SetActive(dynHeroData:IsBench())
      self.fightingPower = dynHeroData:GetFightingPower()
      -- DECOMPILER ERROR at PC80: Confused about usage of register: R8 in 'UnsetPending'

      ;
      ((self.ui).tex_Power).text = tostring(self.fightingPower)
      -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end
  end
end

UINEpSptRoomHeroItem.SetEpSptRoomHeroItemSelect = function(self, select)
  -- function num : 0_2
  ((self.ui).onSelect):SetActive(select)
end

UINEpSptRoomHeroItem.SetEpSptRoomHeroItemHas = function(self, has)
  -- function num : 0_3
  ((self.ui).has):SetActive(has)
  self.has = has
end

UINEpSptRoomHeroItem._OnClickRoot = function(self)
  -- function num : 0_4
  if self.has then
    return 
  end
  if self.clickEvent ~= nil then
    (self.clickEvent)(self, self.dynHeroData, self.fightingPower)
  end
end

UINEpSptRoomHeroItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINEpSptRoomHeroItem


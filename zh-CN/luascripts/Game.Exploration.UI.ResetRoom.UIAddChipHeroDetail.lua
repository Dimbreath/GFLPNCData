-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAddChipHeroDetail = class("UIAddChipHeroDetail", UIBaseNode)
local UINHeroAttrItem = require("Game.Hero.Common.UINHeroAttrItem")
local UINHeroCardItem = require("Game.Hero.SortList.UINHeroCardItem")
local base = UIBaseNode
UIAddChipHeroDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroCardItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.heroItem = (UINHeroCardItem.New)()
  ;
  (self.heroItem):Init((self.ui).heroItem)
  self.listAttr = {}
  ;
  ((self.ui).attriItem):SetActive(false)
end

UIAddChipHeroDetail.InitHeroDetailItem = function(self, heroData, resLoader, onClickAction)
  -- function num : 0_1
  self.heroData = heroData
  self.heroId = heroData.dataId
  ;
  (self.heroItem):InitHeroHeroData(heroData.heroData, resLoader, onClickAction)
  self:UpdateProperty()
end

UIAddChipHeroDetail.ShowProperty = function(self, isShowProperty)
  -- function num : 0_2
  ((self.ui).propertyNode):SetActive(isShowProperty)
end

UIAddChipHeroDetail.SetSelectActive = function(self, active)
  -- function num : 0_3
  (self.heroItem):SetSelectActive(active)
end

UIAddChipHeroDetail.UpdateProperty = function(self)
  -- function num : 0_4 , upvalues : _ENV, UINHeroAttrItem
  for k,v in ipairs(eHeroShowAttrList) do
    local item = (self.listAttr)[v]
    if item == nil then
      item = (UINHeroAttrItem.New)()
      local go = ((self.ui).attriItem):Instantiate()
      go:SetActive(true)
      item:Init(go)
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self.listAttr)[v] = item
    end
    do
      do
        item:InitAttr(v, (self.heroData):GetRealAttr(v))
        -- DECOMPILER ERROR at PC30: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
end

return UIAddChipHeroDetail


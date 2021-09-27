local UIHeroUpgradePreviewNode = class("UIHeroUpgradePreviewNode", UIBaseNode)
local base = UIBaseNode
local UINHeroAttrItem = require("Game.Hero.Common.UINHeroAttrItem")
UIHeroUpgradePreviewNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).attriDetail_Item):SetActive(false)
  self.listAttr = {}
end

UIHeroUpgradePreviewNode.InitHeroData = function(self, heroData)
  -- function num : 0_1
  self.heroData = heroData
  self:RefreshHeroData()
  self:RefreshNextExp(0)
end

UIHeroUpgradePreviewNode.RefreshHeroData = function(self)
  -- function num : 0_2 , upvalues : _ENV, UINHeroAttrItem
  for k,v in ipairs(eHeroShowAttrList) do
    local value = (self.heroData):GetAttr(v)
    local item = (self.listAttr)[v]
    do
      do
        if item == nil then
          local go = ((self.ui).attriDetail_Item):Instantiate()
          go:SetActive(true)
          item = (UINHeroAttrItem.New)()
          item:Init(go.transform)
          -- DECOMPILER ERROR at PC26: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (self.listAttr)[v] = item
        end
        item:InitAttr(v, value)
        -- DECOMPILER ERROR at PC31: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_Exp).fillAmount = (self.heroData).expRatio
  ;
  ((self.ui).tex_Level):SetIndex(0, tostring((self.heroData).level))
end

UIHeroUpgradePreviewNode.RefreshNextExp = function(self, addExp)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  if addExp > 0 then
    ((self.ui).tex_ExpNum).text = "+" .. tostring(addExp)
  else
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_ExpNum).text = ""
  end
  local curLevel = (self.heroData).level
  local nextLevel, nextExp, nextTotalExp = (self.heroData):AddTestExp(addExp)
  local totalExp = (self.heroData):GetLevelTotalExp()
  local fillAmount = 0
  if curLevel < nextLevel then
    ((self.ui).tex_Level):SetIndex(1, tostring(nextLevel))
    fillAmount = 1
  else
    ;
    ((self.ui).tex_Level):SetIndex(0, tostring(curLevel))
    fillAmount = nextExp / totalExp
  end
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).img_ExpAdd).fillAmount = fillAmount
end

UIHeroUpgradePreviewNode.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UIHeroUpgradePreviewNode


local UIPie = class("UIPie", UIBaseNode)
local base = UIBaseNode
local UIPieItem = require("Game.BattleResult.Pie.UIPieItem")
local UIPieText = require("Game.BattleResult.Pie.UIPieText")
UIPie.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIPieItem, UIPieText
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).pieValueItem):SetActive(false)
  ;
  ((self.ui).tex_Rate):SetActive(false)
  self.pieItemPool = (UIItemPool.New)(UIPieItem, (self.ui).pieValueItem)
  self.pieTextPool = (UIItemPool.New)(UIPieText, (self.ui).tex_Rate)
end

UIPie.InitPie = function(self, proportionTab)
  -- function num : 0_1 , upvalues : _ENV
  local showPie = #proportionTab > 0
  ;
  ((self.ui).pie):SetActive(showPie)
  if not showPie then
    return 
  end
  ;
  (table.sort)(proportionTab, function(a, b)
    -- function num : 0_1_0
    do return b < a end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self.pieItemPool):HideAll()
  ;
  (self.pieTextPool):HideAll()
  do
    if (self.ui).maxCount < #proportionTab then
      local proportion = 0
      for i = (self.ui).maxCount, #proportionTab do
        proportion = proportionTab[i] + proportion
        proportionTab[i] = nil
      end
      proportionTab[(self.ui).maxCount] = proportionTab
    end
    local setShortBar = false
    local pieItemRot = Vector3.zero
    for k,v in ipairs(proportionTab) do
      local pieItem = (self.pieItemPool):GetOne()
      local color = self:GetPieColor(k)
      pieItem:InitPieItem(v, true, color)
      pieItem:SetItemRot(pieItemRot)
      pieItemRot = pieItemRot + pieItem:GetPieRot()
      if k == 1 then
        pieItem:SetScaleToBig()
      end
      if v < (self.ui).minProportion then
        pieItem:SetShortBar(setShortBar)
        setShortBar = not setShortBar
      end
      local pieText = (self.pieTextPool):GetOne()
      local textPos = pieItem:GetTextNodePos()
      pieText:InitPieText(v, textPos)
    end
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end
end

UIPie.GetPieColor = function(self, index)
  -- function num : 0_2 , upvalues : _ENV
  if (self.ui).maxCount < index then
    index = (self.ui).maxCount
  end
  return (self.ui)["color" .. tostring(index)]
end

UIPie.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (self.pieItemPool):DeleteAll()
  ;
  (self.pieTextPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UIPie


local UIBattleDPS = class("UIBattleDPS", UIBaseWindow)
local base = UIBaseWindow
local UINBattleDPSItem = require("Game.Battle.UI.UINBattleDPSItem")
UIBattleDPS.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBattleDPSItem
  (UIUtil.AddValueChangedListener)((self.ui).tog_DPS, self, self.OnPageChanged)
  self.achivTypeTogglePool = (UIItemPool.New)(UINBattleDPSItem, (self.ui).obj_template)
  ;
  ((self.ui).obj_template):SetActive(false)
  self.dpsItemDic = {}
  self.dpsItemList = {}
  self.maxDamage = 0
  self.oldDamage = 0
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tog_DPS).isOn = true
  ;
  ((self.ui).obj_panel):SetActive(true)
end

UIBattleDPS.OnHeroTakeDamage = function(self, role, damage)
  -- function num : 0_1 , upvalues : _ENV
  local id = 0
  if role ~= nil then
    id = role.roleDataId
  end
  if (self.dpsItemDic)[id] == nil then
    local item = (self.achivTypeTogglePool):GetOne(true)
    self.maxDamage = (math.max)(damage, self.maxDamage)
    item:InitDPSItem(id, damage, self.maxDamage)
    item.heroID = id
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self.dpsItemDic)[id] = item
    ;
    (table.insert)(self.dpsItemList, item)
  else
    do
      do
        local item = (self.dpsItemDic)[id]
        self.maxDamage = (math.max)(damage, self.maxDamage)
        item:AddDamage(damage, self.maxDamage)
        self:UpdateAll()
      end
    end
  end
end

UIBattleDPS.UpdateAll = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.maxDamage ~= self.oldDamage then
    self.oldDamage = self.maxDamage
    for id,item in pairs(self.dpsItemDic) do
      item:RefreshDamage(self.maxDamage)
    end
  end
end

UIBattleDPS.SortItem = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (table.sort)(self.dpsItemList, function(a, b)
    -- function num : 0_3_0
    if b.heroID >= a.heroID then
      do return a.damage ~= b.damage end
      do return b.damage < a.damage end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  for index,item in ipairs(self.dpsItemList) do
    (item.transform):SetSiblingIndex(index - 1)
  end
end

UIBattleDPS.OnPageChanged = function(self, bool)
  -- function num : 0_4
  if bool then
    ((self.ui).obj_panel):SetActive(true)
  else
    ;
    ((self.ui).obj_panel):SetActive(false)
  end
end

UIBattleDPS.OnHide = function(self)
  -- function num : 0_5 , upvalues : _ENV, base
  for id,item in pairs(self.dpsItemDic) do
    item:Clean()
  end
  ;
  (self.achivTypeTogglePool):HideAll()
  self.dpsItemDic = {}
  ;
  (base.OnHide)(self)
end

UIBattleDPS.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UIBattleDPS


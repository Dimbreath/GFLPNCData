local UINFmtHeroHpBarItem = class("UINFmtHeroHpBarItem", UIBaseNode)
local base = UIBaseNode
UINFmtHeroHpBarItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).block):SetActive(false)
  self.blockGoList = {}
end

UINFmtHeroHpBarItem.InitFmtHeroHpBarItem = function(self, hpPer, maxHp)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).bar).fillAmount = hpPer / 10000
  self:_UpdHpBlockSpliter(maxHp)
end

UINFmtHeroHpBarItem._UpdHpBlockSpliter = function(self, maxHp)
  -- function num : 0_2 , upvalues : _ENV
  local ok, unitBlood, bossUnitBlood, gridMax = (BattleUtil.TryGetCurBattleBloodGridCfg)()
  if not ok then
    return 
  end
  local splitCount = maxHp / unitBlood
  splitCount = (math.min)(gridMax, splitCount)
  for k,go in ipairs(self.blockGoList) do
    go:SetActive(false)
  end
  local width = (((((self.ui).block).transform).parent).rect).width
  local unitDis = width / splitCount
  local oriX = width / 2
  for i = 1, splitCount do
    local go = (self.blockGoList)[i]
    if go == nil then
      go = ((self.ui).block):Instantiate()
      -- DECOMPILER ERROR at PC44: Confused about usage of register: R15 in 'UnsetPending'

      ;
      (self.blockGoList)[i] = go
    end
    go:SetActive(true)
    local pos = (go.transform).localPosition
    pos.x = unitDis * i - oriX
    -- DECOMPILER ERROR at PC54: Confused about usage of register: R16 in 'UnsetPending'

    ;
    (go.transform).localPosition = pos
  end
end

UINFmtHeroHpBarItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINFmtHeroHpBarItem


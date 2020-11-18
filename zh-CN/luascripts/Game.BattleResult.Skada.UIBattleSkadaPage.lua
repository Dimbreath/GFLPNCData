-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBattleSkadaPage = class("UIBattleSkadaPage", UIBaseNode)
local base = UIBaseNode
local UIBattleSkadaItem = require("Game.BattleResult.Skada.UIBattleSkadaItem")
local UIBattleSkadaInfoPage = require("Game.BattleResult.SkadaInfo.UIBattleSkadaInfoPage")
local BattleSkadaEnum = (require("Game.BattleResult.Skada.BattleSkadaEnum"))
local cs_BattleStatistics = nil
local RoleType = {Player = 0, Enemy = 1}
UIBattleSkadaPage.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, RoleType, BattleSkadaEnum, UIBattleSkadaItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.OnClickReturn)
  ;
  (((self.ui).tog_Player).onValueChanged):AddListener(BindCallback(self, self.OnClickRoleChange, RoleType.Player))
  ;
  (((self.ui).tog_Enemy).onValueChanged):AddListener(BindCallback(self, self.OnClickRoleChange, RoleType.Enemy))
  ;
  (((self.ui).tog_DPS).onValueChanged):AddListener(BindCallback(self, self.OnClickDetail, (BattleSkadaEnum.eBattleSkadaType).Damage))
  ;
  (((self.ui).tog_Tank).onValueChanged):AddListener(BindCallback(self, self.OnClickDetail, (BattleSkadaEnum.eBattleSkadaType).TakeDamage))
  ;
  (((self.ui).tog_Heal).onValueChanged):AddListener(BindCallback(self, self.OnClickDetail, (BattleSkadaEnum.eBattleSkadaType).Heal))
  ;
  ((self.ui).skadaItem):SetActive(false)
  self.skadaItemPool = (UIItemPool.New)(UIBattleSkadaItem, (self.ui).skadaItem)
end

UIBattleSkadaPage.InitBattleSkadaPage = function(self, skadaInfoPage, battleStatistics, playerRoleList, enemyRoleList, resLoader)
  -- function num : 0_1 , upvalues : cs_BattleStatistics, BattleSkadaEnum, RoleType
  cs_BattleStatistics = battleStatistics
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.ui).skadaInfoPage = skadaInfoPage
  self.resLoader = resLoader
  self.playerSkada = self:GenSkada(playerRoleList, cs_BattleStatistics.playerDamage, cs_BattleStatistics.playerTakeDamage, cs_BattleStatistics.playerHeal)
  self.enemySkada = self:GenSkada(enemyRoleList, cs_BattleStatistics.enemyDamage, cs_BattleStatistics.enemyTakeDamage, cs_BattleStatistics.enemyHeal)
  self.skadaType = (BattleSkadaEnum.eBattleSkadaType).Damage
  self.roleType = RoleType.Player
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tog_Player).isOn = true
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tog_DPS).isOn = true
  self:RefreshSkadaUI()
end

UIBattleSkadaPage.GenSkada = function(self, roleList, damageDic, takeDamageDic, healDic)
  -- function num : 0_2 , upvalues : BattleSkadaEnum, _ENV
  local skadaList = {}
  local damageTotal = 0
  local takeDamageTotal = 0
  local healTotal = 0
  for i = 0, roleList.Count - 1 do
    local role = roleList[i]
    if not (role.character).onBench then
      local skada = {}
      skada.role = role
      skada.detail = {}
      local damage = self:__NewSkadaDetail()
      local ok, damageDetal = damageDic:TryGetValue(role)
      if ok then
        damage.value = damageDetal.damage
        damageTotal = damageTotal + damageDetal.damage
      end
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R18 in 'UnsetPending'

      ;
      (skada.detail)[(BattleSkadaEnum.eBattleSkadaType).Damage] = damage
      local takeDamage = self:__NewSkadaDetail()
      local ok, takeDamageDetail = takeDamageDic:TryGetValue(role)
      if ok then
        takeDamage.value = takeDamageDetail.damage
        takeDamageTotal = takeDamageTotal + takeDamageDetail.damage
      end
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R21 in 'UnsetPending'

      ;
      (skada.detail)[(BattleSkadaEnum.eBattleSkadaType).TakeDamage] = takeDamage
      local heal = self:__NewSkadaDetail()
      local ok, healDetail = healDic:TryGetValue(role)
      if ok then
        heal.value = healDetail.heal
        healTotal = healTotal + healDetail.heal
      end
      -- DECOMPILER ERROR at PC62: Confused about usage of register: R24 in 'UnsetPending'

      ;
      (skada.detail)[(BattleSkadaEnum.eBattleSkadaType).Heal] = heal
      ;
      (table.insert)(skadaList, skada)
    end
  end
  for k,v in ipairs(skadaList) do
    -- DECOMPILER ERROR at PC83: Confused about usage of register: R14 in 'UnsetPending'

    ((v.detail)[(BattleSkadaEnum.eBattleSkadaType).Damage]).proportion = ((v.detail)[(BattleSkadaEnum.eBattleSkadaType).Damage]).value / (damageTotal)
    -- DECOMPILER ERROR at PC94: Confused about usage of register: R14 in 'UnsetPending'

    ;
    ((v.detail)[(BattleSkadaEnum.eBattleSkadaType).TakeDamage]).proportion = ((v.detail)[(BattleSkadaEnum.eBattleSkadaType).TakeDamage]).value / (takeDamageTotal)
    -- DECOMPILER ERROR at PC105: Confused about usage of register: R14 in 'UnsetPending'

    ;
    ((v.detail)[(BattleSkadaEnum.eBattleSkadaType).Heal]).proportion = ((v.detail)[(BattleSkadaEnum.eBattleSkadaType).Heal]).value / (healTotal)
  end
  local skadaDetail = {}
  skadaDetail.list = skadaList
  skadaDetail.damageTotal = damageTotal
  skadaDetail.takeDamageTotal = takeDamageTotal
  skadaDetail.healTotal = healTotal
  return skadaDetail
end

UIBattleSkadaPage.__NewSkadaDetail = function(self)
  -- function num : 0_3
  return {value = 0, proportion = 0}
end

local SkadaSortFunc = {[(BattleSkadaEnum.eBattleSkadaType).Damage] = function(skada1, skada2)
  -- function num : 0_4 , upvalues : BattleSkadaEnum
  local damage1 = ((skada1.detail)[(BattleSkadaEnum.eBattleSkadaType).Damage]).value
  local damage2 = ((skada2.detail)[(BattleSkadaEnum.eBattleSkadaType).Damage]).value
  if damage2 >= damage1 then
    do return damage1 == damage2 end
    do return (skada1.role).roleDataId < (skada2.role).roleDataId end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end
, [(BattleSkadaEnum.eBattleSkadaType).TakeDamage] = function(skada1, skada2)
  -- function num : 0_5 , upvalues : BattleSkadaEnum
  local takeDamage1 = ((skada1.detail)[(BattleSkadaEnum.eBattleSkadaType).TakeDamage]).value
  local takeDamage2 = ((skada2.detail)[(BattleSkadaEnum.eBattleSkadaType).TakeDamage]).value
  if takeDamage2 >= takeDamage1 then
    do return takeDamage1 == takeDamage2 end
    do return (skada1.role).roleDataId < (skada2.role).roleDataId end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end
, [(BattleSkadaEnum.eBattleSkadaType).Heal] = function(skada1, skada2)
  -- function num : 0_6 , upvalues : BattleSkadaEnum
  local heal1 = ((skada1.detail)[(BattleSkadaEnum.eBattleSkadaType).Heal]).value
  local heal2 = ((skada2.detail)[(BattleSkadaEnum.eBattleSkadaType).Heal]).value
  if heal2 >= heal1 then
    do return heal1 == heal2 end
    do return (skada1.role).roleDataId < (skada2.role).roleDataId end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end
}
UIBattleSkadaPage.OnClickRoleChange = function(self, roleType, isOn)
  -- function num : 0_7
  if isOn then
    self.roleType = roleType
    self:RefreshSkadaUI()
  end
end

UIBattleSkadaPage.OnClickDetail = function(self, skadaType, isOn)
  -- function num : 0_8
  if isOn then
    self.skadaType = skadaType
    self:RefreshSkadaUI()
  end
end

UIBattleSkadaPage.RefreshSkadaUI = function(self)
  -- function num : 0_9 , upvalues : RoleType, _ENV, SkadaSortFunc
  (self.skadaItemPool):HideAll()
  local skada = nil
  if self.roleType == RoleType.Player then
    skada = self.playerSkada
  else
    if self.roleType == RoleType.Enemy then
      skada = self.enemySkada
    end
  end
  ;
  (table.sort)(skada.list, SkadaSortFunc[self.skadaType])
  for k,v in ipairs(skada.list) do
    local item = (self.skadaItemPool):GetOne()
    item:InitSkadaItem(self.resLoader, BindCallback(self, self.OnClickHeroDetail))
    item:RefreshSkadaItem(k, v, self.skadaType, self.roleType == RoleType.Player)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIBattleSkadaPage.OnClickHeroDetail = function(self, roleSkada, roleIndex)
  -- function num : 0_10 , upvalues : UIBattleSkadaInfoPage, RoleType, _ENV
  self.selectRoleIndex = roleIndex
  if self.skadaInfoPage == nil then
    self.skadaInfoPage = (UIBattleSkadaInfoPage.New)()
    ;
    (self.skadaInfoPage):Init((self.ui).skadaInfoPage)
  end
  ;
  (self.skadaInfoPage):Show()
  local belongPlayer = self.roleType == RoleType.Player
  local roleSkadaDetail = self:GenRoleSkadaDetail(roleSkada, belongPlayer)
  ;
  (self.skadaInfoPage):InitSkadaInfoPage(roleSkadaDetail, belongPlayer, self.resLoader, self.skadaType, BindCallback(self, self.OnSwitchPlayer))
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIBattleSkadaPage.GenRoleSkadaDetail = function(self, roleSkada, belongPlayer)
  -- function num : 0_11 , upvalues : BattleSkadaEnum, cs_BattleStatistics, _ENV
  local roleSkadaDetail = {}
  roleSkadaDetail.role = roleSkada.role
  local damage = {}
  roleSkadaDetail[(BattleSkadaEnum.eBattleSkadaType).Damage] = damage
  local damageDic = belongPlayer and cs_BattleStatistics.playerDamage or cs_BattleStatistics.enemyDamage
  local ok, damageDetail = damageDic:TryGetValue(roleSkada.role)
  if ok then
    for k,v in pairs(damageDetail.damageDic) do
      local detail = {}
      detail.csDetail = v
      detail.proportion = v.damage / damageDetail.damage
      ;
      (table.insert)(damage, detail)
    end
    ;
    (table.sort)(damage, function(damage1, damage2)
    -- function num : 0_11_0
    do return damage2.proportion < damage1.proportion end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
  local takeDamage = {}
  roleSkadaDetail[(BattleSkadaEnum.eBattleSkadaType).TakeDamage] = takeDamage
  local takeDamageDic = belongPlayer and cs_BattleStatistics.playerTakeDamage or cs_BattleStatistics.enemyTakeDamage
  local ok, takeDamageDetail = takeDamageDic:TryGetValue(roleSkada.role)
  if ok then
    for k,v in pairs(takeDamageDetail.takeDamageDic) do
      local detail = {}
      detail.csDetail = v
      detail.proportion = v.damage / takeDamageDetail.damage
      ;
      (table.insert)(takeDamage, detail)
    end
    ;
    (table.sort)(takeDamage, function(takeDamage1, takeDamage2)
    -- function num : 0_11_1
    do return takeDamage2.proportion < takeDamage1.proportion end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
  local heal = {}
  roleSkadaDetail[(BattleSkadaEnum.eBattleSkadaType).Heal] = heal
  local healDic = belongPlayer and cs_BattleStatistics.playerHeal or cs_BattleStatistics.enemyHeal
  local ok, healDetail = healDic:TryGetValue(roleSkada.role)
  if ok then
    for k,v in pairs(healDetail.healDic) do
      local detail = {}
      detail.csDetail = v
      detail.proportion = v.heal / healDetail.heal
      ;
      (table.insert)(heal, detail)
    end
    ;
    (table.sort)(heal, function(heal1, heal2)
    -- function num : 0_11_2
    do return heal2.proportion < heal1.proportion end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
  return roleSkadaDetail
end

UIBattleSkadaPage.OnSwitchPlayer = function(self, isLeft)
  -- function num : 0_12 , upvalues : RoleType
  local belongPlayer = self.roleType == RoleType.Player
  self.selectRoleIndex = (isLeft and -1 or 1) + self.selectRoleIndex
  if not belongPlayer or not self.playerSkada then
    local skada = self.enemySkada
  end
  local listCount = #skada.list
  if self.selectRoleIndex < 1 then
    self.selectRoleIndex = listCount
  elseif listCount < self.selectRoleIndex then
    self.selectRoleIndex = 1
  end
  local roleSkada = (skada.list)[self.selectRoleIndex]
  local roleSkadaDetail = self:GenRoleSkadaDetail(roleSkada, belongPlayer)
  ;
  (self.skadaInfoPage):SwitchRoleSkada(roleSkadaDetail)
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

UIBattleSkadaPage.OnClickReturn = function(self)
  -- function num : 0_13
  self:Hide()
end

UIBattleSkadaPage.OnDelete = function(self)
  -- function num : 0_14 , upvalues : base
  (self.skadaItemPool):DeleteAll()
  if self.skadaInfoPage ~= nil then
    (self.skadaInfoPage):Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UIBattleSkadaPage


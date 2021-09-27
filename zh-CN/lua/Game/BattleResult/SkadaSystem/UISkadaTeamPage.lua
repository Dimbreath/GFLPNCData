local UISkadaTeamPage = class("UISkadaTeamPage", UIBaseNode)
local base = UIBaseNode
local UINSkadaTeamItem = require("Game.BattleResult.SkadaSystem.UINSkadaTeamItem")
local SkadaEnum = require("Game.BattleResult.SkadaSystem.SkadaEnum")
local RoleType = {Player = 0, Enemy = 1}
UISkadaTeamPage.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINSkadaTeamItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ChangeTeam, self, self.OnBtnChangedTeamClicked)
  self.__OnClickHeroDetail = BindCallback(self, self.OnClickHeroDetail)
  self.__OnInfoPageReturn = BindCallback(self, self.OnInfoPageReturn)
  ;
  ((self.ui).skadaItem):SetActive(false)
  self.skadaItemPool = (UIItemPool.New)(UINSkadaTeamItem, (self.ui).skadaItem)
end

UISkadaTeamPage.InitSkadaTeamPage = function(self, battleStatistics, playerRoleList, enemyRoleList, resLoader, panelSkadaInfoPage)
  -- function num : 0_1 , upvalues : RoleType
  self.battleStatistics = battleStatistics
  self.resLoader = resLoader
  self.panelSkadaInfoPage = panelSkadaInfoPage
  self.playerSkada = self:GenSkada(battleStatistics, playerRoleList, battleStatistics.playerDamage, battleStatistics.playerTakeDamage, battleStatistics.playerHeal, true)
  self.enemySkada = self:GenSkada(battleStatistics, enemyRoleList, battleStatistics.enemyDamage, battleStatistics.enemyTakeDamage, battleStatistics.enemyHeal)
  self.roleType = RoleType.Player
end

UISkadaTeamPage.GenSkada = function(self, battleStatistics, roleList, damageDic, takeDamageDic, healDic, containCommander)
  -- function num : 0_2 , upvalues : SkadaEnum, _ENV
  local skadaList = {}
  local damageTotal = 0
  local takeDamageTotal = 0
  local healTotal = 0
  for i = 0, roleList.Count - 1 do
    local role = roleList[i]
    if not (role.character).onBench then
      local skada = {}
      skada.isCommander = false
      skada.role = role
      skada.detail = {}
      skada.id = role.roleDataId
      local damage = self:__NewSkadaDetail()
      local ok, damageDetal = damageDic:TryGetValue(role)
      if ok then
        damage.value = damageDetal.damage
        damageTotal = damageTotal + damageDetal.damage
      end
      -- DECOMPILER ERROR at PC35: Confused about usage of register: R20 in 'UnsetPending'

      ;
      (skada.detail)[(SkadaEnum.eSkadaType).Damage] = damage
      local takeDamage = self:__NewSkadaDetail()
      local ok, takeDamageDetail = takeDamageDic:TryGetValue(role)
      if ok then
        takeDamage.value = takeDamageDetail.damage
        takeDamageTotal = takeDamageTotal + takeDamageDetail.damage
      end
      -- DECOMPILER ERROR at PC50: Confused about usage of register: R23 in 'UnsetPending'

      ;
      (skada.detail)[(SkadaEnum.eSkadaType).TakeDamage] = takeDamage
      local heal = self:__NewSkadaDetail()
      local ok, healDetail = healDic:TryGetValue(role)
      if ok then
        heal.value = healDetail.heal
        healTotal = healTotal + healDetail.heal
      end
      -- DECOMPILER ERROR at PC65: Confused about usage of register: R26 in 'UnsetPending'

      ;
      (skada.detail)[(SkadaEnum.eSkadaType).Heal] = heal
      ;
      (table.insert)(skadaList, skada)
    end
  end
  if containCommander then
    local skada = {}
    skada.isCommander = true
    skada.detail = {}
    skada.id = CommonUtil.Int32Max
    local damage = self:__NewSkadaDetail()
    local damageNumber = (battleStatistics.cmderDamage).damage
    damage.value = damageNumber
    damageTotal = damageTotal + damageNumber
    -- DECOMPILER ERROR at PC90: Confused about usage of register: R14 in 'UnsetPending'

    ;
    (skada.detail)[(SkadaEnum.eSkadaType).Damage] = damage
    local takeDamage = self:__NewSkadaDetail()
    -- DECOMPILER ERROR at PC96: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (skada.detail)[(SkadaEnum.eSkadaType).TakeDamage] = takeDamage
    local heal = self:__NewSkadaDetail()
    local healNumber = (battleStatistics.cmderHeal).heal
    heal.value = healNumber
    healTotal = healTotal + healNumber
    -- DECOMPILER ERROR at PC106: Confused about usage of register: R17 in 'UnsetPending'

    ;
    (skada.detail)[(SkadaEnum.eSkadaType).Heal] = heal
    ;
    (table.insert)(skadaList, skada)
  end
  do
    for k,v in ipairs(skadaList) do
      -- DECOMPILER ERROR at PC131: Confused about usage of register: R16 in 'UnsetPending'

      if damageTotal ~= 0 or not 0 then
        ((v.detail)[(SkadaEnum.eSkadaType).Damage]).proportion = ((v.detail)[(SkadaEnum.eSkadaType).Damage]).value / (damageTotal)
        -- DECOMPILER ERROR at PC147: Confused about usage of register: R16 in 'UnsetPending'

        if takeDamageTotal ~= 0 or not 0 then
          ((v.detail)[(SkadaEnum.eSkadaType).TakeDamage]).proportion = ((v.detail)[(SkadaEnum.eSkadaType).TakeDamage]).value / (takeDamageTotal)
          -- DECOMPILER ERROR at PC163: Confused about usage of register: R16 in 'UnsetPending'

          if healTotal ~= 0 or not 0 then
            do
              ((v.detail)[(SkadaEnum.eSkadaType).Heal]).proportion = ((v.detail)[(SkadaEnum.eSkadaType).Heal]).value / (healTotal)
              -- DECOMPILER ERROR at PC164: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC164: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC164: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC164: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC164: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC164: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
    local skadaDetail = {}
    skadaDetail.list = skadaList
    skadaDetail.damageTotal = damageTotal
    skadaDetail.takeDamageTotal = takeDamageTotal
    skadaDetail.healTotal = healTotal
    return skadaDetail
  end
end

UISkadaTeamPage.__NewSkadaDetail = function(self)
  -- function num : 0_3
  return {value = 0, proportion = 0}
end

UISkadaTeamPage.OnSkadaTypeChanged = function(self, skadaType)
  -- function num : 0_4
  self.skadaType = skadaType
  self:RefreshSkadaUI()
end

UISkadaTeamPage.RefreshSkadaUI = function(self)
  -- function num : 0_5 , upvalues : RoleType, _ENV, SkadaEnum
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
  (table.sort)(skada.list, (SkadaEnum.SkadaSortFunc)[self.skadaType])
  for k,v in ipairs(skada.list) do
    local item = (self.skadaItemPool):GetOne()
    item:InitSkadaItem(self.resLoader, self.__OnClickHeroDetail)
    item:RefreshSkadaItem(k, v, self.skadaType, self.roleType == RoleType.Player)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UISkadaTeamPage.OnClickHeroDetail = function(self, roleSkada, roleIndex)
  -- function num : 0_6 , upvalues : RoleType
  local belongPlayer = self.roleType == RoleType.Player
  if not belongPlayer or not self.playerSkada then
    local temaSkada = self.enemySkada
  end
  ;
  (self.panelSkadaInfoPage):ShowSkadaInfoPage(roleIndex, temaSkada, belongPlayer, self.__OnInfoPageReturn)
  self:Hide()
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UISkadaTeamPage.OnBtnChangedTeamClicked = function(self)
  -- function num : 0_7
  self.roleType = 1 - self.roleType
  ;
  ((self.ui).tex_ChangeTeam):SetIndex(self.roleType)
  self:RefreshSkadaUI()
end

UISkadaTeamPage.OnInfoPageReturn = function(self)
  -- function num : 0_8
  self:Show()
end

return UISkadaTeamPage


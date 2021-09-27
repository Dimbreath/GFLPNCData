local UISkadaInfoPage = class("UISkadaInfoPage", UIBaseNode)
local base = UIBaseNode
local SkadaEnum = require("Game.BattleResult.SkadaSystem.SkadaEnum")
local UINRoleHeadItem = require("Game.CommonUI.Hero.UINRoleHeadItem")
local UINSkadaInfoItem = require("Game.BattleResult.SkadaSystem.UINSkadaInfoItem")
local dpsSkillColorType = {[0] = 1, [1] = 2, [2] = 2, [3] = 4}
UISkadaInfoPage.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINRoleHeadItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.OnBtnReturnClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Befor, self, self.OnBtnBeforClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_After, self, self.OnBtnAfterClicked)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).skadaInfoList).onInstantiateItem = BindCallback(self, self.__SkadaInfoInitItem)
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).skadaInfoList).onChangeItem = BindCallback(self, self.__SkadaInfoItemChanged)
  self.skadaInfoItemDic = {}
  self.roleHeadItem = (UINRoleHeadItem.New)()
  ;
  (self.roleHeadItem):Init((self.ui).roleHeadItem)
end

UISkadaInfoPage.OnSkadaTypeChanged = function(self, skadaType)
  -- function num : 0_1
  self.skadaType = skadaType
  if self.active then
    self:RefreshSkadaInfoUI()
  end
end

UISkadaInfoPage.FirstInitSkadaInfoPage = function(self, resloader, battleStatistics)
  -- function num : 0_2
  self.resloader = resloader
  self.battleStatistics = battleStatistics
end

UISkadaInfoPage.ShowSkadaInfoPage = function(self, roleIndex, teamSkada, belongPlayer, returnAction)
  -- function num : 0_3
  self.selectRoleIndex = roleIndex
  self.teamSkada = teamSkada
  self.belongPlayer = belongPlayer
  self.returnAction = returnAction
  self:Show()
  local roleSkada = ((self.teamSkada).list)[self.selectRoleIndex]
  local roleSkadaDetail = self:GenRoleSkadaDetail(roleSkada, self.belongPlayer)
  self:ShowRoleSkada(roleSkadaDetail)
end

UISkadaInfoPage.ShowRoleSkada = function(self, roleSkadaDetail)
  -- function num : 0_4 , upvalues : _ENV
  self.roleSkadaDetail = roleSkadaDetail
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  if roleSkadaDetail.isCommander then
    ((self.ui).tex_HeroName).text = ConfigData:GetTipContent(TipContent.CommanderDPSName)
    ;
    (self.roleHeadItem):InitCommanderHeadItem(self.resloader, nil)
  else
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_HeroName).text = (roleSkadaDetail.role).name
    local dynRole = (roleSkadaDetail.role).character
    ;
    (self.roleHeadItem):InitRoleHeadItem(dynRole, self.resloader, nil, self.belongPlayer)
  end
  do
    self:RefreshSkadaInfoUI()
  end
end

UISkadaInfoPage.RefreshSkadaInfoUI = function(self)
  -- function num : 0_5 , upvalues : SkadaEnum
  (((self.ui).tex_Count).gameObject):SetActive(self.skadaType == (SkadaEnum.eSkadaType).Damage)
  ;
  ((self.ui).tex_Name):SetIndex(self.skadaType - 1)
  local valueTextIndex = 0
  if self.skadaType == (SkadaEnum.eSkadaType).Heal then
    valueTextIndex = 1
  end
  ;
  ((self.ui).tex_Value):SetIndex(valueTextIndex)
  self:__ReFillSkadaInfoList()
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UISkadaInfoPage.__ReFillSkadaInfoList = function(self)
  -- function num : 0_6
  local detailList = (self.roleSkadaDetail)[self.skadaType]
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).skadaInfoList).totalCount = #detailList
  ;
  ((self.ui).skadaInfoList):RefillCells()
end

UISkadaInfoPage.__SkadaInfoInitItem = function(self, go)
  -- function num : 0_7 , upvalues : UINSkadaInfoItem
  local skadaInfoItem = (UINSkadaInfoItem.New)()
  skadaInfoItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.skadaInfoItemDic)[go] = skadaInfoItem
end

UISkadaInfoPage.__SkadaInfoItemChanged = function(self, go, index)
  -- function num : 0_8 , upvalues : _ENV, SkadaEnum, dpsSkillColorType
  local skadaInfoItem = (self.skadaInfoItemDic)[go]
  if skadaInfoItem == nil then
    error("Can\'t find Item by gameObject")
    return 
  end
  index = index + 1
  local detailList = (self.roleSkadaDetail)[self.skadaType]
  local skadaValueData = detailList[index]
  if skadaValueData == nil then
    error("Can\'t find skadaValueData by index, index = " .. tonumber(index))
  end
  local count = nil
  local csDetail = skadaValueData.csDetail
  local name = csDetail.name
  local color = Color.white
  local value = 0
  if self.skadaType == (SkadaEnum.eSkadaType).Damage then
    count = csDetail.count
    local colorIndex = dpsSkillColorType[csDetail.skillTag]
    color = (self.ui)["infoColor" .. tostring(colorIndex)]
    value = csDetail.damage
  else
    do
      if self.skadaType == (SkadaEnum.eSkadaType).TakeDamage then
        value = csDetail.damage
        color = (self.ui).color_TakeDamage
      else
        if self.skadaType == (SkadaEnum.eSkadaType).Heal then
          value = csDetail.heal
          color = (self.ui).color_heal
        end
      end
      skadaInfoItem:InitSkadaInfoItem(color, name, count, value, skadaValueData.proportion)
    end
  end
end

UISkadaInfoPage.OnSwitchPlayer = function(self, isLeft)
  -- function num : 0_9
  self.selectRoleIndex = (isLeft and -1 or 1) + self.selectRoleIndex
  local listCount = #(self.teamSkada).list
  if self.selectRoleIndex < 1 then
    self.selectRoleIndex = listCount
  else
    if listCount < self.selectRoleIndex then
      self.selectRoleIndex = 1
    end
  end
  local roleSkada = ((self.teamSkada).list)[self.selectRoleIndex]
  local roleSkadaDetail = self:GenRoleSkadaDetail(roleSkada, self.belongPlayer)
  self:ShowRoleSkada(roleSkadaDetail)
end

UISkadaInfoPage.GenRoleSkadaDetail = function(self, roleSkada, belongPlayer)
  -- function num : 0_10 , upvalues : SkadaEnum, _ENV
  local roleSkadaDetail = {}
  if roleSkada.isCommander then
    roleSkadaDetail.isCommander = true
    local damage = {}
    roleSkadaDetail[(SkadaEnum.eSkadaType).Damage] = damage
    local damageDetail = (self.battleStatistics).cmderDamage
    for k,v in pairs(damageDetail.damageDic) do
      local detail = {}
      detail.csDetail = v
      detail.proportion = v.damage / damageDetail.damage
      ;
      (table.insert)(damage, detail)
    end
    ;
    (table.sort)(damage, function(damage1, damage2)
    -- function num : 0_10_0
    do return damage2.proportion < damage1.proportion end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    roleSkadaDetail[(SkadaEnum.eSkadaType).TakeDamage] = {}
    local heal = {}
    roleSkadaDetail[(SkadaEnum.eSkadaType).Heal] = heal
    local healDetail = (self.battleStatistics).cmderHeal
    for k,v in pairs(healDetail.healDic) do
      local detail = {}
      detail.csDetail = v
      detail.proportion = v.heal / healDetail.heal
      ;
      (table.insert)(heal, detail)
    end
    ;
    (table.sort)(heal, function(heal1, heal2)
    -- function num : 0_10_1
    do return heal2.proportion < heal1.proportion end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    return roleSkadaDetail
  end
  do
    roleSkadaDetail.isCommander = false
    roleSkadaDetail.role = roleSkada.role
    local damage = {}
    roleSkadaDetail[(SkadaEnum.eSkadaType).Damage] = damage
    if not belongPlayer or not (self.battleStatistics).playerDamage then
      local damageDic = (self.battleStatistics).enemyDamage
    end
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
    -- function num : 0_10_2
    do return damage2.proportion < damage1.proportion end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    end
    local takeDamage = {}
    roleSkadaDetail[(SkadaEnum.eSkadaType).TakeDamage] = takeDamage
    if not belongPlayer or not (self.battleStatistics).playerTakeDamage then
      local takeDamageDic = (self.battleStatistics).enemyTakeDamage
    end
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
    -- function num : 0_10_3
    do return takeDamage2.proportion < takeDamage1.proportion end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    end
    local heal = {}
    roleSkadaDetail[(SkadaEnum.eSkadaType).Heal] = heal
    if not belongPlayer or not (self.battleStatistics).playerHeal then
      local healDic = (self.battleStatistics).enemyHeal
    end
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
    -- function num : 0_10_4
    do return heal2.proportion < heal1.proportion end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    end
    return roleSkadaDetail
  end
end

UISkadaInfoPage.OnBtnBeforClicked = function(self)
  -- function num : 0_11
  self:OnSwitchPlayer(true)
end

UISkadaInfoPage.OnBtnAfterClicked = function(self)
  -- function num : 0_12
  self:OnSwitchPlayer(false)
end

UISkadaInfoPage.OnBtnReturnClicked = function(self)
  -- function num : 0_13
  self:Hide()
  if self.returnAction ~= nil then
    (self.returnAction)()
  end
end

UISkadaInfoPage.OnDelete = function(self)
  -- function num : 0_14 , upvalues : base
  (base.OnDelete)(self)
end

return UISkadaInfoPage


-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBattleSkadaInfoPage = class("UIBattleSkadaInfoPage", UIBaseNode)
local base = UIBaseNode
local UIBattleSkadaInfoItem = require("Game.BattleResult.SkadaInfo.UIBattleSkadaInfoItem")
local UIPie = require("Game.BattleResult.Pie.UIPie")
local BattleSkadaEnum = require("Game.BattleResult.Skada.BattleSkadaEnum")
UIBattleSkadaInfoPage.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, BattleSkadaEnum, UIBattleSkadaInfoItem, UIPie
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.OnClickReturn)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Left, self, self.OnClickLeft)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Right, self, self.OnClickRight)
  ;
  (((self.ui).tog_DPS).onValueChanged):AddListener(BindCallback(self, self.OnClickDetail, (BattleSkadaEnum.eBattleSkadaType).Damage))
  ;
  (((self.ui).tog_Tank).onValueChanged):AddListener(BindCallback(self, self.OnClickDetail, (BattleSkadaEnum.eBattleSkadaType).TakeDamage))
  ;
  (((self.ui).tog_Heal).onValueChanged):AddListener(BindCallback(self, self.OnClickDetail, (BattleSkadaEnum.eBattleSkadaType).Heal))
  ;
  ((self.ui).skillItem):SetActive(false)
  self.infoItemPool = (UIItemPool.New)(UIBattleSkadaInfoItem, (self.ui).skillItem)
  self.pie = (UIPie.New)()
  ;
  (self.pie):Init((self.ui).pieChartNode)
end

UIBattleSkadaInfoPage.InitSkadaInfoPage = function(self, roleSkadaDetail, belongPlayer, resLoader, skadaType, onSwitchPlayerEvent)
  -- function num : 0_1
  self.skadaType = skadaType
  self.onSwitchPlayerEvent = onSwitchPlayerEvent
  self.belongPlayer = belongPlayer
  self.resLoader = resLoader
  self:SwitchRoleSkada(roleSkadaDetail)
end

UIBattleSkadaInfoPage.SwitchRoleSkada = function(self, roleSkadaDetail)
  -- function num : 0_2 , upvalues : _ENV, BattleSkadaEnum
  self.roleSkadaDetail = roleSkadaDetail
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_HeroName).text = (roleSkadaDetail.role).name
  if not self.belongPlayer or not PathConsts:GetCharacterPicPath(((roleSkadaDetail.role).character):GetResPicName()) then
    local path = PathConsts:GetCharacterSmallPicPath(((roleSkadaDetail.role).character):GetResPicName())
  end
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_HeroPic).texture = (self.resLoader):LoadABAsset(path)
  local uvRect = ((self.ui).img_HeroPic).uvRect
  if self.belongPlayer then
    uvRect:Set(0, 0.5, 0.5, 0.5)
  else
    uvRect:Set(0, 0, 1, 1)
  end
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_HeroPic).uvRect = uvRect
  ;
  ((self.ui).togGroup_Battle):SetAllTogglesOff()
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R4 in 'UnsetPending'

  if self.skadaType == (BattleSkadaEnum.eBattleSkadaType).Damage then
    ((self.ui).tog_DPS).isOn = true
  else
    -- DECOMPILER ERROR at PC74: Confused about usage of register: R4 in 'UnsetPending'

    if self.skadaType == (BattleSkadaEnum.eBattleSkadaType).TakeDamage then
      ((self.ui).tog_Tank).isOn = true
    else
      -- DECOMPILER ERROR at PC83: Confused about usage of register: R4 in 'UnsetPending'

      if self.skadaType == (BattleSkadaEnum.eBattleSkadaType).Heal then
        ((self.ui).tog_Heal).isOn = true
      end
    end
  end
end

UIBattleSkadaInfoPage.OnClickDetail = function(self, skadaType, isOn)
  -- function num : 0_3
  if isOn then
    self.skadaType = skadaType
    self:RefreshSkadaInfoUI()
  end
end

UIBattleSkadaInfoPage.RefreshSkadaInfoUI = function(self)
  -- function num : 0_4 , upvalues : BattleSkadaEnum, _ENV
  ((self.ui).text_count):SetActive(self.skadaType == (BattleSkadaEnum.eBattleSkadaType).Damage)
  ;
  ((self.ui).text_skill):SetIndex(self.skadaType - 1)
  ;
  (self.infoItemPool):HideAll()
  local proportionTab = {}
  if self.skadaType == (BattleSkadaEnum.eBattleSkadaType).Damage then
    local detailList = (self.roleSkadaDetail)[self.skadaType]
    for k,v in ipairs(detailList) do
      local infoItem = (self.infoItemPool):GetOne()
      local color = (self.pie):GetPieColor(k)
      infoItem:InitSkadaInfoItem(color, (v.csDetail).name, (v.csDetail).count, (v.csDetail).damage, v.proportion)
      ;
      (table.insert)(proportionTab, v.proportion)
    end
  elseif self.skadaType == (BattleSkadaEnum.eBattleSkadaType).TakeDamage then
    local detailList = (self.roleSkadaDetail)[self.skadaType]
    for k,v in ipairs(detailList) do
      local infoItem = (self.infoItemPool):GetOne()
      local color = (self.pie):GetPieColor(k)
      infoItem:InitSkadaInfoItem(color, (v.csDetail).name, nil, (v.csDetail).damage, v.proportion)
      ;
      (table.insert)(proportionTab, v.proportion)
    end
  elseif self.skadaType == (BattleSkadaEnum.eBattleSkadaType).Heal then
    local detailList = (self.roleSkadaDetail)[self.skadaType]
    for k,v in ipairs(detailList) do
      local infoItem = (self.infoItemPool):GetOne()
      local color = (self.pie):GetPieColor(k)
      infoItem:InitSkadaInfoItem(color, (v.csDetail).name, nil, (v.csDetail).heal, v.proportion)
      ;
      (table.insert)(proportionTab, v.proportion)
    end
  end
  ;
  (self.pie):InitPie(proportionTab)
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

UIBattleSkadaInfoPage.OnClickLeft = function(self)
  -- function num : 0_5
  if self.onSwitchPlayerEvent ~= nil then
    (self.onSwitchPlayerEvent)(true)
  end
end

UIBattleSkadaInfoPage.OnClickRight = function(self)
  -- function num : 0_6
  if self.onSwitchPlayerEvent ~= nil then
    (self.onSwitchPlayerEvent)(false)
  end
end

UIBattleSkadaInfoPage.OnClickReturn = function(self)
  -- function num : 0_7
  self:Hide()
end

UIBattleSkadaInfoPage.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  (self.infoItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UIBattleSkadaInfoPage


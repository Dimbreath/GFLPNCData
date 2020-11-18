-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBattleDeploy = class("UIBattleDeploy", UIBaseWindow)
local base = UIBaseWindow
local UINCampFetterItem = require("Game.Battle.UI.UINCampFetterItem")
local cs_coroutine = require("XLua.Common.cs_coroutine")
UIBattleDeploy.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  ((self.ui).campFetterItem):SetActive(false)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_NodeFetter, self, self.OnBtnNodeFetterClicked)
  self.campFetterItems = {}
  self.__OnCampFetterClicked = BindCallback(self, self.OnCampFetterClicked)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).image_CompanyIcon = (self.transform):FindComponent("Img_Icon", eUnityComponentID.Image)
  self.isShowingHeroInfo = false
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock, true)
  local isEnemyDetailUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_EnemyDetail)
  self:OnEnemyDetailUnlock(isEnemyDetailUnlock)
end

UIBattleDeploy.InitBattleDeployUI = function(self, dynPlayer)
  -- function num : 0_1 , upvalues : _ENV, UINCampFetterItem
  self.dynPlayer = dynPlayer
  local campCount = {}
  for k,dynHero in pairs(dynPlayer.heroList) do
    local campId = dynHero:GetCamp()
    campCount[campId] = (campCount[campId] or 0) + 1
  end
  for k,v in pairs(campCount) do
    local go = ((self.ui).campFetterItem):Instantiate()
    go:SetActive(true)
    local fetterItem = (UINCampFetterItem.New)()
    fetterItem:Init(go)
    fetterItem:InitFetterItem(k, v, self.__OnCampFetterClicked)
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.campFetterItems)[k] = fetterItem
  end
end

UIBattleDeploy.OnBtnNodeFetterClicked = function(self)
  -- function num : 0_2
  (((self.ui).btn_NodeFetter).gameObject):SetActive(false)
end

UIBattleDeploy.OnCampFetterClicked = function(self, fetterItem)
  -- function num : 0_3 , upvalues : _ENV
  local campId = fetterItem.campId
  local campFetterList = ((ConfigData.camp_connection).fetterList)[fetterItem.campId]
  if campFetterList == nil then
    return 
  end
  local activeFetter = ConfigData:GetCampFetter(fetterItem.campId, fetterItem.fetters_num)
  local fetterNum = 0
  if activeFetter ~= nil then
    fetterNum = activeFetter.fetters_num
  end
  local textInfo = (LanguageUtil.GetLocaleText)((fetterItem.campCfg).name) .. "羁绊:\n"
  for k,v in ipairs(campFetterList) do
    local fetterCfg = ((ConfigData.camp_connection)[fetterItem.campId])[v]
    if fetterCfg.fetters_num == fetterNum then
      textInfo = textInfo .. (string.format)("<color=#2be8eb>%d人:%s</color>\n", fetterCfg.fetters_num, fetterCfg:GetDescribe())
    else
      textInfo = textInfo .. (string.format)("%d人:%s\n", fetterCfg.fetters_num, fetterCfg:GetDescribe())
    end
  end
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_FetterDetail).text = textInfo
  ;
  (((self.ui).btn_NodeFetter).gameObject):SetActive(true)
end

UIBattleDeploy.ShowHeroRoleInfo = function(self, hero)
  -- function num : 0_4 , upvalues : _ENV
  self.isShowingHeroInfo = true
  ;
  (UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)):ShowHero(hero)
end

UIBattleDeploy.ShowMonsterRoleInfo = function(self, battleCharacterView, monster)
  -- function num : 0_5 , upvalues : _ENV
  if not self.onEnemyDetailUnlock then
    return 
  end
  if self.battleCharacterViewList ~= nil then
    for _,view in ipairs(self.battleCharacterViewList) do
      view:ShowNewArrow(false)
    end
    self.battleCharacterViewList = nil
  end
  local isNew = battleCharacterView.isNew
  if isNew then
    self.battleCharacterViewList = {}
    ;
    (table.insert)(self.battleCharacterViewList, battleCharacterView)
    local enemyList = ((((ExplorationManager.epCtrl).battleCtrl).battleCtrl).EnemyTeamController).battleOriginRoleList
    for i = 0, enemyList.Count - 1 do
      local enemy = enemyList[i]
      if enemy.roleDataId == monster.dataId then
        (table.insert)(self.battleCharacterViewList, enemy.battleRoleView)
      end
    end
  end
  do
    self.isShowEnemyDetail = true
    UIManager:ShowWindowAsync(UIWindowTypeID.BattleEnemyDetail, function(window)
    -- function num : 0_5_0 , upvalues : self, monster, isNew
    if self.isShowEnemyDetail then
      window:InitBattleEnemyDetail(monster, isNew)
    else
      window:Hide()
    end
  end
)
  end
end

UIBattleDeploy.HideHeroRoleInfo = function(self)
  -- function num : 0_6
  self.isShowingHeroInfo = false
end

UIBattleDeploy.HideMonsterRoleInfo = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if not self.onEnemyDetailUnlock then
    return 
  end
  if self.battleCharacterViewList ~= nil then
    for _,view in ipairs(self.battleCharacterViewList) do
      view:ShowNewArrow(false)
    end
    self.battleCharacterViewList = nil
  end
  self.isShowEnemyDetail = false
  UIManager:HideWindow(UIWindowTypeID.BattleEnemyDetail)
end

UIBattleDeploy.IsHeroOrMonsterInfoShow = function(self)
  -- function num : 0_8
  if not self.isShowingHeroInfo then
    return self.isShowEnemyDetail
  end
end

UIBattleDeploy.SetEpChipListUIActive = function(self, active)
  -- function num : 0_9 , upvalues : _ENV
  if active then
    local win = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
    if win ~= nil then
      win:Show()
      win:SetHeroListActive(false)
      win:SetHeroListHpBar(false)
      win:SetMoneyActive(false)
    end
  else
    do
      local win = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
      if win ~= nil then
        win:SetHeroListActive(true)
        win:SetHeroListHpBar(true)
        win:SetMoneyActive(true)
        win:Hide()
      end
    end
  end
end

UIBattleDeploy.OnEnemyDetailUnlock = function(self, active)
  -- function num : 0_10
  self.onEnemyDetailUnlock = active
end

UIBattleDeploy.OnDelete = function(self)
  -- function num : 0_11 , upvalues : _ENV, base
  UIManager:DeleteWindow(UIWindowTypeID.BattleEnemyDetail)
  ;
  (base.OnDelete)(self)
end

return UIBattleDeploy


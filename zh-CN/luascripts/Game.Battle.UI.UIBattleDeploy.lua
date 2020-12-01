-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBattleDeploy = class("UIBattleDeploy", UIBaseWindow)
local base = UIBaseWindow
local UINCampFetterItem = require("Game.Battle.UI.UINCampFetterItem")
local cs_coroutine = require("XLua.Common.cs_coroutine")
UIBattleDeploy.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.isShowingHeroInfo = false
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock, true)
  local isEnemyDetailUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_EnemyDetail)
  self:OnEnemyDetailUnlock(isEnemyDetailUnlock)
end

UIBattleDeploy.InitBattleDeployUI = function(self, dynPlayer)
  -- function num : 0_1
end

UIBattleDeploy.ShowHeroRoleInfo = function(self, hero)
  -- function num : 0_2 , upvalues : _ENV
  self.isShowingHeroInfo = true
  ;
  (UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)):ShowHero(hero)
end

UIBattleDeploy.ShowMonsterOrNeutralRoleInfo = function(self, battleCharacterView, monsterOrNeutral)
  -- function num : 0_3 , upvalues : _ENV
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
      if enemy.roleDataId == monsterOrNeutral.dataId then
        (table.insert)(self.battleCharacterViewList, enemy.battleRoleView)
      end
    end
    local neutralList = ((((ExplorationManager.epCtrl).battleCtrl).battleCtrl).NeutralTeamController).battleOriginRoleList
    for i = 0, neutralList.Count - 1 do
      local neutral = neutralList[i]
      if neutral.roleDataId == monsterOrNeutral.dataId then
        (table.insert)(self.battleCharacterViewList, neutral.battleRoleView)
      end
    end
  end
  do
    self.isShowEnemyDetail = true
    UIManager:ShowWindowAsync(UIWindowTypeID.BattleEnemyDetail, function(window)
    -- function num : 0_3_0 , upvalues : self, monsterOrNeutral, isNew
    if self.isShowEnemyDetail then
      window:InitBattleEnemyDetail(monsterOrNeutral, isNew)
    else
      window:Hide()
    end
  end
)
  end
end

UIBattleDeploy.HideHeroRoleInfo = function(self)
  -- function num : 0_4
  self.isShowingHeroInfo = false
end

UIBattleDeploy.HideMonsterOrNeutralRoleInfo = function(self)
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
  self.isShowEnemyDetail = false
  UIManager:HideWindow(UIWindowTypeID.BattleEnemyDetail)
end

UIBattleDeploy.HideNeutralRoleInfo = function(self)
  -- function num : 0_6
end

UIBattleDeploy.IsRoleInfoShow = function(self)
  -- function num : 0_7
  if not self.isShowingHeroInfo then
    return self.isShowEnemyDetail
  end
end

UIBattleDeploy.SetEpChipListUIActive = function(self, active)
  -- function num : 0_8 , upvalues : _ENV
  if active then
    local win = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
    if win ~= nil then
      win:Show()
      win:SetHeroListActive(false)
      win:SetHeroListHpBar(false)
      win:SetMoneyActive(false)
      win:SetSaveMoneyActive(false)
    end
  else
    do
      local win = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
      if win ~= nil then
        win:SetHeroListActive(true)
        win:SetHeroListHpBar(true)
        win:SetMoneyActive(true)
        win:SetSaveMoneyActive(true)
        win:Hide()
      end
    end
  end
end

UIBattleDeploy.OnEnemyDetailUnlock = function(self, active)
  -- function num : 0_9
  self.onEnemyDetailUnlock = active
end

UIBattleDeploy.OnDelete = function(self)
  -- function num : 0_10 , upvalues : _ENV, base
  UIManager:DeleteWindow(UIWindowTypeID.BattleEnemyDetail)
  ;
  (base.OnDelete)(self)
end

return UIBattleDeploy

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBattleDeploy = class("UIBattleDeploy", UIBaseWindow)
local base = UIBaseWindow
local UINCampFetterItem = require("Game.Battle.UI.UINCampFetterItem")
local cs_coroutine = require("XLua.Common.cs_coroutine")
UIBattleDeploy.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    self.isShowingHeroInfo = false
    local funcUnLockCrtl = ControllerManager:GetController(
                               ControllerTypeId.FunctionUnlock, true)
    local isEnemyDetailUnlock = funcUnLockCrtl:ValidateUnlock(
                                    proto_csmsg_SystemFunctionID.SystemFunctionID_EnemyDetail)
    self:OnEnemyDetailUnlock(isEnemyDetailUnlock)
end

UIBattleDeploy.InitBattleDeployUI = function(self, dynPlayer)
    -- function num : 0_1
end

UIBattleDeploy.ShowHeroRoleInfo = function(self, hero)
    -- function num : 0_2 , upvalues : _ENV
    self.isShowingHeroInfo = true;
    (UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)):ShowHero(hero)
end

UIBattleDeploy.ShowMonsterOrNeutralRoleInfo =
    function(self, battleCharacterView, monsterOrNeutral)
        -- function num : 0_3 , upvalues : _ENV
        if not self.onEnemyDetailUnlock then return end
        if self.battleCharacterViewList ~= nil then
            for _, view in ipairs(self.battleCharacterViewList) do
                view:ShowNewArrow(false)
            end
            self.battleCharacterViewList = nil
        end
        local isNew = battleCharacterView.isNew
        if isNew then
            self.battleCharacterViewList = {};
            (table.insert)(self.battleCharacterViewList, battleCharacterView)
            local enemyList =
                ((((ExplorationManager.epCtrl).battleCtrl).battleCtrl).EnemyTeamController).battleOriginRoleList
            for i = 0, enemyList.Count - 1 do
                local enemy = enemyList[i]
                if enemy.roleDataId == monsterOrNeutral.dataId then
                    (table.insert)(self.battleCharacterViewList,
                                   enemy.battleRoleView)
                end
            end
            local neutralList =
                ((((ExplorationManager.epCtrl).battleCtrl).battleCtrl).NeutralTeamController).battleOriginRoleList
            for i = 0, neutralList.Count - 1 do
                local neutral = neutralList[i]
                if neutral.roleDataId == monsterOrNeutral.dataId then
                    (table.insert)(self.battleCharacterViewList,
                                   neutral.battleRoleView)
                end
            end
        end
        do
            self.isShowEnemyDetail = true
            UIManager:ShowWindowAsync(UIWindowTypeID.BattleEnemyDetail,
                                      function(window)
                -- function num : 0_3_0 , upvalues : self, monsterOrNeutral, isNew
                if self.isShowEnemyDetail then
                    window:InitBattleEnemyDetail(monsterOrNeutral, isNew)
                else
                    window:Hide()
                end
            end)
        end
    end

UIBattleDeploy.HideHeroRoleInfo = function(self)
    -- function num : 0_4
    self.isShowingHeroInfo = false
end

UIBattleDeploy.HideMonsterOrNeutralRoleInfo =
    function(self)
        -- function num : 0_5 , upvalues : _ENV
        if not self.onEnemyDetailUnlock then return end
        if self.battleCharacterViewList ~= nil then
            for _, view in ipairs(self.battleCharacterViewList) do
                view:ShowNewArrow(false)
            end
            self.battleCharacterViewList = nil
        end
        self.isShowEnemyDetail = false
        UIManager:HideWindow(UIWindowTypeID.BattleEnemyDetail)
    end

UIBattleDeploy.HideNeutralRoleInfo = function(self)
    -- function num : 0_6
end

UIBattleDeploy.IsRoleInfoShow = function(self)
    -- function num : 0_7
    if not self.isShowingHeroInfo then return self.isShowEnemyDetail end
end

UIBattleDeploy.SetEpChipListUIActive = function(self, active)
    -- function num : 0_8 , upvalues : _ENV
    if active then
        local win = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
        if win ~= nil then
            win:Show()
            win:SetHeroListActive(false)
            win:SetHeroListHpBar(false)
            win:SetMoneyActive(false)
            win:SetSaveMoneyActive(false)
        end
    else
        do
            local win = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
            if win ~= nil then
                win:SetHeroListActive(true)
                win:SetHeroListHpBar(true)
                win:SetMoneyActive(true)
                win:SetSaveMoneyActive(true)
                win:Hide()
            end
        end
    end
end

UIBattleDeploy.OnEnemyDetailUnlock = function(self, active)
    -- function num : 0_9
    self.onEnemyDetailUnlock = active
end

UIBattleDeploy.OnDelete = function(self)
    -- function num : 0_10 , upvalues : _ENV, base
    UIManager:DeleteWindow(UIWindowTypeID.BattleEnemyDetail);
    (base.OnDelete)(self)
end

return UIBattleDeploy


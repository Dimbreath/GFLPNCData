-- params : ...
-- function num : 0 , upvalues : _ENV
local UINPlayerSkillNode = class("UINPlayerSkillNode", UIBaseNode)
local base = UIBaseNode
local UINPlayerSkillItem = require("Game.Battle.UI.SkillModule.PlayerSkill.UINPlayerSkillItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local PlayerMaxMp = (ConfigData.game_config).playerMaxMp
UINPlayerSkillNode.ctor = function(self, resloader)
  -- function num : 0_0
  self.resloader = resloader
end

UINPlayerSkillNode.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, UINPlayerSkillItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.__OnItemClick = BindCallback(self, self.OnPlayerSkillItemClick)
  self.__OnItemPointDown = BindCallback(self, self.OnPlayerSkillItemPointDown)
  self.__ShowSkillInfo = BindCallback(self, self.ShowSkillInfo)
  self.__HideSkillInfo = BindCallback(self, self.HideSkillInfo)
  ;
  ((self.ui).skillItem):SetActive(false)
  self.skillItemPool = (UIItemPool.New)(UINPlayerSkillItem, (self.ui).skillItem)
end

UINPlayerSkillNode.InitPlayerSkillNode = function(self, battlePlayerController, skillList)
  -- function num : 0_2 , upvalues : _ENV, PlayerMaxMp
  self.playerCtrl = battlePlayerController
  local curMp = battlePlayerController.CurMp
  ;
  (self.skillItemPool):HideAll()
  local dynplayer = ExplorationManager:GetDynPlayer()
  for i = 0, skillList.Count - 1 do
    local battleSkill = skillList[i]
    local skillItem = (self.skillItemPool):GetOne()
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (skillItem.gameObject).name = tostring(i + 1)
    skillItem:InitPlayerSkillItem(battleSkill, self.resloader, self.__OnItemClick, self.__ShowSkillInfo, self.__HideSkillInfo, self.__OnItemPointDown)
    do
      do
        if dynplayer then
          local isLocked = dynplayer:IsEpBattleSkillLock(i)
          PlayerDataCenter:RecordLockedCmdSkill(battleSkill.dataId, isLocked)
          skillItem:SetSkillItemLock(isLocked)
        end
        skillItem:RefreshPlayerSkillItemMp(curMp, PlayerMaxMp <= curMp)
        -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINPlayerSkillNode.OnPlayerMpChange = function(self, mp)
  -- function num : 0_3 , upvalues : _ENV, PlayerMaxMp
  ((self.ui).tex_Energy):SetIndex(0, tostring(mp), tostring(PlayerMaxMp))
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_Energy).fillAmount = mp / PlayerMaxMp
  self.isMax = PlayerMaxMp <= mp
  for k,skillItem in ipairs((self.skillItemPool).listItem) do
    skillItem:RefreshPlayerSkillItemMp(mp, self.isMax)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINPlayerSkillNode.OnPlayerSkillItemClick = function(self, battleSkill)
  -- function num : 0_4
  if battleSkill.isPassive then
    return 
  end
  ;
  (self.playerCtrl):OnSkillItemMonoCliked(battleSkill)
end

UINPlayerSkillNode.OnPlayerSkillItemPointDown = function(self, battleSkill)
  -- function num : 0_5
  if battleSkill.isPassive or not battleSkill.isManualMode then
    return 
  end
  ;
  (self.playerCtrl):OnSkillItemMonoCliked(battleSkill)
end

UINPlayerSkillNode.ShowSkillInfo = function(self, item, battleSkill)
  -- function num : 0_6 , upvalues : _ENV, HAType, VAType
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  local describe = (battleSkill.skillCfg):GetLevelDescribe(battleSkill.level)
  win:SetTitleAndContext(battleSkill.name, describe)
  win:FloatTo(item.transform, HAType.right, VAType.up)
end

UINPlayerSkillNode.HideSkillInfo = function(self)
  -- function num : 0_7 , upvalues : _ENV
  UIManager:HideWindow(UIWindowTypeID.FloatingFrame)
end

UINPlayerSkillNode.OnUpdateLogic_PlayerSkillNode = function(self)
  -- function num : 0_8 , upvalues : _ENV
  for k,skillItem in ipairs((self.skillItemPool).listItem) do
    skillItem:OnUpdateLogic_PlayerSkillItem()
  end
end

UINPlayerSkillNode.SetSkillItemActive = function(self, index, active)
  -- function num : 0_9
  local skillItem = ((self.skillItemPool).listItem)[index]
  if skillItem ~= nil then
    if active then
      skillItem:Show()
    else
      skillItem:Hide()
    end
  end
end

UINPlayerSkillNode.GetSkillItemById = function(self, skillId)
  -- function num : 0_10 , upvalues : _ENV
  for _,skillItem in pairs((self.skillItemPool).listItem) do
    if skillItem.skillId == skillId then
      return skillItem
    end
  end
  return nil
end

UINPlayerSkillNode.GetSkillItem = function(self, index)
  -- function num : 0_11
  local skillItem = ((self.skillItemPool).listItem)[index]
  return skillItem
end

UINPlayerSkillNode.OnUpdateRender_PlayerSkillNode = function(self, deltaTime, interpolation)
  -- function num : 0_12 , upvalues : _ENV
  for k,skillItem in ipairs((self.skillItemPool).listItem) do
    skillItem:OnUpdateRender_PlayerSkillItem(deltaTime, interpolation)
  end
end

UINPlayerSkillNode.OnDelete = function(self)
  -- function num : 0_13 , upvalues : base
  (base.OnDelete)(self)
end

return UINPlayerSkillNode


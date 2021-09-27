local UINPlayerSkillNode = class("UINPlayerSkillNode", UIBaseNode)
local base = UIBaseNode
local UINPlayerSkillItem = require("Game.Battle.UI.SkillModule.PlayerSkill.UINPlayerSkillItem")
local UINPlayerConsumeSkillItem = require("Game.Battle.UI.SkillModule.PlayerSkill.UINPlayerConsumeSkillItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local cs_DoTween = ((CS.DG).Tweening).DOTween
UINPlayerSkillNode.ctor = function(self, resloader)
  -- function num : 0_0
  self.resloader = resloader
end

UINPlayerSkillNode.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, UINPlayerSkillItem, UINPlayerConsumeSkillItem
  self.playerMaxMp = 0
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.__OnItemClick = BindCallback(self, self.OnPlayerSkillItemClick)
  self.__OnItemPointDown = BindCallback(self, self.OnPlayerSkillItemPointDown)
  self.__ShowSkillInfo = BindCallback(self, self.ShowSkillInfo)
  self.__HideSkillInfo = BindCallback(self, self.HideSkillInfo)
  ;
  ((self.ui).skillItem):SetActive(false)
  self.skillItemPool = (UIItemPool.New)(UINPlayerSkillItem, (self.ui).skillItem)
  ;
  ((self.ui).consumeSkillItem):SetActive(false)
  self.consumeSkillItemPool = (UIItemPool.New)(UINPlayerConsumeSkillItem, (self.ui).consumeSkillItem)
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_engShow).text = ""
end

UINPlayerSkillNode.InitPlayerSkillNode = function(self, battlePlayerController, skillList)
  -- function num : 0_2 , upvalues : _ENV
  if skillList == nil or skillList.Count <= 0 then
    return 
  end
  self.playerCtrl = battlePlayerController
  local curMp = battlePlayerController.CurMp
  ;
  (self.skillItemPool):HideAll()
  ;
  (self.consumeSkillItemPool):HideAll()
  local dynplayer = ExplorationManager:GetDynPlayer()
  if dynplayer == nil then
    dynplayer = BattleDungeonManager:GetDungeonDynPlayer()
  end
  local CSTId = nil
  if dynplayer ~= nil then
    CSTId = dynplayer:GetCSTId()
  end
  local curSkillList, consumeSkillList = self:SortSkillList(CSTId, skillList)
  if curSkillList == nil then
    return 
  end
  for i = 1, #curSkillList do
    local battleSkill = curSkillList[i]
    local skillItem = (self.skillItemPool):GetOne()
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R14 in 'UnsetPending'

    ;
    (skillItem.gameObject).name = tostring(i)
    skillItem:InitPlayerSkillItem(battleSkill, self.resloader, self.__OnItemClick, self.__ShowSkillInfo, self.__HideSkillInfo, self.__OnItemPointDown)
    do
      do
        if dynplayer then
          local isLocked = dynplayer:IsEpBattleSkillLock(i)
          skillItem:SetSkillItemLock(isLocked)
        end
        skillItem:RefreshPlayerSkillItemMp(curMp, self.playerMaxMp <= curMp)
        -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  for k,battleSkill in ipairs(consumeSkillList) do
    local skillItem = (self.consumeSkillItemPool):GetOne()
    skillItem:InitPlayerConsumeSkillItem(battleSkill, self.__OnItemClick, self.__ShowSkillInfo, self.__HideSkillInfo, self.__OnItemPointDown)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINPlayerSkillNode.SortSkillList = function(self, CSTId, skillList)
  -- function num : 0_3 , upvalues : _ENV
  local sortFixSkillFunc = function(skills)
    -- function num : 0_3_0 , upvalues : _ENV
    local isFix, fixSkills, fixSkillPosDic = (BattleUtil.TryGetFixedCstSkills)()
    if not isFix then
      return skills
    end
    if #skills ~= #fixSkills then
      error("在固定指挥官技能关卡中，接受到的指挥官技能数量与配置数量不同")
      return skills
    end
    local templist = skills
    skills = {}
    for _,battleSkill in ipairs(templist) do
      local pos = fixSkillPosDic[battleSkill.dataId]
      if pos ~= nil then
        skills[pos] = battleSkill
      else
        ;
        (table.insert)(skills, battleSkill)
        error("在固定指挥官技能关卡中，存在一个技能不是已配置的技能  id:" .. tostring(battleSkill.dataId))
      end
    end
    return skills
  end

  if skillList == nil or skillList.Count <= 0 then
    return nil
  end
  local curSkillList = {}
  local consumeSkillList = {}
  for i = 0, skillList.Count - 1 do
    local battleSkill = skillList[i]
    if battleSkill.skillType == eBattleSkillLogicType.ChipConsume then
      (table.insert)(consumeSkillList, battleSkill)
    else
      ;
      (table.insert)(curSkillList, battleSkill)
    end
  end
  ;
  (table.sort)(consumeSkillList, function(a, b)
    -- function num : 0_3_1
    do return a.dataId < b.dataId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  if CSTId == nil then
    return sortFixSkillFunc(curSkillList), consumeSkillList
  end
  local cstunlock = (ConfigData.commander_skill_unlock)[CSTId]
  if cstunlock == nil then
    error("Config is nil： commander_skill_unlock，key is " .. tostring(CSTId))
    return sortFixSkillFunc(curSkillList), consumeSkillList
  end
  ;
  (table.sort)(curSkillList, function(a, b)
    -- function num : 0_3_2 , upvalues : cstunlock
    local cmdSkillDataA = cstunlock[a.dataId]
    if cmdSkillDataA == nil then
      return 0
    end
    local cmdSkillDataB = cstunlock[b.dataId]
    if cmdSkillDataB == nil then
      return 0
    end
    do return cmdSkillDataA.place < cmdSkillDataB.place end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return sortFixSkillFunc(curSkillList), consumeSkillList
end

UINPlayerSkillNode.OnPlayerMpChange = function(self, mp)
  -- function num : 0_4 , upvalues : _ENV, cs_DoTween
  ((self.ui).tex_Energy):SetIndex(0, tostring(mp), tostring(self.playerMaxMp))
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_engShow).text = tostring(mp) .. "/" .. tostring(self.playerMaxMp)
  if self._mp ~= mp and mp < self.playerMaxMp then
    if self.playerMaxMp > 0 then
      if self.mpSeq ~= nil then
        (self.mpSeq):Restart()
      else
        local seq = (cs_DoTween.Sequence)()
        seq:OnStart(function()
    -- function num : 0_4_0 , upvalues : self, _ENV
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    ((self.ui).img_Energy).fillAmount = 0
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (((self.ui).tex_engShow).transform).localScale = Vector3.one
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((self.ui).tex_engShow).color = (Color.New)(1, 1, 1, 1)
  end
)
        seq:Append(((self.ui).img_Energy):DOFillAmount(1, 1))
        seq:Join((((self.ui).tex_engShow).transform):DOScale((Vector3.New)(1.2, 1.2, 1), 0.5))
        seq:Join(((self.ui).tex_engShow):DOFade(0, 0.5))
        seq:SetAutoKill(false)
        self.mpSeq = seq
      end
    else
      do
        -- DECOMPILER ERROR at PC80: Confused about usage of register: R2 in 'UnsetPending'

        ;
        ((self.ui).img_Energy).fillAmount = 1
        self._mp = mp
        self.isMax = self.playerMaxMp <= mp
        for k,skillItem in ipairs((self.skillItemPool).listItem) do
          skillItem:RefreshPlayerSkillItemMp(mp, self.isMax)
        end
        -- DECOMPILER ERROR: 2 unprocessed JMP targets
      end
    end
  end
end

UINPlayerSkillNode.OnPlayerMaxMpChange = function(self, maxMp)
  -- function num : 0_5
  self.playerMaxMp = maxMp
end

UINPlayerSkillNode.OnPlayerSkillItemClick = function(self, battleSkill)
  -- function num : 0_6 , upvalues : _ENV
  if battleSkill.isPassive then
    return 
  end
  local skillModuleWin = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if skillModuleWin ~= nil then
    skillModuleWin:SetSelectSkillType(false)
  end
  ;
  (self.playerCtrl):OnSkillItemMonoCliked(battleSkill, false)
end

UINPlayerSkillNode.OnPlayerSkillItemPointDown = function(self, battleSkill)
  -- function num : 0_7 , upvalues : _ENV
  if battleSkill.isPassive or not battleSkill.isManualMode then
    return 
  end
  local skillModuleWin = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if skillModuleWin ~= nil then
    skillModuleWin:SetSelectSkillType(false)
  end
  ;
  (self.playerCtrl):OnSkillItemMonoCliked(battleSkill, false)
end

UINPlayerSkillNode.ShowSkillInfo = function(self, item, battleSkill)
  -- function num : 0_8 , upvalues : _ENV, HAType, VAType
  if battleSkill.totalCDTime == 0 and not battleSkill.isManualMode and not battleSkill.isPassive then
    self:OnPlayerSkillItemClick(battleSkill)
    return 
  end
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  local describe = battleSkill:GetBattleSkillDescribe()
  win:SetTitleAndContext(battleSkill.name, describe)
  win:FloatTo(item.transform, HAType.autoCenter, VAType.up)
end

UINPlayerSkillNode.HideSkillInfo = function(self)
  -- function num : 0_9 , upvalues : _ENV
  UIManager:HideWindow(UIWindowTypeID.FloatingFrame)
end

UINPlayerSkillNode.OnUpdateLogic_PlayerSkillNode = function(self)
  -- function num : 0_10 , upvalues : _ENV
  for k,skillItem in ipairs((self.skillItemPool).listItem) do
    skillItem:OnUpdateLogic_PlayerSkillItem()
  end
  local consumeSkillNum = 0
  for k,skillItem in ipairs((self.consumeSkillItemPool).listItem) do
    skillItem:OnUpdateLogic_PlayerConsumeSkillItem()
    if skillItem.active then
      consumeSkillNum = consumeSkillNum + 1
    end
  end
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_ConsumeCount).text = tostring(consumeSkillNum) .. "/" .. tostring((ConfigData.game_config).activeAlgNumMax)
  ;
  ((self.ui).consumeSkill):SetActive(consumeSkillNum > 0)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINPlayerSkillNode.SetSkillItemActive = function(self, index, active)
  -- function num : 0_11
  local skillItem = ((self.skillItemPool).listItem)[index]
  if skillItem ~= nil and active ~= nil then
    if active then
      skillItem:Show()
    else
      skillItem:Hide()
    end
  end
  return skillItem
end

UINPlayerSkillNode.GetSkillItemById = function(self, skillId)
  -- function num : 0_12 , upvalues : _ENV
  for _,skillItem in pairs((self.skillItemPool).listItem) do
    if skillItem.skillId == skillId then
      return skillItem
    end
  end
  for _,skillItem in pairs((self.consumeSkillItemPool).listItem) do
    if skillItem.skillId == skillId then
      return skillItem
    end
  end
  return nil
end

UINPlayerSkillNode.GetSkillItem = function(self, index)
  -- function num : 0_13
  local skillItem = ((self.skillItemPool).listItem)[index]
  return skillItem
end

UINPlayerSkillNode.SetConsumeSkillItemActive = function(self, index, active)
  -- function num : 0_14
  local skillItem = ((self.consumeSkillItemPool).listItem)[index]
  if skillItem ~= nil and active ~= nil then
    if active then
      skillItem:Show()
    else
      skillItem:Hide()
    end
  end
  return skillItem
end

UINPlayerSkillNode.OnUpdateRender_PlayerSkillNode = function(self, deltaTime, interpolation)
  -- function num : 0_15 , upvalues : _ENV
  for k,skillItem in ipairs((self.skillItemPool).listItem) do
    skillItem:OnUpdateRender_PlayerSkillItem(deltaTime, interpolation)
  end
  for k,skillItem in ipairs((self.consumeSkillItemPool).listItem) do
    skillItem:OnUpdateRender_PlayerConsumeSkillItem(deltaTime, interpolation)
  end
end

UINPlayerSkillNode.OnDelete = function(self)
  -- function num : 0_16 , upvalues : base
  (self.consumeSkillItemPool):DeleteAll()
  ;
  (self.skillItemPool):DeleteAll()
  self.playerCtrl = nil
  if self.mpSeq ~= nil then
    (self.mpSeq):Kill()
    self.mpSeq = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINPlayerSkillNode


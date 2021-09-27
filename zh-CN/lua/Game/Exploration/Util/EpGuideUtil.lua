local EpGuideUtil = {}
local GuideActionType = {PlayGuide = 1, PlayUltGuide = 2, ClearUltMp = 3, TeamCoordChange = 4, HideCmderSkill = 5, HideBattleRestart = 6, PlayCmderGuide = 7, HideUIAndGuideAndSelect = 8, SetCmderSkillSelectable = 9, SetCmderSkillActive = 10, SetDeployCmderSkillActive = 11, DeployCmderSkillNoClick = 12, SetConsumeSkillSelectable = 13}
EpGuideUtil.GuideActionFunc = {[GuideActionType.PlayGuide] = function(guideAction)
  -- function num : 0_0 , upvalues : _ENV
  GuideManager:StartNewGuide(guideAction.action_args)
end
, [GuideActionType.PlayUltGuide] = function(guideAction)
  -- function num : 0_1 , upvalues : _ENV
  if GuideManager.inGuide then
    return 
  end
  if ExplorationManager.epCtrl == nil then
    return 
  end
  local ultCount = ((ExplorationManager.epCtrl).battleCtrl):GetEpBattleUltFullCount()
  if ultCount ~= guideAction.action_delay then
    return 
  end
  local oldTimeScale = (Time.unity_time).timeScale
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (Time.unity_time).timeScale = 0
  GuideManager:StartNewGuide(guideAction.action_args, function()
    -- function num : 0_1_0 , upvalues : _ENV, oldTimeScale
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

    (Time.unity_time).timeScale = oldTimeScale
  end
)
end
, [GuideActionType.ClearUltMp] = function(guideAction)
  -- function num : 0_2 , upvalues : _ENV
  (ExplorationManager:GetDynPlayer()).playerUltSkillMp = 0
end
, [GuideActionType.TeamCoordChange] = function(guideAction)
  -- function num : 0_3 , upvalues : _ENV
  local dynPlayer = ExplorationManager:GetDynPlayer()
  if dynPlayer == nil then
    return 
  end
  for _,dynHero in pairs(dynPlayer.heroList) do
    local coord = (guideAction.action_args)[dynHero:GetID()]
    if coord ~= nil then
      dynHero:SetCoordXY(coord[1], coord[2], (ConfigData.buildinConfig).BenchX)
    end
  end
end
, [GuideActionType.HideCmderSkill] = function(guideAction)
  -- function num : 0_4 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if window ~= nil then
    window:ShowPlayerSkillNode(false)
  end
end
, [GuideActionType.HideBattleRestart] = function(guideAction)
  -- function num : 0_5 , upvalues : _ENV
  if ExplorationManager.epCtrl == nil then
    return 
  end
  ;
  ((ExplorationManager.epCtrl).battleCtrl):SetCloseReloadSupport(true)
end
, [GuideActionType.PlayCmderGuide] = function(guideAction)
  -- function num : 0_6 , upvalues : _ENV
  if GuideManager.inGuide then
    return 
  end
  if ExplorationManager.epCtrl == nil then
    return 
  end
  local oldTimeScale = (Time.unity_time).timeScale
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (Time.unity_time).timeScale = 0
  GuideManager:StartNewGuide(guideAction.action_args, function()
    -- function num : 0_6_0 , upvalues : _ENV, oldTimeScale
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

    (Time.unity_time).timeScale = oldTimeScale
  end
)
end
, [GuideActionType.HideUIAndGuideAndSelect] = function(guideAction)
  -- function num : 0_7 , upvalues : _ENV
  if ExplorationManager.epCtrl == nil then
    return 
  end
  UIManager:HideWindow(UIWindowTypeID.EpEventRoom)
  local eventCtrl = (ExplorationManager.epCtrl).eventCtrl
  local choiceData = ((eventCtrl:GetEpEventData()).choiceDatalist)[1]
  local choiceCfg = eventCtrl:GetEpEventChoiceCfg(choiceData)
  if choiceCfg == nil then
    warn("event choice is nil")
    return 
  end
  if (guideAction.action_args)[1] <= 0 then
    ((ExplorationManager.epCtrl).eventCtrl):OnChoiceItemClick(choiceCfg, (guideAction.action_args)[2], true)
    return 
  end
  GuideManager:StartNewGuide((guideAction.action_args)[1], function()
    -- function num : 0_7_0 , upvalues : _ENV, choiceCfg, guideAction
    ((ExplorationManager.epCtrl).eventCtrl):OnChoiceItemClick(choiceCfg, (guideAction.action_args)[2], true)
  end
)
end
, [GuideActionType.SetCmderSkillSelectable] = function(guideAction)
  -- function num : 0_8 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if window == nil then
    return 
  end
  local skillItem = (window.playerSkillNode):SetSkillItemActive((guideAction.action_args)[1])
  if skillItem == nil then
    warn("ep guide SetCmderSkillSelectable,not find skillItem index:" .. tostring((guideAction.action_args)[1]))
    return 
  end
  if (guideAction.action_args)[2] == 1 then
    skillItem:SetSkillBtnEnabled(true)
  else
    skillItem:SetSkillBtnEnabled(false)
  end
end
, [GuideActionType.SetCmderSkillActive] = function(guideAction)
  -- function num : 0_9 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if window == nil then
    return 
  end
  local skillItem = (window.playerSkillNode):SetSkillItemActive((guideAction.action_args)[1])
  if skillItem == nil then
    warn("ep guide SetCmderSkillActive,not find skillItem index:" .. tostring((guideAction.action_args)[1]))
    return 
  end
  if (guideAction.action_args)[2] == 1 then
    skillItem:Show()
  else
    skillItem:Hide()
  end
end
, [GuideActionType.SetDeployCmderSkillActive] = function(guideAction)
  -- function num : 0_10 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.Battle)
  if window == nil then
    return 
  end
  local cmderSKillItem = window:GetBattleCmderSkillByIndex((guideAction.action_args)[1])
  if cmderSKillItem == nil then
    warn("ep guide SetDeployCmderSkillActive,not find skillItem index:" .. tostring((guideAction.action_args)[1]))
    return 
  end
  if (guideAction.action_args)[2] == 1 then
    cmderSKillItem:Show()
  else
    cmderSKillItem:Hide()
  end
end
, [GuideActionType.DeployCmderSkillNoClick] = function(guideAction)
  -- function num : 0_11 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.Battle)
  if window == nil then
    return 
  end
  ;
  (window:GetBattleCstNode()):SetCmderRootRaycastActive(false)
end
, [GuideActionType.SetConsumeSkillSelectable] = function(guideAction)
  -- function num : 0_12 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if window == nil then
    return 
  end
  local skillItem = (window.playerSkillNode):SetConsumeSkillItemActive((guideAction.action_args)[1])
  if skillItem == nil then
    warn("ep guide SetConsumeSkillSelectable,not find skillItem index:" .. tostring((guideAction.action_args)[1]))
    return 
  end
  if (guideAction.action_args)[2] == 1 then
    skillItem:SetSkillBtnEnabled(true)
  else
    skillItem:SetSkillBtnEnabled(false)
  end
end
}
EpGuideUtil.ExecuteEpGuideActions = function(actionList, battleCount)
  -- function num : 0_13 , upvalues : _ENV, EpGuideUtil
  if not battleCount then
    battleCount = 0
  end
  for _,guideAction in ipairs(actionList) do
    (EpGuideUtil.ExecuteEpGuideActionOne)(guideAction, battleCount)
  end
end

EpGuideUtil.ExecuteEpGuideActionOne = function(guideAction, battleCount)
  -- function num : 0_14 , upvalues : EpGuideUtil, _ENV
  if not battleCount then
    battleCount = 0
  end
  if guideAction.battle_count >= 0 and battleCount ~= guideAction.battle_count then
    return 
  end
  local func = (EpGuideUtil.GuideActionFunc)[guideAction.action_type]
  if func == nil then
    error("no support ep guide action type:" .. tostring(guideAction.action_type))
  else
    func(guideAction)
  end
end

return EpGuideUtil


-- params : ...
-- function num : 0 , upvalues : _ENV
local GuideUtil = {}
local UINTipsGuide = require("Game.Guide.UI.UINTipsGuide")
GuideUtil.TipsGuidePrefabName = "TipsGuide"
GuideUtil.GetTipsGuideNodeName = function(tranName)
  -- function num : 0_0 , upvalues : GuideUtil
  return tranName .. "_" .. GuideUtil.TipsGuidePrefabName
end

GuideUtil.ShowTipsGuide = function(curTargetTransform, guidePrefab, show_dir)
  -- function num : 0_1 , upvalues : GuideUtil, UINTipsGuide
  local objName = (GuideUtil.GetTipsGuideNodeName)(curTargetTransform.name)
  local tipsGuideObj = guidePrefab:Instantiate(curTargetTransform)
  tipsGuideObj.name = objName
  local tipsGuideNode = (UINTipsGuide.New)()
  tipsGuideNode:Init(tipsGuideObj)
  tipsGuideNode:ShowUITipsGuide(curTargetTransform, show_dir)
  return tipsGuideNode
end

GuideUtil.GetEpFirstRoomTarget = function()
  -- function num : 0_2 , upvalues : _ENV
  if not ExplorationManager:IsInExploration() then
    return nil
  end
  if ExplorationManager.epCtrl == nil then
    return nil
  end
  local roomData = (((ExplorationManager.epCtrl).mapCtrl).mapData):GetFirstAbleRoomData()
  if roomData == nil then
    return 
  end
  local uiRoom = ((ExplorationManager.epCtrl).mapCtrl):GetRoomUI(roomData.position)
  if uiRoom == nil then
    return nil
  end
  return ((uiRoom.ui).btn_EpRoom).transform
end

GuideUtil.LocationSectorStageItem = function(stageId)
  -- function num : 0_3 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
  if window ~= nil then
    local difficultListNode = window:GetDifficultListNode()
    local stageItem = difficultListNode:LocationSectorStageItem(stageId)
    return stageItem
  end
  do
    return nil
  end
end

GuideUtil.TipsGuideSectorLevelItem = function(id, isAvg, show_dir)
  -- function num : 0_4 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
  do
    if window ~= nil then
      local difficultListNode = window:GetDifficultListNode()
      difficultListNode:SetSectorStageItemTipsGuide(id, isAvg, show_dir)
      return true
    end
    return false
  end
end

GuideUtil.ClearTipsGuideSectorLevelItem = function(id, isAvg)
  -- function num : 0_5 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
  if window ~= nil then
    local difficultListNode = window:GetDifficultListNode()
    difficultListNode:ClearSectorStageItemTipsGuide(id, isAvg)
  end
end

GuideUtil.StartBattleDeployGuide = function(startX, startY, endX, endY)
  -- function num : 0_6 , upvalues : _ENV, GuideUtil
  local battleMgr = (CS.BattleManager).Instance
  if not battleMgr.IsInBattle then
    (GuideManager:GetCurGuideCtrl()):OnCurStepFinish()
    return 
  end
  local battleCtrl = battleMgr.CurBattleController
  local startPoint = (Vector2.New)(startX, startY)
  local endPoint = (Vector2.New)(endX, endY)
  if not battleCtrl:ContainsRole(startPoint) or battleCtrl:ContainsRole(endPoint) ~= false then
    (GuideManager:GetCurGuideCtrl()):EndGuide(false)
    return 
  end
  local deployGuide = (CS.BattleDeployGuideData)()
  deployGuide.endAction = GuideUtil.__OnBattleDeployGuideEnd
  deployGuide.startCoord = startPoint
  deployGuide.endCoord = endPoint
  local deployState = (battleCtrl.fsm):GetStateFromID((CS.eBattleState).Deploy)
  deployState.guideData = deployGuide
  ;
  (GuideUtil.__OnBattleDeployGuideStart)(deployState, startX, startY, endX, endY)
end

GuideUtil.__OnBattleDeployGuideStart = function(deployState, startX, startY, endX, endY)
  -- function num : 0_7 , upvalues : _ENV
  (UIManager:GetWindow(UIWindowTypeID.Battle)):SetBattleStartActive(false)
  UIManager:ShowWindowAsync(UIWindowTypeID.Guide, function(window)
    -- function num : 0_7_0 , upvalues : deployState, startX, startY, endX, endY, _ENV
    if window == nil then
      return window
    end
    local startPos = ((deployState.battleController).battleFieldData):GetGridUnityPos(startX, startY)
    local endPos = ((deployState.battleController).battleFieldData):GetGridUnityPos(endX, endY)
    local startUIPos = UIManager:World2UIPosition(startPos)
    local endUIPos = UIManager:World2UIPosition(endPos)
    startUIPos = (Vector3.New)(startUIPos.x, startUIPos.y, 0)
    endUIPos = (Vector3.New)(endUIPos.x, endUIPos.y, 0)
    window:PlaySlideGuide(startUIPos, endUIPos)
    local guideStepCfg = (GuideManager:GetCurGuideCtrl()).guideStepCfg
    if guideStepCfg ~= nil then
      window:ShowHeroSmallTalk((LanguageUtil.GetLocaleText)(guideStepCfg.info), guideStepCfg.info_type, guideStepCfg.info_pos)
    end
  end
)
end

GuideUtil.__OnBattleDeployGuideEnd = function(deployState)
  -- function num : 0_8 , upvalues : _ENV
  deployState.guideData = nil
  ;
  (UIManager:GetWindow(UIWindowTypeID.Battle)):SetBattleStartActive(true)
  UIManager:ShowWindowAsync(UIWindowTypeID.Guide, function(window)
    -- function num : 0_8_0
    if window == nil then
      return window
    end
    window:EndSlideGuide()
    window:HideHeroTalkDialog()
  end
)
  ;
  (GuideManager:GetCurGuideCtrl()):OnCurStepFinish()
end

GuideUtil.UnlockOasisMask = function()
  -- function num : 0_9 , upvalues : _ENV, GuideUtil
  if not GuideManager.inGuide then
    return 
  end
  local mainCamera = UIManager:GetMainCamera()
  if IsNull(mainCamera) then
    (GuideManager:GetCurGuideCtrl()):EndGuide(false)
    return 
  end
  local bind = mainCamera:FindComponent(eUnityComponentID.LuaBinding)
  if IsNull(bind) then
    (GuideManager:GetCurGuideCtrl()):EndGuide(false)
    return 
  end
  ;
  (TimelineUtil.StopAll)()
  local sectorPlayableDirector = bind:GetBind("sectorPlayableDirector")
  sectorPlayableDirector.time = 0
  sectorPlayableDirector:Evaluate()
  local homeToSectorGo = bind:GetBind("homeToSectorGo")
  homeToSectorGo:SetActive(false)
  local oasisLockNode = bind:GetBind("oasisLockNode")
  ;
  (oasisLockNode.gameObject):SetActive(true)
  local pd_unlockOasis = bind:GetBind("pd_unlockOasis")
  pd_unlockOasis.time = 0
  pd_unlockOasis:Evaluate()
  local codeActionBinding = pd_unlockOasis:FindComponent(eUnityComponentID.CodeActionBinding)
  codeActionBinding:RegisterAction("PlayAvgAndPause", function()
    -- function num : 0_9_0 , upvalues : _ENV, GuideUtil, codeActionBinding, homeToSectorGo, pd_unlockOasis, bind
    (TimelineUtil.StopTlCo)(GuideUtil.__tlUnlockOasis)
    codeActionBinding:ClearAllAction()
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    local avgName = ((GuideManager:GetCurGuideCtrl()).guideStepCfg).avg_name
    local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
    avgCtrl:ShowAvg(avgName, function()
      -- function num : 0_9_0_0 , upvalues : _ENV, homeToSectorGo, pd_unlockOasis, GuideUtil, bind
      local continueFunc = function()
        -- function num : 0_9_0_0_0 , upvalues : _ENV, homeToSectorGo, pd_unlockOasis, GuideUtil, bind
        (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
        homeToSectorGo:SetActive(true)
        ;
        (TimelineUtil.Play)(pd_unlockOasis, function()
          -- function num : 0_9_0_0_0_0 , upvalues : GuideUtil, _ENV, bind
          GuideUtil.__tlUnlockOasis = nil
          UIManager:HideWindow(UIWindowTypeID.ClickContinue)
          local oasisLockNode = bind:GetBind("oasisLockNode")
          ;
          (oasisLockNode.gameObject):SetActive(false)
          local homeWindow = UIManager:GetWindow(UIWindowTypeID.Home)
          if homeWindow ~= nil then
            homeWindow:Show()
            ;
            (homeWindow.rightList):WaitEpTimeLine(false)
          end
          ;
          (GuideManager:GetCurGuideCtrl()):OnCurStepFinish()
        end
, true)
      end

      local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock, true)
      if funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_ChangeName) and (ConfigData.game_config).changeNameItemNum <= PlayerDataCenter:GetItemCount((ConfigData.game_config).changeNameItemId) then
        UIManager:ShowWindowAsync(UIWindowTypeID.UserNameCreate, function(window)
        -- function num : 0_9_0_0_1 , upvalues : continueFunc
        window:BindUIUserNameAction(continueFunc)
      end
)
      else
        continueFunc()
      end
    end
)
  end
)
  ;
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
  GuideUtil.__tlUnlockOasis = (TimelineUtil.Play)(pd_unlockOasis)
end

GuideUtil.GetHeroListHeroItem = function(heroId, needRoll, isFormationQuick)
  -- function num : 0_10 , upvalues : _ENV
  local heroSortList = nil
  if isFormationQuick then
    local win = UIManager:GetWindow(UIWindowTypeID.FormationQuick)
    if win == nil then
      return nil
    end
    heroSortList = win.heroSortList
  else
    do
      do
        local win = UIManager:GetWindow(UIWindowTypeID.HeroList)
        if win == nil then
          return nil
        end
        heroSortList = win.heroSortList
        if heroSortList ~= nil then
          local hasHero, heroIndex = nil, nil
          for index,heroData in ipairs(heroSortList.curHeroList) do
            if heroData.dataId == heroId then
              hasHero = true
              heroIndex = index
              break
            end
          end
          do
            if hasHero then
              ((heroSortList.ui).scrollRest):SrollToCell(heroIndex - 1, 5000)
              local item = heroSortList:__GetHeroItemById(heroId)
              if item ~= nil then
                return item.transform
              end
            end
            do
              return nil
            end
          end
        end
      end
    end
  end
end

GuideUtil.GetMailListItem = function(mailEntry)
  -- function num : 0_11 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.Mail)
  if win == nil then
    return nil
  end
  local mailWin = win
  if mailWin ~= nil then
    local hasMail, mailIndex = nil, nil
    do
      for index,mailData in ipairs(mailWin.mailDataList) do
        if mailData:GetMailEntryCode() == mailEntry then
          hasMail = true
          mailIndex = index
          break
        end
      end
      do
        if hasMail then
          ((mailWin.ui).loopList_mails):SrollToCell(mailIndex - 1, 5000, function()
    -- function num : 0_11_0 , upvalues : mailWin, mailIndex
    ((mailWin.ui).loopList_mails):SrollToCell(mailIndex - 1, 5000)
  end
)
          local item = mailWin:m_GetItemGoByIndex(mailIndex - 1)
          if item ~= nil then
            return item.transform
          end
        end
      end
      do
        return nil
      end
    end
  end
end

GuideUtil.ClearData = function(self)
  -- function num : 0_12 , upvalues : GuideUtil
  GuideUtil.__tlUnlockOasis = nil
end

return GuideUtil

-- params : ...
-- function num : 0 , upvalues : _ENV
local GuideUtil = {}
local UINTipsGuide = require("Game.Guide.UI.UINTipsGuide")
GuideUtil.TipsGuidePrefabName = "TipsGuide"
GuideUtil.GetTipsGuideNodeName = function(tranName)
    -- function num : 0_0 , upvalues : GuideUtil
    return tranName .. "_" .. GuideUtil.TipsGuidePrefabName
end

GuideUtil.ShowTipsGuide = function(curTargetTransform, guidePrefab, show_dir)
    -- function num : 0_1 , upvalues : GuideUtil, UINTipsGuide
    local objName = (GuideUtil.GetTipsGuideNodeName)(curTargetTransform.name)
    local tipsGuideObj = guidePrefab:Instantiate(curTargetTransform)
    tipsGuideObj.name = objName
    local tipsGuideNode = (UINTipsGuide.New)()
    tipsGuideNode:Init(tipsGuideObj)
    tipsGuideNode:ShowUITipsGuide(curTargetTransform, show_dir)
    return tipsGuideNode
end

GuideUtil.GetEpFirstRoomTarget = function()
    -- function num : 0_2 , upvalues : _ENV
    if not ExplorationManager:IsInExploration() then return nil end
    if ExplorationManager.epCtrl == nil then return nil end
    local roomData =
        (((ExplorationManager.epCtrl).mapCtrl).mapData):GetFirstAbleRoomData()
    if roomData == nil then return end
    local uiRoom = ((ExplorationManager.epCtrl).mapCtrl):GetRoomUI(
                       roomData.position)
    if uiRoom == nil then return nil end
    return ((uiRoom.ui).btn_EpRoom).transform
end

GuideUtil.LocationSectorStageItem = function(stageId)
    -- function num : 0_3 , upvalues : _ENV
    local window = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
    if window ~= nil then
        local difficultListNode = window:GetDifficultListNode()
        local stageItem = difficultListNode:LocationSectorStageItem(stageId)
        return stageItem
    end
    do return nil end
end

GuideUtil.TipsGuideSectorLevelItem = function(id, isAvg, show_dir)
    -- function num : 0_4 , upvalues : _ENV
    local window = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
    do
        if window ~= nil then
            local difficultListNode = window:GetDifficultListNode()
            difficultListNode:SetSectorStageItemTipsGuide(id, isAvg, show_dir)
            return true
        end
        return false
    end
end

GuideUtil.ClearTipsGuideSectorLevelItem =
    function(id, isAvg)
        -- function num : 0_5 , upvalues : _ENV
        local window = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
        if window ~= nil then
            local difficultListNode = window:GetDifficultListNode()
            difficultListNode:ClearSectorStageItemTipsGuide(id, isAvg)
        end
    end

GuideUtil.StartBattleDeployGuide = function(startX, startY, endX, endY)
    -- function num : 0_6 , upvalues : _ENV, GuideUtil
    local battleMgr = (CS.BattleManager).Instance
    if not battleMgr.IsInBattle then
        (GuideManager:GetCurGuideCtrl()):OnCurStepFinish()
        return
    end
    local battleCtrl = battleMgr.CurBattleController
    local startPoint = (Vector2.New)(startX, startY)
    local endPoint = (Vector2.New)(endX, endY)
    if not battleCtrl:ContainsRole(startPoint) or
        battleCtrl:ContainsRole(endPoint) ~= false then
        (GuideManager:GetCurGuideCtrl()):EndGuide(false)
        return
    end
    local deployGuide = (CS.BattleDeployGuideData)()
    deployGuide.endAction = GuideUtil.__OnBattleDeployGuideEnd
    deployGuide.startCoord = startPoint
    deployGuide.endCoord = endPoint
    local deployState =
        (battleCtrl.fsm):GetStateFromID((CS.eBattleState).Deploy)
    deployState.guideData = deployGuide;
    (GuideUtil.__OnBattleDeployGuideStart)(deployState, startX, startY, endX,
                                           endY)
end

GuideUtil.__OnBattleDeployGuideStart = function(deployState, startX, startY,
                                                endX, endY)
    -- function num : 0_7 , upvalues : _ENV
    (UIManager:GetWindow(UIWindowTypeID.Battle)):SetBattleStartActive(false)
    UIManager:ShowWindowAsync(UIWindowTypeID.Guide, function(window)
        -- function num : 0_7_0 , upvalues : deployState, startX, startY, endX, endY, _ENV
        if window == nil then return window end
        local startPos =
            ((deployState.battleController).battleFieldData):GetGridUnityPos(
                startX, startY)
        local endPos =
            ((deployState.battleController).battleFieldData):GetGridUnityPos(
                endX, endY)
        local startUIPos = UIManager:World2UIPosition(startPos)
        local endUIPos = UIManager:World2UIPosition(endPos)
        startUIPos = (Vector3.New)(startUIPos.x, startUIPos.y, 0)
        endUIPos = (Vector3.New)(endUIPos.x, endUIPos.y, 0)
        window:PlaySlideGuide(startUIPos, endUIPos)
        local guideStepCfg = (GuideManager:GetCurGuideCtrl()).guideStepCfg
        if guideStepCfg ~= nil then
            window:ShowHeroSmallTalk((LanguageUtil.GetLocaleText)(
                                         guideStepCfg.info),
                                     guideStepCfg.info_type,
                                     guideStepCfg.info_pos)
        end
    end)
end

GuideUtil.__OnBattleDeployGuideEnd = function(deployState)
    -- function num : 0_8 , upvalues : _ENV
    deployState.guideData = nil;
    (UIManager:GetWindow(UIWindowTypeID.Battle)):SetBattleStartActive(true)
    UIManager:ShowWindowAsync(UIWindowTypeID.Guide, function(window)
        -- function num : 0_8_0
        if window == nil then return window end
        window:EndSlideGuide()
        window:HideHeroTalkDialog()
    end);
    (GuideManager:GetCurGuideCtrl()):OnCurStepFinish()
end

GuideUtil.UnlockOasisMask = function()
    -- function num : 0_9 , upvalues : _ENV, GuideUtil
    if not GuideManager.inGuide then return end
    local mainCamera = UIManager:GetMainCamera()
    if IsNull(mainCamera) then
        (GuideManager:GetCurGuideCtrl()):EndGuide(false)
        return
    end
    local bind = mainCamera:FindComponent(eUnityComponentID.LuaBinding)
    if IsNull(bind) then
        (GuideManager:GetCurGuideCtrl()):EndGuide(false)
        return
    end
    (TimelineUtil.StopAll)()
    local sectorPlayableDirector = bind:GetBind("sectorPlayableDirector")
    sectorPlayableDirector.time = 0
    sectorPlayableDirector:Evaluate()
    local homeToSectorGo = bind:GetBind("homeToSectorGo")
    homeToSectorGo:SetActive(false)
    local oasisLockNode = bind:GetBind("oasisLockNode");
    (oasisLockNode.gameObject):SetActive(true)
    local pd_unlockOasis = bind:GetBind("pd_unlockOasis")
    pd_unlockOasis.time = 0
    pd_unlockOasis:Evaluate()
    local codeActionBinding = pd_unlockOasis:FindComponent(
                                  eUnityComponentID.CodeActionBinding)
    codeActionBinding:RegisterAction("PlayAvgAndPause", function()
        -- function num : 0_9_0 , upvalues : _ENV, GuideUtil, codeActionBinding, homeToSectorGo, pd_unlockOasis, bind
        (TimelineUtil.StopTlCo)(GuideUtil.__tlUnlockOasis)
        codeActionBinding:ClearAllAction()
        UIManager:HideWindow(UIWindowTypeID.ClickContinue)
        local avgName = ((GuideManager:GetCurGuideCtrl()).guideStepCfg).avg_name
        local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg,
                                                        true)
        avgCtrl:ShowAvg(avgName, function()
            -- function num : 0_9_0_0 , upvalues : _ENV, homeToSectorGo, pd_unlockOasis, GuideUtil, bind
            local continueFunc = function()
                -- function num : 0_9_0_0_0 , upvalues : _ENV, homeToSectorGo, pd_unlockOasis, GuideUtil, bind
                (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(
                    nil, nil, nil, Color.clear, false)
                homeToSectorGo:SetActive(true);
                (TimelineUtil.Play)(pd_unlockOasis, function()
                    -- function num : 0_9_0_0_0_0 , upvalues : GuideUtil, _ENV, bind
                    GuideUtil.__tlUnlockOasis = nil
                    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
                    local oasisLockNode = bind:GetBind("oasisLockNode");
                    (oasisLockNode.gameObject):SetActive(false)
                    local homeWindow = UIManager:GetWindow(UIWindowTypeID.Home)
                    if homeWindow ~= nil then
                        homeWindow:Show();
                        (homeWindow.rightList):WaitEpTimeLine(false)
                    end
                    (GuideManager:GetCurGuideCtrl()):OnCurStepFinish()
                end, true)
            end

            local funcUnLockCrtl = ControllerManager:GetController(
                                       ControllerTypeId.FunctionUnlock, true)
            if funcUnLockCrtl:ValidateUnlock(
                proto_csmsg_SystemFunctionID.SystemFunctionID_ChangeName) and
                (ConfigData.game_config).changeNameItemNum <=
                PlayerDataCenter:GetItemCount(
                    (ConfigData.game_config).changeNameItemId) then
                UIManager:ShowWindowAsync(UIWindowTypeID.UserNameCreate,
                                          function(window)
                    -- function num : 0_9_0_0_1 , upvalues : continueFunc
                    window:BindUIUserNameAction(continueFunc)
                end)
            else
                continueFunc()
            end
        end)
    end);
    (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil,
                                                                      nil,
                                                                      Color.clear,
                                                                      false)
    GuideUtil.__tlUnlockOasis = (TimelineUtil.Play)(pd_unlockOasis)
end

GuideUtil.GetHeroListHeroItem = function(heroId, needRoll, isFormationQuick)
    -- function num : 0_10 , upvalues : _ENV
    local heroSortList = nil
    if isFormationQuick then
        local win = UIManager:GetWindow(UIWindowTypeID.FormationQuick)
        if win == nil then return nil end
        heroSortList = win.heroSortList
    else
        do
            do
                local win = UIManager:GetWindow(UIWindowTypeID.HeroList)
                if win == nil then return nil end
                heroSortList = win.heroSortList
                if heroSortList ~= nil then
                    local hasHero, heroIndex = nil, nil
                    for index, heroData in ipairs(heroSortList.curHeroList) do
                        if heroData.dataId == heroId then
                            hasHero = true
                            heroIndex = index
                            break
                        end
                    end
                    do
                        if hasHero then
                            ((heroSortList.ui).scrollRest):SrollToCell(
                                heroIndex - 1, 5000)
                            local item = heroSortList:__GetHeroItemById(heroId)
                            if item ~= nil then
                                return item.transform
                            end
                        end
                        do return nil end
                    end
                end
            end
        end
    end
end

GuideUtil.GetMailListItem = function(mailEntry)
    -- function num : 0_11 , upvalues : _ENV
    local win = UIManager:GetWindow(UIWindowTypeID.Mail)
    if win == nil then return nil end
    local mailWin = win
    if mailWin ~= nil then
        local hasMail, mailIndex = nil, nil
        do
            for index, mailData in ipairs(mailWin.mailDataList) do
                if mailData:GetMailEntryCode() == mailEntry then
                    hasMail = true
                    mailIndex = index
                    break
                end
            end
            do
                if hasMail then
                    ((mailWin.ui).loopList_mails):SrollToCell(mailIndex - 1,
                                                              5000, function()
                        -- function num : 0_11_0 , upvalues : mailWin, mailIndex
                        ((mailWin.ui).loopList_mails):SrollToCell(mailIndex - 1,
                                                                  5000)
                    end)
                    local item = mailWin:m_GetItemGoByIndex(mailIndex - 1)
                    if item ~= nil then return item.transform end
                end
            end
            do return nil end
        end
    end
end

GuideUtil.ClearData = function(self)
    -- function num : 0_12 , upvalues : GuideUtil
    GuideUtil.__tlUnlockOasis = nil
end

return GuideUtil


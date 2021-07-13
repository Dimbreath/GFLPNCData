-- params : ...
-- function num : 0 , upvalues : _ENV
local GuideUtil = {}
local UINTipsGuide = require("Game.Guide.UI.UINTipsGuide")
GuideUtil.TipsGuidePrefabName = "TipsGuide"
local cs_coroutine = require("XLua.Common.cs_coroutine")
local cs_WaitForSeconds = (CS.UnityEngine).WaitForSeconds
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

GuideUtil.ShowTipsGuideToggle = function(curTargetTransform, guidePrefab, show_dir)
  -- function num : 0_2 , upvalues : GuideUtil, _ENV
  local tipsGuideNode = (GuideUtil.ShowTipsGuide)(curTargetTransform, guidePrefab, show_dir)
  local toggle = curTargetTransform:FindComponent(eUnityComponentID.ExToggle)
  if IsNull(toggle) then
    return 
  end
  local luaEvent = ((CS.LuaBehaviourEvent).AddNew)(tipsGuideNode.gameObject)
  local onValueChanged = function(value)
    -- function num : 0_2_0 , upvalues : tipsGuideNode
    if value then
      tipsGuideNode:Hide()
    else
      tipsGuideNode:Show()
    end
  end

  onValueChanged(toggle.isOn)
  ;
  (toggle.onValueChanged):AddListener(onValueChanged)
  luaEvent:onDestroy("+", function()
    -- function num : 0_2_1 , upvalues : _ENV, toggle, onValueChanged
    if IsNull(toggle) then
      return 
    end
    ;
    (toggle.onValueChanged):RemoveListener(onValueChanged)
  end
)
end

GuideUtil.GetEpFirstRoomTarget = function()
  -- function num : 0_3 , upvalues : _ENV
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

GuideUtil.GetEpCuroomTarget = function()
  -- function num : 0_4 , upvalues : _ENV
  if not ExplorationManager:IsInExploration() then
    return nil
  end
  if ExplorationManager.epCtrl == nil then
    return nil
  end
  local roomData = (ExplorationManager.epCtrl):GetCurrentRoomData(true)
  if roomData == nil then
    return 
  end
  local uiRoom = ((ExplorationManager.epCtrl).mapCtrl):GetRoomUI(roomData.position)
  if uiRoom == nil then
    return nil
  end
  return uiRoom.transform
end

GuideUtil.GetSpaceAthByAthList = function(size)
  -- function num : 0_5 , upvalues : _ENV
  local uiAth = UIManager:GetWindow(UIWindowTypeID.Ath)
  if uiAth == nil then
    return 
  end
  local transform = (((uiAth.athListNode).athListArea).athScrollList):GetSpaceAthByList(size)
  return transform
end

GuideUtil.LocationSectorStageItem = function(stageId, isAvg)
  -- function num : 0_6 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
  if window ~= nil then
    local difficultListNode = window:GetDifficultListNode()
    local stageItem = difficultListNode:LocationSectorStageItem(stageId, isAvg)
    return stageItem
  end
  do
    return nil
  end
end

GuideUtil.TipsGuideSectorLevelItem = function(id, isAvg, show_dir)
  -- function num : 0_7 , upvalues : _ENV
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
  -- function num : 0_8 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
  if window ~= nil then
    local difficultListNode = window:GetDifficultListNode()
    difficultListNode:ClearSectorStageItemTipsGuide(id, isAvg)
  end
end

GuideUtil.StartBattleDeployGuide = function(startX, startY, endX, endY)
  -- function num : 0_9 , upvalues : _ENV, GuideUtil
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
  -- function num : 0_10 , upvalues : _ENV
  (UIManager:GetWindow(UIWindowTypeID.Battle)):SetBattleCanvasRaycast(false)
  UIManager:ShowWindowAsync(UIWindowTypeID.Guide, function(window)
    -- function num : 0_10_0 , upvalues : deployState, startX, startY, endX, endY, _ENV
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
  -- function num : 0_11 , upvalues : _ENV
  deployState.guideData = nil
  ;
  (UIManager:GetWindow(UIWindowTypeID.Battle)):SetBattleCanvasRaycast(true)
  UIManager:ShowWindowAsync(UIWindowTypeID.Guide, function(window)
    -- function num : 0_11_0
    if window == nil then
      return window
    end
    window:EndSlideGuide()
    window:EndHandClickGuide()
    window:HideHeroTalkDialog()
  end
)
  ;
  (GuideManager:GetCurGuideCtrl()):OnCurStepFinish()
end

GuideUtil.StartBattleDeployClickGuide = function(endX, endY)
  -- function num : 0_12 , upvalues : _ENV, GuideUtil
  local battleMgr = (CS.BattleManager).Instance
  if not battleMgr.IsInBattle then
    (GuideManager:GetCurGuideCtrl()):OnCurStepFinish()
    return 
  end
  local battleCtrl = battleMgr.CurBattleController
  local deployState = (battleCtrl.fsm):GetStateFromID((CS.eBattleState).Deploy)
  local deployGuide = (CS.BattleDeployGuideData)()
  deployGuide.guideType = ((CS.BattleDeployGuideData).GuideType).ClickRole
  deployGuide.endAction = GuideUtil.__OnBattleDeployGuideEnd
  deployGuide.endCoord = {x = endX, y = endY}
  deployState.guideData = deployGuide
  ;
  (UIManager:GetWindow(UIWindowTypeID.Battle)):SetBattleCanvasRaycast(false)
  UIManager:ShowWindowAsync(UIWindowTypeID.Guide, function(window)
    -- function num : 0_12_0 , upvalues : deployState, endX, endY, _ENV
    if window == nil then
      return window
    end
    local startPos = ((deployState.battleController).battleFieldData):GetGridUnityPos(endX, endY)
    local startUIPos = UIManager:World2UIPosition(startPos)
    window:PlayHandClickGuide(startUIPos)
    local guideStepCfg = (GuideManager:GetCurGuideCtrl()).guideStepCfg
    if guideStepCfg ~= nil then
      window:ShowHeroSmallTalk((LanguageUtil.GetLocaleText)(guideStepCfg.info), guideStepCfg.info_type, guideStepCfg.info_pos)
    end
  end
)
end

GuideUtil.CancelReturnHomeCv = function()
  -- function num : 0_13 , upvalues : _ENV
  local homeCtrl = ControllerManager:GetController(ControllerTypeId.HomeController, true)
  homeCtrl:NextReturnHomeDontPlayCv(true)
end

GuideUtil.UnlockOasisMask = function()
  -- function num : 0_14 , upvalues : _ENV, GuideUtil
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
    -- function num : 0_14_0 , upvalues : _ENV, GuideUtil, codeActionBinding, homeToSectorGo, pd_unlockOasis, bind
    (TimelineUtil.StopTlCo)(GuideUtil.__tlUnlockOasis)
    codeActionBinding:ClearAllAction()
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    local avgName = ((GuideManager:GetCurGuideCtrl()).guideStepCfg).avg_name
    local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
    avgCtrl:ShowAvg(avgName, function()
      -- function num : 0_14_0_0 , upvalues : _ENV, homeToSectorGo, pd_unlockOasis, GuideUtil, bind
      local continueFunc = function()
        -- function num : 0_14_0_0_0 , upvalues : _ENV, homeToSectorGo, pd_unlockOasis, GuideUtil, bind
        (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
        homeToSectorGo:SetActive(true)
        ;
        (TimelineUtil.Play)(pd_unlockOasis, function()
          -- function num : 0_14_0_0_0_0 , upvalues : GuideUtil, _ENV, bind
          GuideUtil.__tlUnlockOasis = nil
          UIManager:HideWindow(UIWindowTypeID.ClickContinue)
          local oasisLockNode = bind:GetBind("oasisLockNode")
          ;
          (oasisLockNode.gameObject):SetActive(false)
          local homeWindow = UIManager:GetWindow(UIWindowTypeID.Home)
          if homeWindow ~= nil then
            homeWindow:Show()
          end
          ;
          (GuideManager:GetCurGuideCtrl()):OnCurStepFinish()
        end
, true)
      end

      if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_ChangeName) and (ConfigData.game_config).changeNameItemNum <= PlayerDataCenter:GetItemCount((ConfigData.game_config).changeNameItemId) then
        UIManager:ShowWindowAsync(UIWindowTypeID.UserNameCreate, function(window)
        -- function num : 0_14_0_0_1 , upvalues : continueFunc
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
  -- function num : 0_15 , upvalues : _ENV
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
                if isFormationQuick then
                  return (item.cardItem).transform
                end
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

GuideUtil.GetNewFmtHeroItem = function(heroId)
  -- function num : 0_16 , upvalues : _ENV
  local fmtWindow = UIManager:GetWindow(UIWindowTypeID.Formation)
  if fmtWindow == nil then
    return nil
  end
  local heroList = (fmtWindow.editorNode).showHeroList
  if heroList == nil then
    return 
  end
  local heroIndex = nil
  for index,heroData in ipairs(heroList) do
    if heroData.dataId == heroId then
      heroIndex = index
      break
    end
  end
  do
    if heroIndex == nil then
      return nil
    end
    ;
    (((fmtWindow.editorNode).ui).cardList):SrollToCell(heroIndex - 1, 10000)
    local heroItem = (fmtWindow.editorNode):__GetFmtHeroItemByIndex(heroIndex - 1)
    if heroItem ~= nil then
      return (heroItem.heroCardItem).transform
    end
    return nil
  end
end

GuideUtil.GetMailListItem = function(mailEntry)
  -- function num : 0_17 , upvalues : _ENV
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
    -- function num : 0_17_0 , upvalues : mailWin, mailIndex
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

GuideUtil.SectorForceFocus = function(fromArg)
  -- function num : 0_18 , upvalues : _ENV
  local SectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  if SectorCtrl == nil then
    return 
  end
  SectorCtrl:SetForceFocus(fromArg)
end

GuideUtil.SelectLotteryPool = function(poolId)
  -- function num : 0_19 , upvalues : _ENV
  local lotteryWindow = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
  if lotteryWindow ~= nil then
    lotteryWindow:SelectLotteryPoolById(poolId)
  end
end

GuideUtil.ScrollLotteryPoolEnd = function()
  -- function num : 0_20 , upvalues : _ENV
  local lotteryWindow = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
  if lotteryWindow ~= nil then
    lotteryWindow:ScrollLotteryPoolEnd()
  end
end

GuideUtil.SetGuideShopHeroActive = function(active)
  -- function num : 0_21 , upvalues : _ENV
  local shopWindow = UIManager:GetWindow(UIWindowTypeID.ShopMain)
  if shopWindow == nil or shopWindow.recommeShopNode == nil then
    return 
  end
  ;
  (shopWindow.recommeShopNode):SetInGuideShopHeroActive(active)
end

GuideUtil.StartFormationGuide = function(heroId, posId)
  -- function num : 0_22 , upvalues : cs_coroutine, _ENV, cs_WaitForSeconds, GuideUtil
  (cs_coroutine.start)(function()
    -- function num : 0_22_0 , upvalues : _ENV, cs_WaitForSeconds, heroId, GuideUtil, posId
    local guideWindow = UIManager:GetWindow(UIWindowTypeID.Guide)
    local fmtWindow = UIManager:GetWindow(UIWindowTypeID.Formation)
    if guideWindow == nil or fmtWindow == nil then
      GuideManager:SkipGuide()
      return 
    end
    guideWindow:SetWaitMaskActive(true)
    ;
    (coroutine.yield)(cs_WaitForSeconds(0.7))
    local heroList = (fmtWindow.editorNode).showHeroList
    if heroList == nil then
      guideWindow:SetWaitMaskActive(false)
      GuideManager:SkipGuide()
      return 
    end
    local heroIndex = nil
    for index,heroData in ipairs(heroList) do
      if heroData.dataId == heroId then
        heroIndex = index
        break
      end
    end
    do
      if heroIndex == nil then
        warn("guide formation not heroId:" .. tostring(heroId))
        guideWindow:SetWaitMaskActive(false)
        GuideManager:SkipGuide()
        return 
      end
      local heroTransfrom = nil
      while heroTransfrom == nil do
        heroTransfrom = (GuideUtil.GetNewFmtHeroItem)(heroId)
        ;
        (coroutine.yield)()
      end
      ;
      (coroutine.yield)(cs_WaitForSeconds(0.3))
      guideWindow:SetWaitMaskActive(false)
      guideWindow:StartLimitGuideOpArea((fmtWindow.ui).guideLimitArea)
      local obj = (((CS.UnityEngine).GameObject).Find)("Formation(Clone)/Scene/BasePlatform" .. tostring(posId))
      if IsNull(obj) then
        warn("guide formation not Platform Id:" .. tostring(posId))
        GuideManager:SkipGuide()
        return 
      end
      local destTransfrom = obj.transform
      local startUIPos = UIManager:World2UIPosition(heroTransfrom.position, nil, nil, UIManager.UICamera)
      local endUIPos = UIManager:World2UIPosition(destTransfrom.position)
      startUIPos = (Vector3.New)(startUIPos.x, startUIPos.y, 0)
      endUIPos = (Vector3.New)(endUIPos.x, endUIPos.y, 0)
      guideWindow:PlaySlideGuide(startUIPos, endUIPos)
      local guideStepCfg = (GuideManager:GetCurGuideCtrl()).guideStepCfg
      if guideStepCfg ~= nil then
        guideWindow:ShowHeroSmallTalk((LanguageUtil.GetLocaleText)(guideStepCfg.info), guideStepCfg.info_type, guideStepCfg.info_pos)
      end
      ;
      (fmtWindow.editorNode):SetFmtEditorGuideData(heroId, posId)
      while not (fmtWindow.editorNode):IsFmtEditorGuideComplete() do
        (coroutine.yield)()
      end
      ;
      (fmtWindow.editorNode):ClearFmtEditorGuideData()
      guideWindow:EndLimitGuideOpArea()
      guideWindow:EndSlideGuide()
      guideWindow:EndHandClickGuide()
      guideWindow:HideHeroTalkDialog()
      ;
      (GuideManager:GetCurGuideCtrl()):OnCurStepFinish()
    end
  end
)
end

GuideUtil.GetHeroPotentialFmtPlat = function()
  -- function num : 0_23 , upvalues : _ENV
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
  local fmtWindow = UIManager:GetWindow(UIWindowTypeID.Formation)
  if fmtCtrl == nil or fmtWindow == nil then
    warn("guide get potential formation plat controller or window is null !!")
    return nil
  end
  local heroDic = fmtCtrl:GetFormationHeroDic()
  if heroDic == nil then
    warn("guide get potential formation plat hero data dic is null !!")
    return 
  end
  local guideIndex = 0
  for index = 1, (ConfigData.game_config).max_formation_hero do
    local heroId = heroDic[index]
    if heroId ~= nil then
      local heroInfoItem = (fmtWindow.heroInfoDic)[heroId]
      if heroInfoItem ~= nil and heroInfoItem:FmtHeroAblePotential() then
        guideIndex = index
        break
      end
    end
  end
  do
    if guideIndex == 0 then
      warn("guide get potential formation plat not a hero able potential !!")
      return nil
    end
    local fmtPlatEntity = (fmtCtrl.fmtSceneCtrl):GetFmtPlatEntityByIndex(guideIndex)
    if fmtPlatEntity == nil then
      warn("guide get potential formation plat not a hero able potential !!")
      return nil
    end
    return fmtPlatEntity.transform
  end
end

GuideUtil.GetHeroQuickLevelUpFmtPlat = function()
  -- function num : 0_24 , upvalues : _ENV
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
  local fmtWindow = UIManager:GetWindow(UIWindowTypeID.Formation)
  if fmtCtrl == nil or fmtWindow == nil then
    warn("guide get QuickLevelUp formation plat controller or window is null !!")
    return nil
  end
  local ui3dFmt = (fmtCtrl.fmtSceneCtrl):Get3DUIFormation()
  if ui3dFmt == nil then
    warn("guide get QuickLevelUp formation 3DUIFormation is null !!")
    return nil
  end
  local platformDic = ui3dFmt:GetPlotformItemDic()
  for index,platItem in pairs(platformDic) do
    if platItem:IsAbleQuickLevelup() then
      return platItem:GetQuickLevelupBtnUI()
    end
  end
  return nil
end

GuideUtil.ClearData = function(self)
  -- function num : 0_25 , upvalues : GuideUtil
  GuideUtil.__tlUnlockOasis = nil
end

return GuideUtil


-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleDungeonBattleCtrl = require("Game.BattleDungeon.Ctrl.BattleDungeonBattleCtrl")
local BattleDungeonGuideBatteCtrl = class("BattleDungeonGuideBatteCtrl", BattleDungeonBattleCtrl)
local DungeonBattleRoom = require("Game.BattleDungeon.Data.DungeonBattleRoom")
BattleDungeonGuideBatteCtrl.ctor = function(self, bdCtrl, guideType)
  -- function num : 0_0 , upvalues : _ENV
  self.guideType = guideType
  self.__OnBattleUpdateUltSkill = BindCallback(self, self.OnBattleUpdateUltSkill)
  MsgCenter:AddListener(eMsgEventId.OnBattleUpdateUltSkill, self.__OnBattleUpdateUltSkill)
end

BattleDungeonGuideBatteCtrl.OnBattleStateChange = function(self, battleCtrl, stateId, isDeployRoom)
  -- function num : 0_1 , upvalues : _ENV
  self.curStateId = stateId
  if stateId ~= eBattleState.Init or stateId == eBattleState.Deploy then
    if self.guideType == 1 then
      local window = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
      if window ~= nil then
        window:ShowUltSkillNode(false)
      end
    else
      do
        if self.guideType == 2 then
          self:StartNewClickRoleGuide(battleCtrl)
        end
        if stateId == eBattleState.Running then
          UIManager:HideWindow(UIWindowTypeID.BattleDPS)
          local window = UIManager:GetWindow(UIWindowTypeID.Battle)
          if window ~= nil then
            window:HidePauseButton()
          end
        else
        end
        do
          if stateId ~= eBattleState.End or stateId == eBattleState.Delete then
            self.curStateId = -1
          end
        end
      end
    end
  end
end

BattleDungeonGuideBatteCtrl.DungeonBattleStepLogic = function(self, monsterGroup)
  -- function num : 0_2 , upvalues : DungeonBattleRoom, _ENV
  local battleRoomData = (DungeonBattleRoom.CreateBattleDungeonRoom)(self.bdCtrl, monsterGroup, (self.bdCtrl).dungeonCfg, (self.bdCtrl).dynPlayer)
  self.battleRoomData = battleRoomData
  if self.guideType == 1 then
    local firstBattle1Config = (GuideManager.firstBattleGuideCtrl):GetFirstBattleConfig()
    do
      self.__guideConfig = firstBattle1Config
      local battleCtrl = ((CS.BattleManager).Instance):StartNewBattle(battleRoomData, (self.bdCtrl).dynPlayer, self)
      battleCtrl:StartEnterDeployState()
      GuideManager:StartNewGuide(((self.__guideConfig).guideList)[1])
    end
  else
    do
      if self.guideType == 2 then
        local firstBattle2Config = (GuideManager.firstBattleGuideCtrl):GetFirstBattleConfig()
        self.__guideConfig = firstBattle2Config
        local dynPlayer = (self.bdCtrl).dynPlayer
        for k,v in ipairs(firstBattle2Config.formHeroPos) do
          ((dynPlayer.heroList)[k]):SetCoordXY(v[1], v[2])
        end
        local battleCtrl = ((CS.BattleManager).Instance):StartNewBattle(battleRoomData, (self.bdCtrl).dynPlayer, self)
        local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
        avgCtrl:ShowAvg(firstBattle2Config.beforeDragAvg, function()
    -- function num : 0_2_0 , upvalues : battleCtrl
    battleCtrl:StartEnterDeployState()
  end
, true)
      else
        do
          error("error battle guideType:" .. tostring(self.guideType))
        end
      end
    end
  end
end

BattleDungeonGuideBatteCtrl.StartNewClickRoleGuide = function(self, battleCtrl)
  -- function num : 0_3 , upvalues : _ENV
  local deployState = (battleCtrl.fsm):GetStateFromID((CS.eBattleState).Deploy)
  local firstBattle2Config = (GuideManager.firstBattleGuideCtrl):GetFirstBattleConfig()
  local deployGuide = (CS.BattleDeployGuideData)()
  deployGuide.guideType = ((CS.BattleDeployGuideData).GuideType).ClickRole
  deployGuide.endAction = BindCallback(self, self.OnClickRoleGuideComplete, deployState)
  local dstCoord = {x = (firstBattle2Config.clickHeroPos)[1], y = (firstBattle2Config.clickHeroPos)[2]}
  deployGuide.endCoord = dstCoord
  deployState.guideData = deployGuide
  ;
  (UIManager:GetWindow(UIWindowTypeID.Battle)):SetBattleStartActive(false)
  UIManager:ShowWindowAsync(UIWindowTypeID.Guide, function(window)
    -- function num : 0_3_0 , upvalues : deployState, dstCoord, _ENV, firstBattle2Config
    if window == nil then
      return window
    end
    local startPos = ((deployState.battleController).battleFieldData):GetGridUnityPos(dstCoord.x, dstCoord.y)
    local startUIPos = UIManager:World2UIPosition(startPos)
    window:PlayHandClickGuide(startUIPos)
    window:ShowHeroSmallTalk(ConfigData:GetTipContent(firstBattle2Config.introHeroGuideTextId), firstBattle2Config.introHeroGuideHeroId, firstBattle2Config.introHeroGuidePos)
  end
)
end

BattleDungeonGuideBatteCtrl.OnClickRoleGuideComplete = function(self, deployState)
  -- function num : 0_4 , upvalues : _ENV
  deployState.guideData = nil
  UIManager:ShowWindowAsync(UIWindowTypeID.Guide, function(window)
    -- function num : 0_4_0
    if window == nil then
      return window
    end
    window:EndHandClickGuide()
    window:HideHeroTalkDialog()
  end
)
  self.__OnHeroDetailActiveChange = BindCallback(self, self.OnHeroDetailActiveChange, deployState)
  MsgCenter:AddListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnHeroDetailActiveChange)
  GuideManager:StartNewGuide(((self.__guideConfig).guideList)[4])
end

BattleDungeonGuideBatteCtrl.OnHeroDetailActiveChange = function(self, deployState, active)
  -- function num : 0_5 , upvalues : _ENV
  if not active then
    MsgCenter:RemoveListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnHeroDetailActiveChange)
    self.__OnHeroDetailActiveChange = nil
    ;
    (UIManager:GetWindow(UIWindowTypeID.Battle)):SetBattleStartActive(true)
    GuideManager:StartNewGuide(((self.__guideConfig).guideList)[1])
  end
end

BattleDungeonGuideBatteCtrl.StartNewDeployDragGuide = function(self, battleCtrl)
  -- function num : 0_6 , upvalues : _ENV
  local firstBattle2Config = (GuideManager.firstBattleGuideCtrl):GetFirstBattleConfig()
  local deployGuide = (CS.BattleDeployGuideData)()
  deployGuide.endAction = BindCallback(self, self.OnDeployGuideEnd)
  deployGuide.startCoord = {x = ((self.battleRoomData).battleMap).BenchCoordX, y = firstBattle2Config.benchHeroOriginPos}
  deployGuide.endCoord = {x = (firstBattle2Config.benchHeroPos)[1], y = (firstBattle2Config.benchHeroPos)[2]}
  local deployState = (battleCtrl.fsm):GetStateFromID((CS.eBattleState).Deploy)
  deployState.guideData = deployGuide
  self:OnDeployGuideStart(deployState)
end

BattleDungeonGuideBatteCtrl.OnBattleStart = function(self, battleCtrl)
  -- function num : 0_7 , upvalues : _ENV, BattleDungeonBattleCtrl
  if self.guideType == 1 then
    local window = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
    if window ~= nil then
      window:ShowPlayerSkillNode(false)
      window:ShowUltSkillNode(false)
    end
    LuaSkillCtrl:GetTimer((self.__guideConfig).csGuideDelay, BindCallback(self, self.StartGuideCommandSkill1, battleCtrl))
  else
    do
      do
        if self.guideType == 2 then
          local window = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
          if window ~= nil then
            (window.playerSkillNode):SetSkillItemActive(2, false)
          end
          LuaSkillCtrl:GetTimer((self.__guideConfig).csGuideDelay, BindCallback(self, self.StartGuideCommandSkill2, battleCtrl))
        end
        ;
        (BattleDungeonBattleCtrl.OnBattleStart)(self, battleCtrl)
      end
    end
  end
end

BattleDungeonGuideBatteCtrl.StartGuideCommandSkill1 = function(self, battleCtrl)
  -- function num : 0_8 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if window ~= nil then
    window:ShowPlayerSkillNode(true)
  end
  self.oldTimeScale = (Time.unity_time).timeScale
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (Time.unity_time).timeScale = 0
  GuideManager:StartNewGuide(((self.__guideConfig).guideList)[2], function()
    -- function num : 0_8_0 , upvalues : _ENV, self
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

    (Time.unity_time).timeScale = self.oldTimeScale
  end
)
end

BattleDungeonGuideBatteCtrl.StartGuideCommandSkill2 = function(self, battleCtrl)
  -- function num : 0_9 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if window ~= nil then
    (window.playerSkillNode):SetSkillItemActive(2, true)
  end
  if battleCtrl == nil then
    return 
  end
  ;
  (battleCtrl.PlayerController):ResetCurMpRatio(100)
  self.oldTimeScale = (Time.unity_time).timeScale
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (Time.unity_time).timeScale = 0
  local firstBattle2Config = (GuideManager.firstBattleGuideCtrl):GetFirstBattleConfig()
  local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
  avgCtrl:ShowAvg(firstBattle2Config.dragSkillGuideAvg, function()
    -- function num : 0_9_0 , upvalues : self, battleCtrl
    self:StartGuideCommandSkillSelect(battleCtrl)
  end
, true, true)
end

BattleDungeonGuideBatteCtrl.StartGuideCommandSkillSelect = function(self, battleCtrl)
  -- function num : 0_10 , upvalues : _ENV
  local skillWindow = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if skillWindow == nil then
    return 
  end
  local guideSkillIndex = 2
  local skillItem = (skillWindow.playerSkillNode):GetSkillItem(guideSkillIndex)
  if skillItem == nil then
    return 
  end
  local firstBattle2Config = (GuideManager.firstBattleGuideCtrl):GetFirstBattleConfig()
  local startUIPos = (skillWindow.transform):InverseTransformPoint((skillItem.transform).position)
  UIManager:ShowWindowAsync(UIWindowTypeID.Guide, function(window)
    -- function num : 0_10_0 , upvalues : battleCtrl, firstBattle2Config, _ENV, startUIPos
    if window == nil then
      return window
    end
    local endPos = (battleCtrl.battleFieldData):GetGridUnityPos((firstBattle2Config.dragSkillGuidePos)[1], (firstBattle2Config.dragSkillGuidePos)[2])
    local endUIPos = UIManager:World2UIPosition(endPos)
    endUIPos = (Vector3.New)(endUIPos.x, endUIPos.y, 0)
    window:PlaySlideGuide(startUIPos, endUIPos)
    window:ShowHeroSmallTalk(ConfigData:GetTipContent(firstBattle2Config.dragSkillGuideTextId), firstBattle2Config.dragSkillGuideHeroId, firstBattle2Config.dragSkillGuideTalkPos)
  end
)
  local skillGuideData = (CS.BattleSkillCastGuideData)()
  skillGuideData.guideSkillId = (firstBattle2Config.formCSList)[guideSkillIndex]
  skillGuideData.endAction = function(battleCtrl)
    -- function num : 0_10_1 , upvalues : _ENV, self
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

    (Time.unity_time).timeScale = self.oldTimeScale
    local guideWindow = UIManager:GetWindow(UIWindowTypeID.Guide)
    if guideWindow ~= nil then
      guideWindow:EndSlideGuide()
      guideWindow:HideHeroTalkDialog()
    end
  end

  ;
  (battleCtrl.PlayerController):StartSkillCastGuide(skillGuideData)
end

BattleDungeonGuideBatteCtrl.OnDeployGuideStart = function(self, deployState)
  -- function num : 0_11 , upvalues : _ENV
  local firstBattle2Config = (GuideManager.firstBattleGuideCtrl):GetFirstBattleConfig()
  ;
  (UIManager:GetWindow(UIWindowTypeID.Battle)):SetBattleStartActive(false)
  UIManager:ShowWindowAsync(UIWindowTypeID.Guide, function(window)
    -- function num : 0_11_0 , upvalues : deployState, firstBattle2Config, _ENV
    if window == nil then
      return window
    end
    local startPos = ((deployState.battleController).battleFieldData):GetBenchUnityPos(firstBattle2Config.benchHeroOriginPos)
    local endPos = ((deployState.battleController).battleFieldData):GetGridUnityPos((firstBattle2Config.benchHeroPos)[1], (firstBattle2Config.benchHeroPos)[2])
    local startUIPos = UIManager:World2UIPosition(startPos)
    local endUIPos = UIManager:World2UIPosition(endPos)
    startUIPos = (Vector3.New)(startUIPos.x, startUIPos.y, 0)
    endUIPos = (Vector3.New)(endUIPos.x, endUIPos.y, 0)
    window:PlaySlideGuide(startUIPos, endUIPos)
    window:ShowHeroSmallTalk(ConfigData:GetTipContent(firstBattle2Config.dragGuideTextId), firstBattle2Config.guideTalkHeroId, firstBattle2Config.guideTalkPos)
  end
)
  self.__guideResloader = ((CS.ResLoader).Create)()
  ;
  (self.__guideResloader):LoadABAssetAsync("FX/Common/FX_UI/FXP_pickHexagonPlayer/FXUI_pickHexagonPlayer_go.prefab", function(go)
    -- function num : 0_11_1 , upvalues : _ENV, deployState, firstBattle2Config, self
    if IsNull(go) then
      return 
    end
    local floorTile = ((deployState.battleController).FloorTileController):GetFloorTile((firstBattle2Config.benchHeroPos)[1], (firstBattle2Config.benchHeroPos)[2])
    if floorTile == nil then
      return 
    end
    self.__deployHightlight = go:Instantiate(floorTile.transform)
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.__deployHightlight).transform).localPosition = Vector3.zero
  end
)
end

BattleDungeonGuideBatteCtrl.OnDeployGuideEnd = function(self, deployState)
  -- function num : 0_12 , upvalues : _ENV
  deployState.guideData = nil
  DestroyUnityObject(self.__deployHightlight)
  if self.__guideResloader ~= nil then
    (self.__guideResloader):Put2Pool()
    self.__guideResloader = nil
  end
  GuideManager:StartNewGuide(((self.__guideConfig).guideList)[1])
  ;
  (UIManager:GetWindow(UIWindowTypeID.Battle)):SetBattleStartActive(true)
  local guideWindow = UIManager:GetWindow(UIWindowTypeID.Guide)
  if guideWindow ~= nil then
    guideWindow:EndSlideGuide()
    guideWindow:HideHeroTalkDialog()
  end
end

BattleDungeonGuideBatteCtrl.OnBattleUpdateUltSkill = function(self, useEnable, curRatio, factor)
  -- function num : 0_13 , upvalues : _ENV
  if useEnable and self.guideType == 2 then
    if self.__guideUltSkillOver then
      return 
    end
    self.__guideUltSkillOver = true
    ;
    ((((CS.BattleManager).Instance).CurBattleController).PlayerController):EndSelectInputByCancel()
    self.oldTimeScale = (Time.unity_time).timeScale
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (Time.unity_time).timeScale = 0
    GuideManager:StartNewGuide(((self.__guideConfig).guideList)[2], function()
    -- function num : 0_13_0 , upvalues : _ENV, self
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

    (Time.unity_time).timeScale = self.oldTimeScale
  end
)
  end
end

BattleDungeonGuideBatteCtrl.ReqBattleSettle = function(self, battleEndState, requestData)
  -- function num : 0_14 , upvalues : BattleDungeonBattleCtrl
  battleEndState.win = true
  ;
  (BattleDungeonBattleCtrl.ReqBattleSettle)(self, battleEndState, requestData)
end

BattleDungeonGuideBatteCtrl.OnDelete = function(self)
  -- function num : 0_15 , upvalues : _ENV, BattleDungeonBattleCtrl
  if self.__OnHeroDetailActiveChange ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnHeroDetailActiveChange)
  end
  MsgCenter:RemoveListener(eMsgEventId.OnBattleUpdateUltSkill, self.__OnBattleUpdateUltSkill)
  ;
  (BattleDungeonBattleCtrl.OnDelete)(self)
  UIManager:DeleteWindow(UIWindowTypeID.Guide)
end

return BattleDungeonGuideBatteCtrl


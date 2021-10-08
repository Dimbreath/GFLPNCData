local UINFormationChoice = class("UINFormationChoice", UIBaseNode)
local base = UIBaseNode
local UINFormationChoiceItem = require("Game.Formation.UI.UINFormationChoiceItem")
local UINFormationChoiceSupportItem = require("Game.Formation.UI.UINFormationChoiceSupportItem")
local UINFormationChioceCareerTog = require("Game.Formation.UI.UINFormationChioceCareerTog")
local HeroFilterEnum = require("Game.Hero.NewUI.HeroFilterEnum")
local UINFmtEvaluation = require("Game.Formation.UI.FormationEvaluation.UIFmtEvaluation")
local FriendSupportHeroData = require("Game.Formation.Data.FriendSupportHeroData")
local cs_MessageCommon = CS.MessageCommon
UINFormationChoice.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINFormationChioceCareerTog, UINFormationChoiceSupportItem, HeroFilterEnum
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ReSet, self, self.OnClickResetFomration)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Sort, self, self.OnClickPowerSort)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnClickChioceClose)
  self.heroItemDic = {}
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).cardList).onInstantiateItem = BindCallback(self, self.OnInstantiateItem)
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).cardList).onChangeItem = BindCallback(self, self.OnHeroChangeItem)
  self.__OnBeginDragHero = BindCallback(self, self.OnBeginDragHero)
  self.__OnDragHero = BindCallback(self, self.OnDragHero)
  self.__OnEndDragHero = BindCallback(self, self.OnEndDragHero)
  self.__OnClickHero = BindCallback(self, self.OnClickHero)
  self.__OnClickSelectSupportHero = BindCallback(self, self.OnClickSelectSupportHero)
  self.__OnCheckModelDrag = BindCallback(self, self.OnCheckModelDrag)
  self.__OnPullFormationDeal = BindCallback(self, self.OnPullFormationDeal)
  self.__OnClickCareerFiltrate = BindCallback(self, self.OnClickCareerFiltrate)
  self.careerPool = (UIItemPool.New)(UINFormationChioceCareerTog, (self.ui).tog_Filtrate)
  ;
  (((self.ui).tog_Filtrate).gameObject):SetActive(false)
  self.supportHero = (UINFormationChoiceSupportItem.New)()
  ;
  (self.supportHero):Init((self.ui).obj_SupportHolder)
  local careerMax = (HeroFilterEnum.eKindMaxCount)[(HeroFilterEnum.eKindType).Career]
  for i = 0, careerMax do
    local careerTog = (self.careerPool):GetOne()
    careerTog:InitCareerTog(i, self.__OnClickCareerFiltrate)
  end
  self.selectCareer = 0
  self.isDesOrder = true
  self.__dragingHero = false
  self.__OnShowChoiceItemRedTip = BindCallback(self, self.OnShowChoiceItemRedTip)
  RedDotController:AddListener(RedDotDynPath.HeroCardStartUpPath, self.__OnShowChoiceItemRedTip)
  self.__OnShowChoiceItemNorTip = BindCallback(self, self.OnShowChoiceItemNorTip)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnShowChoiceItemNorTip)
  self.__OnShowChoiceItemInfo = BindCallback(self, self.OnShowChoiceItemInfo)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__OnShowChoiceItemInfo)
  self.__OnChoiceItemSkinChange = BindCallback(self, self.OnChoiceItemSkinChange)
  MsgCenter:AddListener(eMsgEventId.OnHeroSkinChange, self.__OnChoiceItemSkinChange)
end

UINFormationChoice.OnShow = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (UIUtil.SetTopStatus)(self, self.OnClickQuick)
end

UINFormationChoice.InitFormationChoice = function(self, uiFormation, isInitArg)
  -- function num : 0_2 , upvalues : _ENV, FriendSupportHeroData
  self.fmtCtrl = uiFormation.fmtCtrl
  self.uiFormation = uiFormation
  if isInitArg then
    self.selectCareer = 0
    self.isDesOrder = true
  end
  local heroDataDic = {}
  local fomationData = nil
  if (self.fmtCtrl).virtualFormationData ~= nil then
    fomationData = (self.fmtCtrl).virtualFormationData
  else
    fomationData = (PlayerDataCenter.formationDic)[(self.uiFormation).fmtId]
  end
  if (self.fmtCtrl).fmtDailyDungeonDyncData ~= nil then
    ((self.ui).curPower):SetActive(false)
  end
  if (self.fmtCtrl).isFriendSupport then
    local supportHeroData = fomationData:GetRealSupportHeroData()
    local inFmt = fomationData:GetRealSupportHeroData() ~= nil
    if supportHeroData == nil then
      supportHeroData = (self.fmtCtrl):GetCacheSelectedSupportHero()
    end
    local fmtDailyDungeonDyncData = (self.fmtCtrl).fmtDailyDungeonDyncData
    if fmtDailyDungeonDyncData ~= nil and fmtDailyDungeonDyncData:HasDgDyncLastAstHero() then
      local brief, random = fmtDailyDungeonDyncData:GetDgDyncAscHeroData()
      local fixCfg = (PlayerDataCenter.supportHeroData):GetCurFormationLevelEffectByAllHero(PlayerDataCenter.heroDic)
      supportHeroData = (FriendSupportHeroData.CreatSupportHeroDataBase)(brief, random, fixCfg)
    end
    ;
    (self.supportHero):Show()
    if (self.fmtCtrl).isFriendSupportTimeLimitted then
      (self.supportHero):InitAsExhaustCard()
    elseif supportHeroData ~= nil then
      (self.supportHero):InitChoiceItem(supportHeroData, (self.fmtCtrl).resloader, self.__OnBeginDragHero, self.__OnDragHero, self.__OnEndDragHero, self.__OnClickSelectSupportHero)
      ;
      (self.supportHero):SetFmtChoiceSupportItemInFmt(inFmt)
      if fmtDailyDungeonDyncData ~= nil then
        local hpPer = fmtDailyDungeonDyncData:GetDungeonDyncHeroHpPer(supportHeroData)
        ;
        (self.supportHero):UpdFmtHeroChoiceItemHp(hpPer)
      end
    else
      (self.supportHero):InitAsEmpuyCard(self.__OnClickSelectSupportHero)
    end
  else
    (self.supportHero):Hide()
  end
  for k,v in pairs(PlayerDataCenter.heroDic) do
    local isCanAdd = true
    for i,formationHeroId in pairs(fomationData:GetFormationHeroList(true)) do
      if v.dataId == formationHeroId then
        isCanAdd = false
        break
      end
    end
    if isCanAdd then
      heroDataDic[k] = v
    end
  end
  self.heroDataDic = heroDataDic
  for k,v in pairs((self.careerPool).listItem) do
    if v.careerId == self.selectCareer then
      v:SetTogState(true)
      break
    end
  end
  self:RefreshPowerSortBtn()
  self:RefreshEvaluationAndPower()
  if self.copyCard ~= nil then
    (self.copyCard):Hide()
  end
  ;
  ((self.fmtCtrl).fmtSceneCtrl):RegisterPullFormationDragAct(self.__OnCheckModelDrag, self.__OnPullFormationDeal)
  -- DECOMPILER ERROR: 13 unprocessed JMP targets
end

UINFormationChoice.SetFmtEditorGuideData = function(self, heroId, posId)
  -- function num : 0_3
  self.__guideData = {heroId = heroId, posId = posId, compelete = false}
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).rect_cardList).raycastTarget = false
  ;
  ((self.ui).cardList):StopMovement()
  ;
  ((self.fmtCtrl).fmtSceneCtrl):GuideDisableClickPlat(true)
end

UINFormationChoice.IsFmtEditorGuideComplete = function(self)
  -- function num : 0_4
  if self.__guideData == nil then
    return true
  end
  return (self.__guideData).compelete
end

UINFormationChoice.ClearFmtEditorGuideData = function(self)
  -- function num : 0_5
  self.__guideData = nil
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).rect_cardList).raycastTarget = true
  ;
  ((self.fmtCtrl).fmtSceneCtrl):GuideDisableClickPlat(false)
end

UINFormationChoice.RefreshHeroList = function(self, isKeepFixedly)
  -- function num : 0_6 , upvalues : _ENV
  self.showHeroList = {}
  for i,v in pairs(self.heroDataDic) do
    if self.selectCareer == 0 or v.career == self.selectCareer then
      (table.insert)(self.showHeroList, v)
    end
  end
  ;
  (table.sort)(self.showHeroList, function(a, b)
    -- function num : 0_6_0 , upvalues : self
    if (self.fmtCtrl).fmtDailyDungeonDyncData ~= nil then
      local hpPerA = ((self.fmtCtrl).fmtDailyDungeonDyncData):GetDungeonDyncHeroHpPer(a)
      local hpPerB = ((self.fmtCtrl).fmtDailyDungeonDyncData):GetDungeonDyncHeroHpPer(b)
      local deadA = hpPerA == 0
      local deadB = hpPerB == 0
      if deadA ~= deadB then
        return deadB
      end
    end
    if b:GetFightingPower() >= a:GetFightingPower() then
      do return not self.isDesOrder end
      do return a:GetFightingPower() < b:GetFightingPower() end
      -- DECOMPILER ERROR: 7 unprocessed JMP targets
    end
  end
)
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).cardList).totalCount = #self.showHeroList
  if isKeepFixedly then
    ((self.ui).cardList):RefreshCells()
  else
    ;
    ((self.ui).cardList):RefillCells()
  end
  ;
  ((self.ui).obj_noCard):SetActive(((self.ui).cardList).totalCount == 0)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINFormationChoice.OnInstantiateItem = function(self, go)
  -- function num : 0_7 , upvalues : UINFormationChoiceItem
  local item = (UINFormationChoiceItem.New)()
  item:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.heroItemDic)[go] = item
end

UINFormationChoice.OnHeroChangeItem = function(self, go, index)
  -- function num : 0_8
  local heroData = (self.showHeroList)[index + 1]
  local item = (self.heroItemDic)[go]
  item:InitChoiceItem(heroData, (self.fmtCtrl).resloader, self.__OnBeginDragHero, self.__OnDragHero, self.__OnEndDragHero, self.__OnClickHero)
  if heroData.dataId ~= ((self.copyCard).heroData).dataId then
    item:SetSelectedState(self.selectedCard ~= item or not (self.copyCard).active or (self.copyCard).heroData == nil)
    do
      if (self.fmtCtrl).fmtDailyDungeonDyncData ~= nil then
        local hpPer = ((self.fmtCtrl).fmtDailyDungeonDyncData):GetDungeonDyncHeroHpPer(heroData)
        item:UpdFmtHeroChoiceItemHp(hpPer)
      end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
end

UINFormationChoice.__CalculateUIPosAndCanSeekPlatform = function(self, touchPos)
  -- function num : 0_9 , upvalues : _ENV
  local uiPos = UIManager:Screen2UIPosition(touchPos, ((self.transform).gameObject):GetComponent(typeof((CS.UnityEngine).RectTransform)), UIManager.UICamera)
  if self._autoPutPosY == nil then
    local rectTrWordPos = (((self.ui).rectTr_Touch2Recycle).transform):TransformPoint(Vector3.zero)
    local rectTrlocalPos = (self.transform):InverseTransformPoint(rectTrWordPos)
    self._autoPutPosY = rectTrlocalPos.y + (((self.ui).rectTr_Touch2Recycle).rect).height / 2
  end
  do
    do return uiPos, self._autoPutPosY < uiPos.y end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
end

UINFormationChoice.__GetFmtHeroItemByIndex = function(self, index)
  -- function num : 0_10 , upvalues : _ENV
  local go = ((self.ui).cardList):GetCellByIndex(index)
  if not IsNull(go) then
    return (self.heroItemDic)[go]
  end
  return nil
end

UINFormationChoice.OnClickResetFomration = function(self)
  -- function num : 0_11 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(win)
    -- function num : 0_11_0 , upvalues : _ENV, self
    if win ~= nil then
      win:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(389), function()
      -- function num : 0_11_0_0 , upvalues : self, _ENV
      local curFormationData = ((self.fmtCtrl).fmtSceneCtrl).formationData
      for _,heroId in pairs(curFormationData:GetFormationHeroList(true)) do
        -- DECOMPILER ERROR at PC16: Confused about usage of register: R6 in 'UnsetPending'

        (self.heroDataDic)[heroId] = ((((self.fmtCtrl).fmtSceneCtrl).heroEntityIdDic)[heroId]):GetFmtHeroEntityData()
      end
      curFormationData.data = {}
      self:RefreshHeroList()
      ;
      ((self.fmtCtrl).fmtSceneCtrl):ClearFmtInEditorModel()
      self:RefreshEvaluationAndPower()
      ;
      (self.supportHero):SetFmtChoiceSupportItemInFmt(false)
    end
, nil)
    end
  end
)
end

UINFormationChoice.OnClickPowerSort = function(self)
  -- function num : 0_12 , upvalues : _ENV
  self.isDesOrder = not self.isDesOrder
  self:RefreshHeroList()
  self:RefreshPowerSortBtn()
  AudioManager:PlayAudioById(4100)
end

UINFormationChoice.RefreshPowerSortBtn = function(self)
  -- function num : 0_13
  local color = ((self.ui).img_ArrowUp).color
  color.a = self.isDesOrder and 0.5 or 1
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_ArrowUp).color = color
  color = ((self.ui).img_ArrowDown).color
  color.a = self.isDesOrder and 1 or 0.5
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_ArrowDown).color = color
end

UINFormationChoice.OnClickCareerFiltrate = function(self, careerId, item)
  -- function num : 0_14 , upvalues : _ENV
  self.selectCareer = careerId
  self:RefreshHeroList()
  ;
  ((self.ui).tr_CurSel):SetParent(item.transform)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tr_CurSel).localPosition = Vector3.zero
end

UINFormationChoice.RefreshEvaluationAndPower = function(self)
  -- function num : 0_15 , upvalues : UINFmtEvaluation, _ENV
  if self.fmtEvaluation == nil then
    self.fmtEvaluation = (UINFmtEvaluation.New)()
    ;
    (self.fmtEvaluation):Init((self.ui).evaluation)
    ;
    (self.fmtEvaluation):InitializeAdvantageConfig((self.uiFormation).sectorStageId, (self.fmtCtrl).fromModule)
    for _,careerItem in ipairs((self.careerPool).listItem) do
      careerItem:SetEvaluation(((self.fmtEvaluation).advTypeDic)[careerItem.advTypeId] == true)
    end
  end
  local formationData = ((self.fmtCtrl).fmtSceneCtrl).formationData
  if formationData ~= nil then
    (self.fmtEvaluation):AnalysisFormation(formationData:GetFormationHeroList())
    local ftpower, benchPower = (self.fmtCtrl):CalculatePower(formationData)
    local power = ftpower + benchPower
    -- DECOMPILER ERROR at PC55: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).tex_CurPower).text = tostring(power)
    ;
    (self.uiFormation):RefreshFmtPower(ftpower, benchPower)
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UINFormationChoice.OnBeginDragHero = function(self, eventData, item)
  -- function num : 0_16
  self.dragPos = eventData.position
  self.checkDragCount = 3
  self._isPlayDragAudio = false
end

UINFormationChoice.OnDragHero = function(self, eventData, item)
  -- function num : 0_17 , upvalues : _ENV, cs_MessageCommon, UINFormationChoiceItem
  if self.checkDragCount >= 0 then
    self.checkDragCount = self.checkDragCount - 1
    if self.checkDragCount == 0 then
      local xDiff = (math.abs)((eventData.position).x - (self.dragPos).x)
      local yDiff = (math.abs)((eventData.position).y - (self.dragPos).y)
      if yDiff * 3 < xDiff then
        if self.__guideData ~= nil then
          return 
        end
        ;
        ((self.ui).cardList):ChangePointDrag(eventData)
      else
        if self.__guideData ~= nil and (item.heroData).dataId ~= (self.__guideData).heroId then
          return 
        end
        if (self.fmtCtrl).fmtDailyDungeonDyncData ~= nil and ((self.fmtCtrl).fmtDailyDungeonDyncData):GetDungeonDyncHeroHpPer(item.heroData) == 0 then
          (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(2903))
          item:SetSelectedState(true)
          self._banDrag = true
          return 
        end
        self.__dragingHero = true
        ;
        (self.uiFormation):ShowChangeMark(true)
        if self.copyCard == nil then
          self.copyCard = (UINFormationChoiceItem.New)()
          local go = ((self.ui).heroCardHolder):Instantiate(self.transform)
          ;
          (self.copyCard):Init(go)
        end
        do
          ;
          (self.copyCard):Show()
          ;
          (self.copyCard):InitChoiceItem(item.heroData, (self.fmtCtrl).resloader)
          item:SetSelectedState(true)
          local uiPos, isCanSeek = self:__CalculateUIPosAndCanSeekPlatform(eventData.position)
          -- DECOMPILER ERROR at PC113: Confused about usage of register: R7 in 'UnsetPending'

          ;
          ((self.copyCard).transform).localPosition = (Vector3.New)(uiPos.x, uiPos.y, 0)
          -- DECOMPILER ERROR at PC122: Confused about usage of register: R7 in 'UnsetPending'

          ;
          ((self.copyCard).transform).localScale = (Vector3.New)(0.8, 0.8, 0.8)
          do
            do
              if (self.fmtCtrl).fmtDailyDungeonDyncData ~= nil then
                local hpPer = ((self.fmtCtrl).fmtDailyDungeonDyncData):GetDungeonDyncHeroHpPer(item.heroData)
                ;
                (self.copyCard):UpdFmtHeroChoiceItemHp(hpPer)
              end
              self.selectedCard = item
              if not self._isPlayDragAudio then
                AudioManager:PlayAudioById(1059)
                self._isPlayDragAudio = true
              end
              do return  end
              if not self.__dragingHero then
                return 
              end
              local uiPos, isCanSeek = self:__CalculateUIPosAndCanSeekPlatform(eventData.position)
              -- DECOMPILER ERROR at PC161: Confused about usage of register: R5 in 'UnsetPending'

              ;
              ((self.copyCard).transform).localPosition = (Vector3.New)(uiPos.x, uiPos.y, 0)
              if isCanSeek then
                ((self.fmtCtrl).fmtSceneCtrl):SeekHeroPutPlatform()
              else
                ;
                ((self.fmtCtrl).fmtSceneCtrl):RecoverHeroPutPlatform()
              end
            end
          end
        end
      end
    end
  end
end

UINFormationChoice.OnEndDragHero = function(self, eventData, item)
  -- function num : 0_18 , upvalues : _ENV
  if self._banDrag then
    item:SetSelectedState(false)
    self._banDrag = false
    return 
  end
  if not self.__dragingHero then
    return 
  end
  self.__dragingHero = false
  item:SetSelectedState(false)
  self.selectedCard = nil
  ;
  (self.uiFormation):ShowChangeMark(false)
  if self.copyCard == nil then
    error("copyCard is NIL")
    return 
  end
  ;
  (self.copyCard):Hide()
  local uiPos, isCanSeek = self:__CalculateUIPosAndCanSeekPlatform(eventData.position)
  if not isCanSeek then
    return 
  end
  do
    if self.__guideData ~= nil then
      local lastHeroPlat = ((self.fmtCtrl).fmtSceneCtrl):GetFmtLastSeekHeroPlat()
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R6 in 'UnsetPending'

      if lastHeroPlat ~= nil and lastHeroPlat.fmtIndex == (self.__guideData).posId then
        (self.__guideData).compelete = true
      else
        ;
        ((self.fmtCtrl).fmtSceneCtrl):RecoverHeroPutPlatform()
      end
    end
    local flag, beReplaceHeroData = ((self.fmtCtrl).fmtSceneCtrl):ConfirmHeroPutPlatform((self.copyCard).heroData)
    if flag then
      if (item.heroData).isFriendSupport then
        item:SetFmtChoiceSupportItemInFmt(true)
      else
        -- DECOMPILER ERROR at PC78: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (self.heroDataDic)[((self.copyCard).heroData).dataId] = nil
      end
      -- DECOMPILER ERROR at PC86: Confused about usage of register: R7 in 'UnsetPending'

      if beReplaceHeroData ~= nil then
        if not beReplaceHeroData.isFriendSupport then
          (self.heroDataDic)[beReplaceHeroData.dataId] = beReplaceHeroData
        else
          ;
          (self.supportHero):SetFmtChoiceSupportItemInFmt(false)
        end
      end
      self:RefreshHeroList(true)
      self:RefreshEvaluationAndPower()
      local voiceId = ConfigData:GetVoicePointRandom(3)
      local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
      cvCtr:PlayCv(((self.copyCard).heroData).dataId, voiceId)
    end
  end
end

UINFormationChoice.OnClickHero = function(self, heroData)
  -- function num : 0_19 , upvalues : _ENV
  if self.__guideData ~= nil then
    return 
  end
  if self.copyCard ~= nil and (self.copyCard).active then
    return 
  end
  if heroData.isFriendSupport then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroState, function(win)
    -- function num : 0_19_0 , upvalues : heroData, self
    if win ~= nil then
      win:InitHeroState(heroData, self.showHeroList)
    end
  end
)
end

UINFormationChoice.OnCheckModelDrag = function(self, touchPos)
  -- function num : 0_20
  local uiPos, isCanSeek = self:__CalculateUIPosAndCanSeekPlatform(touchPos)
  ;
  (((self.ui).rectTr_Touch2Recycle).gameObject):SetActive(true)
  ;
  ((self.ui).obj_noCard):SetActive(false)
  if isCanSeek and (((self.ui).doTween_RecycleImage).tween):IsPlaying() then
    ((self.ui).doTween_RecycleImage):DOPause()
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).canvasGroup_RecycleImage).alpha = 1
  end
  if not (((self.ui).doTween_RecycleImage).tween):IsPlaying() then
    ((self.ui).doTween_RecycleImage):DORestart()
  end
  return not isCanSeek
end

UINFormationChoice.OnPullFormationDeal = function(self, heroData)
  -- function num : 0_21
  ((self.ui).doTween_RecycleImage):DOPause()
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).canvasGroup_RecycleImage).alpha = 1
  ;
  (((self.ui).rectTr_Touch2Recycle).gameObject):SetActive(false)
  if ((self.ui).cardList).totalCount ~= 0 then
    ((self.ui).obj_noCard):SetActive(heroData ~= nil)
    do return  end
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

    if not heroData.isFriendSupport then
      (self.heroDataDic)[heroData.dataId] = heroData
    else
      (self.supportHero):SetFmtChoiceSupportItemInFmt(false)
    end
    self:RefreshHeroList(true)
    self:RefreshEvaluationAndPower()
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end

UINFormationChoice.OnClickSelectSupportHero = function(self)
  -- function num : 0_22 , upvalues : cs_MessageCommon, _ENV
  if self.__guideData ~= nil then
    return 
  end
  if (self.fmtCtrl).fmtDailyDungeonDyncData ~= nil and ((self.fmtCtrl).fmtDailyDungeonDyncData):HasDgDyncLastAstHero() then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(2904))
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.SelectSupportList, function(win)
    -- function num : 0_22_0 , upvalues : self
    if win ~= nil then
      local fomationData = ((self.fmtCtrl).fmtSceneCtrl).formationData
      do
        win:InitSelectSupportHeroList(function(friednSupportHeroData)
      -- function num : 0_22_0_0 , upvalues : fomationData, self
      local supportHeroData = fomationData:GetRealSupportHeroData()
      if supportHeroData ~= nil and friednSupportHeroData ~= supportHeroData then
        fomationData:CleanSupportData()
        ;
        ((self.fmtCtrl).fmtSceneCtrl):RefreshFmtScene()
      end
      if friednSupportHeroData ~= nil then
        (self.supportHero):InitChoiceItem(friednSupportHeroData, (self.fmtCtrl).resloader, self.__OnBeginDragHero, self.__OnDragHero, self.__OnEndDragHero, self.__OnClickSelectSupportHero)
        do
          if (self.fmtCtrl).fmtDailyDungeonDyncData ~= nil then
            local hpPer = 10000
            ;
            (self.supportHero):UpdFmtHeroChoiceItemHp(hpPer)
          end
          ;
          (self.fmtCtrl):CacheSelectedSupportHero(friednSupportHeroData)
        end
      end
    end
, self.selectCareer, fomationData)
      end
    end
  end
)
end

UINFormationChoice.ClearSupportCard = function(self)
  -- function num : 0_23
  (self.supportHero):InitAsEmpuyCard(self.__OnClickSelectSupportHero)
end

UINFormationChoice.OnClickQuick = function(self, tohome)
  -- function num : 0_24 , upvalues : _ENV
  self:TryModifyFormation()
  if self.fmtCtrl ~= nil then
    (self.fmtCtrl):ExitEditMode()
    ;
    ((self.fmtCtrl).fmtSceneCtrl):RemovePullFormationDragAct()
  end
  if not tohome then
    GuideManager:TryTriggerGuide(eGuideCondition.InFormation)
    GuideManager:TryTriggerGuide(eGuideCondition.InFormationSpecial)
  end
end

UINFormationChoice.TryModifyFormation = function(self)
  -- function num : 0_25 , upvalues : _ENV
  local defaultFormationData = ((self.fmtCtrl).curFormation).data
  local curFormationData = {}
  for k,v in pairs((((self.fmtCtrl).fmtSceneCtrl).formationData):GetFormationHeroList()) do
    curFormationData[k] = v
  end
  if not (self.fmtCtrl):CheckFormationHero(curFormationData) then
    return 
  end
  local isChange = false
  if (table.count)(defaultFormationData) ~= (table.count)(curFormationData) then
    isChange = true
  else
    if ((self.fmtCtrl).curFormation).isHaveSupport ~= (((self.fmtCtrl).fmtSceneCtrl).formationData).isHaveSupport then
      isChange = true
    else
      for k,heroId in pairs(defaultFormationData) do
        if curFormationData[k] == nil or curFormationData[k] ~= heroId then
          isChange = true
          break
        end
      end
    end
  end
  do
    if isChange then
      (self.fmtCtrl):ModifyFormation(((self.fmtCtrl).fmtSceneCtrl).formationData)
    end
  end
end

UINFormationChoice.OnClickChioceClose = function(self)
  -- function num : 0_26 , upvalues : _ENV
  (UIUtil.OnClickBack)()
end

UINFormationChoice.OnShowChoiceItemRedTip = function(self)
  -- function num : 0_27 , upvalues : _ENV
  for k,v in pairs(self.heroItemDic) do
    v:OnShowChoiceRedTip()
  end
end

UINFormationChoice.OnShowChoiceItemNorTip = function(self)
  -- function num : 0_28 , upvalues : _ENV
  for k,v in pairs(self.heroItemDic) do
    v:OnShowChoiceNorTip()
  end
end

UINFormationChoice.OnShowChoiceItemInfo = function(self, heroUpdateDic)
  -- function num : 0_29 , upvalues : _ENV
  for k,v in pairs(self.heroItemDic) do
    if heroUpdateDic[((v.heroCardItem).heroData).dataId] ~= nil then
      (v.heroCardItem):RefreshHeroCardItem()
    end
  end
end

UINFormationChoice.OnChoiceItemSkinChange = function(self, heroId)
  -- function num : 0_30 , upvalues : _ENV
  for k,v in pairs(self.heroItemDic) do
    if ((v.heroCardItem).heroData).dataId == heroId then
      (v.heroCardItem):UpdateSkin()
      break
    end
  end
end

UINFormationChoice.OnDelete = function(self)
  -- function num : 0_31 , upvalues : _ENV, base
  RedDotController:RemoveListener(RedDotDynPath.HeroCardStartUpPath, self.__OnShowChoiceItemRedTip)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnShowChoiceItemNorTip)
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__OnShowChoiceItemInfo)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroSkinChange, self.__OnChoiceItemSkinChange)
  for k,v in pairs(self.heroItemDic) do
    v:Delete()
  end
  ;
  (self.careerPool):DeleteAll()
  ;
  (self.supportHero):Delete()
  ;
  (base.OnDelete)(self)
end

return UINFormationChoice


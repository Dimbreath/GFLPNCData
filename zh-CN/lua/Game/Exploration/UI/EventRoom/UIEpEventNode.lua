local UIEpEventNode = class("UIEpEventNode", UIBaseNode)
local UIChoiceItem = require("Game.Exploration.UI.EventRoom.UIEpEventChoiceItem")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local GoodsItem = require("Game.Exploration.UI.EventRoom.UIEpChoiceGoodsItem")
local UINEpEventSlotMachineItem = require("Game.Exploration.UI.EventRoom.UINEpEventSlotMachineItem")
local CS_DOTween = ((CS.DG).Tweening).DOTween
local cs_Edge = ((CS.UnityEngine).RectTransform).Edge
local base = UIBaseNode
UIEpEventNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIChoiceItem, UINEpEventSlotMachineItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).obj_choiceItem):SetActive(false)
  ;
  ((self.ui).rankdomItem):SetActive(false)
  ;
  ((self.ui).obj_SelectRankdomNode):SetActive(false)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_EventText).text = ""
  self.choiceItemPool = (UIItemPool.New)(UIChoiceItem, (self.ui).obj_choiceItem)
  self.slotMachinePool = (UIItemPool.New)(UINEpEventSlotMachineItem, (self.ui).rankdomItem)
  self._onSlotMachinePressUp = BindCallback(self, self._OnSlotMachinePressUp)
  self._onSlotMachinePressDown = BindCallback(self, self._OnSlotMachinePressDown)
end

UIEpEventNode.InitEpEventNode = function(self, eRoomData, onChoiceClick, onMaskActiveFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.onChoiceClick = onChoiceClick
  self.onMaskActiveFunc = onMaskActiveFunc
  self.eRoomData = eRoomData
  local eventCfg = (ConfigData.event)[eRoomData.eventId]
  if eventCfg == nil then
    error("eRoomCfg null,id:" .. tostring(eRoomData.eventId))
    return 
  end
  self:__ShowEventText(eventCfg)
  self:__UpdateRoomUI(eRoomData.eRoomType)
  if eventCfg.gamble_tag then
    ((self.ui).rankdomNode):SetActive(true)
    self:__CreatEventSlotMachine(eRoomData.choiceDatalist)
  else
    ;
    ((self.ui).rankdomNode):SetActive(false)
    self:__CreatEventChoiceItem(eRoomData.choiceDatalist)
  end
end

UIEpEventNode.__ShowEventText = function(self, eRoomCfg)
  -- function num : 0_2 , upvalues : _ENV, CS_DOTween
  local eventText = (LanguageUtil.GetLocaleText)(eRoomCfg.event_txt)
  if self.tween ~= nil then
    (self.tween):Kill(true)
  end
  self.tween = ((CS_DOTween.To)(function()
    -- function num : 0_2_0 , upvalues : self
    return ((self.ui).tex_EventText).text
  end
, function(x)
    -- function num : 0_2_1 , upvalues : self
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

    ((self.ui).tex_EventText).text = x
  end
, eventText, (self.ui).ani_duration)):SetEase((((CS.DG).Tweening).Ease).Linear)
end

UIEpEventNode.__UpdateRoomUI = function(self, eRoomType)
  -- function num : 0_3 , upvalues : _ENV, ExplorationEnum
  local roomTypeCfg = (ConfigData.exploration_roomtype)[eRoomType]
  if roomTypeCfg == nil then
    error("exploration room type is null,id:" .. tostring(eRoomType))
    return 
  end
  local colorCfg = roomTypeCfg.color
  local color = (Color.New)(colorCfg[1], colorCfg[2], colorCfg[3])
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_TypeColor).color = color
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_RoomIcon).color = color
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_RoomIcon).sprite = CRH:GetSprite(roomTypeCfg.icon, CommonAtlasType.ExplorationIcon)
  if eRoomType == (ExplorationEnum.eRoomType).recovery then
    ((self.ui).tex_RoomType):SetIndex(1)
  else
    if eRoomType == (ExplorationEnum.eRoomType).eventroom then
      ((self.ui).tex_RoomType):SetIndex(0)
    end
  end
end

UIEpEventNode.__CreatEventChoiceItem = function(self, chioceDataList)
  -- function num : 0_4 , upvalues : _ENV
  (self.choiceItemPool):HideAll()
  if self.choiceExtraItemPool ~= nil then
    (self.choiceExtraItemPool):HideAll()
  end
  self.choiceItemDic = {}
  for index,choiceData in ipairs(chioceDataList) do
    local choiceItem = (self.choiceItemPool):GetOne()
    choiceItem:InitEventChoiceItem(choiceData, self.onChoiceClick)
    if choiceItem.cfg ~= nil then
      local displayGetNewData = self:__analysisChoiceGetNew(choiceItem.cfg)
      do
        do
          do
            if displayGetNewData ~= nil then
              local extraItemPool = self:__getChoiceExtraItemPool()
              choiceItem:InjectExtraItemPool(extraItemPool)
            end
            choiceItem:RefreshChoiceUI(displayGetNewData)
            -- DECOMPILER ERROR at PC42: Confused about usage of register: R8 in 'UnsetPending'

            ;
            (choiceItem.gameObject).name = tostring(index)
            -- DECOMPILER ERROR at PC44: Confused about usage of register: R8 in 'UnsetPending'

            ;
            (self.choiceItemDic)[index] = choiceItem
            -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

UIEpEventNode.__CreatEventSlotMachine = function(self, choiceDatalist)
  -- function num : 0_5 , upvalues : _ENV
  if self.__ChoiceFinihsEftEvent == nil then
    self.__ChoiceFinihsEftEvent = BindCallback(self, self.__ChoiceFinihsEft)
  end
  ;
  ((ExplorationManager.epCtrl).eventCtrl):RegistEventSelectSuccessFunc(self.__ChoiceFinihsEftEvent)
  ;
  (self.slotMachinePool):HideAll()
  ;
  (self.choiceItemPool):HideAll()
  self.choiceItemDic = {}
  for index,choiceData in ipairs(choiceDatalist) do
    local eventChoiceCfg = (ConfigData.event_choice)[choiceData.choiceId]
    if eventChoiceCfg ~= nil and eventChoiceCfg.gamblebenefit_tag > 0 then
      local slotItem = (self.slotMachinePool):GetOne(true)
      slotItem:InitSlotMachineItem(choiceData, self._onSlotMachinePressUp, self._onSlotMachinePressDown)
    else
      do
        local choiceItem = (self.choiceItemPool):GetOne(true)
        choiceItem:InitEventChoiceItem(choiceData, self.onChoiceClick, true)
        if choiceItem.cfg ~= nil then
          local displayGetNewData = self:__analysisChoiceGetNew(choiceItem.cfg)
          do
            do
              do
                if displayGetNewData ~= nil then
                  local extraItemPool = self:__getChoiceExtraItemPool()
                  choiceItem:InjectExtraItemPool(extraItemPool)
                end
                choiceItem:RefreshChoiceUI(displayGetNewData)
                -- DECOMPILER ERROR at PC74: Confused about usage of register: R9 in 'UnsetPending'

                ;
                (choiceItem.gameObject).name = tostring(index)
                -- DECOMPILER ERROR at PC76: Confused about usage of register: R9 in 'UnsetPending'

                ;
                (self.choiceItemDic)[index] = choiceItem
                -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      end
    end
  end
end

UIEpEventNode.__getChoiceExtraItemPool = function(self)
  -- function num : 0_6 , upvalues : _ENV, GoodsItem
  if self.choiceExtraItemPool == nil then
    self.choiceExtraItemPool = (UIItemPool.New)(GoodsItem, (self.ui).goodsNode)
  end
  return self.choiceExtraItemPool
end

UIEpEventNode.__analysisChoiceGetNew = function(self, choiceCfg)
  -- function num : 0_7 , upvalues : _ENV
  local displayNewData = nil
  local getItems = choiceCfg.choiceGetNew
  if getItems ~= nil and #getItems > 0 then
    for _,v in ipairs(getItems) do
      -- DECOMPILER ERROR at PC27: Unhandled construct in 'MakeBoolean' P1

      if v.dataType == eEpEvtChoiceGetNewType.item and ConfigData:GetItemType(v.dataId) == ConfigData:GetItemType(v.dataId) then
        displayNewData = {}
        displayNewData.type = v.dataType
        displayNewData.dataId = v.dataId
        displayNewData.dataNum = v.dataNum
        return displayNewData
      end
      if v.dataType == eEpEvtChoiceGetNewType.expBuff then
        local buffCfg = (ConfigData.exploration_buff)[v.dataId]
        if buffCfg == nil then
          error("找不到对应的探索buff配置,id:" .. v.dataId)
        end
        if buffCfg.is_onboard then
          displayNewData = {}
          displayNewData.type = v.dataType
          displayNewData.dataId = v.dataId
          return displayNewData
        end
      end
    end
  end
  do
    return displayNewData
  end
end

UIEpEventNode.__ChoiceFinihsEft = function(self, selectIndex, completeFunc)
  -- function num : 0_8 , upvalues : _ENV, CS_DOTween
  ((ExplorationManager.epCtrl).eventCtrl):CancleEventSelectSuccessFunc(self.__ChoiceFinihsEftEvent)
  local choiceItem = (self.choiceItemDic)[selectIndex + 1]
  if choiceItem == nil then
    completeFunc()
    return 
  end
  local eventChoiceCfg = (ConfigData.event_choice)[choiceItem.choiceId]
  if (choiceItem.cfg).gamble_group or choiceItem.cfg == nil or 0 == 0 then
    completeFunc()
    return 
  end
  local eftStopItem = nil
  for _,slotItem in ipairs((self.slotMachinePool).listItem) do
    do
      if slotItem.cfg ~= nil and (slotItem.cfg).group == (choiceItem.cfg).gamble_group then
        do
          eftStopItem = slotItem
          do break end
          -- DECOMPILER ERROR at PC48: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC48: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  if eftStopItem == nil then
    completeFunc()
    return 
  end
  if self.finishTween ~= nil then
    (self.finishTween):Kill()
    self.finishTween = nil
  end
  local finishTween = (CS_DOTween.Sequence)()
  ;
  ((self.ui).obj_SelectRankdomNode):SetActive(true)
  if self.onMaskActiveFunc then
    (self.onMaskActiveFunc)(true)
  end
  do
    for i = 1, (self.ui).rankdomTotalCycle do
      for _,slotItem in ipairs((self.slotMachinePool).listItem) do
        finishTween:AppendCallback(function()
    -- function num : 0_8_0 , upvalues : self, slotItem
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

    (((self.ui).obj_SelectRankdomNode).transform).position = (slotItem.transform).position
  end
)
        finishTween:AppendInterval((self.ui).rankdomIntervialTime)
      end
    end
  end
  for _,slotItem in ipairs((self.slotMachinePool).listItem) do
    finishTween:AppendCallback(function()
    -- function num : 0_8_1 , upvalues : self, slotItem
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

    (((self.ui).obj_SelectRankdomNode).transform).position = (slotItem.transform).position
  end
)
    if slotItem ~= eftStopItem then
      do
        finishTween:AppendInterval((self.ui).rankdomIntervialTime)
        -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  finishTween:AppendInterval((self.ui).rankdomStayTime)
  finishTween:AppendCallback(function()
    -- function num : 0_8_2 , upvalues : self, completeFunc
    if self.finishTween ~= nil then
      (self.finishTween):Kill()
      self.finishTween = nil
    end
    ;
    ((self.ui).obj_SelectRankdomNode):SetActive(false)
    if self.onMaskActiveFunc then
      (self.onMaskActiveFunc)(false)
    end
    completeFunc()
  end
)
end

UIEpEventNode.SetNodeActive = function(self, active)
  -- function num : 0_9
  ((self.transform).gameObject):SetActive(active)
end

UIEpEventNode._OnSlotMachinePressUp = function(self)
  -- function num : 0_10 , upvalues : _ENV
  UIManager:HideWindow(UIWindowTypeID.RichIntro)
end

UIEpEventNode._OnSlotMachinePressDown = function(self, name, desc)
  -- function num : 0_11 , upvalues : _ENV, cs_Edge
  UIManager:ShowWindowAsync(UIWindowTypeID.RichIntro, function(win)
    -- function num : 0_11_0 , upvalues : self, name, desc, cs_Edge
    if win ~= nil then
      win:ShowIntroCustom((self.ui).rect_introHolder, name, desc, true)
      win:SetIntroListPosition(cs_Edge.Right, cs_Edge.Top)
    end
  end
)
end

UIEpEventNode.OnDelete = function(self)
  -- function num : 0_12 , upvalues : _ENV, base
  if ExplorationManager.epCtrl ~= nil and (ExplorationManager.epCtrl).eventCtrl ~= nil then
    ((ExplorationManager.epCtrl).eventCtrl):CancleEventSelectSuccessFunc(self.__ChoiceFinihsEftEvent)
  end
  if self.choiceItemDic ~= nil then
    for id,choiceItem in pairs(self.choiceItemDic) do
      choiceItem:OnDelete()
    end
    self.choiceItemDic = nil
  end
  if self.tween ~= nil then
    (self.tween):Kill()
    self.tween = nil
  end
  if self.finishTween ~= nil then
    (self.finishTween):Kill()
    self.finishTween = nil
  end
  UIManager:HideWindow(UIWindowTypeID.RichIntro)
  ;
  (base.OnDelete)(self)
end

return UIEpEventNode


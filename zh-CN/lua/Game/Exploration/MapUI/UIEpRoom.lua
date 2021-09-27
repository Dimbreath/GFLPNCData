local UIEpRoom = class("UIEpRoom", UIBaseNode)
local base = UIBaseNode
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local CS_Tweening = (CS.DG).Tweening
local CS_CameraController = CS.CameraController
local fadeTweenDuration = 0.5
UIEpRoom.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_EpRoom, self, self.OnRoomClicked)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_power).text = ""
  ;
  (((self.ui).img_Danger).gameObject):SetActive(false)
end

UIEpRoom.GetRoomSize = function(self)
  -- function num : 0_1
  return (self.transform).sizeDelta
end

UIEpRoom.InitRoomUI = function(self, roomData)
  -- function num : 0_2 , upvalues : _ENV
  self.roomData = roomData
  self.roomType = roomData:GetRoomType()
  local roomTypeCfg = (ConfigData.exploration_roomtype)[self.roomType]
  if roomTypeCfg == nil then
    error("exploration room type is null,id:" .. tostring(self.roomType))
    return 
  end
  self.roomTypeCfg = roomTypeCfg
  self:__SetRoomBaseInfo()
  self:__UpdateRoomUI()
  self:ResetRoomDefaultUI()
end

UIEpRoom.__SetRoomBaseInfo = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local iconSprite = CRH:GetSprite((self.roomTypeCfg).icon, CommonAtlasType.ExplorationIcon)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_RoomIcon).sprite = iconSprite
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_RoomIconSD).sprite = iconSprite
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Tile).text = (LanguageUtil.GetLocaleText)((self.roomTypeCfg).title)
  ;
  ((self.ui).crossNode):SetActive((self.roomData):IsCrossRoom())
end

UIEpRoom.__UpdateRoomUI = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local colorCfg = (self.roomTypeCfg).color
  local color = (Color.New)(colorCfg[1], colorCfg[2], colorCfg[3])
  self:SetRoomColor(color)
end

UIEpRoom.SetRoomColor = function(self, color)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).img_TileBG).color = color
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_RoomIcon).color = color
  color.a = (((self.ui).img_Anima).color).a
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_Anima).color = color
  color.a = (((self.ui).img_markBG).color).a
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_markBG).color = color
  for index,component in ipairs((self.ui).arr_CrossCols) do
    component.color = color
  end
end

UIEpRoom.ResetRoomDefaultUI = function(self)
  -- function num : 0_6
  self:SetSelectUIActive(false)
  self:SetRoomUIAlpha(1)
  self:SetBattleFightingActive(false)
  ;
  (((self.ui).normalNode).gameObject):SetActive(true)
  ;
  (((self.ui).completeNode).gameObject):SetActive(false)
  ;
  ((self.ui).stopNode):SetActive(false)
  ;
  ((self.ui).autoNode):SetActive(false)
end

UIEpRoom.OnRoomClicked = function(self)
  -- function num : 0_7 , upvalues : CS_CameraController, _ENV
  if (CS_CameraController.Instance):InDragEpMap() then
    return 
  end
  local playerCtrl = (ExplorationManager.epCtrl).playerCtrl
  if playerCtrl:CheckIsEpRoomWatchingMap(self.roomData) then
    return 
  end
  local autoCtrl = (ExplorationManager.epCtrl).autoCtrl
  if autoCtrl:CheckAutoModeRoomClick(self.roomData) then
    return 
  end
  if playerCtrl:CheckEpRoomAccess(self.roomData, self.isFreeSelect) then
    playerCtrl:Move(self.roomData)
  end
end

UIEpRoom.SetIsFreeSelect = function(self, bool)
  -- function num : 0_8
  self.isFreeSelect = bool
end

UIEpRoom.RefreshBattleFightingPower = function(self, fightingPower, playerPower)
  -- function num : 0_9 , upvalues : _ENV
  if IsNull(self.gameObject) then
    return 
  end
  ;
  ((self.ui).powerNode):SetActive(true)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_power).text = tostring(fightingPower)
  self:__ShowRoomChipPreview()
  ;
  (((self.ui).img_Danger).gameObject):SetActive(playerPower < fightingPower)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIEpRoom.__ShowRoomChipPreview = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local chipPreviewIndex = (self.roomData):GetRoomChipPreview()
  if chipPreviewIndex == 0 then
    ((self.ui).markNode):SetActive(false)
    self:ClearChipDropTween()
    return 
  end
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  if chipPreviewIndex <= 0 then
    ((self.ui).tex_MarkName).text = ""
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_mark).sprite = nil
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_markSD).sprite = nil
    return 
  end
  local chipMarkCfg = (ConfigData.chip_mark)[chipPreviewIndex]
  if chipMarkCfg == nil then
    error("chip mark cfg is null,id:" .. tostring(chipPreviewIndex))
    return 
  end
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_MarkName).text = (LanguageUtil.GetLocaleText)(chipMarkCfg.name)
  local sprite = CRH:GetSprite(chipMarkCfg.icon, CommonAtlasType.ExplorationIcon)
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_mark).sprite = sprite
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_markSD).sprite = sprite
end

UIEpRoom.SetBattleFightingActive = function(self, active)
  -- function num : 0_11 , upvalues : CS_Tweening
  local chipPreviewIndex = (self.roomData):GetRoomChipPreview()
  ;
  ((self.ui).markNode):SetActive(not active or chipPreviewIndex > 0)
  ;
  ((self.ui).powerNode):SetActive(active)
  if active then
    local color = ((self.ui).img_Danger).color
    color.a = 1
    self.__dangerTween = ((((self.ui).img_Danger):DOFade(0, 0.6)):SetLoops(-1, (CS_Tweening.LoopType).Yoyo)):SetEase((CS_Tweening.Ease).Linear)
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).cg_markNode).alpha = 0
    self.__chipDropTween = ((CS_Tweening.DOTween).Sequence)()
    ;
    (self.__chipDropTween):Append(((self.ui).cg_markNode):DOFade(1, 0.05))
    ;
    (self.__chipDropTween):Append(((self.ui).cg_markNode):DOFade(0, 0.05))
    ;
    (self.__chipDropTween):Append(((self.ui).cg_markNode):DOFade(1, 0.05))
    ;
    (self.__chipDropTween):AppendCallback(function()
    -- function num : 0_11_0 , upvalues : self
    self.__chipDropTween = nil
  end
)
  else
    self:ClearBattleRoomTween()
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UIEpRoom.ClearBattleRoomTween = function(self)
  -- function num : 0_12
  if self.__dangerTween ~= nil then
    (self.__dangerTween):Kill()
    self.__dangerTween = nil
  end
  self:ClearChipDropTween()
end

UIEpRoom.ClearChipDropTween = function(self)
  -- function num : 0_13
  if self.__chipDropTween ~= nil then
    (self.__chipDropTween):Kill()
    self.__chipDropTween = nil
  end
end

UIEpRoom.ChangeUIState = function(self, eRoomState, withTween, isAutoPath)
  -- function num : 0_14 , upvalues : ExplorationEnum
  self:ResetRoomDefaultUI()
  if eRoomState == (ExplorationEnum.eRoomTypeState).Complete then
    if withTween then
      self:__ClearFadeTween()
      ;
      (((self.ui).normalNode).gameObject):SetActive(true)
      -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).normalNode).alpha = 1
      self.__normalNodeTween = ((self.ui).normalNode):DOFade(0, 0.5)
      ;
      (((self.ui).completeNode).gameObject):SetActive(true)
      -- DECOMPILER ERROR at PC34: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).completeNode).alpha = 0
      self.__completeNodeTween = ((self.ui).completeNode):DOFade(1, 0.5)
    else
      ;
      (((self.ui).normalNode).gameObject):SetActive(false)
      ;
      (((self.ui).completeNode).gameObject):SetActive(true)
    end
  else
  end
  if eRoomState ~= (ExplorationEnum.eRoomTypeState).CurrentStay or eRoomState == (ExplorationEnum.eRoomTypeState).AbleChoose then
    self:SetSelectUIActive(true)
    if (self.roomData):IsBattleRoom() then
      self:SetBattleFightingActive(true)
    end
  else
    if eRoomState == (ExplorationEnum.eRoomTypeState).UnReachable then
      self:SetRoomUIAlpha(ExplorationEnum.UnReachableAlpha)
      ;
      ((self.ui).stopNode):SetActive(true)
    end
  end
  if isAutoPath then
    ((self.ui).autoNode):SetActive(true)
  end
end

UIEpRoom.ForceChangeRoomState2AbleChoose = function(self)
  -- function num : 0_15
  self:ResetRoomDefaultUI()
  self:SetSelectUIActive(true)
  if (self.roomData):IsBattleRoom() then
    self:SetBattleFightingActive(true)
  end
end

UIEpRoom.SetRoomUIAlpha = function(self, alphaValue)
  -- function num : 0_16
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).EpRoomAlpha).alpha = alphaValue
end

UIEpRoom.SetSelectUIActive = function(self, active)
  -- function num : 0_17
  ((self.ui).img_OnSelect):SetActive(active)
end

UIEpRoom.SetCurrentStayActive = function(self, active)
  -- function num : 0_18
  ((self.ui).img_CurrRoom):SetActive(active)
end

UIEpRoom.__ClearFadeTween = function(self)
  -- function num : 0_19
  if self.__normalNodeTween ~= nil then
    (self.__normalNodeTween):Kill()
    self.__normalNodeTween = nil
  end
  if self.__completeNodeTween ~= nil then
    (self.__completeNodeTween):Kill()
    self.__completeNodeTween = nil
  end
end

UIEpRoom.OnDelete = function(self)
  -- function num : 0_20 , upvalues : base
  self:ClearBattleRoomTween()
  self:__ClearFadeTween()
  ;
  (base.OnDelete)(self)
end

return UIEpRoom


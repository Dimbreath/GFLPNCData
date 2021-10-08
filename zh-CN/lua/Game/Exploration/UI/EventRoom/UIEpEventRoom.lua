local UIEpEventRoom = class("UIEpEventRoom", UIBaseWindow)
local base = UIBaseWindow
local UIEpEventNode = require("Game.Exploration.UI.EventRoom.UIEpEventNode")
local UINEventRoomRandom = require("Game.Exploration.UI.EventRoom.UINEventRoomRandom")
UIEpEventRoom.OnInit = function(self)
  -- function num : 0_0 , upvalues : UIEpEventNode, UINEventRoomRandom, _ENV
  self.eventNode = (UIEpEventNode.New)()
  ;
  (self.eventNode):Init((self.ui).obj_EventNode)
  ;
  ((self.ui).obj_EventNode):SetActive(false)
  self.randomEventRoom = (UINEventRoomRandom.New)()
  ;
  (self.randomEventRoom):Init((self.ui).obj_RandomNode)
  ;
  ((self.ui).obj_RandomNode):SetActive(false)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Map, self, self.OnMapButtonClick)
  self.__OnChipDetailActiveChange = BindCallback(self, self.OnChipDetailActiveChange)
  MsgCenter:AddListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
  self.__FromMapBackToUI = BindCallback(self, self.FromMapBackToUI)
  MsgCenter:AddListener(eMsgEventId.OnShowingMapRoomClick, self.__FromMapBackToUI)
  self.__ActiveUIMask = BindCallback(self, self.ActiveUIMask)
  self:ActiveUIMask(false)
end

UIEpEventRoom.InitEpEventRoom = function(self, eventData, onChiceClickAction)
  -- function num : 0_1 , upvalues : _ENV
  (((self.ui).btn_Map).gameObject):SetActive(ExplorationManager:HasRoomSceneInEp())
  self:UpdEpEventRoom(eventData, onChiceClickAction)
  self.onMapClick = false
  self:SwitchMapBtnState(self.onMapClick)
  if GuideManager:TryTriggerGuide(eGuideCondition.InEpEventRoom) then
  end
end

UIEpEventRoom.UpdEpEventRoom = function(self, eventData, onChiceClickAction)
  -- function num : 0_2 , upvalues : _ENV
  if eventData.isHaveRandom then
    local dynPlayData = ExplorationManager:GetDynPlayer()
    ;
    (self.randomEventRoom):InitRandomEvent(eventData, dynPlayData, onChiceClickAction)
    ;
    ((self.randomEventRoom).gameObject):SetActive(true)
    ;
    ((self.eventNode).gameObject):SetActive(false)
  else
    do
      ;
      (self.eventNode):InitEpEventNode(eventData, onChiceClickAction, self.__ActiveUIMask)
      ;
      ((self.randomEventRoom).gameObject):SetActive(false)
      ;
      ((self.eventNode).gameObject):SetActive(true)
    end
  end
end

UIEpEventRoom.GetEventChoiceItem = function(self, index)
  -- function num : 0_3
  return ((self.eventNode).choiceItemDic)[index]
end

UIEpEventRoom.SwitchMapBtnState = function(self, isOpen)
  -- function num : 0_4
  ((self.ui).obj_Frame):SetActive(not isOpen)
  ;
  ((self.ui).img_BtnBg):SetIndex(not isOpen and 0 or 1)
  ;
  ((self.ui).tex_BtnName):SetIndex(not isOpen and 0 or 1)
end

UIEpEventRoom.OnMapButtonClick = function(self)
  -- function num : 0_5
  self.onMapClick = not self.onMapClick
  self:SwitchMapBtnState(self.onMapClick)
end

UIEpEventRoom.FromMapBackToUI = function(self)
  -- function num : 0_6
  self.onMapClick = false
  self:SwitchMapBtnState(self.onMapClick)
end

UIEpEventRoom.OnChipDetailActiveChange = function(self, bool)
  -- function num : 0_7
  if bool then
    self:Hide()
  else
    self:Show()
  end
end

UIEpEventRoom.GetAniItemPosAndScale = function(self)
  -- function num : 0_8
  local position = (self.transform):InverseTransformPoint((((self.ui).obj_ChipAniNode).transform).position)
  local scale = (((self.ui).obj_ChipAniNode).transform).scale
  return position, scale
end

UIEpEventRoom.ActiveUIMask = function(self, flag)
  -- function num : 0_9
  ((self.ui).obj_AniMask):SetActive(flag)
end

UIEpEventRoom.CloseWindow = function(self)
  -- function num : 0_10
  self:Delete()
end

UIEpEventRoom.OnDelete = function(self)
  -- function num : 0_11 , upvalues : _ENV, base
  (self.randomEventRoom):Delete()
  ;
  (self.eventNode):Delete()
  MsgCenter:RemoveListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
  MsgCenter:RemoveListener(eMsgEventId.OnShowingMapRoomClick, self.__FromMapBackToUI)
  ;
  (base.OnDelete)(self)
end

return UIEpEventRoom


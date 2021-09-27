local UINEpEventSlotMachineItem = class("UINEpEventSlotMachineItem", UIBaseNode)
local base = UIBaseNode
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
UINEpEventSlotMachineItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (((self.ui).btn_item).onPressDown):AddListener(BindCallback(self, self._OnPressDown))
  ;
  (((self.ui).btn_item).onPressUp):AddListener(BindCallback(self, self._OnPressUp))
end

UINEpEventSlotMachineItem.InitSlotMachineItem = function(self, choiceData, onPressUp, onPressDown)
  -- function num : 0_1 , upvalues : _ENV, ExplorationEnum
  self.choiceData = choiceData
  self._onPressUp = onPressUp
  self._onPressDown = onPressDown
  self.cfg = (ConfigData.event_choice)[(self.choiceData).choiceId]
  self.strName = (LanguageUtil.GetLocaleText)((self.cfg).describe)
  self.strDesc = (LanguageUtil.GetLocaleText)((self.cfg).exDescribe)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Random).text = self.strName
  ;
  ((self.ui).bottom):SetIndex((self.cfg).gamblebenefit_tag ~= (ExplorationEnum.epGamblebenefitTagType).Debuff and 0 or 1)
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite((self.cfg).icon, CommonAtlasType.ExplorationIcon)
  self.hasExDesc = self.strDesc == nil and not (string.IsNullOrEmpty)(self.strDesc)
  ;
  (((self.ui).img_OnSelect).gameObject):SetActive(self.hasExDesc)
  -- DECOMPILER ERROR at PC71: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_OnSelect).color = (self.ui).col_gray
  -- DECOMPILER ERROR at PC75: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).btn_item).enabled = self.hasExDesc
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINEpEventSlotMachineItem._OnPressDown = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if not self.hasExDesc then
    return 
  end
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  if self._onPressDown ~= nil then
    ((self.ui).img_OnSelect).color = Color.white
    ;
    (self._onPressDown)(self.strName, self.strDesc)
  end
end

UINEpEventSlotMachineItem._OnPressUp = function(self)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  if self._onPressUp ~= nil then
    ((self.ui).img_OnSelect).color = (self.ui).col_gray
    ;
    (self._onPressUp)()
  end
end

return UINEpEventSlotMachineItem


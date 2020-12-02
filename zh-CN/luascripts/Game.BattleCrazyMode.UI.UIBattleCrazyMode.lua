-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBattleCrazyMode = class("UIBattleCrazyMode", UIBaseWindow)
local base = UIBaseWindow
local DungeonBattleBaseCtrl = require("Game.Common.CommonGameCtrl.DungeonBattleBaseCtrl")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local cs_DoTween = ((CS.DG).Tweening).DOTween
local cs_WaitForSecondsRealtime = (CS.UnityEngine).WaitForSecondsRealtime
local util = require("XLua.Common.xlua_util")
UIBattleCrazyMode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  ((self.ui).countdown):SetActive(false)
  ;
  ((self.ui).crazyBuffList):SetActive(false)
  ;
  ((self.ui).tipsList):SetActive(false)
  ;
  (((self.ui).crazyAtnTips).gameObject):SetActive(false)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).crazyAtnTipsMoveY = 20
  self.cAtnTipsPos = (((self.ui).crazyAtnTips).transform).localPosition
  ;
  (((self.ui).crazyHpTips).gameObject):SetActive(false)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).crazyHpTipsMoveY = 20
  self.cHpTipsPos = (((self.ui).crazyHpTips).transform).localPosition
  ;
  (((self.ui).crazyBuff1).onPress):AddListener(BindCallback(self, self.__OnCrazyBuff1Press))
  ;
  (((self.ui).crazyBuff1).onPressUp):AddListener(BindCallback(self, self.__OnCrazyBuffPressUp))
  ;
  (((self.ui).crazyBuff2).onPress):AddListener(BindCallback(self, self.__OnCrazyBuff2Press))
  ;
  (((self.ui).crazyBuff2).onPressUp):AddListener(BindCallback(self, self.__OnCrazyBuffPressUp))
  ;
  (((self.ui).btn_countdown).onPress):AddListener(BindCallback(self, self.__OnCountdownPress))
  ;
  (((self.ui).btn_countdown).onPressUp):AddListener(BindCallback(self, self.__OnCrazyBuffPressUp))
  self.isCrazy = false
  self.crazyStartTime = (ConfigData.game_config).battleCrazyStartTime
  self.CrazyTipsData = {}
  self:InitCrazyTipsData()
end

UIBattleCrazyMode.InitCrazyTipsData = function(self)
  -- function num : 0_1 , upvalues : _ENV
  ((self.ui).tex_Percentage1):SetIndex(0, "0")
  ;
  ((self.ui).tex_Percentage2):SetIndex(0, "0")
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Countdown).text = self.crazyStartTime
  for k,v in pairs(ConfigData.overload) do
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R6 in 'UnsetPending'

    if v.pop_up then
      (self.CrazyTipsData)[k] = 1
    end
  end
end

UIBattleCrazyMode.Update = function(self, battleCtrl)
  -- function num : 0_2 , upvalues : _ENV
  local time = battleCtrl.timeInt
  if self.isCrazy then
    self:CrazyBuffInfoUpdate((math.floor)(time - self.crazyStartTime))
  else
    self:CrazyTimeInfoUpdate(self.crazyStartTime - time)
  end
end

UIBattleCrazyMode.CrazyTimeInfoUpdate = function(self, time)
  -- function num : 0_3 , upvalues : _ENV
  if self.isCrazy then
    return 
  end
  local Countdown = (math.max)(0, time)
  ;
  ((self.ui).countdown):SetActive(Countdown <= 10)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Countdown).text = Countdown
  if Countdown <= 0 then
    self:OnBattleCrazyStart()
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIBattleCrazyMode.CrazyBuffInfoUpdate = function(self, time)
  -- function num : 0_4 , upvalues : _ENV
  if not self.isCrazy or time <= 0 then
    return 
  end
  local overloadCfg = (ConfigData.overload)[time]
  if overloadCfg then
    ((self.ui).tex_Percentage1):SetIndex(0, tostring(overloadCfg.dps_up))
    ;
    ((self.ui).tex_Percentage2):SetIndex(0, tostring(overloadCfg.heal_down))
    if overloadCfg.pop_up then
      local AtnTips = tostring(overloadCfg.dps_up) .. "%"
      local HpTips = tostring(overloadCfg.heal_down) .. "%"
      -- DECOMPILER ERROR at PC51: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).tex_CrazyAtnTips).text = (string.format)(ConfigData:GetTipContent(TipContent.Overload_Atn_Buff_Tip), AtnTips)
      -- DECOMPILER ERROR at PC63: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).tex_CrazyHpTips).text = (string.format)(ConfigData:GetTipContent(TipContent.Overload_Hp_Buff_Tip), HpTips)
      self:ShowCrazyTips()
    end
  end
end

UIBattleCrazyMode.OnBattleStartCrazyMode = function(self, battleCtrl)
  -- function num : 0_5 , upvalues : _ENV
  self.__Timer = (TimerManager:GetTimer(1, (BindCallback(self, self.Update, battleCtrl)), nil, false, false, false)):Start()
  self:Show()
end

UIBattleCrazyMode.OnBattlePause = function(self)
  -- function num : 0_6
  self:Hide()
end

UIBattleCrazyMode.OnBattleContinue = function(self)
  -- function num : 0_7
  self:Show()
end

UIBattleCrazyMode.OnBattleCrazyStart = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.Battle)
  if win ~= nil then
    win:StartCrazyMode()
  end
  self.isCrazy = true
  ;
  ((self.ui).countdown):SetActive(false)
  ;
  ((self.ui).crazyBuffList):SetActive(true)
end

UIBattleCrazyMode.__OnCrazyBuff1Press = function(self)
  -- function num : 0_9
  self:ShowBuffInfo(1)
end

UIBattleCrazyMode.__OnCrazyBuff2Press = function(self)
  -- function num : 0_10
  self:ShowBuffInfo(2)
end

UIBattleCrazyMode.__OnCountdownPress = function(self)
  -- function num : 0_11
  self:ShowBuffInfo(3)
end

UIBattleCrazyMode.__OnCrazyBuffPressUp = function(self)
  -- function num : 0_12
  self:HideBuffInfo()
end

UIBattleCrazyMode.ShowBuffInfo = function(self, index)
  -- function num : 0_13 , upvalues : _ENV, HAType, VAType
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  if index == 1 or index == 2 then
    win:SetTitleAndContext("", ConfigData:GetTipContent(TipContent.Overload_Buff_Tip))
  else
    win:SetTitleAndContext("", ConfigData:GetTipContent(TipContent.Overload_Time_Tip))
  end
  if index == 1 then
    win:FloatTo(((self.ui).crazyBuff1).transform, HAType.left, VAType.down)
  end
  if index == 2 then
    win:FloatTo(((self.ui).crazyBuff2).transform, HAType.left, VAType.down)
  end
  if index == 3 then
    win:FloatTo(((self.ui).countdown).transform, HAType.left, VAType.down)
  end
end

UIBattleCrazyMode.HideBuffInfo = function(self)
  -- function num : 0_14 , upvalues : _ENV
  UIManager:HideWindow(UIWindowTypeID.FloatingFrame)
end

UIBattleCrazyMode.ShowCrazyTips = function(self)
  -- function num : 0_15 , upvalues : _ENV, util
  if self.__crazyTipsCoroutine == nil then
    self.__crazyTipsCoroutine = (GR.StartCoroutine)((util.cs_generator)(BindCallback(self, self.__StartCoroutineCrazyTips)))
  end
end

UIBattleCrazyMode.__ShowCrazyTipsTween = function(self)
  -- function num : 0_16 , upvalues : _ENV, cs_DoTween
  if self.__showCAtnTipsSeq ~= nil then
    (self.__showCAtnTipsSeq):Restart()
  else
    ;
    (((self.ui).crazyAtnTips).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).crazyAtnTips).alpha = 0
    local cTipsPos = (Vector3.New)((self.cAtnTipsPos).x, (self.cAtnTipsPos).y - (self.ui).crazyAtnTipsMoveY, (self.cAtnTipsPos).z)
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self.ui).crazyAtnTips).transform).localPosition = cTipsPos
    local sequence = (cs_DoTween.Sequence)()
    sequence:Append((((self.ui).crazyAtnTips):DOFade(1, 0.15)):SetLoops(4, (((CS.DG).Tweening).LoopType).Restart))
    sequence:Join(((((self.ui).crazyAtnTips).transform):DOLocalMoveY((self.ui).crazyAtnTipsMoveY, 0.3)):SetRelative(true))
    sequence:SetAutoKill(false)
    sequence:SetUpdate(true)
    self.__showCAtnTipsSeq = sequence
  end
  do
    if self.__showCHpTipsSeq ~= nil then
      (self.__showCHpTipsSeq):Restart()
    else
      ;
      (((self.ui).crazyHpTips).gameObject):SetActive(true)
      -- DECOMPILER ERROR at PC85: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((self.ui).crazyHpTips).alpha = 0
      local cTipsPos = (Vector3.New)((self.cHpTipsPos).x, (self.cHpTipsPos).y - (self.ui).crazyAtnTipsMoveY, (self.cHpTipsPos).z)
      -- DECOMPILER ERROR at PC101: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (((self.ui).crazyHpTips).transform).localPosition = cTipsPos
      local sequence = (cs_DoTween.Sequence)()
      sequence:Append((((self.ui).crazyHpTips):DOFade(1, 0.15)):SetLoops(4, (((CS.DG).Tweening).LoopType).Restart))
      sequence:Join(((((self.ui).crazyHpTips).transform):DOLocalMoveY((self.ui).crazyAtnTipsMoveY, 0.3)):SetRelative(true))
      sequence:SetAutoKill(false)
      sequence:SetUpdate(true)
      self.__showCHpTipsSeq = sequence
    end
  end
end

UIBattleCrazyMode.__HideCrazyTipsTween = function(self)
  -- function num : 0_17 , upvalues : cs_DoTween, _ENV
  if self.__hideCAtnTipsSeq ~= nil then
    (self.__hideCAtnTipsSeq):Restart()
  else
    local sequence = (cs_DoTween.Sequence)()
    sequence:Append(((self.ui).crazyAtnTips):DOFade(0, 0.3))
    sequence:Join(((((self.ui).crazyAtnTips).transform):DOLocalMoveY((self.ui).crazyAtnTipsMoveY, 0.3)):SetRelative(true))
    sequence:SetAutoKill(false)
    sequence:SetUpdate(true)
    sequence:AppendCallback(function()
    -- function num : 0_17_0 , upvalues : self, _ENV
    (((self.ui).crazyAtnTips).gameObject):SetActive(false)
    ;
    (GR.StopCoroutine)(self.__crazyTipsCoroutine)
    self.__crazyTipsCoroutine = nil
  end
)
    self.__hideCAtnTipsSeq = sequence
  end
  do
    if self.__hideCHpTipsSeq ~= nil then
      (self.__hideCHpTipsSeq):Restart()
    else
      local sequence = (cs_DoTween.Sequence)()
      sequence:Append(((self.ui).crazyHpTips):DOFade(0, 0.3))
      sequence:Join(((((self.ui).crazyHpTips).transform):DOLocalMoveY((self.ui).crazyAtnTipsMoveY, 0.3)):SetRelative(true))
      sequence:SetAutoKill(false)
      sequence:SetUpdate(true)
      sequence:AppendCallback(function()
    -- function num : 0_17_1 , upvalues : self
    (((self.ui).crazyHpTips).gameObject):SetActive(false)
  end
)
      self.__hideCHpTipsSeq = sequence
    end
  end
end

UIBattleCrazyMode.__StartCoroutineCrazyTips = function(self)
  -- function num : 0_18 , upvalues : _ENV, cs_WaitForSecondsRealtime
  self:__ClearTipsTween()
  self:__ShowCrazyTipsTween()
  ;
  (coroutine.yield)(cs_WaitForSecondsRealtime((self.ui).cTipsShowTime))
  self:__HideCrazyTipsTween()
end

UIBattleCrazyMode.__ClearTipsTween = function(self)
  -- function num : 0_19
  if self.__showCAtnTipsSeq ~= nil then
    (self.__showCAtnTipsSeq):Kill()
    self.__showCAtnTipsSeq = nil
  end
  if self.__showCHpTipsSeq ~= nil then
    (self.__showCHpTipsSeq):Kill()
    self.__showCHpTipsSeq = nil
  end
  if self.__hideCAtnTipsSeq ~= nil then
    (self.__hideCAtnTipsSeq):Kill(true)
    self.__hideCAtnTipsSeq = nil
  end
  if self.__hideCHpTipsSeq ~= nil then
    (self.__hideCHpTipsSeq):Kill(true)
    self.__hideCHpTipsSeq = nil
  end
end

UIBattleCrazyMode.Show = function(self, withTween)
  -- function num : 0_20 , upvalues : base
  if self.active then
    return 
  end
  ;
  (base.Show)(self)
end

UIBattleCrazyMode.Hide = function(self, withTween)
  -- function num : 0_21 , upvalues : base
  if not self.active then
    return 
  end
  ;
  (base.Hide)(self)
end

UIBattleCrazyMode.OnDelete = function(self)
  -- function num : 0_22 , upvalues : _ENV, base
  self:__ClearTipsTween()
  self.isCrazy = false
  if self.__Timer ~= nil then
    (self.__Timer):Stop()
    self.__Timer = nil
  end
  self.CrazyTipsData = {}
  if self.__crazyTipsCoroutine ~= nil then
    (GR.StopCoroutine)(self.__crazyTipsCoroutine)
    self.__crazyTipsCoroutine = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIBattleCrazyMode


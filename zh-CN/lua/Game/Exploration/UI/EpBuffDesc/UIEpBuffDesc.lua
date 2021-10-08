local UIEpBuffDesc = class("UIEpBuffDesc", UIBaseWindow)
local base = UIBaseWindow
local UINBuffDescItem = require("Game.Exploration.UI.EpBuffDesc.UINBuffDescItem")
local cs_DoTween = ((CS.DG).Tweening).DOTween
UIEpBuffDesc.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBuffDescItem
  ((self.ui).epBuffDescItem):SetActive(false)
  ;
  (((self.ui).ani_textContinue).gameObject):SetActive(false)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).Img_Bg).raycastTarget = false
  self.buffDescItemPool = (UIItemPool.New)(UINBuffDescItem, (self.ui).epBuffDescItem)
  ;
  (UIUtil.AddButtonListener)((self.ui).Btn_Bg, self, self._OnBackgroundClick)
  self:InitTimer((self.ui).flo_canClickTime or 1)
end

UIEpBuffDesc.OnShow = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local dungeonStateWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonStateWindow ~= nil then
    dungeonStateWindow:SetBuffListActive(false)
  end
end

UIEpBuffDesc.OnHide = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local dungeonStateWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonStateWindow ~= nil then
    dungeonStateWindow:SetBuffListActive(true)
  end
end

UIEpBuffDesc.InitTimer = function(self, SetTime)
  -- function num : 0_3 , upvalues : _ENV
  self._timerID = TimerManager:StartTimer(SetTime, self._OnTimeOver, self, true, false, false)
end

UIEpBuffDesc.InitEpBuffDesc = function(self, buffList, closeCallback)
  -- function num : 0_4
  self.closeCallback = closeCallback
  self:RefershEpBuffDesc(buffList)
end

UIEpBuffDesc.RefershEpBuffDesc = function(self, buffList)
  -- function num : 0_5 , upvalues : _ENV, cs_DoTween
  (self.buffDescItemPool):HideAll()
  for index,epBuff in ipairs(buffList) do
    if index <= 4 then
      do
        local item = (self.buffDescItemPool):GetOne(true)
        item:InitBuffDescItem(epBuff)
        -- DECOMPILER ERROR at PC16: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC16: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  ;
  (((CS.UnityEngine).Canvas).ForceUpdateCanvases)()
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).hLayout).enabled = false
  if self._showSeq ~= nil then
    (self._showSeq):Rewind()
    ;
    (self._showSeq):Kill()
    self._showSeq = nil
  end
  local sequence = (cs_DoTween.Sequence)()
  for index,item in ipairs((self.buffDescItemPool).listItem) do
    local delay = (index - 1) * 0.15
    sequence:Insert(0, ((((item.transform):DOAnchorPosY(((item.transform).anchoredPosition).y - 100, 1)):From()):SetDelay(delay)):SetLink(item.gameObject))
    sequence:Insert(0, (((((item.ui).fade):DOFade(0, 1)):From()):SetDelay(delay)):SetLink(item.gameObject))
  end
  sequence:OnComplete(function()
    -- function num : 0_5_0 , upvalues : _ENV, self
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

    if not IsNull(self.gameobject) then
      ((self.ui).hLayout).enabled = true
    end
  end
)
  self._showSeq = sequence
end

UIEpBuffDesc._OnTimeOver = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if IsNull(self.transform) then
    return 
  end
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).Img_Bg).raycastTarget = true
  ;
  (((self.ui).ani_textContinue).gameObject):SetActive(true)
end

UIEpBuffDesc._OnBackgroundClick = function(self)
  -- function num : 0_7
  if self.closeCallback ~= nil then
    (self.closeCallback)()
  end
  self:Delete()
end

UIEpBuffDesc.OnDelete = function(self)
  -- function num : 0_8 , upvalues : _ENV, base
  if self._timeID ~= nil then
    TimerManager:StopTimer(self._timerID)
    self._timerID = nil
  end
  ;
  (self.buffDescItemPool):DeleteAll()
  ;
  ((self.ui).ani_textContinue):DOKill()
  if self._showSeq ~= nil then
    (self._showSeq):Kill()
    self._showSeq = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIEpBuffDesc


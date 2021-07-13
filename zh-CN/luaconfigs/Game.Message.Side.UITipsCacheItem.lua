-- params : ...
-- function num : 0 , upvalues : _ENV
local UITipsCacheItem = class("UISideTipsItem", UIBaseNode)
local base = UIBaseNode
local eCacheState = require("Game.Message.Side.eCacheState")
local cs_DoTween = ((CS.DG).Tweening).DOTween
UITipsCacheItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self._onFadeOut = BindCallback(self, self._FadeOutTween)
  self._onFadeIn = BindCallback(self, self._FadeInTween)
  self._onSeqComplete = BindCallback(self, self._SeqComplete)
  self._offsetY = ((self.transform).rect).height
  self._halfOffsetY = self._offsetY / 2
  self._showTime = 0.3
  self._oriAnchoredPos = (self.transform).anchoredPosition
end

UITipsCacheItem.InitTipsCacheItem = function(self, msgData)
  -- function num : 0_1
  self:_InitData(msgData)
  self:_InitUI(msgData)
  self:_InitTweenSeq()
end

UITipsCacheItem._InitData = function(self, msgData)
  -- function num : 0_2 , upvalues : eCacheState
  self._waitSecond = msgData.waitTime
  self.curState = eCacheState.FadeIn
end

UITipsCacheItem._InitUI = function(self, msgData)
  -- function num : 0_3 , upvalues : _ENV
  (self.transform):SetAsLastSibling()
  ;
  ((self.ui).obj_efficiency):SetActive(false)
  ;
  ((self.ui).obj_normal):SetActive(false)
  local content = msgData.content
  if msgData.tipsType == eMessageSideType.normal or msgData.tipsType == nil then
    ((self.ui).obj_normal):SetActive(true)
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Content).text = content
  else
    if msgData.tipsType == eMessageSideType.efficiency then
      ((self.ui).obj_efficiency):SetActive(true)
      local class = type(content)
      do
        if class == "number" then
          local color = Color.white
          if content > 0 then
            color = (self.ui).col_orange
            content = "+" .. tostring(content)
          else
            color = (self.ui).col_red
            content = tostring(content)
          end
          -- DECOMPILER ERROR at PC66: Confused about usage of register: R5 in 'UnsetPending'

          ;
          ((self.ui).tex_EfficiencyNum).color = color
        end
        -- DECOMPILER ERROR at PC69: Confused about usage of register: R4 in 'UnsetPending'

        ;
        ((self.ui).tex_EfficiencyNum).text = content
      end
    end
  end
end

UITipsCacheItem._InitTweenSeq = function(self)
  -- function num : 0_4 , upvalues : cs_DoTween, eCacheState
  if self._tweenSeq ~= nil then
    (self._tweenSeq):Restart(false)
  else
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).fade).alpha = 0
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self.transform).anchoredPosition = self._oriAnchoredPos
    local tweenSeq = (cs_DoTween.Sequence)()
    tweenSeq:SetAutoKill(false)
    tweenSeq:SetUpdate(true)
    tweenSeq:InsertCallback(0, self._onFadeIn)
    tweenSeq:AppendInterval(self._showTime)
    tweenSeq:AppendCallback(function()
    -- function num : 0_4_0 , upvalues : self, eCacheState
    self.curState = eCacheState.Show
  end
)
    tweenSeq:AppendInterval(self._waitSecond)
    tweenSeq:AppendCallback(self._onFadeOut)
    tweenSeq:AppendInterval(self._showTime)
    tweenSeq:OnComplete(self._onSeqComplete)
    self._tweenSeq = tweenSeq
  end
end

UITipsCacheItem._FadeInTween = function(self)
  -- function num : 0_5
  ((self.ui).fade):DOKill()
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).fade).alpha = 1
  ;
  (((self.ui).fade):DOFade(0, self._showTime)):From()
  ;
  (self.transform):DOKill()
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.transform).anchoredPosition = self._oriAnchoredPos
  ;
  ((self.transform):DOAnchorPosX((self._oriAnchoredPos).x + 517, self._showTime)):From()
end

UITipsCacheItem._FadeOutTween = function(self)
  -- function num : 0_6 , upvalues : eCacheState
  if self.curState == eCacheState.Show then
    self.curState = eCacheState.FadeOut
    ;
    ((self.ui).fade):DOKill()
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).fade).alpha = 1
    ;
    ((self.ui).fade):DOFade(0, self._showTime)
    ;
    (self.transform):DOAnchorPosY(self._halfOffsetY, self._showTime)
  end
end

UITipsCacheItem._SeqComplete = function(self)
  -- function num : 0_7 , upvalues : eCacheState
  if self.curState == eCacheState.Useless then
    return 
  end
  ;
  (self._tweenSeq):Complete(false)
  ;
  (self.transform):DOKill()
  ;
  ((self.ui).fade):DOKill()
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).fade).alpha = 0
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.transform).anchoredPosition = self._oriAnchoredPos
  self.curState = eCacheState.Useless
end

UITipsCacheItem.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  if self._tweenSeq ~= nil then
    (self._tweenSeq):Kill(true)
    self._tweenSeq = nil
  end
  ;
  (self.transform):DOKill()
  ;
  ((self.ui).fade):DOKill()
  ;
  (base.OnDelete)(self)
end

return UITipsCacheItem


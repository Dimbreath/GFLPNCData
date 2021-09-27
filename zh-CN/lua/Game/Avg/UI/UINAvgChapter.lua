local UINAvgChapter = class("UINAvgChapter", UIBaseNode)
local base = UIBaseNode
local CS_ScrambleMode = ((CS.DG).Tweening).ScrambleMode
UINAvgChapter.ctor = function(self, avgSystem)
  -- function num : 0_0
  self.avgSystem = avgSystem
end

UINAvgChapter.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (((self.ui).tween_ChapterText).onComplete):AddListener(BindCallback(self, self.OnChapterTextTweenComplete))
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tween_ChapterText).isIndependentUpdate = (self.avgSystem):AvgIgnoreTimeScale()
  ;
  (((self.ui).tex_ChapterNarrator).onHrefClick):AddListener((self.avgSystem):GetOnClickAvgTextLinkCallback())
end

UINAvgChapter.ShowAvgChapter = function(self, content, shake, immediate, scramble)
  -- function num : 0_2 , upvalues : CS_ScrambleMode, _ENV
  self:Show()
  self.shake = shake
  self:ClearShakeTween()
  self.tweenComplete = false
  local extents = ((((self.ui).tex_ChapterNarrator).rectTransform).rect).size
  extents.y = 0
  ;
  ((self.ui).tex_ChapterNarrator):PreSetTextSizeDelta(content, false, true, extents)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R6 in 'UnsetPending'

  if immediate then
    ((self.ui).tex_ChapterNarrator).text = content
    self:OnChapterTextTweenComplete()
  else
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_ChapterNarrator).text = nil
    ;
    ((self.ui).tween_ChapterText):DOKill()
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tween_ChapterText).optionalScrambleMode = scramble and CS_ScrambleMode.Uppercase or CS_ScrambleMode.None
    ;
    ((self.ui).tween_ChapterText):CreateTween()
    local textSpeed = (ConfigData.buildinConfig).AvgTextTweenSpeed
    ;
    (((self.ui).tween_ChapterText).tween):ChangeEndValue(content, textSpeed, true)
    ;
    ((self.ui).tween_ChapterText):DORestart()
  end
  do
    self.contentLenth = #content
  end
end

UINAvgChapter.OnChapterTextTweenComplete = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.tweenComplete then
    return 
  end
  self.tweenComplete = true
  if self.shake then
    self.shakeTween = ((((self.ui).tex_ChapterNarrator).transform):DOShakePosition(0.4, (Vector3.New)(10, 10, 0), 20)):SetUpdate((self.avgSystem):AvgIgnoreTimeScale())
  end
  ;
  (self.avgSystem):ShowTextComplete(self.contentLenth)
end

UINAvgChapter.SkipAvgContent = function(self)
  -- function num : 0_4
  ((self.ui).tween_ChapterText):DOComplete()
end

UINAvgChapter.ClearShakeTween = function(self)
  -- function num : 0_5
  if self.shakeTween ~= nil then
    (self.shakeTween):Rewind()
    ;
    (self.shakeTween):Kill()
    self.shakeTween = nil
  end
end

UINAvgChapter.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  self:ClearShakeTween()
  ;
  ((self.ui).tween_ChapterText):DOKill()
  ;
  (base.OnDelete)(self)
end

return UINAvgChapter


-- params : ...
-- function num : 0 , upvalues : _ENV
local UINNoticeSide = class("UINNoticeSide", UIBaseNode)
local base = UIBaseNode
local cs_DoTween = ((CS.DG).Tweening).DOTween
UINNoticeSide.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, cs_DoTween
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  local oldSize = (((self.ui).go_side).transform).sizeDelta
  self.inTweenSequence = ((((((cs_DoTween.Sequence)()):AppendCallback(function()
    -- function num : 0_0_0 , upvalues : self, oldSize
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

    (((self.ui).go_side).transform).sizeDelta = oldSize
    ;
    ((self.ui).sideList):SetLayoutVertical()
  end
)):Append((((((self.ui).side).transform):DOLocalMoveX(-((((self.ui).side).transform).sizeDelta).x, 0.4)):From(true)):SetRelative(true))):Pause()):SetAutoKill(false)):SetUpdate(true)
end

UINNoticeSide.SideShowNotice = function(self, noticeData, resloader)
  -- function num : 0_1 , upvalues : _ENV
  self.resloader = resloader
  self.noticeData = noticeData
  ;
  (self.inTweenSequence):Restart()
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Title_side).text = noticeData:GetNoticeTitle()
  ;
  ((self.ui).tex_Title_side):StartScrambleTypeWriter()
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Intro_side).text = noticeData:GetNoticeStr()
  ;
  ((self.ui).tex_Intro_side):StartScrambleTypeWriter()
  if not (string.IsNullOrEmpty)(noticeData:GetIcon()) then
    (self.resloader):LoadABAssetAsync(PathConsts:GetAtlasAssetPath("UI_HomeSide"), function(spriteAtlas)
    -- function num : 0_1_0 , upvalues : _ENV, self, noticeData
    if spriteAtlas == nil or IsNull(self.ui) then
      return 
    end
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).image_icon).sprite = spriteAtlas:GetSprite(noticeData:GetIcon())
  end
)
  end
end

UINNoticeSide.HideSideNotice = function(self, callback)
  -- function num : 0_2 , upvalues : cs_DoTween, _ENV
  self.callback = callback
  if self.outTweenSequence == nil then
    self.outTweenSequence = (((((((cs_DoTween.Sequence)()):Append(((((self.ui).side).transform):DOLocalMoveX(-((((self.ui).side).transform).sizeDelta).x * 1.5, 0.3)):SetRelative(true))):Append((((((self.ui).go_side).transform):DOSizeDelta(Vector2.zero, 0.2)):SetEase((((CS.DG).Tweening).Ease).Linear)):OnUpdate(function()
    -- function num : 0_2_0 , upvalues : self
    ((self.ui).sideList):SetLayoutVertical()
  end
))):AppendCallback(function()
    -- function num : 0_2_1 , upvalues : self
    if self.callback ~= nil then
      (self.callback)()
    end
  end
)):Pause()):SetAutoKill(false)):SetUpdate(true)
  end
  ;
  (self.outTweenSequence):Restart()
end

UINNoticeSide.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  if self.inTweenSequence ~= nil then
    (self.inTweenSequence):Kill()
    self.inTweenSequence = nil
  end
  if self.outTweenSequence ~= nil then
    (self.outTweenSequence):Kill()
    self.outTweenSequence = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINNoticeSide


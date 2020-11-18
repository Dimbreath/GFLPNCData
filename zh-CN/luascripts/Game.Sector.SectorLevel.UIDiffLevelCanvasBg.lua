-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDiffLevelCanvasBg = class("UIDiffLevelCanvasBg", UIBaseNode)
local base = UIBaseNode
local cs_DOTween = ((CS.DG).Tweening).DOTween
local cs_DOTweenEase = ((CS.DG).Tweening).Ease
UIDiffLevelCanvasBg.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.aniTime = 0.5
end

UIDiffLevelCanvasBg.SetCanvasBgParent = function(self, parent, sizeDelta)
  -- function num : 0_1
  (self.transform):SetParent(parent)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  if sizeDelta ~= nil then
    (self.transform).sizeDelta = sizeDelta
  end
end

UIDiffLevelCanvasBg.PlayBgAnima = function(self, duration)
  -- function num : 0_2 , upvalues : cs_DOTween
  if self.backgroundTween == nil then
    local sequence = (cs_DOTween.Sequence)()
    sequence:AppendInterval(duration or 0)
    sequence:Append(((self.ui).img_middle):DOLocalMove((self.ui).v3_middle, self.aniTime))
    sequence:Join(((self.ui).img_back):DOLocalMove((self.ui).v3_back, self.aniTime))
    self.backgroundTween = sequence
  else
    do
      ;
      (self.backgroundTween):Restart()
    end
  end
end

UIDiffLevelCanvasBg.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  if self.backgroundTween ~= nil then
    (self.backgroundTween):Kill()
    self.backgroundTween = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIDiffLevelCanvasBg


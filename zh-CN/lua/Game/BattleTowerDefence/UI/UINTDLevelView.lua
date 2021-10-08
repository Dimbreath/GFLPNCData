local UINTDLevelView = class("UINTDLevelView", UIBaseNode)
local base = UIBaseNode
local cs_DoTween = ((CS.DG).Tweening).DOTween
local cs_EaseOutBack = (((CS.DG).Tweening).Ease).OutBack
UINTDLevelView.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINTDLevelView.InitTDLevelView = function(self, totalCount, curCount)
  -- function num : 0_1 , upvalues : _ENV
  ((self.ui).tex_DefProgress):SetIndex(0, tostring(curCount), tostring(totalCount))
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).ani_DefProgress).text = tostring(curCount) .. "/" .. tostring(totalCount)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).ani_DefProgress).enabled = false
  ;
  ((self.ui).fx_Glow):Stop()
end

UINTDLevelView.PlayFx = function(self)
  -- function num : 0_2 , upvalues : cs_DoTween, _ENV, cs_EaseOutBack
  ((self.ui).fx_Glow):Play()
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).ani_DefProgress).enabled = true
  if self.dpSeq ~= nil then
    (self.dpSeq):Restart()
  else
    local seq = (cs_DoTween.Sequence)()
    seq:OnStart(function()
    -- function num : 0_2_0 , upvalues : self, _ENV
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

    (((self.ui).ani_DefProgress).transform).localScale = Vector3.one
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((self.ui).ani_DefProgress).color = (Color.New)(1, 1, 1, 1)
  end
)
    seq:Append(((((self.ui).ani_DefProgress).transform):DOScale((Vector3.New)(1.3, 1.3, 1), 0.5)):SetEase(cs_EaseOutBack))
    seq:Join(((self.ui).ani_DefProgress):DOFade(0, 0.5))
    seq:SetAutoKill(false)
    self.dpSeq = seq
  end
end

UINTDLevelView.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  if self.dpSeq ~= nil then
    (self.dpSeq):Kill()
    self.dpSeq = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINTDLevelView


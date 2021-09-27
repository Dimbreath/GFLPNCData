local UINHomeNoticeItem = class("UINHomeNoticeItem", UIBaseNode)
local base = UIBaseNode
local CS_DoTween = ((CS.DG).Tweening).DOTween
UINHomeNoticeItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.m_OnPlayOver = BindCallback(self, self.OnPlayOver)
end

UINHomeNoticeItem.InitNoticeItem = function(self, noticeData, OnTweenPlayOver, resloader)
  -- function num : 0_1 , upvalues : _ENV, CS_DoTween
  self.OnTweenPlayOver = OnTweenPlayOver
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Content).text = noticeData:GetNoticeStr()
  resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("UI_HomeSide"), function(spriteAtlas)
    -- function num : 0_1_0 , upvalues : self, noticeData
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = spriteAtlas:GetSprite(noticeData:GetIcon())
  end
)
  local sequence = (CS_DoTween.Sequence)()
  sequence:Append(((self.ui).tipsItem):DOLocalMoveX(0, 0.5))
  sequence:Append((((self.ui).tipsItem):DOLocalMoveX(-600, 0.5)):SetDelay(3))
  sequence:AppendCallback(self.m_OnPlayOver)
  sequence:SetAutoKill(true)
  sequence:Play()
  self.sequence = sequence
end

UINHomeNoticeItem.OnPlayOver = function(self)
  -- function num : 0_2
  if self.OnTweenPlayOver ~= nil then
    (self.OnTweenPlayOver)()
  end
  self.sequence = nil
end

UINHomeNoticeItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  if self.sequence ~= nil then
    (self.sequence):Kill()
    self.sequence = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINHomeNoticeItem


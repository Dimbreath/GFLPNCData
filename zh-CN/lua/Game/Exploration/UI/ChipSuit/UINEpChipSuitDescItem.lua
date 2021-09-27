local UINEpChipSuitDescItem = class("UINEpChipSuitDescItem", UIBaseNode)
local base = UIBaseNode
local cs_TweenLoopType = ((CS.DG).Tweening).LoopType
UINEpChipSuitDescItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINEpChipSuitDescItem.InitSuitDescItem = function(self, number, active, info, activeColor, lockColor)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

  ((self.ui).tex_Count).text = tostring(number)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Desc).text = tostring(info)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R6 in 'UnsetPending'

  if active then
    if activeColor ~= nil then
      ((self.ui).tex_Desc).color = activeColor
    else
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).tex_Desc).color = Color.white
    end
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).img_Count).color = (self.ui).color_active
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_Count).color = Color.white
  else
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R6 in 'UnsetPending'

    if lockColor ~= nil then
      ((self.ui).tex_Desc).color = lockColor
    else
      -- DECOMPILER ERROR at PC46: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).tex_Desc).color = (self.ui).color_deactive
    end
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).img_Count).color = (self.ui).color_deactive
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_Count).color = (self.ui).color_fontdeactive
  end
  if not IsNull((self.ui).canvasGroup) then
    ((self.ui).canvasGroup):DOKill(true)
  end
end

UINEpChipSuitDescItem.TweenEpChipSuitDescItem = function(self)
  -- function num : 0_2 , upvalues : _ENV, cs_TweenLoopType
  ((self.ui).canvasGroup):DOKill(true)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).canvasGroup).alpha = 1
  local t = Time.time % 1.4
  ;
  ((((((self.ui).canvasGroup):DOFade(0.5, 0.7)):From()):SetLoops(-1, cs_TweenLoopType.Yoyo)):SetLink(self.gameObject)):Goto(t, true)
end

UINEpChipSuitDescItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINEpChipSuitDescItem


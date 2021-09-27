local UINEpTaskItem = class("UINEpTaskItem", UIBaseNode)
local base = UIBaseNode
local cs_DoTween = ((CS.DG).Tweening).DOTween
local cs_Ease = ((CS.DG).Tweening).Ease
UINEpTaskItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_itemClick, self, self._OnItemClick)
  self:_ShowCompleteUI(false)
end

UINEpTaskItem.SetTaskClickCallback = function(self, clickCallback)
  -- function num : 0_1
  self._onClickCallback = clickCallback
end

UINEpTaskItem.RefreshItemUI = function(self, taskData)
  -- function num : 0_2 , upvalues : _ENV
  self:_InitCompleteTweenUI()
  self.taskData = taskData
  local stepCfg = taskData:GetStepCfg()
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_QuestContent).text = (LanguageUtil.GetLocaleText)(stepCfg.intro)
  self:RefreshProcessUI()
end

UINEpTaskItem.RefreshProcessUI = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.taskData == nil then
    return 
  end
  local schedule, aim = (self.taskData):GetTaskProcess()
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  if schedule == nil or aim == nil then
    ((self.ui).tex_Count).text = ""
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_Bar).fillAmount = 0
    return 
  end
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R3 in 'UnsetPending'

  if schedule <= aim then
    ((self.ui).tex_Count).text = tostring(schedule) .. "/" .. tostring(aim)
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_Bar).fillAmount = schedule / aim
  end
end

UINEpTaskItem.ShowComplete = function(self)
  -- function num : 0_4 , upvalues : cs_DoTween, _ENV, cs_Ease
  self:_InitCompleteTweenUI()
  if self.completeSeq ~= nil then
    (self.completeSeq):Kill()
  end
  local completeSeq = (cs_DoTween.Sequence)()
  completeSeq:SetAutoKill(false)
  completeSeq:SetLink(self.gameObject)
  self:_ShowCompleteUI(true)
  completeSeq:InsertCallback(0, function()
    -- function num : 0_4_0 , upvalues : self
    self._hasCompleteTween = true
  end
)
  completeSeq:Append((((self.ui).tran_complete):DOSizeDelta((Vector2.New)(536.991, 80), 1)):SetEase(cs_Ease.OutQuart))
  completeSeq:Join((((self.ui).fade_complete):DOFade(1, 0.7)):SetEase(cs_Ease.OutQuad))
  completeSeq:OnComplete(function()
    -- function num : 0_4_1 , upvalues : self
    self._hasCompleteTween = false
    ;
    ((self.ui).fx_Exploration):SetActive(true)
  end
)
  self.completeSeq = completeSeq
end

UINEpTaskItem.HideComplete = function(self)
  -- function num : 0_5 , upvalues : cs_DoTween, _ENV, cs_Ease
  if self.hideSeq ~= nil then
    (self.hideSeq):Kill()
  end
  local hideSeq = (cs_DoTween.Sequence)()
  hideSeq:SetAutoKill(false)
  hideSeq:SetLink(self.gameObject)
  hideSeq:InsertCallback(0, function()
    -- function num : 0_5_0 , upvalues : self
    self._hasCompleteTween = true
  end
)
  hideSeq:Append((((self.ui).tran_complete):DOSizeDelta((Vector2.New)(10, 80), 1)):SetEase(cs_Ease.OutQuart))
  hideSeq:Join((((self.ui).fade_complete):DOFade(0.2, 0.7)):SetEase(cs_Ease.OutQuad))
  hideSeq:OnComplete(function()
    -- function num : 0_5_1 , upvalues : self
    self._hasCompleteTween = false
    self:Hide()
  end
)
  self.hideSeq = hideSeq
end

UINEpTaskItem._InitCompleteTweenUI = function(self)
  -- function num : 0_6 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).fade_complete).alpha = 0.2
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tran_complete).sizeDelta = (Vector2.New)(10, 80)
  self:_ShowCompleteUI(false)
end

UINEpTaskItem._ShowCompleteUI = function(self, Active)
  -- function num : 0_7
  (((self.ui).tran_complete).gameObject):SetActive(Active)
  ;
  ((self.ui).obj_normal):SetActive(not Active)
end

UINEpTaskItem._OnItemClick = function(self)
  -- function num : 0_8
  if self._hasCompleteTween then
    return 
  end
  if self._onClickCallback ~= nil then
    (self._onClickCallback)()
  end
end

UINEpTaskItem.ClearTask = function(self, isComplete)
  -- function num : 0_9
  ((self.ui).fx_Exploration):SetActive(false)
  if isComplete then
    self:HideComplete()
  else
    self:Hide()
  end
  self.taskData = nil
end

UINEpTaskItem.GetTaskId = function(self)
  -- function num : 0_10
  if self.taskData ~= nil then
    return (self.taskData).id
  end
  return 0
end

UINEpTaskItem.OnDelete = function(self)
  -- function num : 0_11 , upvalues : base
  ((self.ui).tran_complete):DOKill()
  ;
  ((self.ui).fade_complete):DOKill()
  ;
  (base.OnDelete)(self)
end

return UINEpTaskItem


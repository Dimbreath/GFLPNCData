-- params : ...
-- function num : 0 , upvalues : _ENV
local UIWCDebuffResult = class("UIWCDebuffResult", UIBaseWindow)
local base = UIBaseWindow
local UINWCDebuffResultItem = require("Game.PeriodicChallenge.UI.WeeklyChallengeDebuffResult.UINWCDebuffResultItem")
local cs_Ease = ((CS.DG).Tweening).Ease
local cs_Dotween = ((CS.DG).Tweening).DOTween
UIWCDebuffResult.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINWCDebuffResultItem
  self.protoLayer = nil
  self.scoreGainRate = nil
  self.scoreRate = nil
  self.historyMaxScore = 0
  self.curScore = 0
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_NextStep, self, self.__OnClickContinue)
  self.resultItemPool = (UIItemPool.New)(UINWCDebuffResultItem, (self.ui).obj_debuffResultItem)
  ;
  ((self.ui).obj_debuffResultItem):SetActive(false)
  ;
  ((self.ui).obj_NewRecord):SetActive(false)
end

UIWCDebuffResult.InitWCDebuffResult = function(self, scoreShow, isWin, continueCallback)
  -- function num : 0_1 , upvalues : _ENV
  self.elemDataDic = scoreShow.show
  self.curScore = scoreShow.score
  self.historyMaxScore = (PlayerDataCenter.allWeeklyChallengeData).currentScore
  self.protoLayer = (Mathf.Floor)(scoreShow.buffRateFix / 100)
  self.scoreGainRate = scoreShow.buffRateFix
  self.scoreRate = (scoreShow.baseRate + 1000) / 1000
  self.continueCallback = continueCallback
  self:__RefreshUI(isWin)
end

UIWCDebuffResult.__RefreshUI = function(self, isWin)
  -- function num : 0_2 , upvalues : _ENV, cs_Dotween, cs_Ease
  local resultBG_Material = ((self.ui).img_ResultBG).material
  resultBG_Material:SetFloat("_Decoloration", 0)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  if isWin then
    ((self.ui).img_ResultBG).color = (self.ui).color_win
  else
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_ResultBG).color = (self.ui).color_loss
  end
  ;
  ((self.ui).tex_historyMaxPoint):SetIndex(0, tostring(self.historyMaxScore))
  ;
  ((self.ui).tex_Layer):SetIndex(0, tostring(self.protoLayer))
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Gain).text = tostring(self.scoreGainRate / 10) .. "%"
  local isNewRecord = self:__IsNewRecord()
  ;
  ((self.ui).obj_scoreRatio):SetActive(self.scoreRate ~= 1)
  ;
  ((self.ui).tex_ScoureRatio):SetIndex(0, tostring(self.scoreRate))
  -- DECOMPILER ERROR at PC69: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_NewPoint).text = tostring(self.curScore)
  for scoreId,cfg in pairs(ConfigData.weekly_challenge_score) do
    -- DECOMPILER ERROR at PC88: Confused about usage of register: R9 in 'UnsetPending'

    if cfg.const_show then
      if (self.elemDataDic)[scoreId] == nil then
        (self.elemDataDic)[scoreId] = {id = scoreId, score = 0, param = 0, isconst = true}
      else
        -- DECOMPILER ERROR at PC92: Confused about usage of register: R9 in 'UnsetPending'

        ((self.elemDataDic)[scoreId]).isconst = true
      end
    end
  end
  local index = 1
  local sequece = (cs_Dotween.Sequence)()
  local addFadeTween = function(canvasGroup)
    -- function num : 0_2_0 , upvalues : index, cs_Ease, sequece
    local tween = (((canvasGroup:DOFade(0, 0.3)):SetDelay(index * 0.12)):SetEase(cs_Ease.InCirc)):From()
    index = index + 1
    sequece:Insert(0, tween)
  end

  local elemDataList = {}
  for _,resultItemData in pairs(self.elemDataDic) do
    if resultItemData.id ~= 18 then
      (table.insert)(elemDataList, resultItemData)
    end
  end
  ;
  (table.sort)(elemDataList, function(a, b)
    -- function num : 0_2_1
    if a.isconst ~= b.isconst then
      return a.isconst
    end
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  if (self.elemDataDic)[18] ~= nil then
    (table.insert)(elemDataList, 1, (self.elemDataDic)[18])
  end
  ;
  (self.resultItemPool):HideAll()
  for index,resultItemData in ipairs(elemDataList) do
    local resultItem = (self.resultItemPool):GetOne()
    resultItem:InitResultItem(resultItemData, index)
    if index <= 12 then
      addFadeTween((resultItem.ui).cg_debuffResultItem)
    end
  end
  addFadeTween((self.ui).cg_debuffConditon)
  addFadeTween((self.ui).cg_total)
  if ((self.ui).obj_scoreRatio).activeInHierarchy then
    addFadeTween((self.ui).cg_scoreRatio)
  end
  if isNewRecord then
    sequece:InsertCallback(index * 0.12, function()
    -- function num : 0_2_2 , upvalues : self
    ((self.ui).obj_NewRecord):SetActive(true)
  end
)
    addFadeTween((self.ui).cg_NewRecord)
  end
  addFadeTween((self.ui).tex_NewPoint)
  addFadeTween((self.ui).cg_btn_NextStep)
  self._showSequence = sequece
  -- DECOMPILER ERROR: 8 unprocessed JMP targets
end

UIWCDebuffResult.__OnClickContinue = function(self)
  -- function num : 0_3
  self:Delete()
  if self.continueCallback ~= nil then
    (self.continueCallback)()
  end
end

UIWCDebuffResult.__IsNewRecord = function(self)
  -- function num : 0_4
  do return self.historyMaxScore or 0 < self.curScore or 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIWCDebuffResult.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  if self._showSequence ~= nil then
    (self._showSequence):Kill()
    self._showSequence = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIWCDebuffResult


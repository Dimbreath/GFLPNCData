local UINAvgChoose = class("UINAvgChoose", UIBaseNode)
local base = UIBaseNode
local UINAvgChooseItem = require("Game.Avg.UI.UINAvgChooseItem")
local fadeTweenId = "Fade"
UINAvgChoose.ctor = function(self, avgSystem)
  -- function num : 0_0
  self.avgSystem = avgSystem
end

UINAvgChoose.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, UINAvgChooseItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.__onClickChooseItem = BindCallback(self, self.OnClickChooseItem)
  ;
  ((self.ui).chooseItem):SetActive(false)
  self.chooseItemPool = (UIItemPool.New)(UINAvgChooseItem, (self.ui).chooseItem)
  ;
  (((self.ui).tween_Fade).onRewind):AddListener(BindCallback(self, self.__OnFadeTweenRewind))
end

UINAvgChoose.ShowAvgChoose = function(self, branchCfg)
  -- function num : 0_2 , upvalues : fadeTweenId, _ENV
  if branchCfg == nil then
    return 
  end
  self.branchCfg = branchCfg
  self:Show()
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).choose_Canvas).interactable = true
  ;
  ((self.ui).tween_Fade):DORestartAllById(fadeTweenId)
  ;
  (self.chooseItemPool):HideAll()
  for index,v in ipairs(branchCfg) do
    local chooseItem = (self.chooseItemPool):GetOne()
    local content = ((self.avgSystem).avgCtrl):GetAvgLanguage(v.content)
    local couldNotSelect = false
    if branchCfg.disableSelected and v.jumpAct ~= nil then
      couldNotSelect = ((self.avgSystem).avgCtrl):GetIsBranchSelected(((self.avgSystem).avgCtrl).curActId, index)
    end
    chooseItem:InitAvgChooseItem(index, content, self.__onClickChooseItem, couldNotSelect)
  end
end

UINAvgChoose.OnClickChooseItem = function(self, index)
  -- function num : 0_3 , upvalues : _ENV
  local cfg = (self.branchCfg)[index]
  if cfg == nil then
    ((self.avgSystem).avgCtrl):AvgLogError("Can\'t find branchCfg, index = " .. tostring(index))
    return 
  end
  ;
  (self.avgSystem):BranchChooseComplete(index, cfg.jumpAct, cfg.jumpChapter)
end

UINAvgChoose.HideAvgChoose = function(self)
  -- function num : 0_4 , upvalues : fadeTweenId
  if not self.active or self.__isFadeTweenRewind then
    return 
  end
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).choose_Canvas).interactable = false
  self.__isFadeTweenRewind = true
  ;
  ((self.ui).tween_Fade):DOPlayBackwardsAllById(fadeTweenId)
end

UINAvgChoose.ShowAvgUI = function(self, show)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).canvasGroup).alpha = show and 1 or 0
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).canvasGroup).interactable = show
end

UINAvgChoose.__OnFadeTweenRewind = function(self)
  -- function num : 0_6
  if self.__isFadeTweenRewind then
    self:Hide()
  end
  self.__isFadeTweenRewind = false
end

UINAvgChoose.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnDelete)(self)
end

return UINAvgChoose


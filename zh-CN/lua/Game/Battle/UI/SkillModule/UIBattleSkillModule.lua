local UIBattleSkillModule = class("UIBattleSkillModule", UIBaseWindow)
local base = UIBaseWindow
local UINBattleHudNode = require("Game.Battle.UI.SkillModule.HudNode.UINBattleHudNode")
local UINUltimateNode = require("Game.Battle.UI.SkillModule.UltimateSkill.UINUltimateNode")
local UINPlayerSkillNode = require("Game.Battle.UI.SkillModule.PlayerSkill.UINPlayerSkillNode")
local UIInputNode = require("Game.Battle.UI.SkillModule.UISkillInput")
local CS_ResLoader = CS.ResLoader
local CS_DOTween = ((CS.DG).Tweening).DOTween
local CS_CanvasGroup = (CS.UnityEngine).CanvasGroup
UIBattleSkillModule.OnInit = function(self)
  -- function num : 0_0 , upvalues : CS_ResLoader, UINBattleHudNode, UINUltimateNode, UINPlayerSkillNode, UIInputNode, _ENV
  self.resloader = (CS_ResLoader.Create)()
  self.hudNode = (UINBattleHudNode.New)()
  ;
  (self.hudNode):Init((self.ui).hUDNode)
  self.ultSkillNode = (UINUltimateNode.New)(self.resloader)
  ;
  (self.ultSkillNode):Init((self.ui).ultimateNode)
  self.playerSkillNode = (UINPlayerSkillNode.New)(self.resloader)
  ;
  (self.playerSkillNode):Init((self.ui).playerSkillNode)
  self.inputModeMaskUI = (UIInputNode.New)()
  ;
  (self.inputModeMaskUI):Init((self.ui).mask)
  ;
  (self.inputModeMaskUI):Hide()
  self.__OnPlayHeroUltrSkillAction = BindCallback(self, self.OnPlayHeroUltrSkillAction)
  MsgCenter:AddListener(eMsgEventId.OnUltSkillRoleActionStart, self.__OnPlayHeroUltrSkillAction)
  self.__OnPlayHeroUltrSkillVideo = BindCallback(self, self.OnPlayHeroUltrSkillVideo)
  MsgCenter:AddListener(eMsgEventId.OnUltSkillVideoStart, self.__OnPlayHeroUltrSkillVideo)
end

UIBattleSkillModule.InitBattleHud = function(self, camera)
  -- function num : 0_1
  (self.hudNode):InitBattleHud(camera)
end

UIBattleSkillModule.SetBattleHudScrollValue = function(self, value)
  -- function num : 0_2
  (self.hudNode):RefreshHudScroll(value)
end

UIBattleSkillModule.InitBattlePlayerUltSkill = function(self, battleSkillList, useSkillFunc, ultEffectSkipFunc)
  -- function num : 0_3
  (self.ultSkillNode):InitBattlePlayerUltSkill(battleSkillList, useSkillFunc, ultEffectSkipFunc)
end

UIBattleSkillModule.AddUltSkillItemInBattle = function(self, roleDataId, battleSkill)
  -- function num : 0_4
  (self.ultSkillNode):AddUltSkillItemInBattle(roleDataId, battleSkill)
end

UIBattleSkillModule.RemoveUltSkillItemInBattle = function(self, roleDataId, battleSkill)
  -- function num : 0_5
  (self.ultSkillNode):RemoveUltSkillItemInBattle(roleDataId, battleSkill)
end

UIBattleSkillModule.DisableHeroUltSkill = function(self, heroId, disable)
  -- function num : 0_6
  (self.ultSkillNode):DisableHeroUltSkill(heroId, disable)
end

UIBattleSkillModule.UpdateUltSkill = function(self, useEnable, curRatio, nextRatio, factor, interpolation)
  -- function num : 0_7
  (self.ultSkillNode):UpdateUltSkill(useEnable, curRatio, nextRatio, factor, interpolation)
end

UIBattleSkillModule.UpdateUltSkillForce = function(self, useEnable, curRatio, factor)
  -- function num : 0_8 , upvalues : _ENV
  (self.ultSkillNode):UpdateUltSkillForce(useEnable, curRatio, factor)
  MsgCenter:Broadcast(eMsgEventId.OnBattleUpdateUltSkill, useEnable, curRatio, factor)
end

UIBattleSkillModule.CreateMpParticle = function(self, startPos, ratio)
  -- function num : 0_9
  if ((self.ultSkillNode).gameObject).activeInHierarchy then
    (self.ultSkillNode):CreateMpParticle(startPos, ratio)
  end
end

UIBattleSkillModule.ShowUltSkillFocusMask = function(self, show)
  -- function num : 0_10
  (self.ultSkillNode):ShowUltSkillFocusMask(show)
end

UIBattleSkillModule.UpdateUltSkillFocusMask = function(self, screenPos)
  -- function num : 0_11
  (self.ultSkillNode):UpdateUltSkillFocusMask(screenPos)
end

UIBattleSkillModule.GetUltSkillMovieRenderer = function(self)
  -- function num : 0_12
  return (self.ultSkillNode):GetUltSkillMovieRenderer()
end

UIBattleSkillModule.GetUltSkipBtnRenderer = function(self)
  -- function num : 0_13
  return (self.ultSkillNode):GetUltSkipBtnRenderer()
end

UIBattleSkillModule.ShowUltSkillNode = function(self, show)
  -- function num : 0_14
  if show then
    (self.ultSkillNode):Show()
  else
    ;
    (self.ultSkillNode):Hide()
  end
end

UIBattleSkillModule.GetUltVideoPath = function(self)
  -- function num : 0_15 , upvalues : _ENV
  return PathConsts.UltSkillVideoPath
end

UIBattleSkillModule.InitPlayerSkillNode = function(self, battlePlayerController, skillList)
  -- function num : 0_16
  (self.playerSkillNode):InitPlayerSkillNode(battlePlayerController, skillList)
end

UIBattleSkillModule.OnPlayerMpChange = function(self, mp)
  -- function num : 0_17
  (self.playerSkillNode):OnPlayerMpChange(mp)
end

UIBattleSkillModule.OnPlayerMaxMpChange = function(self, maxMp)
  -- function num : 0_18
  (self.playerSkillNode):OnPlayerMaxMpChange(maxMp)
end

UIBattleSkillModule.ShowPlayerSkillNode = function(self, show)
  -- function num : 0_19 , upvalues : _ENV
  local isCSUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill)
  if not isCSUnlock then
    (self.playerSkillNode):Hide()
    return 
  end
  if show then
    (self.playerSkillNode):Show()
  else
    ;
    (self.playerSkillNode):Hide()
  end
end

UIBattleSkillModule.BattleSkillMoveToTopSiblingIndex = function(self)
  -- function num : 0_20
  if (self.transform):GetSiblingIndex() ~= ((self.transform).parent).childCount - 1 then
    (self.transform):SetAsLastSibling()
  end
end

UIBattleSkillModule.OnUpdateLogic_BSkillModule = function(self)
  -- function num : 0_21
  (self.playerSkillNode):OnUpdateLogic_PlayerSkillNode()
  ;
  (self.ultSkillNode):OnUpdateLogic_UltimateNode()
end

UIBattleSkillModule.OnUpdateRender_BSkillModule = function(self, deltaTime, interpolation)
  -- function num : 0_22
  (self.playerSkillNode):OnUpdateRender_PlayerSkillNode(deltaTime, interpolation)
  ;
  (self.ultSkillNode):OnUpdateRender_UltimateNode(deltaTime, interpolation)
end

UIBattleSkillModule.__JoinHideTween = function(self, sequence, uiLayer)
  -- function num : 0_23 , upvalues : _ENV, CS_CanvasGroup
  local layerTran = UIManager:GetUILayer(uiLayer)
  if not IsNull(layerTran) then
    sequence:Join(layerTran:DOScale(Vector3.one * 2, (self.ui).hideTweenDuration))
    local canvasGroup = layerTran:FindComponent(eUnityComponentID.CanvasGroup)
    if IsNull(canvasGroup) then
      canvasGroup = (layerTran.gameObject):AddComponent(typeof(CS_CanvasGroup))
    end
    sequence:Join(canvasGroup:DOFade(0, (self.ui).hideTweenDuration))
  end
end

UIBattleSkillModule.BattleHideAllUITween = function(self, hide)
  -- function num : 0_24 , upvalues : CS_DOTween, _ENV
  do
    if self.__hideAllUISequence == nil then
      local sequence = (CS_DOTween.Sequence)()
      self:__JoinHideTween(sequence, EUILayoutLevel.Normal)
      self:__JoinHideTween(sequence, EUILayoutLevel.Middle)
      self:__JoinHideTween(sequence, EUILayoutLevel.High)
      sequence:OnRewind(function()
    -- function num : 0_24_0 , upvalues : self
    if self.__isPlayBack then
      ((self.ui).ultSkillVideo):SetParent(self.transform)
      self.__isPlayBack = false
    end
  end
)
      sequence:SetAutoKill(false)
      self.__hideAllUISequence = sequence
    end
    if hide then
      self.__isPlayBack = false
      ;
      (self.__hideAllUISequence):Restart()
      local layerTran = UIManager:GetUILayer(EUILayoutLevel.Top)
      ;
      ((self.ui).ultSkillVideo):SetParent(layerTran)
    else
      do
        self.__isPlayBack = true
        ;
        (self.__hideAllUISequence):Complete()
        ;
        (self.__hideAllUISequence):PlayBackwards()
      end
    end
  end
end

UIBattleSkillModule.Show = function(self, withTween)
  -- function num : 0_25 , upvalues : base, _ENV
  if self.active then
    return 
  end
  ;
  (base.Show)(self)
  if withTween then
    self:__ClearFadeTween()
    self.__fadeTween = UIManager:PlayDoFade((self.ui).canvasGroup, 0, 1, 0.5)
  end
end

UIBattleSkillModule.Hide = function(self, withTween)
  -- function num : 0_26 , upvalues : base, _ENV
  if not self.active then
    return 
  end
  ;
  (base.Hide)(self)
  if withTween then
    self:__ClearFadeTween()
    self.__fadeTween = UIManager:PlayDoFade((self.ui).canvasGroup, 1, 0, 0.5)
  end
end

UIBattleSkillModule.__ClearFadeTween = function(self)
  -- function num : 0_27
  if self.__fadeTween ~= nil then
    (self.__fadeTween):Kill()
    self.__fadeTween = nil
  end
end

UIBattleSkillModule.SetSelectSkillType = function(self, isHeroSkill)
  -- function num : 0_28
  self.isSelectHeroSkill = isHeroSkill
end

UIBattleSkillModule.SetSkillInputState = function(self, isInInputState)
  -- function num : 0_29
  if isInInputState then
    self.ultimateNodeActiveRecord = (((self.ui).ultimateNode).gameObject).activeSelf
    self.playerSkillNodeActiveRecord = (((self.ui).playerSkillNode).gameObject).activeSelf
    ;
    (((self.ui).ultimateNode).gameObject):SetActive(self.isSelectHeroSkill)
    ;
    (((self.ui).playerSkillNode).gameObject):SetActive(not self.isSelectHeroSkill)
  else
    if self.ultimateNodeActiveRecord ~= nil then
      (((self.ui).ultimateNode).gameObject):SetActive(self.ultimateNodeActiveRecord)
      self.ultimateNodeActiveRecord = nil
    else
      ;
      (((self.ui).ultimateNode).gameObject):SetActive(true)
    end
    if self.playerSkillNodeActiveRecord ~= nil then
      (((self.ui).playerSkillNode).gameObject):SetActive(self.playerSkillNodeActiveRecord)
      self.playerSkillNodeActiveRecord = nil
    else
      ;
      (((self.ui).playerSkillNode).gameObject):SetActive(true)
    end
  end
end

UIBattleSkillModule.OnPlayHeroUltrSkillAction = function(self, caster)
  -- function num : 0_30 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.UltimateSkillShow, function(win)
    -- function num : 0_30_0 , upvalues : caster
    if win == nil then
      return 
    end
    win:InitUltrSkillHeroShow(caster)
  end
)
end

UIBattleSkillModule.OnPlayHeroUltrSkillVideo = function(self)
  -- function num : 0_31 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.UltimateSkillShow)
  if win ~= nil then
    win:Delete()
  end
end

UIBattleSkillModule.OnDelete = function(self)
  -- function num : 0_32 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnUltSkillRoleActionStart, self.__OnPlayHeroUltrSkillAction)
  MsgCenter:RemoveListener(eMsgEventId.OnUltSkillVideoStart, self.__OnPlayHeroUltrSkillVideo)
  self:__ClearFadeTween()
  ;
  (self.resloader):Put2Pool()
  self.resloader = nil
  ;
  ((self.ui).ultSkillVideo):SetParent(self.transform)
  if self.inputModeMaskUI ~= nil then
    (self.inputModeMaskUI):Delete()
    self.inputModeMaskUI = nil
  end
  ;
  (self.hudNode):Delete()
  ;
  (self.ultSkillNode):Delete()
  ;
  (self.playerSkillNode):Delete()
  if self.__hideAllUISequence ~= nil then
    (self.__hideAllUISequence):Rewind()
    ;
    (self.__hideAllUISequence):Kill()
    self.__hideAllUISequence = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIBattleSkillModule


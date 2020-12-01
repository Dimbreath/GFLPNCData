-- params : ...
-- function num : 0 , upvalues : _ENV
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
  -- function num : 0_0 , upvalues : CS_ResLoader, UINBattleHudNode, UINUltimateNode, UINPlayerSkillNode, UIInputNode
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
end

UIBattleSkillModule.InitBattleHud = function(self, camera)
  -- function num : 0_1
  (self.hudNode):InitBattleHud(camera)
end

UIBattleSkillModule.SetBattleHudScrollValue = function(self, value)
  -- function num : 0_2
  (self.hudNode):RefreshHudScroll(value)
end

UIBattleSkillModule.InitBattlePlayerUltSkill = function(self, battleSkillList, useSkillFunc, stopVideoFunc)
  -- function num : 0_3
  (self.ultSkillNode):InitBattlePlayerUltSkill(battleSkillList, useSkillFunc, stopVideoFunc)
end

UIBattleSkillModule.DisableHeroUltSkill = function(self, heroId, disable)
  -- function num : 0_4
  (self.ultSkillNode):DisableHeroUltSkill(heroId, disable)
end

UIBattleSkillModule.UpdateUltSkill = function(self, useEnable, curRatio, nextRatio, factor, interpolation)
  -- function num : 0_5
  (self.ultSkillNode):UpdateUltSkill(useEnable, curRatio, nextRatio, factor, interpolation)
end

UIBattleSkillModule.UpdateUltSkillForce = function(self, useEnable, curRatio, factor)
  -- function num : 0_6 , upvalues : _ENV
  (self.ultSkillNode):UpdateUltSkillForce(useEnable, curRatio, factor)
  MsgCenter:Broadcast(eMsgEventId.OnBattleUpdateUltSkill, useEnable, curRatio, factor)
end

UIBattleSkillModule.CreateMpParticle = function(self, startPos, ratio)
  -- function num : 0_7
  if ((self.ultSkillNode).gameObject).activeInHierarchy then
    (self.ultSkillNode):CreateMpParticle(startPos, ratio)
  end
end

UIBattleSkillModule.ShowUltSkillFocusMask = function(self, show)
  -- function num : 0_8
  (self.ultSkillNode):ShowUltSkillFocusMask(show)
end

UIBattleSkillModule.UpdateUltSkillFocusMask = function(self, screenPos)
  -- function num : 0_9
  (self.ultSkillNode):UpdateUltSkillFocusMask(screenPos)
end

UIBattleSkillModule.GetUltSkillMovieRenderer = function(self)
  -- function num : 0_10
  return (self.ultSkillNode):GetUltSkillMovieRenderer()
end

UIBattleSkillModule.ShowUltSkillNode = function(self, show)
  -- function num : 0_11
  if show then
    (self.ultSkillNode):Show()
  else
    ;
    (self.ultSkillNode):Hide()
  end
end

UIBattleSkillModule.InitPlayerSkillNode = function(self, skillList, battlePlayerController)
  -- function num : 0_12
  (self.playerSkillNode):InitPlayerSkillNode(skillList, battlePlayerController)
end

UIBattleSkillModule.OnPlayerMpChange = function(self, mp)
  -- function num : 0_13
  (self.playerSkillNode):OnPlayerMpChange(mp)
end

UIBattleSkillModule.ShowPlayerSkillNode = function(self, show)
  -- function num : 0_14 , upvalues : _ENV
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock, true)
  local isCSUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill)
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
  -- function num : 0_15
  if (self.transform):GetSiblingIndex() ~= ((self.transform).parent).childCount - 1 then
    (self.transform):SetAsLastSibling()
  end
end

UIBattleSkillModule.OnUpdateLogic_BSkillModule = function(self)
  -- function num : 0_16
  (self.playerSkillNode):OnUpdateLogic_PlayerSkillNode()
end

UIBattleSkillModule.OnUpdateRender_BSkillModule = function(self, deltaTime, interpolation)
  -- function num : 0_17
  (self.playerSkillNode):OnUpdateRender_PlayerSkillNode(deltaTime, interpolation)
end

UIBattleSkillModule.__JoinHideTween = function(self, sequence, uiLayer)
  -- function num : 0_18 , upvalues : _ENV, CS_CanvasGroup
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
  -- function num : 0_19 , upvalues : CS_DOTween, _ENV
  do
    if self.__hideAllUISequence == nil then
      local sequence = (CS_DOTween.Sequence)()
      self:__JoinHideTween(sequence, EUILayoutLevel.Normal)
      self:__JoinHideTween(sequence, EUILayoutLevel.Middle)
      self:__JoinHideTween(sequence, EUILayoutLevel.High)
      sequence:OnRewind(function()
    -- function num : 0_19_0 , upvalues : self
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
  -- function num : 0_20 , upvalues : base, _ENV
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
  -- function num : 0_21 , upvalues : base, _ENV
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
  -- function num : 0_22
  if self.__fadeTween ~= nil then
    (self.__fadeTween):Kill()
    self.__fadeTween = nil
  end
end

UIBattleSkillModule.OnDelete = function(self)
  -- function num : 0_23 , upvalues : base
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

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBattleSkillModule = class("UIBattleSkillModule", UIBaseWindow)
local base = UIBaseWindow
local UINBattleHudNode = require(
                             "Game.Battle.UI.SkillModule.HudNode.UINBattleHudNode")
local UINUltimateNode = require(
                            "Game.Battle.UI.SkillModule.UltimateSkill.UINUltimateNode")
local UINPlayerSkillNode = require(
                               "Game.Battle.UI.SkillModule.PlayerSkill.UINPlayerSkillNode")
local UIInputNode = require("Game.Battle.UI.SkillModule.UISkillInput")
local CS_ResLoader = CS.ResLoader
local CS_DOTween = ((CS.DG).Tweening).DOTween
local CS_CanvasGroup = (CS.UnityEngine).CanvasGroup
UIBattleSkillModule.OnInit = function(self)
    -- function num : 0_0 , upvalues : CS_ResLoader, UINBattleHudNode, UINUltimateNode, UINPlayerSkillNode, UIInputNode
    self.resloader = (CS_ResLoader.Create)()
    self.hudNode = (UINBattleHudNode.New)();
    (self.hudNode):Init((self.ui).hUDNode)
    self.ultSkillNode = (UINUltimateNode.New)(self.resloader);
    (self.ultSkillNode):Init((self.ui).ultimateNode)
    self.playerSkillNode = (UINPlayerSkillNode.New)(self.resloader);
    (self.playerSkillNode):Init((self.ui).playerSkillNode)
    self.inputModeMaskUI = (UIInputNode.New)();
    (self.inputModeMaskUI):Init((self.ui).mask);
    (self.inputModeMaskUI):Hide()
end

UIBattleSkillModule.InitBattleHud = function(self, camera)
    -- function num : 0_1
    (self.hudNode):InitBattleHud(camera)
end

UIBattleSkillModule.SetBattleHudScrollValue =
    function(self, value)
        -- function num : 0_2
        (self.hudNode):RefreshHudScroll(value)
    end

UIBattleSkillModule.InitBattlePlayerUltSkill =
    function(self, battleSkillList, useSkillFunc, stopVideoFunc)
        -- function num : 0_3
        (self.ultSkillNode):InitBattlePlayerUltSkill(battleSkillList,
                                                     useSkillFunc, stopVideoFunc)
    end

UIBattleSkillModule.DisableHeroUltSkill =
    function(self, heroId, disable)
        -- function num : 0_4
        (self.ultSkillNode):DisableHeroUltSkill(heroId, disable)
    end

UIBattleSkillModule.UpdateUltSkill = function(self, useEnable, curRatio,
                                              nextRatio, factor, interpolation)
    -- function num : 0_5
    (self.ultSkillNode):UpdateUltSkill(useEnable, curRatio, nextRatio, factor,
                                       interpolation)
end

UIBattleSkillModule.UpdateUltSkillForce =
    function(self, useEnable, curRatio, factor)
        -- function num : 0_6 , upvalues : _ENV
        (self.ultSkillNode):UpdateUltSkillForce(useEnable, curRatio, factor)
        MsgCenter:Broadcast(eMsgEventId.OnBattleUpdateUltSkill, useEnable,
                            curRatio, factor)
    end

UIBattleSkillModule.CreateMpParticle = function(self, startPos, ratio)
    -- function num : 0_7
    if ((self.ultSkillNode).gameObject).activeInHierarchy then
        (self.ultSkillNode):CreateMpParticle(startPos, ratio)
    end
end

UIBattleSkillModule.ShowUltSkillFocusMask =
    function(self, show)
        -- function num : 0_8
        (self.ultSkillNode):ShowUltSkillFocusMask(show)
    end

UIBattleSkillModule.UpdateUltSkillFocusMask =
    function(self, screenPos)
        -- function num : 0_9
        (self.ultSkillNode):UpdateUltSkillFocusMask(screenPos)
    end

UIBattleSkillModule.GetUltSkillMovieRenderer =
    function(self)
        -- function num : 0_10
        return (self.ultSkillNode):GetUltSkillMovieRenderer()
    end

UIBattleSkillModule.ShowUltSkillNode = function(self, show)
    -- function num : 0_11
    if show then
        (self.ultSkillNode):Show()
    else

        (self.ultSkillNode):Hide()
    end
end

UIBattleSkillModule.InitPlayerSkillNode =
    function(self, skillList, battlePlayerController)
        -- function num : 0_12
        (self.playerSkillNode):InitPlayerSkillNode(skillList,
                                                   battlePlayerController)
    end

UIBattleSkillModule.OnPlayerMpChange = function(self, mp)
    -- function num : 0_13
    (self.playerSkillNode):OnPlayerMpChange(mp)
end

UIBattleSkillModule.ShowPlayerSkillNode =
    function(self, show)
        -- function num : 0_14 , upvalues : _ENV
        local funcUnLockCrtl = ControllerManager:GetController(
                                   ControllerTypeId.FunctionUnlock, true)
        local isCSUnlock = funcUnLockCrtl:ValidateUnlock(
                               proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill)
        if not isCSUnlock then
            (self.playerSkillNode):Hide()
            return
        end
        if show then
            (self.playerSkillNode):Show()
        else

            (self.playerSkillNode):Hide()
        end
    end

UIBattleSkillModule.BattleSkillMoveToTopSiblingIndex =
    function(self)
        -- function num : 0_15
        if (self.transform):GetSiblingIndex() ~=
            ((self.transform).parent).childCount - 1 then
            (self.transform):SetAsLastSibling()
        end
    end

UIBattleSkillModule.OnUpdateLogic_BSkillModule =
    function(self)
        -- function num : 0_16
        (self.playerSkillNode):OnUpdateLogic_PlayerSkillNode()
    end

UIBattleSkillModule.OnUpdateRender_BSkillModule =
    function(self, deltaTime, interpolation)
        -- function num : 0_17
        (self.playerSkillNode):OnUpdateRender_PlayerSkillNode(deltaTime,
                                                              interpolation)
    end

UIBattleSkillModule.__JoinHideTween = function(self, sequence, uiLayer)
    -- function num : 0_18 , upvalues : _ENV, CS_CanvasGroup
    local layerTran = UIManager:GetUILayer(uiLayer)
    if not IsNull(layerTran) then
        sequence:Join(layerTran:DOScale(Vector3.one * 2,
                                        (self.ui).hideTweenDuration))
        local canvasGroup = layerTran:FindComponent(
                                eUnityComponentID.CanvasGroup)
        if IsNull(canvasGroup) then
            canvasGroup = (layerTran.gameObject):AddComponent(
                              typeof(CS_CanvasGroup))
        end
        sequence:Join(canvasGroup:DOFade(0, (self.ui).hideTweenDuration))
    end
end

UIBattleSkillModule.BattleHideAllUITween =
    function(self, hide)
        -- function num : 0_19 , upvalues : CS_DOTween, _ENV
        do
            if self.__hideAllUISequence == nil then
                local sequence = (CS_DOTween.Sequence)()
                self:__JoinHideTween(sequence, EUILayoutLevel.Normal)
                self:__JoinHideTween(sequence, EUILayoutLevel.Middle)
                self:__JoinHideTween(sequence, EUILayoutLevel.High)
                sequence:OnRewind(function()
                    -- function num : 0_19_0 , upvalues : self
                    if self.__isPlayBack then
                        ((self.ui).ultSkillVideo):SetParent(self.transform)
                        self.__isPlayBack = false
                    end
                end)
                sequence:SetAutoKill(false)
                self.__hideAllUISequence = sequence
            end
            if hide then
                self.__isPlayBack = false;
                (self.__hideAllUISequence):Restart()
                local layerTran = UIManager:GetUILayer(EUILayoutLevel.Top);
                ((self.ui).ultSkillVideo):SetParent(layerTran)
            else
                do
                    self.__isPlayBack = true;
                    (self.__hideAllUISequence):Complete();
                    (self.__hideAllUISequence):PlayBackwards()
                end
            end
        end
    end

UIBattleSkillModule.Show = function(self, withTween)
    -- function num : 0_20 , upvalues : base, _ENV
    if self.active then return end
    (base.Show)(self)
    if withTween then
        self:__ClearFadeTween()
        self.__fadeTween =
            UIManager:PlayDoFade((self.ui).canvasGroup, 0, 1, 0.5)
    end
end

UIBattleSkillModule.Hide = function(self, withTween)
    -- function num : 0_21 , upvalues : base, _ENV
    if not self.active then return end
    (base.Hide)(self)
    if withTween then
        self:__ClearFadeTween()
        self.__fadeTween =
            UIManager:PlayDoFade((self.ui).canvasGroup, 1, 0, 0.5)
    end
end

UIBattleSkillModule.__ClearFadeTween = function(self)
    -- function num : 0_22
    if self.__fadeTween ~= nil then
        (self.__fadeTween):Kill()
        self.__fadeTween = nil
    end
end

UIBattleSkillModule.OnDelete = function(self)
    -- function num : 0_23 , upvalues : base
    self:__ClearFadeTween();
    (self.resloader):Put2Pool()
    self.resloader = nil;
    ((self.ui).ultSkillVideo):SetParent(self.transform)
    if self.inputModeMaskUI ~= nil then
        (self.inputModeMaskUI):Delete()
        self.inputModeMaskUI = nil
    end
    (self.hudNode):Delete();
    (self.ultSkillNode):Delete();
    (self.playerSkillNode):Delete()
    if self.__hideAllUISequence ~= nil then
        (self.__hideAllUISequence):Rewind();
        (self.__hideAllUISequence):Kill()
        self.__hideAllUISequence = nil
    end
    (base.OnDelete)(self)
end

return UIBattleSkillModule


-- params : ...
-- function num : 0 , upvalues : _ENV
UIBaseWindow = class("UIBaseWindow", UIBaseNode)
local base = UIBaseNode
local cs_DoTween = ((CS.DG).Tweening).DOTween
local cs_Ease = ((CS.DG).Tweening).Ease
-- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

UIBaseWindow.ctor = function(self)
  -- function num : 0_0
  self.__typeID = nil
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

UIBaseWindow.GetUIWindowTypeId = function(self)
  -- function num : 0_1
  return self.__typeID
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

UIBaseWindow.Init = function(self, root)
  -- function num : 0_2 , upvalues : base
  self.__permanent = false
  ;
  (base.Init)(self, root)
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

UIBaseWindow.Delete = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.treeDCanvas ~= nil then
    DestroyUnityObject(self.treeDCanvas)
  end
  UIManager:DeleteWindow(self.__typeID)
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

UIBaseWindow.GetWindowSortingLayer = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local uiconfig = UIWindowGlobalConfig[self.__typeID]
  return UIManager:GetSortingLayerName(uiconfig.LayoutLevel + 1)
end

local cs_ScreenSpaceCamera = ((CS.UnityEngine).RenderMode).ScreenSpaceCamera
local cs_WorldSpace = ((CS.UnityEngine).RenderMode).WorldSpace
local cs_Canvas = (CS.UnityEngine).Canvas
local cs_UIManager = (CS.UIManager).Instance
-- DECOMPILER ERROR at PC45: Confused about usage of register: R7 in 'UnsetPending'

UIBaseWindow.AlignToFakeCamera = function(self, camera)
  -- function num : 0_5 , upvalues : _ENV, cs_Canvas, cs_ScreenSpaceCamera, cs_UIManager, cs_WorldSpace
  if self.canvas == nil then
    self.canvas = (camera.transform):GetComponentInChildren(typeof(cs_Canvas))
  end
  local canvasScale = (self.canvas):FindComponent(eUnityComponentID.CanvasScaler)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.canvas).worldCamera = camera
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.canvas).renderMode = cs_ScreenSpaceCamera
  cs_UIManager:AdaptationCanvasScaler(canvasScale, true)
  ;
  (self.transform):SetParent((self.canvas).transform, false)
  ;
  (cs_Canvas.ForceUpdateCanvases)()
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.canvas).renderMode = cs_WorldSpace
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.canvas).worldCamera = ((CS.UnityEngine).Camera).main
  cs_UIManager:SetNotchTransfrom(self.transform)
end

-- DECOMPILER ERROR at PC48: Confused about usage of register: R7 in 'UnsetPending'

UIBaseWindow.SetWindows2TreeDCanvas = function(self, layerID)
  -- function num : 0_6 , upvalues : _ENV, cs_UIManager, cs_ScreenSpaceCamera, cs_Canvas, cs_WorldSpace
  local coroutineFunc = function(objCanvas)
    -- function num : 0_6_0 , upvalues : self, _ENV, cs_UIManager, cs_ScreenSpaceCamera, cs_Canvas, cs_WorldSpace, layerID
    self.treeDCanvas = objCanvas
    local canvasScale = objCanvas:FindComponent(eUnityComponentID.CanvasScaler)
    local treeDCanvas = objCanvas:FindComponent(eUnityComponentID.Canvas)
    treeDCanvas.worldCamera = cs_UIManager.UICamera
    treeDCanvas.renderMode = cs_ScreenSpaceCamera
    cs_UIManager:AdaptationCanvasScaler(canvasScale, true)
    ;
    (self.transform):SetParent(treeDCanvas.transform, false)
    ;
    (cs_Canvas.ForceUpdateCanvases)()
    treeDCanvas.renderMode = cs_WorldSpace
    treeDCanvas.worldCamera = cs_UIManager.UICamera
    treeDCanvas.sortingLayerName = UIManager:GetSortingLayerName(layerID + 1)
    cs_UIManager:SetNotchTransfrom(self.transform)
  end

  UIManager:CreateThreeDCanvas(self.__typeID, coroutineFunc, (self.gameObject).name)
end

-- DECOMPILER ERROR at PC51: Confused about usage of register: R7 in 'UnsetPending'

UIBaseWindow.OnShow = function(self)
  -- function num : 0_7 , upvalues : cs_Ease
  if self.winTween ~= nil then
    (self.winTween):SetEase(cs_Ease.OutExpo)
    ;
    (self.winTween):Restart()
  else
    self:__InitTween()
  end
end

-- DECOMPILER ERROR at PC54: Confused about usage of register: R7 in 'UnsetPending'

UIBaseWindow.__InitTween = function(self)
  -- function num : 0_8 , upvalues : _ENV, cs_DoTween, cs_Ease
  if self.__typeID == nil then
    return 
  end
  local animaType = (UIWindowGlobalConfig[self.__typeID]).AnimaType
  if animaType == nil then
    return 
  end
  self.winTween = (cs_DoTween.Sequence)()
  if animaType == EUIAnimaType.Fade then
    (self.winTween):Append((((self.ui).canvasGroup):DOFade(0, 0.5)):From())
  else
    if animaType == EUIAnimaType.FadeScaleUp then
      (self.winTween):Append((((self.ui).canvasGroup):DOFade(0, 0.5)):From())
      ;
      (self.winTween):Join(((self.transform):DOScale(1.2, 0.5)):From())
    else
      if animaType == EUIAnimaType.FadeScaleDown then
        self._hasShowTweenMask = true
        self._showTweenIsPlayForward = true
        ;
        (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
        ;
        (self.winTween):Append((((self.ui).canvasGroup):DOFade(0, 0.5)):From())
        ;
        (self.winTween):Join(((self.transform):DOScale(0.4, 0.5)):From())
        ;
        (self.winTween):AppendCallback(function()
    -- function num : 0_8_0 , upvalues : self, _ENV
    if self._showTweenIsPlayForward then
      UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    else
      ;
      (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
    end
  end
)
      else
        if animaType == EUIAnimaType.ScaleUp then
          (self.winTween):Append(((self.transform):DOScale(1.2, 0.5)):From())
        end
      end
    end
  end
  ;
  (self.winTween):SetEase(cs_Ease.OutQuart)
  ;
  (self.winTween):SetAutoKill(false)
  -- DECOMPILER ERROR at PC123: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.winTween).target = self.transform
end

-- DECOMPILER ERROR at PC57: Confused about usage of register: R7 in 'UnsetPending'

UIBaseWindow.CloseTween = function(self, resloader)
  -- function num : 0_9 , upvalues : cs_Ease, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if (self.ui).canvasGroup ~= nil then
    ((self.ui).canvasGroup).blocksRaycasts = false
  end
  ;
  (self.winTween):SetEase(cs_Ease.InExpo)
  ;
  (self.winTween):OnRewind(function()
    -- function num : 0_9_0 , upvalues : self, _ENV, resloader
    if self._hasShowTweenMask then
      UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    end
    ;
    (self.winTween):Kill()
    self.winTween = nil
    UIManager:RecycleWindowEntity(resloader, self)
  end
)
  self._showTweenIsPlayForward = false
  ;
  (self.winTween):Complete()
  ;
  (self.winTween):PlayBackwards()
end

-- DECOMPILER ERROR at PC60: Confused about usage of register: R7 in 'UnsetPending'

UIBaseWindow.SwitchFakeCanvasScreen = function(self)
  -- function num : 0_10 , upvalues : cs_ScreenSpaceCamera
  if self.canvas == nil then
    return 
  end
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.canvas).renderMode = cs_ScreenSpaceCamera
end

-- DECOMPILER ERROR at PC63: Confused about usage of register: R7 in 'UnsetPending'

UIBaseWindow.SwitchFakeCanvasWorld = function(self)
  -- function num : 0_11 , upvalues : cs_WorldSpace
  if self.canvas == nil then
    return 
  end
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.canvas).renderMode = cs_WorldSpace
end

-- DECOMPILER ERROR at PC66: Confused about usage of register: R7 in 'UnsetPending'

UIBaseWindow.SetFromWhichUI = function(self, fromType)
  -- function num : 0_12
  self.fromType = fromType
end

-- DECOMPILER ERROR at PC69: Confused about usage of register: R7 in 'UnsetPending'

UIBaseWindow.OnCloseWin = function(self)
  -- function num : 0_13 , upvalues : _ENV
  if self.fromType == nil or self.fromType <= 0 then
    return 
  end
  do
    if self.fromType & eBaseWinFromWhere.home == eBaseWinFromWhere.home then
      local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
      if homeWin ~= nil then
        homeWin:BackFromOtherWin()
      end
    end
    do
      if self.fromType & eBaseWinFromWhere.homeCorver == eBaseWinFromWhere.homeCorver then
        local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
        if homeWin ~= nil then
          homeWin:BackFromOtherCoverWin()
        end
      end
      if self.fromType & eBaseWinFromWhere.jumpCorver == eBaseWinFromWhere.jumpCorver and self.jumpCorverArgs ~= nil then
        local JumpManager = require("Game.Jump.JumpManager")
        for _,win in pairs((self.jumpCorverArgs).hideWinList) do
          if win ~= nil and win.gameObject ~= nil then
            win:Show()
          end
        end
        if (self.jumpCorverArgs).befroeJumpCouldUseItemJump ~= nil then
          JumpManager.couldUseItemJump = (self.jumpCorverArgs).befroeJumpCouldUseItemJump
        end
      end
    end
  end
end

return UIBaseWindow


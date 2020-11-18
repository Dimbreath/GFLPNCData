-- params : ...
-- function num : 0 , upvalues : _ENV
UIBaseWindow = class("UIBaseWindow", UIBaseNode)
local base = UIBaseNode
-- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

UIBaseWindow.ctor = function(self)
  -- function num : 0_0
  self.__typeID = nil
end

-- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

UIBaseWindow.Init = function(self, root)
  -- function num : 0_1 , upvalues : base
  self.__permanent = false
  ;
  (base.Init)(self, root)
end

-- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

UIBaseWindow.Delete = function(self)
  -- function num : 0_2 , upvalues : _ENV
  UIManager:DeleteWindow(self.__typeID)
end

local cs_ScreenSpaceCamera = ((CS.UnityEngine).RenderMode).ScreenSpaceCamera
local cs_WorldSpace = ((CS.UnityEngine).RenderMode).WorldSpace
local cs_Canvas = (CS.UnityEngine).Canvas
-- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'

UIBaseWindow.AlignToFakeCamera = function(self, camera)
  -- function num : 0_3 , upvalues : _ENV, cs_Canvas, cs_ScreenSpaceCamera, cs_WorldSpace
  local cs_UIManager = (CS.UIManager).Instance
  if self.canvas == nil then
    self.canvas = (camera.transform):GetComponentInChildren(typeof(cs_Canvas))
  end
  local canvasScale = (self.canvas):FindComponent(eUnityComponentID.CanvasScaler)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.canvas).worldCamera = camera
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.canvas).renderMode = cs_ScreenSpaceCamera
  cs_UIManager:AdaptationCanvasScaler(canvasScale, true)
  ;
  (self.transform):SetParent((self.canvas).transform, false)
  ;
  (cs_Canvas.ForceUpdateCanvases)()
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.canvas).renderMode = cs_WorldSpace
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.canvas).worldCamera = ((CS.UnityEngine).Camera).main
  cs_UIManager:SetNotchTransfrom(self.transform)
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R4 in 'UnsetPending'

UIBaseWindow.OnShow = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self.__typeID ~= nil then
    local animaType = (UIWindowGlobalConfig[self.__typeID]).AnimaType
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

    if animaType == EUIAnimaType.Fade then
      ((self.ui).canvasGroup).alpha = 0
      ;
      (((self.ui).canvasGroup):DOFade(1, 0.8)):SetEase((((CS.DG).Tweening).Ease).OutExpo)
    else
      -- DECOMPILER ERROR at PC34: Confused about usage of register: R2 in 'UnsetPending'

      if animaType == EUIAnimaType.FadeScaleUp then
        ((self.ui).canvasGroup).alpha = 0
        ;
        (((self.ui).canvasGroup):DOFade(1, 0.8)):SetEase((((CS.DG).Tweening).Ease).OutExpo)
        -- DECOMPILER ERROR at PC55: Confused about usage of register: R2 in 'UnsetPending'

        ;
        (self.transform).localScale = (Vector3.New)(0.9, 0.9, 0.9)
        ;
        ((self.transform):DOScale(1, 0.8)):SetEase((((CS.DG).Tweening).Ease).OutExpo)
      else
        -- DECOMPILER ERROR at PC80: Confused about usage of register: R2 in 'UnsetPending'

        if animaType == EUIAnimaType.ScaleUp then
          (self.transform).localScale = (Vector3.New)(0.9, 0.9, 0.9)
          ;
          ((self.transform):DOScale(1, 0.8)):SetEase((((CS.DG).Tweening).Ease).OutExpo)
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R4 in 'UnsetPending'

UIBaseWindow.SwitchFakeCanvasScreen = function(self)
  -- function num : 0_5 , upvalues : cs_ScreenSpaceCamera
  if self.canvas == nil then
    return 
  end
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.canvas).renderMode = cs_ScreenSpaceCamera
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R4 in 'UnsetPending'

UIBaseWindow.SwitchFakeCanvasWorld = function(self)
  -- function num : 0_6 , upvalues : cs_WorldSpace
  if self.canvas == nil then
    return 
  end
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.canvas).renderMode = cs_WorldSpace
end

return UIBaseWindow


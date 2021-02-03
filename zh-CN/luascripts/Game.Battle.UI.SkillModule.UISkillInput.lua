-- params : ...
-- function num : 0 , upvalues : _ENV
local UISkillInput = class("UISkillInput", UIBaseNode)
local base = UIBaseNode
local csInputUtility = CS.InputUtility
UISkillInput.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_cancle, self, self.__onClick)
  self.cancleButton = (self.ui).btn_cancle
  self.onButtonImageChanged = BindCallback(self, self.__onButtonImageChanged)
end

UISkillInput.OnShow = function(self)
  -- function num : 0_1 , upvalues : _ENV
  ((self.ui).messageTips):SetActive(true)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_cancle).color = (self.ui).img_cancle_normalColor
  if self.detectedButtonChangedTimer == nil then
    self.detectedButtonChangedTimer = TimerManager:GetTimer(0.1, self.onButtonImageChanged, self, false, false, true)
  end
  ;
  (self.detectedButtonChangedTimer):Start()
end

UISkillInput.__onButtonImageChanged = function(self)
  -- function num : 0_2 , upvalues : csInputUtility, _ENV
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  if (csInputUtility.OverUIValidTag)(TagConsts.ValidTarget) then
    ((self.ui).img_cancle).color = (self.ui).img_cancle_HighlightColor
  else
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_cancle).color = (self.ui).img_cancle_normalColor
  end
end

UISkillInput.OnHide = function(self)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).img_cancle).color = (self.ui).img_cancle_normalColor
  if self.detectedButtonChangedTimer ~= nil then
    (self.detectedButtonChangedTimer):Stop()
    self.detectedButtonChangedTimer = nil
  end
  ;
  ((self.ui).messageTips):SetActive(false)
end

UISkillInput.InjectCancleInputAction = function(self, cancleFunc)
  -- function num : 0_4
  self.cancleFunc = cancleFunc
end

UISkillInput.__onClick = function(self)
  -- function num : 0_5
  if self.cancleFunc ~= nil then
    (self.cancleFunc)()
  end
end

UISkillInput.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
  if self.detectedButtonChangedTimer ~= nil then
    (self.detectedButtonChangedTimer):Stop()
    self.detectedButtonChangedTimer = nil
  end
end

return UISkillInput


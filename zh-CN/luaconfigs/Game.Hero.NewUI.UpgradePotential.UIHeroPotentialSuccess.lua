-- params : ...
-- function num : 0 , upvalues : _ENV
local UIHeroPotentialSuccess = class("UIHeroPotentialSuccess", UIBaseWindow)
local base = UIBaseWindow
UIHeroPotentialSuccess.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.Push2BackStack)(self, self.OnBtnCloseClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnClickClose)
end

UIHeroPotentialSuccess.OnInitHeroLimitUpSuccess = function(self, curLimit, nextLimit, heroId)
  -- function num : 0_1 , upvalues : _ENV
  AudioManager:PlayAudioById(1074)
  local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
  cvCtr:PlayCv(heroId, eVoiceType.LEVELUP)
  ;
  ((self.ui).uiAdapter):AdaptBgUI()
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_CurLimit).text = tostring(curLimit or 0)
  if nextLimit ~= nil then
    ((self.ui).tex_NextLimit):SetIndex(0, tostring(nextLimit))
  else
    ;
    ((self.ui).tex_NextLimit):SetIndex(1)
  end
end

UIHeroPotentialSuccess.SetBtnCloseAction = function(self, action)
  -- function num : 0_2
  self.onBtnCloseAction = action
end

UIHeroPotentialSuccess.OnClickClose = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (UIUtil.OnClickBack)()
end

UIHeroPotentialSuccess.OnBtnCloseClick = function(self)
  -- function num : 0_4
  do
    if self.onBtnCloseAction ~= nil then
      local bindFunc = self.onBtnCloseAction
      self.onBtnCloseActio = nil
      bindFunc()
    end
    self:Delete()
  end
end

UIHeroPotentialSuccess.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UIHeroPotentialSuccess


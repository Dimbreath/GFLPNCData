-- params : ...
-- function num : 0 , upvalues : _ENV
local UILoading = class("UILoading", UIBaseWindow)
local base = UIBaseWindow
UILoading.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.__permanent = true
  self.onProgressRefresh = BindCallback(self, self.RefreshSceneProgress)
  MsgCenter:AddListener(eMsgEventId.OnSceneLoadingProgress, self.onProgressRefresh)
end

UILoading.RefreshSceneProgress = function(self, value)
  -- function num : 0_1 , upvalues : _ENV
  local p = value * 100
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_Bar).fillAmount = value
  ;
  ((self.ui).tex_Info):SetIndex(0, tostring((Mathf.Ceil)(p)))
end

UILoading.OnDelete = function(self)
  -- function num : 0_2 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnSceneLoadingProgress, self.onProgressRefresh)
  ;
  (base.OnDelete)(self)
end

return UILoading


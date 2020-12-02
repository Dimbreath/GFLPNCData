-- params : ...
-- function num : 0 , upvalues : _ENV
local UISkillInput = class("UISkillInput", UIBaseNode)
local base = UIBaseNode
UISkillInput.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_cancle, self, self.__onClick)
  self.cancleButton = (self.ui).btn_cancle
end

UISkillInput.OnShow = function(self)
  -- function num : 0_1
  ((self.ui).messageTips):SetActive(true)
end

UISkillInput.OnHide = function(self)
  -- function num : 0_2
  ((self.ui).messageTips):SetActive(false)
end

UISkillInput.InjectCancleInputAction = function(self, cancleFunc)
  -- function num : 0_3
  self.cancleFunc = cancleFunc
end

UISkillInput.__onClick = function(self)
  -- function num : 0_4
  if self.cancleFunc ~= nil then
    (self.cancleFunc)()
  end
end

return UISkillInput


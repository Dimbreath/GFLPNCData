local UICommonRename = class("UICommonRename", UIBaseWindow)
local base = UIBaseWindow
UICommonRename.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).buttonNo, self, self.OnBtnNoClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).buttonYes, self, self.OnBtnYesClicked)
end

UICommonRename.InitCommonRename = function(self, yesAction, cancelAction)
  -- function num : 0_1
  self.__yesAction = yesAction
  self.__cancelAction = cancelAction
end

UICommonRename.InitRenameUIArg = function(self)
  -- function num : 0_2
end

UICommonRename.OnBtnYesClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local inputName = ((self.ui).input_Name).text
  if (string.IsNullOrEmpty)(inputName) then
    ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(53))
    return 
  end
  if self.__yesAction ~= nil then
    (self.__yesAction)(inputName)
  end
end

UICommonRename.OnBtnNoClicked = function(self)
  -- function num : 0_4
  do
    if self.__cancelAction ~= nil then
      local cancelAction = self.__cancelAction
      self.__cancelAction = nil
      cancelAction()
    end
    self:Delete()
  end
end

UICommonRename.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UICommonRename


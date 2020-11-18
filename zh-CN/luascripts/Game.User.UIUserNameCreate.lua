-- params : ...
-- function num : 0 , upvalues : _ENV
local UIUserNameCreate = class("UIUserNameModify", UIBaseWindow)
UIUserNameCreate.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_RandomName, self, self.OnclickRandomNameBtn)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnClickCreateUserConfirm)
end

UIUserNameCreate.BindUIUserNameAction = function(self, nextAction)
  -- function num : 0_1
  self.nextAction = nextAction
end

UIUserNameCreate.OnclickRandomNameBtn = function(self)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).input_UserName).text = self:GengrateRandomName()
end

UIUserNameCreate.GengrateRandomName = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local famulyName = require("LuaConfigs.player_familyName")
  local firstName = require("LuaConfigs.player_firstName")
  ;
  (math.randomseed)((os.time)())
  local num1 = (math.random)(#famulyName)
  local num2 = (math.random)(#firstName)
  local arg1 = (LanguageUtil.GetLocaleText)((famulyName[num1]).family_name)
  local arg2 = (LanguageUtil.GetLocaleText)((firstName[num2]).first_name)
  return arg1 .. arg2
end

UIUserNameCreate.OnClickCreateUserConfirm = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local inputUserName = ((self.ui).input_UserName).text
  if (string.IsNullOrEmpty)(inputUserName) then
    ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(53))
    return 
  end
  ;
  (NetworkManager:GetNetwork(NetworkTypeID.Object)):CS_User_UserNameModify(inputUserName, function()
    -- function num : 0_4_0 , upvalues : self
    self:Delete()
    if self.nextAction ~= nil then
      (self.nextAction)()
    end
  end
)
end

return UIUserNameCreate


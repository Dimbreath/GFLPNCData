local UINCDKeyPanelNode = class("UINCDKeyPanelNode", UIBaseNode)
local cs_MessageCommon = CS.MessageCommon
UINCDKeyPanelNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_cDKey, self, self.EnterCDKey)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).btn_cDKey).onInCDCallBack = BindCallback(self.OnBtnInCDClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_systemCopy, self, self.EnterSystemCopy)
  self:RefreshText2Empty()
end

UINCDKeyPanelNode.EnterCDKey = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self.inputCDkey = ((self.ui).input_cDkey).text
  if (string.IsNullOrEmpty)(self.inputCDkey) then
    self:ShowErrorTips()
  else
    ;
    (NetworkManager:GetNetwork(NetworkTypeID.CDKey)):SendCDKRedeem(self.inputCDkey)
  end
end

UINCDKeyPanelNode.OnBtnInCDClick = function(self)
  -- function num : 0_2 , upvalues : cs_MessageCommon, _ENV
  (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(195))
end

UINCDKeyPanelNode.EnterSystemCopy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local copyCDKey = ((CS.UnityEngine).GUIUtility).systemCopyBuffer
  if (string.IsNullOrEmpty)(copyCDKey) then
    return 
  end
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).input_cDkey).text = copyCDKey
end

UINCDKeyPanelNode.ShowErrorTips = function(self, errorCode)
  -- function num : 0_4 , upvalues : cs_MessageCommon, _ENV
  local errorStr = self:TranslationErrorCode(errorCode)
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Failed).text = errorStr
  ;
  (cs_MessageCommon.ShowMessageTips)(errorStr, true)
  local isALREADY = errorCode == proto_csmsg_ErrorCode.CDK_NOT_SURPLUS
  local isINVALID = errorCode == proto_csmsg_ErrorCode.CDK_HAS_EXCHANGED
  local isEXPIRED = errorCode == proto_csmsg_ErrorCode.CDK_TIME_EXCEEDED
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R6 in 'UnsetPending'

  if not isALREADY and not isINVALID and not isEXPIRED then
    ((self.ui).input_cDkey).text = self.inputCDkey
  else
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R6 in 'UnsetPending'

    ((self.ui).input_cDkey).text = ""
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

UINCDKeyPanelNode.TranslationErrorCode = function(self, ret)
  -- function num : 0_5 , upvalues : _ENV
  local tipId = 193
  if ret == proto_csmsg_ErrorCode.CDK_NOT_SURPLUS then
    tipId = 191
  else
    if ret == proto_csmsg_ErrorCode.CDK_HAS_EXCHANGED then
      tipId = 190
    else
      if ret == proto_csmsg_ErrorCode.CDK_TIME_EXCEEDED then
        tipId = 192
      end
    end
  end
  return ConfigData:GetTipContent(tipId)
end

UINCDKeyPanelNode.RefreshText2Empty = function(self)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).tex_Failed).text = ""
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).input_cDkey).text = ""
end

return UINCDKeyPanelNode


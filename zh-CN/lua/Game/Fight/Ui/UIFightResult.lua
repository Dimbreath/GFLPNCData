local ShieldDuration = 2
local cs_ResLoader = CS.ResLoader
local DormFightConst = require("Game.Fight.DormFightConst")
local UIFightUserHeadNode = require("Game.Fight.Ui.UIFightUserHeadNode")
local UIFightResult = class("UIFightResult", UIBaseWindow)
UIFightResult.OnInit = function(self)
  -- function num : 0_0 , upvalues : cs_ResLoader, UIFightUserHeadNode, _ENV
  self._resLoader = (cs_ResLoader.Create)()
  self._closeTime = 0
  self._headNode = (UIFightUserHeadNode.New)()
  ;
  (self._headNode):Init((self.ui).head, self._resLoader)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.OnReturnBtnClick)
end

UIFightResult.SetResult = function(self, userInfo, resultType)
  -- function num : 0_1 , upvalues : _ENV, ShieldDuration
  if userInfo == nil then
    return 
  end
  self._closeTime = Time.realtimeSinceStartup + ShieldDuration
  ;
  (self._headNode):RefreshUserHead(userInfo:GetAvatarId())
  ;
  (self._headNode):RefreshUserHeadFrame(userInfo:GetAvatarFrameId())
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).txt_UserName).text = userInfo:GetUserName()
  ;
  ((self.ui).img_ResultIcon):SetIndex(resultType - 1)
  ;
  ((self.ui).txt_Result):SetIndex(resultType - 1)
end

UIFightResult.OnReturnBtnClick = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if Time.realtimeSinceStartup <= self._closeTime then
    return 
  end
  local dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight, true)
  dormFightCtrl:ExitScene()
end

UIFightResult.OnDelete = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (UIBaseWindow.OnDelete)(self)
  if self._resLoader ~= nil then
    (self._resLoader):Put2Pool()
    self._resLoader = nil
  end
end

return UIFightResult


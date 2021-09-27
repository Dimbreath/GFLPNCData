local cs_ResLoader = CS.ResLoader
local UIFightUserHeadNode = require("Game.Fight.Ui.UIFightUserHeadNode")
local UIFightStart = class("UIFightStart", UIBaseWindow)
UIFightStart.OnInit = function(self)
  -- function num : 0_0 , upvalues : cs_ResLoader, UIFightUserHeadNode, _ENV
  self._resLoader = (cs_ResLoader.Create)()
  self._leftHead = (UIFightUserHeadNode.New)()
  ;
  (self._leftHead):Init((self.ui).leftHead, self._resLoader)
  self._rightHead = (UIFightUserHeadNode.New)()
  ;
  (self._rightHead):Init((self.ui).rightHead, self._resLoader)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Start, self, self.OnStartBtnClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.OnReturnBtnClick)
end

UIFightStart.Refresh = function(self, myUserInfo, opUserInfo)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  if myUserInfo ~= nil then
    ((self.ui).txt_LeftName).text = myUserInfo:GetUserName()
    ;
    (self._leftHead):RefreshUserHead(myUserInfo:GetAvatarId())
    ;
    (self._leftHead):RefreshUserHeadFrame(myUserInfo:GetAvatarFrameId())
  end
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

  if opUserInfo ~= nil then
    ((self.ui).txt_RightName).text = opUserInfo:GetUserName()
    ;
    (self._rightHead):RefreshUserHead(opUserInfo:GetAvatarId())
    ;
    (self._rightHead):RefreshUserHeadFrame(opUserInfo:GetAvatarFrameId())
  end
end

UIFightStart.OnStartBtnClick = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight, true)
  dormFightCtrl:StartFight()
  self:Delete()
end

UIFightStart.OnReturnBtnClick = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight, true)
  dormFightCtrl:ExitScene()
end

UIFightStart.OnDelete = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (UIBaseWindow.OnDelete)(self)
  if self._resLoader ~= nil then
    (self._resLoader):Put2Pool()
    self._resLoader = nil
  end
end

return UIFightStart


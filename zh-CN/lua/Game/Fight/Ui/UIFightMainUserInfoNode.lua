local UIFightUserHeadNode = require("Game.Fight.Ui.UIFightUserHeadNode")
local UIFightMainScorePoint = class("UIFightMainScorePoint", UIBaseNode)
UIFightMainScorePoint.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIFightMainScorePoint.SetActive = function(self, active)
  -- function num : 0_1
  (((self.ui).winCount).gameObject):SetActive(active)
end

local UIFightMainUserInfoNode = class("UIFightMainUserInfoNode", UIBaseNode)
UIFightMainUserInfoNode.OnInit = function(self)
  -- function num : 0_2 , upvalues : _ENV, UIFightUserHeadNode, UIFightMainScorePoint
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self._headNode = (UIFightUserHeadNode.New)()
  ;
  (self._headNode):Init((self.ui).head, self._resLoader)
  self._itemPool = (UIItemPool.New)(UIFightMainScorePoint, (self.ui).score)
  self._scoreItems = {}
end

UIFightMainUserInfoNode.Init = function(self, root, resLoader)
  -- function num : 0_3 , upvalues : _ENV
  self._resLoader = resLoader
  ;
  (UIBaseNode.Init)(self, root)
end

UIFightMainUserInfoNode.SetUserInfo = function(self, userInfo)
  -- function num : 0_4
  if userInfo == nil then
    return 
  end
  ;
  (self._headNode):RefreshUserHead(userInfo:GetAvatarId())
  ;
  (self._headNode):RefreshUserHeadFrame(userInfo:GetAvatarFrameId())
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).txt_UserName).text = userInfo:GetUserName() or ""
end

UIFightMainUserInfoNode.SetScore = function(self, score, scoreMax)
  -- function num : 0_5 , upvalues : _ENV
  if scoreMax ~= #self._scoreItems then
    self:RebuildScoreItem(scoreMax)
  end
  for index,item in ipairs(self._scoreItems) do
    item:SetActive(index <= score)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIFightMainUserInfoNode.RebuildScoreItem = function(self, count)
  -- function num : 0_6 , upvalues : _ENV
  (self._itemPool):HideAll()
  self._scoreItems = {}
  for _ = 1, count do
    local item = (self._itemPool):GetOne()
    ;
    (table.insert)(self._scoreItems, item)
  end
end

UIFightMainUserInfoNode.Dispose = function(self)
  -- function num : 0_7
  if self._itemPool ~= nil then
    (self._itemPool):DeleteAll()
    self._itemPool = nil
  end
end

return UIFightMainUserInfoNode


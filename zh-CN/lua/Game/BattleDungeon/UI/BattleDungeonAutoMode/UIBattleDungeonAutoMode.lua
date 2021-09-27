local UIBattleDungeonAutoMode = class("UIBattleDungeonAutoMode", UIBaseWindow)
local base = UIBaseWindow
local UINBattleDungeonAutoResult = require("Game.BattleDungeon.UI.BattleDungeonAutoMode.UINBattleDungeonAutoResult")
local UINBattleDungeonAutoStart = require("Game.BattleDungeon.UI.BattleDungeonAutoMode.UINBattleDungeonAutoStart")
UIBattleDungeonAutoMode.OnInit = function(self)
  -- function num : 0_0 , upvalues : UINBattleDungeonAutoStart, UINBattleDungeonAutoResult, _ENV
  self.autoSetClass = (UINBattleDungeonAutoStart.New)()
  ;
  (self.autoSetClass):Init((self.ui).autoBattle)
  ;
  (self.autoSetClass):Hide()
  self.autoResultClass = (UINBattleDungeonAutoResult.New)()
  ;
  (self.autoResultClass):Init((self.ui).autoResult)
  ;
  (self.autoResultClass):Hide()
  self.__OnClickClose = BindCallback(self, self.OnClickClose)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnClickClose)
  self.__OnBattleStart = BindCallback(self, self.OnBattleStart)
  ;
  (UIUtil.HideTopStatus)()
end

UIBattleDungeonAutoMode.InitDungeonAutoSet = function(self, dungeonCfg, callback)
  -- function num : 0_1
  (self.autoResultClass):Hide()
  ;
  (self.autoSetClass):Show()
  ;
  (self.autoSetClass):InitAutoStart(dungeonCfg, self.__OnBattleStart)
  self.startcallback = callback
  self.closeCallback = nil
end

UIBattleDungeonAutoMode.InitDungeonAutoRes = function(self, dungeonCfg, count, rewardDic, ath, callback)
  -- function num : 0_2
  (self.autoSetClass):Hide()
  ;
  (self.autoResultClass):Show()
  ;
  (self.autoResultClass):InitAutoResult(dungeonCfg, count, rewardDic, ath, self.__OnClickClose)
  self.startcallback = nil
  self.closeCallback = callback
end

UIBattleDungeonAutoMode.OnClickClose = function(self)
  -- function num : 0_3
  self:Delete()
  if self.closeCallback then
    (self.closeCallback)()
  end
end

UIBattleDungeonAutoMode.OnBattleStart = function(self, count)
  -- function num : 0_4
  self:Delete()
  if self.startcallback ~= nil then
    (self.startcallback)(count)
  end
end

UIBattleDungeonAutoMode.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base, _ENV
  (base.OnDelete)(self)
  ;
  (self.autoSetClass):Delete()
  ;
  (self.autoResultClass):Delete()
  ;
  (UIUtil.ReShowTopStatus)()
end

return UIBattleDungeonAutoMode


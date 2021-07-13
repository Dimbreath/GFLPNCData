-- params : ...
-- function num : 0 , upvalues : _ENV
local UINEpResFlyAniPanel = class("UINEpResFlyAniPanel", UIBaseNode)
local UINEpResFlyAniItem = require("Game.CommonUI.DungeonState.ResFly.UINEpResFlyAniItem")
UINEpResFlyAniPanel.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINEpResFlyAniItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.particlePool = (UIItemPool.New)(UINEpResFlyAniItem, (self.ui).particleItem)
  ;
  ((self.ui).particleItem):SetActive(false)
  ;
  (self.particlePool):HideAll()
  self.__OnResFlyAniOver = BindCallback(self, self.OnResFlyAniOver)
end

UINEpResFlyAniPanel.StartNewResFlyAni = function(self, itemId, startPos, targetPos, count)
  -- function num : 0_1
  local resflyAni = (self.particlePool):GetOne()
  resflyAni:InitResFlyAniItem(itemId, startPos, targetPos, self.__OnResFlyAniOver, count)
end

UINEpResFlyAniPanel.OnResFlyAniOver = function(self, item)
  -- function num : 0_2
  (self.particlePool):HideOne(item)
end

return UINEpResFlyAniPanel


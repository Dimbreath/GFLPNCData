-- params : ...
-- function num : 0 , upvalues : _ENV
local UIMessageSide = class("UIMessageSide", UIBaseWindow)
local base = UIBaseWindow
local UITipsCacheItem = require("Game.Message.Side.UITipsCacheItem")
local util = require("XLua.Common.xlua_util")
local eCacheState = require("Game.Message.Side.eCacheState")
local cs_WaitForFixedUpdate = (CS.UnityEngine).WaitForFixedUpdate
UIMessageSide.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UITipsCacheItem
  self._cacheItemPool = (UIItemPool.New)(UITipsCacheItem, (self.ui).obj_TipsItem)
  ;
  ((self.ui).obj_TipsItem):SetActive(false)
  self.msgDataList = {}
  self.curShowItemList = {}
  self.__update__handle = BindCallback(self, self.__OnCoroutinePlay)
  UpdateManager:AddFixedUpdate(self.__update__handle)
end

UIMessageSide.ShowTips = function(self, content, waitSecond, tipsType, cachePlay)
  -- function num : 0_1 , upvalues : _ENV
  local msgData = {tipsType = tipsType, content = content, waitTime = waitSecond or 1.5}
  if cachePlay then
    (table.insert)(self.msgDataList, msgData)
  else
    self:_ShowCacheItem(msgData)
  end
end

UIMessageSide._ShowCacheItem = function(self, msgData)
  -- function num : 0_2 , upvalues : _ENV
  local cacheItem = nil
  if #self.curShowItemList <= 2 then
    cacheItem = (self._cacheItemPool):GetOne()
  else
    cacheItem = (table.remove)(self.curShowItemList, 1)
  end
  cacheItem:InitTipsCacheItem(msgData)
  ;
  (table.insert)(self.curShowItemList, cacheItem)
  self._lastItem = cacheItem
end

UIMessageSide.__OnCoroutinePlay = function(self)
  -- function num : 0_3 , upvalues : _ENV
  do
    while #self.msgDataList > 0 and self:IsCanStart() do
      local msgData = (table.remove)(self.msgDataList, 1)
      self:_ShowCacheItem(msgData)
    end
    do
      if self:IsCanStart() and #self.curShowItemList > 0 then
        local cacheItem = (table.remove)(self.curShowItemList, 1)
        ;
        (self._cacheItemPool):HideOne(cacheItem)
      end
      if #self.curShowItemList <= 0 then
        self:Delete()
      end
    end
  end
end

UIMessageSide.IsCanStart = function(self)
  -- function num : 0_4 , upvalues : eCacheState
  do return self._lastItem == nil or (self._lastItem).curState == eCacheState.Useless end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIMessageSide.OnDelete = function(self)
  -- function num : 0_5 , upvalues : _ENV, base
  UpdateManager:RemoveFixedUpdate(self.__update__handle)
  ;
  (self._cacheItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UIMessageSide


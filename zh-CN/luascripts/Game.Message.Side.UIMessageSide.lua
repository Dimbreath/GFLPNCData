-- params : ...
-- function num : 0 , upvalues : _ENV
local UIMessageSide = class("UIMessageSide", UIBaseWindow)
local base = UIBaseWindow
local UITipsCacheItem = require("Game.Message.Side.UITipsCacheItem")
local util = require("XLua.Common.xlua_util")
local cs_WaitForSeconds = (CS.UnityEngine).WaitForSeconds
UIMessageSide.OnInit = function(self)
  -- function num : 0_0 , upvalues : UITipsCacheItem, _ENV
  self.tipsCacheItem = (UITipsCacheItem.New)()
  ;
  (self.tipsCacheItem):Init((self.ui).obj_TipsItem)
  ;
  (self.tipsCacheItem):Hide()
  self.__onItemAnimaComplete = BindCallback(self, self.__OnItemAnimaComplete)
  ;
  (self.tipsCacheItem):SetCompleteAction(self.__onItemAnimaComplete)
  self.msgList = {}
end

UIMessageSide.ShowTips = function(self, content, waitSecond, sideType)
  -- function num : 0_1 , upvalues : _ENV, util
  self.waitSecond = waitSecond or 1.5
  local tipsData = {}
  tipsData.type = sideType
  tipsData.content = content
  ;
  (table.insert)(self.msgList, tipsData)
  if self.__playCoroutine == nil then
    self.__playCoroutine = (GR.StartCoroutine)((util.cs_generator)(BindCallback(self, self.__OnCoroutinePlay)))
  end
end

UIMessageSide.__OnCoroutinePlay = function(self)
  -- function num : 0_2 , upvalues : _ENV, cs_WaitForSeconds
  do
    while #self.msgList > 0 do
      local tipsData = (table.remove)(self.msgList, 1)
      ;
      (self.tipsCacheItem):InitTipsCacheData(tipsData)
      ;
      (self.tipsCacheItem):Show()
      while not self.itemAnimaComplete do
        (coroutine.yield)(cs_WaitForSeconds(self.waitSecond))
      end
      ;
      (self.tipsCacheItem):Hide()
      self.itemAnimaComplete = false
    end
    self.__playCoroutine = nil
    self:Delete()
  end
end

UIMessageSide.__OnItemAnimaComplete = function(self, isComplete)
  -- function num : 0_3
  self.itemAnimaComplete = isComplete
end

UIMessageSide.OnDelete = function(self)
  -- function num : 0_4 , upvalues : _ENV, base
  if self.__playCoroutine ~= nil then
    (GR.StopCoroutine)(self.__playCoroutine)
    self.__playCoroutine = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIMessageSide


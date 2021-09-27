local UIGiftPageDetail = class("UIGiftPageDetail", UIBaseWindow)
local base = UIBaseWindow
local UINGiftPageDetail = require("Game.QuickPurchaseBox.UINGiftPageDetail")
UIGiftPageDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINGiftPageDetail
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnClickGiftPageClose)
  ;
  (UIUtil.AddButtonListener)((self.ui).background, self, self.OnClickGiftPageClose)
  ;
  (UIUtil.HideTopStatus)()
  self.giftPagePool = (UIItemPool.New)(UINGiftPageDetail, (self.ui).giftPageDetailItem)
  ;
  ((self.ui).giftPageDetailItem):SetActive(false)
end

UIGiftPageDetail.InitGiftPageDetail = function(self, payGiftInfo)
  -- function num : 0_1 , upvalues : _ENV
  local flag, giftCfg, allDay = payGiftInfo:TryGetGiftSubscriptionCfg()
  if not flag then
    error("这个礼包不存在订阅项 id is " .. tostring((payGiftInfo.groupCfg).id))
    return 
  end
  local timepassCtr = ControllerManager:GetController(ControllerTypeId.TimePass, true)
  local counterEl = timepassCtr:getCounterElemData(proto_object_CounterModule.CounterModuleGiftReset, giftCfg.id)
  local receivedDay = 0
  local isRuning = false
  if counterEl ~= nil and PlayerDataCenter.timestamp < counterEl.nextExpiredTm then
    isRuning = true
    receivedDay = allDay - (math.floor)((counterEl.nextExpiredTm - PlayerDataCenter.timestamp) / 86400)
  end
  ;
  ((self.ui).tex_Tips):SetIndex(0, tostring(allDay))
  ;
  ((self.ui).progress):SetActive(isRuning)
  ;
  ((self.ui).tex_progress):SetIndex(0, tostring(receivedDay), tostring(allDay))
  ;
  (self.giftPagePool):HideAll()
  local itemList = {}
  for i,itemId in ipairs(giftCfg.awardIds) do
    local itemCfg = (ConfigData.item)[itemId]
    ;
    (table.insert)(itemList, {itemCfg = itemCfg, count = (giftCfg.awardCounts)[i]})
  end
  for i = 1, allDay do
    local item = (self.giftPagePool):GetOne()
    item:InitGiftPageItem(i, itemList, i <= receivedDay, isRuning)
  end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIGiftPageDetail.OnClickGiftPageClose = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:Delete()
  ;
  (UIUtil.ReShowTopStatus)()
end

return UIGiftPageDetail


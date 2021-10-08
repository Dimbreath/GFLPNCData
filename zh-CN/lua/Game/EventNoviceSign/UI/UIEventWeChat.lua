local UIEventWeChat = class("UIEventWeChat", UIBaseWindow)
local base = UIBaseWindow
local UIItemPool = require("Game.CommonUI.UIItemPool")
local UINEventWeChatItem = require("Game.EventNoviceSign.UI.UINEventWeChatItem")
UIEventWeChat.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIItemPool, UINEventWeChatItem
  self.resloader = ((CS.ResLoader).Create)()
  self.itemPool = (UIItemPool.New)(UINEventWeChatItem, (self.ui).item)
  ;
  ((self.ui).item):SetActive(false)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GetReward, self, self.GetRewardClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CopyKey, self, self.CopyKeyClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Info, self, self.OnClickInfo)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_QRCode, self, self.QRCodeClicked)
  self.WechatUpdata = BindCallback(self, self.__WechatUpdata)
  MsgCenter:AddListener(eMsgEventId.WechatUpdata, self.WechatUpdata)
end

UIEventWeChat.InitWeChat = function(self, id)
  -- function num : 0_1 , upvalues : _ENV
  self.actId = id
  self.data = (ConfigData.wechat_activity)[id]
  self.actFrameCtr = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  if self.actFrameCtr == nil then
    error("微信关注活动页面获取不到活动控制器！")
  end
  self.states = ((self.actFrameCtr).wechatActivityElems)[self.actId]
  ;
  (self.itemPool):HideAll()
  for k,v in pairs((self.data).awardIds) do
    local item = (self.itemPool):GetOne()
    local itemCfg = (ConfigData.item)[v]
    local itemNums = ((self.data).awardCounts)[k]
    item:InitWeChatItem(itemCfg, v, itemNums, self.resloader)
  end
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Key).text = (self.states).token
  self:RefreshNoviceSign()
end

UIEventWeChat.GetRewardClicked = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local actFrameCtr = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  actFrameCtr:CS_ACTIVITY_Wechat_Follow_Take(self.actId, BindCallback(self, self.RewardClickedBack))
end

UIEventWeChat.RewardClickedBack = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_3_0 , upvalues : self
    if window == nil then
      return 
    end
    window:InitRewardsItem((self.data).awardIds, (self.data).awardCounts, self._heroIdSnapShoot, false, true)
  end
)
  self:RefreshNoviceSign()
end

UIEventWeChat.__WechatUpdata = function(self)
  -- function num : 0_4
  self.states = ((self.actFrameCtr).wechatActivityElems)[self.actId]
  self:RefreshNoviceSign()
end

UIEventWeChat.RefreshNoviceSign = function(self)
  -- function num : 0_5
  if (self.states).followed == false then
    ((self.ui).btn_CantGetReward):SetActive(true)
    ;
    ((self.ui).tex_CantGetReward):SetIndex(0)
    ;
    (((self.ui).btn_GetReward).gameObject):SetActive(false)
  else
    if (self.states).followed == true and (self.states).redeemed == true then
      ((self.ui).btn_CantGetReward):SetActive(true)
      ;
      ((self.ui).tex_CantGetReward):SetIndex(1)
      ;
      (((self.ui).btn_GetReward).gameObject):SetActive(false)
    else
      ;
      ((self.ui).btn_CantGetReward):SetActive(false)
      ;
      (((self.ui).btn_GetReward).gameObject):SetActive(true)
    end
  end
  if (self.states).redeemed == false then
    self:RefreshItem(false)
  else
    self:RefreshItem(true)
  end
end

UIEventWeChat.CopyKeyClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ((CS.UnityEngine).GUIUtility).systemCopyBuffer = ((self.ui).tex_Key).text
  ;
  ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(TipContent.UserInfo_CopyUIDDone))
  AudioManager:PlayAudioById(1124)
end

UIEventWeChat.RefreshItem = function(self, hasGet)
  -- function num : 0_7 , upvalues : _ENV
  for i,v in ipairs((self.itemPool).listItem) do
    v:RefreshItem(hasGet)
  end
end

UIEventWeChat.OnClickInfo = function(self)
  -- function num : 0_8 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.EventWeChatInformation, function(window)
    -- function num : 0_8_0
    window:InitWeChatInfo()
  end
)
end

UIEventWeChat.QRCodeClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.EventWeChatViewQRCode)
end

UIEventWeChat.SetCloseCallback = function(self, callback)
  -- function num : 0_10
end

UIEventWeChat.OnDelete = function(self)
  -- function num : 0_11 , upvalues : _ENV, base
  (self.itemPool):DeleteAll()
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.WechatUpdata, self.WechatUpdata)
  ;
  (base.OnDelete)(self)
end

return UIEventWeChat


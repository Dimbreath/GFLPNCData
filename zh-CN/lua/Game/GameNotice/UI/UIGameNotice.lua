local UIGameNotice = class("UIGameNotice", UIBaseWindow)
local base = UIBaseWindow
local UINGameNoticeType = require("Game.GameNotice.UI.UINGameNoticeType")
local UINGameNoticeTag = require("Game.GameNotice.UI.UINGameNoticeTag")
local UINGameNoticeBannerItem = require("Game.GameNotice.UI.UINGameNoticeBannerItem")
local UINWebViewItem = require("Game.GameNotice.UI.UINWebViewItem")
local GameNoticEnum = require("Game.GameNotice.GameNoticEnum")
local JumpManager = require("Game.Jump.JumpManager")
UIGameNotice.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, GameNoticEnum, UINGameNoticeTag, UINGameNoticeBannerItem
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self._OnGameNoticeClose)
  self.typeList = {(GameNoticEnum.eNoticType).system, (GameNoticEnum.eNoticType).activity}
  self.typeItemDic = {}
  self._onTypeItemClick = BindCallback(self, self._OnTypeItemClick)
  self._onTagItemClick = BindCallback(self, self._OnTagItemClick)
  self._onTagItemPool = (UIItemPool.New)(UINGameNoticeTag, (self.ui).obj_noticeItem)
  ;
  ((self.ui).obj_noticeItem):SetActive(false)
  ;
  ((self.ui).obj_webViewItem):SetActive(false)
  self._onBannerClick = BindCallback(self, self._OnBannerClick)
  self.UINGNBanner = (UINGameNoticeBannerItem.New)()
  ;
  (self.UINGNBanner):Init((self.ui).obj_bannerItem)
  ;
  (self.UINGNBanner):Hide()
  self.ctrl = ControllerManager:GetController(ControllerTypeId.GameNotice, true)
  self._onLogout = BindCallback(self, self._OnGameNoticeClose)
  MsgCenter:AddListener(eMsgEventId.OnLogout, self._onLogout)
end

UIGameNotice.InitUIGameNotice = function(self, ShowErrorTips)
  -- function num : 0_1 , upvalues : _ENV
  (self.ctrl):LoadGameNoticeDatas(function(isDone)
    -- function num : 0_1_0 , upvalues : self, _ENV, ShowErrorTips
    if isDone and (self.ctrl):HasNoticData() then
      NoticeManager:PuaseShowNotice("UIGameNotice")
      self:RefreshGameNotic(true)
    else
      if ShowErrorTips then
        ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(10012))
      end
      if self.closeCallback ~= nil then
        (self.closeCallback)()
      end
    end
  end
)
  self:Hide()
end

UIGameNotice.RefreshGameNotic = function(self, dataIsDone)
  -- function num : 0_2
  if not dataIsDone then
    return 
  end
  ;
  (self.ctrl):SaveTimestamp()
  self:Show()
  self:RefreshUIGameNotice()
end

UIGameNotice.RefreshUIGameNotice = function(self)
  -- function num : 0_3
  self:RefreshGNTypeUI()
end

UIGameNotice.RefreshGNTypeUI = function(self)
  -- function num : 0_4 , upvalues : _ENV, UINGameNoticeType
  for index,typeId in ipairs(self.typeList) do
    local typeItem = (UINGameNoticeType.New)()
    local go = ((self.ui).typeArr)[index]
    typeItem:Init(go)
    typeItem:InitGameNoticType(typeId, self._onTypeItemClick)
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self.typeItemDic)[typeId] = typeItem
  end
  local typeID = (self.ctrl):GetNewGNType()
  ;
  ((self.typeItemDic)[typeID]):SetNoticeTypeIsOn(true)
end

UIGameNotice._OnTypeItemClick = function(self, typeId)
  -- function num : 0_5 , upvalues : _ENV
  if self.typeId == typeId then
    return 
  end
  self:RefresGNTogUI(nil)
  self:DestoryUniWebItem()
  ;
  (self.UINGNBanner):Hide()
  self.typeId = typeId
  self.tagIdx = nil
  do
    if not (self.ctrl):GetNewGNDataIndex(typeId) then
      local tagIdx = not (self.ctrl):HasGameNoticData(typeId) or 1
    end
    self:RefresGNTogUI(tagIdx)
    ;
    ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(10012))
  end
end

UIGameNotice.RefresGNTogUI = function(self, tagIdx)
  -- function num : 0_6 , upvalues : _ENV
  local noticDataList = (self.ctrl):GetNoticDataList(self.typeId)
  ;
  (self._onTagItemPool):HideAll()
  self.tagItemDic = {}
  if tagIdx == nil then
    return 
  end
  for index,gameNoticData in ipairs(noticDataList) do
    local item = (self._onTagItemPool):GetOne()
    item:RefreshGameNoticeTag(index, gameNoticData, self._onTagItemClick)
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self.tagItemDic)[index] = item
  end
  ;
  ((self.tagItemDic)[tagIdx]):SetNoticeTagIsOn(true)
end

UIGameNotice._OnTagItemClick = function(self, tagIdx)
  -- function num : 0_7
  if self.tagIdx == tagIdx then
    return 
  end
  self.tagIdx = tagIdx
  ;
  (self.ctrl):SetGameNoticeIsRead(self.typeId, tagIdx)
  self:RefreshGNDetailViewUI(self.typeId, tagIdx)
end

UIGameNotice.RefreshGNDetailViewUI = function(self, typeId, tagIdx)
  -- function num : 0_8 , upvalues : GameNoticEnum
  local gameNoticData = (self.ctrl):GetNoticData(typeId, tagIdx)
  if gameNoticData == nil then
    return 
  end
  if gameNoticData.template == (GameNoticEnum.eTemplates).banner then
    self:DestoryUniWebItem()
    ;
    (self.UINGNBanner):UpdateGNBanner(gameNoticData, self._onBannerClick)
    return 
  end
  if gameNoticData.template == (GameNoticEnum.eTemplates).html then
    (self.UINGNBanner):Hide()
    local encryptUrl = (self.ctrl):GetEncryptHtmlUrl(gameNoticData.idx)
    if encryptUrl ~= nil then
      self:CreateUniWebItem(encryptUrl, true)
    end
    return 
  end
end

UIGameNotice.CreateUniWebItem = function(self, url, hasFade)
  -- function num : 0_9 , upvalues : UINWebViewItem
  self:DestoryUniWebItem()
  local uniWebItem = (UINWebViewItem.New)()
  local go = ((self.ui).obj_webViewItem):Instantiate()
  go:SetActive(true)
  uniWebItem:Init(go)
  uniWebItem:LoadWebViewByUrl(url, hasFade)
  self.uniWebItem = uniWebItem
end

UIGameNotice.DestoryUniWebItem = function(self, clearCache)
  -- function num : 0_10 , upvalues : _ENV
  if self.uniWebItem ~= nil and not IsNull((self.uniWebItem).gameObject) then
    if clearCache then
      (self.uniWebItem):ClearCache()
    end
    DestroyUnityObject((self.uniWebItem).gameObject)
    self.uniWebItem = nil
  end
end

UIGameNotice._OnBannerClick = function(self, gameNoticeData)
  -- function num : 0_11 , upvalues : _ENV, JumpManager
  if gameNoticeData:IsJumpOuter() then
    if self.__OnOpenUrl == nil then
      self.__OnOpenUrl = BindCallback(self, self.OnOpenUrl)
    end
    self.jumpUrl = gameNoticeData:GetJumpUrl()
    ;
    ((CS.MessageCommon).ShowMessageBox)(ConfigData:GetTipContent(TipContent.bannerJumpMention), ConfigData:GetTipContent(TipContent.commonConfirm), ConfigData:GetTipContent(TipContent.commonCancle), self.__OnOpenUrl, nil)
    return 
  end
  if not gameNoticeData:IsJumpInner() then
    return 
  end
  local targetID = gameNoticeData:GetJumpID()
  local jumpArgs = gameNoticeData:GetJumpArgs()
  local bool, num = JumpManager:ValidateJump(targetID, jumpArgs)
  if not bool then
    return 
  end
  JumpManager:Jump(targetID, nil, nil, jumpArgs)
  self:_OnGameNoticeClose()
end

UIGameNotice.OnOpenUrl = function(self)
  -- function num : 0_12 , upvalues : _ENV
  (((CS.UnityEngine).Application).OpenURL)(self.jumpUrl)
end

UIGameNotice._OnGameNoticeClose = function(self)
  -- function num : 0_13
  if self.closeCallback ~= nil then
    (self.closeCallback)()
  end
  self:Delete()
end

UIGameNotice.SetCloseCallback = function(self, callback)
  -- function num : 0_14
  self.closeCallback = callback
end

UIGameNotice.OnDelete = function(self)
  -- function num : 0_15 , upvalues : _ENV, base
  (self.ctrl):SaveModelData()
  if self.typeItemDic ~= nil then
    for k,v in pairs(self.typeItemDic) do
      v:Delete()
    end
    self.typeItemDic = nil
  end
  ;
  (self._onTagItemPool):DeleteAll()
  self:DestoryUniWebItem(true)
  ;
  (self.UINGNBanner):Delete()
  self.closeCallback = nil
  MsgCenter:RemoveListener(eMsgEventId.OnLogout, self._onLogout)
  NoticeManager:ContinueShowNotice("UIGameNotice")
  ;
  (base.OnDelete)(self)
end

return UIGameNotice


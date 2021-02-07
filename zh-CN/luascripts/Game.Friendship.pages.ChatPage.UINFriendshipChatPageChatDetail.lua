-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFriendshipChatPageChatDetail = class("UINFriendshipChatPageChatDetail", UIBaseNode)
local base = UIBaseNode
local UINFriendshipSendGift = require("Game.Friendship.pages.ChatPage.UINFriendshipSendGift")
local util = require("XLua.Common.xlua_util")
local cs_WaitForSeconds = (CS.UnityEngine).WaitForSeconds
local cs_MessageCommon = CS.MessageCommon
local CS_GSceneManager_Ins = (CS.GSceneManager).Instance
UINFriendshipChatPageChatDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.isTogMenuOpen = false
  self.heroId = nil
  self.GetHeroData = BindCallback(self, self.__GetHeroData)
  self.isShowingGiftNode = false
  self.SendGiftNode = nil
  self.__RefreshIntimacyBar = BindCallback(self, self.RefreshIntimacyBar)
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_MenuTog, self, self.OnTogMenuClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Gift, self, self.OnGiftIconClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GiftClose, self, self.OnGifCloseClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Foster, self, self.OnFosterClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Plot, self, self.OnPlotDungenClick)
  MsgCenter:AddListener(eMsgEventId.OnHeroFriendshipDataChange, self.__RefreshIntimacyBar)
end

UINFriendshipChatPageChatDetail.InitChatDetail = function(self, resloader)
  -- function num : 0_1 , upvalues : UINFriendshipSendGift
  self.resloader = resloader
  self.SendGiftNode = (UINFriendshipSendGift.New)()
  ;
  (self.SendGiftNode):Init((self.ui).obj_giftNode)
  ;
  (self.SendGiftNode):InitResloader(resloader)
  ;
  ((self.ui).obj_giftNode):SetActive(false)
end

UINFriendshipChatPageChatDetail.__GetHeroData = function(self, heroData)
  -- function num : 0_2 , upvalues : _ENV
  self.heroId = (heroData.heroCfg).id
  self.times = (PlayerDataCenter.allFriendshipData):GetBattleTimes(self.heroId)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_HeroName).text = (LanguageUtil.GetLocaleText)((heroData.heroCfg).name) .. " " .. (heroData.heroCfg).name_en
  ;
  (self.SendGiftNode):InitSendGift((heroData.heroCfg).id, self.__RefreshIntimacyBar)
  if self.isShowingGiftNode == true then
    self:OnGifCloseClick()
  end
  ;
  ((self.ui).tex_BattleTimes):SetIndex(0, tostring(self.times))
  self:RefreshIntimacyBar()
end

UINFriendshipChatPageChatDetail.OnTogMenuClick = function(self, bool)
  -- function num : 0_3
  if self.isTogMenuOpen then
    ((self.ui).DOTween_buttonGroup):DORewind()
    self.isTogMenuOpen = false
  else
    ;
    ((self.ui).DOTween_buttonGroup):DOPlay()
    self.isTogMenuOpen = true
  end
end

UINFriendshipChatPageChatDetail.OnFosterClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if not self.isTogMenuOpen then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.FriendShipHeroFoster, function(window)
    -- function num : 0_4_0 , upvalues : self
    if window == nil then
      return 
    end
    window:InitHeroFosterLine(self.heroId)
  end
)
end

UINFriendshipChatPageChatDetail.OnPlotDungenClick = function(self)
  -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon, CS_GSceneManager_Ins
  if not self.isTogMenuOpen then
    return 
  end
  local isFriendshipUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship_sector_Ui)
  do
    if not isFriendshipUnlock then
      local isFriendshipUnlockDes = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship_sector_Ui)
      ;
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(isFriendshipUnlockDes)
      return 
    end
    UIManager:DeleteAllWindow()
    local loadFriendUIFunc = BindCallback(self, function(table, heroId)
    -- function num : 0_5_0 , upvalues : _ENV
    UIManager:ShowWindowAsync(UIWindowTypeID.FriendShipPlotDungeon, function(window)
      -- function num : 0_5_0_0 , upvalues : heroId
      if window == nil then
        return 
      end
      window:InitPlotDungeon(heroId)
    end
)
  end
, self.heroId)
    CS_GSceneManager_Ins:LoadSceneAsyncByAB((Consts.SceneName).Sector, function()
    -- function num : 0_5_1 , upvalues : _ENV, loadFriendUIFunc
    (ControllerManager:GetController(ControllerTypeId.SectorController, true)):SetFrom(AreaConst.FriendshipMoments, loadFriendUIFunc)
  end
)
  end
end

UINFriendshipChatPageChatDetail.OnGiftIconClick = function(self)
  -- function num : 0_6
  self.isShowingGiftNode = true
  ;
  ((self.ui).obj_giftNode):SetActive(true)
end

UINFriendshipChatPageChatDetail.OnGifCloseClick = function(self)
  -- function num : 0_7
  self.isShowingGiftNode = false
  ;
  (self.SendGiftNode):OnClose()
  ;
  ((self.ui).obj_giftNode):SetActive(false)
end

UINFriendshipChatPageChatDetail.RefreshIntimacyBar = function(self, promoteValue)
  -- function num : 0_8 , upvalues : _ENV
  local NowLevel = (PlayerDataCenter.allFriendshipData):GetLevel(self.heroId)
  local NowExp = (PlayerDataCenter.allFriendshipData):GetExp(self.heroId)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'

  if NowLevel == #ConfigData.friendship_level then
    ((self.ui).silder_FavorBar).value = 1
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).silder_FavorBarpromote).value = 0
    ;
    ((self.ui).tex_favorLevel):SetIndex(0, tostring(NowLevel))
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_favorRate).text = "MAX"
    return 
  end
  if not promoteValue then
    promoteValue = 0
  end
  local levelup = 0
  local remaindExp = promoteValue
  local thisLevelMaxExp = ((ConfigData.friendship_level)[NowLevel]).friendship
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R7 in 'UnsetPending'

  if remaindExp + NowExp < thisLevelMaxExp then
    ((self.ui).silder_FavorBarpromote).value = (remaindExp + NowExp) / thisLevelMaxExp
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).silder_FavorBar).value = NowExp / thisLevelMaxExp
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).tex_favorRate).text = GetPreciseDecimalStr((remaindExp + NowExp) / thisLevelMaxExp * 100, 0) .. "%"
    ;
    ((self.ui).tex_favorLevel):SetIndex(0, tostring(NowLevel))
  else
    remaindExp = remaindExp + NowExp - thisLevelMaxExp
    levelup = levelup + 1
    thisLevelMaxExp = ((ConfigData.friendship_level)[NowLevel + (levelup)]).friendship
    while thisLevelMaxExp <= remaindExp and NowLevel + (levelup) < #ConfigData.friendship_level do
      remaindExp = remaindExp - thisLevelMaxExp
      levelup = levelup + 1
      thisLevelMaxExp = ((ConfigData.friendship_level)[NowLevel + (levelup)]).friendship
    end
    -- DECOMPILER ERROR at PC100: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).silder_FavorBar).value = 0
    ;
    ((self.ui).tex_favorLevel):SetIndex(0, tostring(NowLevel + (levelup)))
    -- DECOMPILER ERROR at PC117: Confused about usage of register: R7 in 'UnsetPending'

    if NowLevel + (levelup) == #ConfigData.friendship_level then
      ((self.ui).silder_FavorBarpromote).value = 1
      -- DECOMPILER ERROR at PC120: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self.ui).tex_favorRate).text = "MAX"
    else
      -- DECOMPILER ERROR at PC125: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self.ui).silder_FavorBarpromote).value = (remaindExp) / thisLevelMaxExp
      -- DECOMPILER ERROR at PC135: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self.ui).tex_favorRate).text = GetPreciseDecimalStr((remaindExp) / thisLevelMaxExp * 100, 0) .. "%"
    end
  end
end

UINFriendshipChatPageChatDetail.OnDelete = function(self)
  -- function num : 0_9 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnHeroFriendshipDataChange, self.__RefreshIntimacyBar)
  ;
  (self.SendGiftNode):Delete()
  ;
  (base.OnDelete)(self)
end

return UINFriendshipChatPageChatDetail


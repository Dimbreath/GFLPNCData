local UINUserInfoSupportHeroNode = class("UINUserInfoSupportHeroNode", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadWithStarItem = require("Game.CommonUI.Hero.UINHeroHeadWithStarItem")
local FriendSupportHeroData = require("Game.Formation.Data.FriendSupportHeroData")
local cs_MessageCommon = CS.MessageCommon
UINUserInfoSupportHeroNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroHeadWithStarItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self._onClickAddSupport = BindCallback(self, self.OnClickAddSupport)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_AddSupport, self, self.OnClickAddSupport)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Empty, self, self.OnClickEmpty)
  self.headItem = (UINHeroHeadWithStarItem.New)()
  ;
  (self.headItem):Init((self.ui).obj_HeroHeadItem)
  self._refreshAll = BindCallback(self, self.RefreshAll)
end

UINUserInfoSupportHeroNode.InitSupportHero = function(self, index, userInfoData, resLoader, couldEditSelf)
  -- function num : 0_1 , upvalues : _ENV
  self.index = index
  self.userInfoData = userInfoData
  self.resLoader = resLoader
  self.supportHeroInfo = (userInfoData:GetSupportHoreInfoList())[index]
  self.isSelf = userInfoData:GetIsSelfUserInfo()
  self.supportHoreIdDic = userInfoData:GetSupportHoreIdDic()
  self.couldEditSelf = couldEditSelf
  self.isEmpty = self.supportHeroInfo == false or ((self.supportHeroInfo).assistsBrief).id == 0
  local unlockCfg = (ConfigData.support_count)[index]
  local isUnlock = (CheckCondition.CheckLua)(unlockCfg.pre_condition, unlockCfg.pre_para1, unlockCfg.pre_para2)
  if isUnlock then
    if self.isEmpty then
      (((self.ui).btn_Empty).gameObject):SetActive(not self.isSelf)
      if self.isEmpty then
        (((self.ui).btn_AddSupport).gameObject):SetActive(self.isSelf)
        ;
        ((self.ui).obj_Normal):SetActive(not self.isEmpty)
        ;
        (((self.ui).btn_Empty).gameObject):SetActive(true)
        ;
        (((self.ui).btn_AddSupport).gameObject):SetActive(false)
        ;
        ((self.ui).obj_Normal):SetActive(false)
        if self.isEmpty then
          return 
        end
        self:RefreshSupportHero()
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
      end
    end
  end
end

UINUserInfoSupportHeroNode.RefreshSupportHero = function(self)
  -- function num : 0_2 , upvalues : _ENV, FriendSupportHeroData
  if self.isEmpty then
    return 
  end
  local heroData = nil
  if self.isSelf then
    if not self.supportHeroInfo then
      return 
    end
    heroData = (PlayerDataCenter.heroDic)[((self.supportHeroInfo).assistsBrief).id]
  else
    if not self.supportHeroInfo then
      return 
    end
    heroData = (FriendSupportHeroData.GenSupportHeroData)(self.userInfoData, ((self.supportHeroInfo).assistsBrief).id)
  end
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_HeroName).text = heroData:GetName()
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Power).text = tostring(heroData:GetFightingPower())
  ;
  (self.headItem):InitHead(heroData, nil, nil, self._onClickAddSupport)
end

UINUserInfoSupportHeroNode.OnClickAddSupport = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if not (self.userInfoData):GetIsSelfUserInfo() or not self.couldEditSelf then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.UserInfoSelectSupport, function(win)
    -- function num : 0_3_0 , upvalues : self
    if win ~= nil then
      if self.isEmpty then
        win:InitSelectSupportHero(self.index, nil, (self.userInfoData):GetSupportHoreIdDic(), self._refreshAll)
      else
        win:InitSelectSupportHero(self.index, ((self.supportHeroInfo).assistsBrief).id, (self.userInfoData):GetSupportHoreIdDic(), self._refreshAll)
      end
    end
  end
)
end

UINUserInfoSupportHeroNode.OnClickEmpty = function(self)
  -- function num : 0_4 , upvalues : _ENV, cs_MessageCommon
  if not self.isSelf then
    return 
  end
  local unlockCfg = (ConfigData.support_count)[self.index]
  local unlockInfo = (CheckCondition.GetUnlockInfoLua)(unlockCfg.pre_condition, unlockCfg.pre_para1, unlockCfg.pre_para2)
  ;
  (cs_MessageCommon.ShowMessageTips)(unlockInfo)
end

UINUserInfoSupportHeroNode.RefreshAll = function(self)
  -- function num : 0_5
  self:InitSupportHero(self.index, self.userInfoData, self.resLoader, self.couldEditSelf)
end

UINUserInfoSupportHeroNode.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UINUserInfoSupportHeroNode


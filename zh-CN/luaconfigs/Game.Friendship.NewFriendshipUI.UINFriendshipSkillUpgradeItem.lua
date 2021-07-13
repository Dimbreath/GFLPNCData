-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFriendshipSkillUpgradeItem = class("UINFriendshipSkillUpgradeItem", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
UINFriendshipSkillUpgradeItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friendship)
  self.couldUnlcok = false
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_skillUpgradeItem, self, self.OnItemClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CanLevelUp, self, self.OnItemClick)
end

UINFriendshipSkillUpgradeItem.InitSkillItem = function(self, heroId, fosterCfg, OpenInfoNodeCallback)
  -- function num : 0_1
  self.heroId = heroId
  self.fosterCfg = fosterCfg
  self.fosterId = ((self.fosterCfg)[1]).id
  self.OpenInfoNodeCallback = OpenInfoNodeCallback
  self:Refresh()
end

UINFriendshipSkillUpgradeItem.Refresh = function(self)
  -- function num : 0_2
  self:RefreshIsUnlock()
  self:RefreshLevel()
  self:RefreshCouldUpgrade()
end

UINFriendshipSkillUpgradeItem.RefreshIsUnlock = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local isUnlock = (PlayerDataCenter.allFriendshipData):IsForestLineUnlock(self.heroId, self.fosterId)
  ;
  ((self.ui).obj_lock):SetActive(not isUnlock)
  ;
  ((self.ui).obj_skill_lock):SetActive(not isUnlock)
  ;
  ((self.ui).obj_skill_unlock):SetActive(isUnlock)
end

UINFriendshipSkillUpgradeItem.RefreshLevel = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local level = (PlayerDataCenter.allFriendshipData):GetForestLineLevel(self.heroId, self.fosterId)
  ;
  ((self.ui).tex_Lv):SetIndex(0, tostring(level))
  self:RefreshNameDesIcon(level)
end

UINFriendshipSkillUpgradeItem.RefreshNameDesIcon = function(self, level)
  -- function num : 0_5 , upvalues : _ENV
  if level <= 0 then
    level = 1
  end
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(((self.fosterCfg)[level]).name)
  local des = (LanguageUtil.GetLocaleText)(((self.fosterCfg)[level]).describe)
  for index,attrID in ipairs(((self.fosterCfg)[level]).attributeIds) do
    local _, value = ConfigData:GetAttribute((((self.fosterCfg)[level]).attributeIds)[index], (((self.fosterCfg)[level]).attributeNums)[index])
    if (string.endswith)(value, "%", true) then
      value = value .. "%"
    end
    if des == nil then
      error("can\'t read Friendship foster descripition")
    else
      des = (string.gsub)(des, "{" .. tostring(index - 1) .. "}", value)
    end
  end
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Descr).text = des
  -- DECOMPILER ERROR at PC77: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_SkillIcon).sprite = CRH:GetSprite(((self.fosterCfg)[level]).icon)
end

UINFriendshipSkillUpgradeItem.RefreshCouldUpgrade = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (((self.ui).btn_CanLevelUp).gameObject):SetActive(false)
  self.couldUnlcok = false
  local could, isUnlock, requireFriendshipLevel, requireHeroLevel, boolFL, boolHL = (PlayerDataCenter.allFriendshipData):GetCouldUnlockOrUpgrade(self.heroId, self.fosterId)
  if could then
    if isUnlock then
      self.couldUnlcok = true
      ;
      (((self.ui).image_lockOpen).gameObject):SetActive(true)
      ;
      (((self.ui).image_lock).gameObject):SetActive(false)
    else
      ;
      (((self.ui).btn_CanLevelUp).gameObject):SetActive(true)
    end
  else
    if isUnlock then
      (((self.ui).image_lockOpen).gameObject):SetActive(false)
      ;
      (((self.ui).image_lock).gameObject):SetActive(true)
      ;
      ((self.ui).text_unlock_c0):SetIndex(0, tostring(requireFriendshipLevel))
      ;
      ((self.ui).text_unlock_c1):SetIndex(1, tostring(requireHeroLevel))
      if boolFL then
        ((self.ui).img_marker_c0):SetIndex(1)
      else
        ;
        ((self.ui).img_marker_c0):SetIndex(0)
      end
      if boolHL then
        ((self.ui).img_marker_c1):SetIndex(1)
      else
        ;
        ((self.ui).img_marker_c1):SetIndex(0)
      end
    end
  end
  self:RefreshRedDot(could, isUnlock)
end

UINFriendshipSkillUpgradeItem.RefreshRedDot = function(self, could, isUnlock)
  -- function num : 0_7
  ;
  ((self.ui).obj_RedDot):SetActive(not could or isUnlock)
  if could then
    ((self.ui).obj_blueDot):SetActive(not isUnlock)
  end
end

UINFriendshipSkillUpgradeItem.OnItemClick = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self.couldUnlcok then
    local heroData = PlayerDataCenter:GetHeroData(self.heroId)
    do
      if heroData == nil then
        error("Can\'t find HeroData By id:" .. tostring(self.heroId))
        return 
      end
      local oldHeroPower = heroData:GetFightingPower()
      ;
      (self.networkCtrl):CS_INTIMACY_UpgradeLine(self.heroId, ((self.fosterCfg)[1]).id, function()
    -- function num : 0_8_0 , upvalues : heroData, _ENV, oldHeroPower
    local newPower = heroData:GetFightingPower()
    UIManager:ShowWindowAsync(UIWindowTypeID.HeroPowerUpSuccess, function(win)
      -- function num : 0_8_0_0 , upvalues : oldHeroPower, newPower
      if win ~= nil then
        win:InitHeroPowerUpSuccess(oldHeroPower, newPower)
      end
    end
)
  end
)
      self.couldUnlcok = false
      return 
    end
  end
  do
    if not (PlayerDataCenter.allFriendshipData):IsForestLineUnlock(self.heroId, self.fosterId) then
      return 
    end
    if self.OpenInfoNodeCallback ~= nil then
      (self.OpenInfoNodeCallback)(self.heroId, self.fosterCfg)
    end
  end
end

UINFriendshipSkillUpgradeItem.OnDelete = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnDelete)(self)
end

return UINFriendshipSkillUpgradeItem


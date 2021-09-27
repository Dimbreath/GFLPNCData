local UINFriendshipSkillInfoNode = class("UINFriendshipSkillInfoNode", UIBaseNode)
local base = UIBaseNode
local UINHeroSkillUpgradeCostItem = require("Game.Hero.NewUI.UpgradeSkill.UINHeroSkillUpgradeCostItem")
local cs_MessageCommon = CS.MessageCommon
UINFriendshipSkillInfoNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroSkillUpgradeCostItem
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friendship)
  self.fitLevelRequire = false
  self.fitMaterialRequire = false
  self.curLevel = 0
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Cancel, self, self.OnClickCancel)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnClickConfirm)
  self.CostItemPool = (UIItemPool.New)(UINHeroSkillUpgradeCostItem, (self.ui).obj_extrItem)
  ;
  ((self.ui).obj_extrItem):SetActive(false)
end

UINFriendshipSkillInfoNode.InitSkillInfoNode = function(self, heroId, fosterCfg, onCancelClickAction)
  -- function num : 0_1
  self.heroId = heroId
  self.fosterCfg = fosterCfg
  self.fosterId = (fosterCfg[1]).id
  self.onCancelClickAction = onCancelClickAction
  self:Refresh()
end

UINFriendshipSkillInfoNode.Refresh = function(self, isUpgrade)
  -- function num : 0_2 , upvalues : _ENV
  self.curLevel = (PlayerDataCenter.allFriendshipData):GetForestLineLevel(self.heroId, self.fosterId)
  self:RefreshNowSkillUI(isUpgrade)
  self:RefreshNextSkillUI(isUpgrade)
  self:RefreshAllMaterial()
  self:RefreshLevelRequirement(isUpgrade)
end

UINFriendshipSkillInfoNode.RefreshAllMaterial = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self.fitMaterialRequire = true
  local nextCfg = (self.fosterCfg)[self.curLevel + 1]
  local currencyId, currencyNum = nil, nil
  ;
  (self.CostItemPool):HideAll()
  for index,itemId in ipairs(nextCfg.deduct_itemIds) do
    if itemId == ConstGlobalItem.NormalGold then
      currencyId = itemId
      currencyNum = (nextCfg.deduct_itemNums)[index] or 0
    else
      local num = (nextCfg.deduct_itemNums)[index] or 0
      local item = (self.CostItemPool):GetOne(true)
      local hasNum = PlayerDataCenter:GetItemCount(itemId)
      item:InitCostItem(itemId, num)
      if hasNum < num then
        self.fitMaterialRequire = false
      end
    end
  end
  local hasId = currencyId ~= nil
  local hasNum = currencyNum ~= nil and currencyNum ~= 0
  if hasId and hasNum then
    ((self.ui).obj_cost):SetActive(true)
    local itemCfg = (ConfigData.item)[currencyId]
    -- DECOMPILER ERROR at PC76: Confused about usage of register: R7 in 'UnsetPending'

    if itemCfg ~= nil then
      ((self.ui).img_Item).sprite = CRH:GetSprite(itemCfg.small_icon)
    else
      error("can\'t read itemCfg with id:" .. tostring(currencyId))
    end
    local totalCurrencyNum = PlayerDataCenter:GetItemCount(currencyId)
    if totalCurrencyNum < currencyNum then
      ((self.ui).tex_Cost):SetIndex(1, tostring(currencyNum))
      self.fitMaterialRequire = false
    else
      ((self.ui).tex_Cost):SetIndex(0, tostring(currencyNum))
    end
  else
    ((self.ui).obj_cost):SetActive(false)
  end
  -- DECOMPILER ERROR: 8 unprocessed JMP targets
end

UINFriendshipSkillInfoNode.RefreshNowSkillUI = function(self, isUpgrade)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  if self.curLevel <= 9 then
    ((self.ui).tex_curLv).text = "0" .. tostring(self.curLevel)
  else
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_curLv).text = tostring(self.curLevel)
  end
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).now_tex_Lv).text = "LV" .. tostring(self.curLevel)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).now_tex_Name).text = (LanguageUtil.GetLocaleText)(((self.fosterCfg)[self.curLevel]).name)
  local curCfg = (self.fosterCfg)[self.curLevel]
  local currDes = (LanguageUtil.GetLocaleText)(curCfg.describe)
  for index,attrID in ipairs(curCfg.attributeIds) do
    local _, value = ConfigData:GetAttribute((curCfg.attributeIds)[index], (curCfg.attributeNums)[index])
    if (string.endswith)(value, "%", true) then
      value = value .. "%"
    end
    if currDes == nil then
      error("can\'t read Friendship foster descripition")
    else
      currDes = (string.gsub)(currDes, "{" .. tostring(index - 1) .. "}", "<color=#FF8400>" .. value .. "</color>")
    end
  end
  -- DECOMPILER ERROR at PC90: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).now_tex_Descr).text = currDes
  -- DECOMPILER ERROR at PC97: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).now_img_SkillIcon).sprite = CRH:GetSprite(curCfg.icon)
  if isUpgrade then
    ((self.ui).tex_curLv):StartScrambleTypeWriter()
    ;
    ((self.ui).now_tex_Lv):StartScrambleTypeWriter()
    ;
    ((self.ui).now_tex_Descr):StartScrambleTypeWriter()
  end
end

UINFriendshipSkillInfoNode.RefreshNextSkillUI = function(self, isUpgrade)
  -- function num : 0_5 , upvalues : _ENV
  if #self.fosterCfg < self.curLevel + 1 then
    return 
  end
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  if self.curLevel + 1 <= 9 then
    ((self.ui).tex_NextLv).text = "0" .. tostring(self.curLevel + 1)
  else
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_NextLv).text = tostring(self.curLevel + 1)
  end
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).next_tex_Lv).text = "LV" .. tostring(self.curLevel + 1)
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).next_tex_Name).text = (LanguageUtil.GetLocaleText)(((self.fosterCfg)[self.curLevel + 1]).name)
  local nextCfg = (self.fosterCfg)[self.curLevel + 1]
  local nextDes = (LanguageUtil.GetLocaleText)(nextCfg.describe)
  for index,attrID in ipairs(nextCfg.attributeIds) do
    local _, value = ConfigData:GetAttribute((nextCfg.attributeIds)[index], (nextCfg.attributeNums)[index])
    if (string.endswith)(value, "%", true) then
      value = value .. "%"
    end
    if nextDes == nil then
      error("can\'t read Friendship foster descripition")
    else
      nextDes = (string.gsub)(nextDes, "{" .. tostring(index - 1) .. "}", "<color=#FF8400>" .. value .. "</color>")
    end
  end
  -- DECOMPILER ERROR at PC103: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).next_tex_Descr).text = nextDes
  -- DECOMPILER ERROR at PC110: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).next_img_SkillIcon).sprite = CRH:GetSprite(nextCfg.icon)
  if isUpgrade then
    ((self.ui).tex_NextLv):StartScrambleTypeWriter()
    ;
    ((self.ui).next_tex_Lv):StartScrambleTypeWriter()
    ;
    ((self.ui).next_tex_Descr):StartScrambleTypeWriter()
  end
end

UINFriendshipSkillInfoNode.RefreshLevelRequirement = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local could, isUnlock, requireFriendshipLevel, requireHeroLevel, boolFL, boolHL = (PlayerDataCenter.allFriendshipData):GetCouldUnlockOrUpgrade(self.heroId, self.fosterId)
  self.fitLevelRequire = not boolFL or boolHL
  ;
  ((self.ui).tex_Condition0):SetIndex(0, tostring(requireFriendshipLevel))
  ;
  ((self.ui).tex_Condition1):SetIndex(0, tostring(requireHeroLevel))
  ;
  ((self.ui).obj_lockedNode):SetActive(not self.fitLevelRequire)
  if not could then
    if not boolFL then
      ((self.ui).text_lockedNode):SetIndex(0)
    else
      if not boolHL then
        ((self.ui).text_lockedNode):SetIndex(1)
      end
    end
  end
end

UINFriendshipSkillInfoNode.OnClickConfirm = function(self)
  -- function num : 0_7 , upvalues : _ENV, cs_MessageCommon
  if self.fitMaterialRequire and self.fitLevelRequire then
    self.fitLevelRequire = false
    self.fitMaterialRequire = false
    local heroData = PlayerDataCenter:GetHeroData(self.heroId)
    do
      local oldPower = heroData:GetFightingPower()
      ;
      (self.networkCtrl):CS_INTIMACY_UpgradeLine(self.heroId, self.fosterId, function()
    -- function num : 0_7_0 , upvalues : self, _ENV, heroData, oldPower
    self.curLevel = (PlayerDataCenter.allFriendshipData):GetForestLineLevel(self.heroId, self.fosterId)
    local newPower = heroData:GetFightingPower()
    if oldPower ~= newPower then
      UIManager:ShowWindowAsync(UIWindowTypeID.HeroPowerUpSuccess, function(win)
      -- function num : 0_7_0_0 , upvalues : oldPower, newPower
      if win ~= nil then
        win:InitHeroPowerUpSuccess(oldPower, newPower)
      end
    end
)
    end
    if #self.fosterCfg <= self.curLevel then
      self:OnClickCancel()
      return 
    end
    self:Refresh(true)
  end
)
    end
  else
    do
      if not self.fitMaterialRequire then
        (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Friendship_SkillUpgrade_MatInsufficient))
      else
        if not self.fitMaterialRequire then
          (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Friendship_SkillUpgrade_LevelInsufficient))
        end
      end
    end
  end
end

UINFriendshipSkillInfoNode.OnClickCancel = function(self)
  -- function num : 0_8
  if self.onCancelClickAction ~= nil then
    (self.onCancelClickAction)()
  end
end

UINFriendshipSkillInfoNode.OnDelete = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnDelete)(self)
end

return UINFriendshipSkillInfoNode


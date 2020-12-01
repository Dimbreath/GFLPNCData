-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFosterLineItem = class("UINFosterLineItem", UIBaseNode)
local base = UIBaseNode
UINFosterLineItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.heroId = nil
  self.fosterCfg = nil
  self.clickCallback = nil
  self.lienLevel = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_favorSkillItem, self, self.OnTogValueChange)
end

UINFosterLineItem.InitFosterItem = function(self, heroId, fosterCfg, heroLevel, friendShipLevel, clickCallback)
  -- function num : 0_1 , upvalues : _ENV
  self.heroId = heroId
  self.fosterCfg = fosterCfg
  self.herolevel = heroLevel
  self.friendShipLevel = friendShipLevel
  self.clickCallback = clickCallback
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_SkillName).text = (LanguageUtil.GetLocaleText)((fosterCfg[1]).name)
  self:RefreshCondition()
end

UINFosterLineItem.Move = function(self, bool, pos)
  -- function num : 0_2 , upvalues : _ENV
  if bool then
    if pos == nil then
      error("don\'t have pos")
    end
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).trans_pos).anchoredPosition = (Vector2.New)(pos.x + 70, pos.y)
  end
end

UINFosterLineItem.OnTogValueChange = function(self, bool)
  -- function num : 0_3
  if self.clickCallback ~= nil then
    (self.clickCallback)(bool)
  end
end

UINFosterLineItem.RefreshCondition = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self.lienLevel = (PlayerDataCenter.allFriendshipData):GetForestLineLevel(self.heroId, ((self.fosterCfg)[1]).id)
  if self:isUnlocked() then
    (((self.ui).img_condition).gameObject):SetActive(false)
    ;
    ((self.ui).obj_skillLevel):SetActive(true)
    if self.lienLevel == #self.fosterCfg then
      ((self.ui).tex_SkillLevel):SetIndex(1)
    else
      ;
      ((self.ui).tex_SkillLevel):SetIndex(0, tostring(self.lienLevel))
    end
  else
    ;
    (((self.ui).img_condition).gameObject):SetActive(true)
    ;
    ((self.ui).obj_skillLevel):SetActive(false)
    local requireFriendshipLevel = ((self.fosterCfg)[1]).friendship_level
    ;
    ((self.ui).txt_condition):SetIndex(0, tostring(requireFriendshipLevel))
    -- DECOMPILER ERROR at PC73: Confused about usage of register: R2 in 'UnsetPending'

    if requireFriendshipLevel <= self.friendShipLevel then
      ((self.ui).img_condition).color = (self.ui).color_black
    else
      -- DECOMPILER ERROR at PC79: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).img_condition).color = (self.ui).color_orange
    end
  end
  do
    self:SetIsUnlock()
  end
end

UINFosterLineItem.isUnlocked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  return (PlayerDataCenter.allFriendshipData):IsForestLineUnlock(self.heroId, ((self.fosterCfg)[1]).id)
end

UINFosterLineItem.SetIsUnlock = function(self, bool)
  -- function num : 0_6 , upvalues : _ENV
  if bool == nil then
    bool = self:isUnlocked()
  end
  ;
  ((self.ui).obj_lock):SetActive(not bool)
  ;
  ((self.ui).obj_unlock):SetActive(bool)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

  if bool then
    ((self.ui).img_unlockIcon).sprite = CRH:GetSprite(((self.fosterCfg)[self.lienLevel]).icon)
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_OnSelect).color = (self.ui).color_yellow
  else
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_OnSelect).color = (self.ui).color_black
  end
end

UINFosterLineItem.setSelect = function(self, bool)
  -- function num : 0_7
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tog_favorSkillItem).isOn = bool
end

UINFosterLineItem.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnDelete)(self)
end

return UINFosterLineItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFosterLineItem = class("UINFosterLineItem", UIBaseNode)
local base = UIBaseNode
UINFosterLineItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    self.heroId = nil
    self.fosterCfg = nil
    self.clickCallback = nil
    self.lienLevel = nil;
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddValueChangedListener)((self.ui).tog_favorSkillItem, self,
                                     self.OnTogValueChange)
end

UINFosterLineItem.InitFosterItem = function(self, heroId, fosterCfg, heroLevel,
                                            friendShipLevel, clickCallback)
    -- function num : 0_1 , upvalues : _ENV
    self.heroId = heroId
    self.fosterCfg = fosterCfg
    self.herolevel = heroLevel
    self.friendShipLevel = friendShipLevel
    self.clickCallback = clickCallback -- DECOMPILER ERROR at PC12: Confused about usage of register: R6 in 'UnsetPending'
    ;
    ((self.ui).tex_SkillName).text = (LanguageUtil.GetLocaleText)(
                                         (fosterCfg[1]).name)
    self:RefreshCondition()
end

UINFosterLineItem.Move = function(self, bool, pos)
    -- function num : 0_2 , upvalues : _ENV
    if bool then
        if pos == nil then error("don\'t have pos") end -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'
        
        ((self.ui).trans_pos).anchoredPosition =
            (Vector2.New)(pos.x + 70, pos.y)
    end
end

UINFosterLineItem.OnTogValueChange = function(self, bool)
    -- function num : 0_3
    if self.clickCallback ~= nil then (self.clickCallback)(bool) end
end

UINFosterLineItem.RefreshCondition = function(self)
    -- function num : 0_4 , upvalues : _ENV
    self.lienLevel = (PlayerDataCenter.allFriendshipData):GetForestLineLevel(
                         self.heroId, ((self.fosterCfg)[1]).id)
    if self:isUnlocked() then
        (((self.ui).img_condition).gameObject):SetActive(false);
        ((self.ui).obj_skillLevel):SetActive(true)
        if self.lienLevel == #self.fosterCfg then
            ((self.ui).tex_SkillLevel):SetIndex(1)
        else

            ((self.ui).tex_SkillLevel):SetIndex(0, tostring(self.lienLevel))
        end
    else

        (((self.ui).img_condition).gameObject):SetActive(true);
        ((self.ui).obj_skillLevel):SetActive(false)
        local requireFriendshipLevel = ((self.fosterCfg)[1]).friendship_level;
        ((self.ui).txt_condition):SetIndex(0, tostring(requireFriendshipLevel))
        -- DECOMPILER ERROR at PC73: Confused about usage of register: R2 in 'UnsetPending'

        if requireFriendshipLevel <= self.friendShipLevel then
            ((self.ui).img_condition).color = (self.ui).color_black
        else
            -- DECOMPILER ERROR at PC79: Confused about usage of register: R2 in 'UnsetPending'


            ((self.ui).img_condition).color = (self.ui).color_orange
        end
    end
    do self:SetIsUnlock() end
end

UINFosterLineItem.isUnlocked = function(self)
    -- function num : 0_5 , upvalues : _ENV
    return (PlayerDataCenter.allFriendshipData):IsForestLineUnlock(self.heroId,
                                                                   ((self.fosterCfg)[1]).id)
end

UINFosterLineItem.SetIsUnlock = function(self, bool)
    -- function num : 0_6 , upvalues : _ENV
    if bool == nil then bool = self:isUnlocked() end
    ((self.ui).obj_lock):SetActive(not bool);
    ((self.ui).obj_unlock):SetActive(bool)
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

    if bool then
        ((self.ui).img_unlockIcon).sprite =
            CRH:GetSprite(((self.fosterCfg)[self.lienLevel]).icon) -- DECOMPILER ERROR at PC31: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).img_OnSelect).color = (self.ui).color_yellow
    else
        -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'


        ((self.ui).img_OnSelect).color = (self.ui).color_black
    end
end

UINFosterLineItem.setSelect = function(self, bool)
    -- function num : 0_7
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

    ((self.ui).tog_favorSkillItem).isOn = bool
end

UINFosterLineItem.OnDelete = function(self)
    -- function num : 0_8 , upvalues : base
    (base.OnDelete)(self)
end

return UINFosterLineItem


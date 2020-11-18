-- params : ...
-- function num : 0 , upvalues : _ENV
local UICommonItemDetailWin = class("UICommonItemDetailWin", UIBaseWindow)
local base = UIBaseWindow
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
local UINAthDetailItem = require("Game.Arithmetic.AthDetail.UINAthDetailItem")
local JumpInfoItem = require("Game.CommonUI.ItemDetail.UICIDJumpInfoItem")
local JumpManager = require("Game.Jump.JumpManager")
UICommonItemDetailWin.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItem, UINAthDetailItem, JumpInfoItem
  (UIUtil.AddButtonListener)((self.ui).btn_return, self, self.OnBtnReturnClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Use, self, self.OnBtnUseClick)
  self.onJumpBtnClick = BindCallback(self, self.OnJumpBtnClick)
  self.baseItem = (UINBaseItem.New)()
  ;
  (self.baseItem):Init((self.ui).uINBaseItem)
  self.athInfoNode = (UINAthDetailItem.New)()
  ;
  (self.athInfoNode):Init((self.ui).aTHDetailItem)
  self.poolInfoItem = (UIItemPool.New)(JumpInfoItem, (self.ui).obj_jumpInfoItem)
  ;
  ((self.ui).obj_jumpInfoItem):SetActive(false)
end

UICommonItemDetailWin.InitCommonItemDetail = function(self, itemCfg, useAction)
  -- function num : 0_1 , upvalues : _ENV
  if itemCfg == nil then
    error("Can\'t find itemCfg")
    return 
  end
  self:__InitCIDData(itemCfg)
  self.useAction = useAction
  self:__InitCIDUI(itemCfg)
  ;
  (self.athInfoNode):Hide()
  ;
  (((self.ui).tex_Name).gameObject):SetActive(true)
  ;
  (((self.ui).tex_Descr).gameObject):SetActive(true)
  ;
  ((self.ui).WareHouseName_text):SetActive(true)
  ;
  (((self.ui).tex_Count).gameObject):SetActive(true)
end

UICommonItemDetailWin.InitAthDetail = function(self, itemCfg, athData, useAction)
  -- function num : 0_2 , upvalues : _ENV
  if itemCfg == nil then
    error("Can\'t find itemCfg")
    return 
  end
  self:__InitCIDData(itemCfg)
  self.useAction = useAction
  self:__InitCIDUI(itemCfg)
  ;
  (((self.ui).tex_Name).gameObject):SetActive(false)
  ;
  (((self.ui).tex_Descr).gameObject):SetActive(false)
  ;
  ((self.ui).WareHouseName_text):SetActive(false)
  ;
  (((self.ui).tex_Count).gameObject):SetActive(false)
  ;
  (self.athInfoNode):InitAthDetailItem(nil, athData, nil, false, false)
  ;
  (self.athInfoNode):Show()
end

UICommonItemDetailWin.__InitCIDData = function(self, itemCfg)
  -- function num : 0_3 , upvalues : _ENV
  self.isHeroItem = false
  if itemCfg.action_type == eItemActionType.HeroCardFrag then
    self.isHeroItem = true
  end
  self.showUseBtn = false
  if (itemCfg.can_use ~= false and itemCfg.can_use ~= nil) or self.useAction ~= nil then
    self.showUseBtn = true
  end
  self.canUse = itemCfg.can_use
  self.showAchieve = itemCfg.achieve_des ~= "" and true or false
  self.showJumpList = #itemCfg.jump_id ~= 0 and self.canJump and true or false
  self.jumpInfoData = {}
  if self.showJumpList then
    local jumpData = {}
    for index,id in ipairs(itemCfg.jump_id) do
      jumpData.jumpId = id
      jumpData.cfg = (ConfigData.system_jump)[id]
      ;
      (table.insert)(self.jumpInfoData, jumpData)
    end
  end
end

UICommonItemDetailWin.__InitCIDUI = function(self, itemCfg)
  -- function num : 0_4 , upvalues : _ENV
  (self.baseItem):InitBaseItem(itemCfg, nil)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  if itemCfg.id == ItemIdOfKey then
    ((self.ui).tex_Count).text = tostring((PlayerDataCenter.stamina):GetCurrentStamina())
  else
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_Count).text = tostring(PlayerDataCenter:GetItemCount(itemCfg.id))
  end
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = tostring((LanguageUtil.GetLocaleText)(itemCfg.name))
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Descr).text = tostring((LanguageUtil.GetLocaleText)(itemCfg.describe))
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R2 in 'UnsetPending'

  if not self.isHeroItem then
    ((self.ui).img_ItemQuality).color = ItemQualityColor[itemCfg.quality]
  end
  ;
  ((self.ui).obj_HeroQuailty):SetActive(self.isHeroItem)
  ;
  (((self.ui).img_ItemQuality).gameObject):SetActive(not self.isHeroItem)
  ;
  (((self.ui).btn_Use).gameObject):SetActive(self.showUseBtn)
  ;
  ((self.ui).obj_jumpList):SetActive(false)
  ;
  (((self.ui).tex_achieveText).gameObject):SetActive(false)
  if self.showJumpList then
    ((self.ui).obj_jumpList):SetActive(true)
    self:ShowJumpList()
  else
    if self.showAchieve then
      (((self.ui).tex_achieveText).gameObject):SetActive(true)
      -- DECOMPILER ERROR at PC112: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).tex_achieveText).text = tostring((LanguageUtil.GetLocaleText)(itemCfg.achieve_des))
    end
  end
end

UICommonItemDetailWin.ShowJumpList = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if #self.jumpInfoData <= 0 then
    return 
  end
  ;
  (self.poolInfoItem):HideAll()
  for index,jumpData in ipairs(self.jumpInfoData) do
    local item = (self.poolInfoItem):GetOne()
    item:InitCIDJumpInfoItem(jumpData, self.onJumpBtnClick)
  end
end

UICommonItemDetailWin.OnJumpBtnClick = function(self, jumpId)
  -- function num : 0_6 , upvalues : JumpManager
  JumpManager:Jump(jumpId)
  if self.parentWindowType ~= nil then
    JumpManager:CloseWin(self.parentWindowType)
  end
  self:Hide()
end

UICommonItemDetailWin.OnBtnReturnClick = function(self)
  -- function num : 0_7
  self:Hide()
end

UICommonItemDetailWin.OnBtnUseClick = function(self)
  -- function num : 0_8
  if self.useAction ~= nil then
    (self.useAction)()
    return 
  end
  if self.canUse then
  end
end

UICommonItemDetailWin.ParentWindowType = function(self, type)
  -- function num : 0_9
  self.parentWindowType = type
end

UICommonItemDetailWin.SetJumpable = function(self, canJump)
  -- function num : 0_10
  self.canJump = canJump
end

return UICommonItemDetailWin


local UINNavigationBranchBtn = class("UINNavigationBranchBtn", UIBaseNode)
local base = UIBaseNode
UINNavigationBranchBtn.eLockType = {perCoditonLock = 0, forceLock = 1}
local JumpManager = require("Game.Jump.JumpManager")
local cs_MessageCommon = CS.MessageCommon
UINNavigationBranchBtn.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.isRedDotInited = false
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_subNavBranchItem, self, self.OnClickNavigationBranchBtn)
end

UINNavigationBranchBtn.InitNavigationBranchBtn = function(self, navigation_subCfg, resloader, index)
  -- function num : 0_1 , upvalues : _ENV
  self.resloader = resloader
  self.navigation_subCfg = navigation_subCfg
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).txt_Title).text = (LanguageUtil.GetLocaleText)(navigation_subCfg.name)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.transform).gameObject).name = tostring(index)
  self:RefreshNBBIsUnlock()
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).enabled = false
  ;
  (self.resloader):LoadABAssetAsync(PathConsts:GetAtlasAssetPath("UI_NavigationBar"), function(spriteAtlas)
    -- function num : 0_1_0 , upvalues : self, navigation_subCfg
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = spriteAtlas:GetSprite(navigation_subCfg.img)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).enabled = true
  end
)
end

UINNavigationBranchBtn.OnClickNavigationBranchBtn = function(self)
  -- function num : 0_2 , upvalues : UINNavigationBranchBtn, cs_MessageCommon, _ENV, JumpManager
  if not self.isUnlock then
    if self.lockType == (UINNavigationBranchBtn.eLockType).perCoditonLock then
      (cs_MessageCommon.ShowMessageTips)(self.lockInfo)
    else
      if self.lockType == (UINNavigationBranchBtn.eLockType).forceLock then
        (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.NavigationBtnForceLocked))
      end
    end
    return 
  end
  JumpManager:Jump((self.navigation_subCfg).jump_target, function(jumpCallback)
    -- function num : 0_2_0 , upvalues : _ENV, self
    if (UIUtil.CheckIsHaveSpecialMarker)((self.navigation_subCfg).marker) then
      (UIUtil.ReturnUntil2Marker)((self.navigation_subCfg).marker)
      local win = UIManager:GetWindow(UIWindowTypeID.TopStatus)
      if win ~= nil then
        win:HideNavigation()
      end
      local win = UIManager:GetWindow(UIWindowTypeID.ClickContinue)
      if win ~= nil then
        win:Hide()
      end
      return 
    end
    do
      if jumpCallback ~= nil then
        local win = UIManager:GetWindow(UIWindowTypeID.TopStatus)
        if win ~= nil then
          win:HideNavigation()
        end
        jumpCallback()
      end
    end
  end
, nil, (self.navigation_subCfg).jump_arg, (self.navigation_subCfg).jump_is_cover)
end

UINNavigationBranchBtn.RefreshNBBIsUnlock = function(self)
  -- function num : 0_3 , upvalues : UINNavigationBranchBtn, JumpManager, _ENV
  local isUnlock = nil
  if (self.navigation_subCfg).force_lock then
    isUnlock = false
    self.lockType = (UINNavigationBranchBtn.eLockType).forceLock
  else
    if (self.navigation_subCfg).id == 13 then
      isUnlock = JumpManager:Jump2DynActivityValidate()
      self.lockType = (UINNavigationBranchBtn.eLockType).forceLock
    else
      isUnlock = (CheckCondition.CheckLua)((self.navigation_subCfg).pre_condition, (self.navigation_subCfg).pre_para1, (self.navigation_subCfg).pre_para2)
      self.lockType = (UINNavigationBranchBtn.eLockType).perCoditonLock
      self.lockInfo = (CheckCondition.GetUnlockInfoLua)((self.navigation_subCfg).pre_condition, (self.navigation_subCfg).pre_para1, (self.navigation_subCfg).pre_para2)
    end
  end
  self.isUnlock = isUnlock
  ;
  ((self.ui).obj_isLock):SetActive(not isUnlock)
  if isUnlock and not self.isRedDotInited then
    self:InitNBBRedDot()
  end
  ;
  ((self.ui).obj_redDot):SetActive(false)
end

UINNavigationBranchBtn.GetNBBIsUnlock = function(self)
  -- function num : 0_4
  return self.isUnlock
end

UINNavigationBranchBtn.RefreshIsInThisUI = function(self, bool)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if bool then
    ((self.ui).img_Icon_outline).color = (self.ui).color_yellow
  else
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_Icon_outline).color = Color.white
  end
end

UINNavigationBranchBtn.InitNBBRedDot = function(self)
  -- function num : 0_6 , upvalues : _ENV
  self.isRedDotInited = true
  local redDotPathList = (string.split)((self.navigation_subCfg).red_dot_path, ".")
  if redDotPathList == nil or #redDotPathList == 0 then
    ((self.ui).obj_redDot):SetActive(false)
    return 
  end
  local ok, node = RedDotController:GetRedDotNode((table.unpack)(redDotPathList))
  -- DECOMPILER ERROR at PC38: Unhandled construct in 'MakeBoolean' P1

  if ok and node:GetRedDotCount() <= 0 then
    ((self.ui).obj_redDot):SetActive(not ok)
    self.redDotFunc = function(node)
    -- function num : 0_6_0 , upvalues : self
    ((self.ui).obj_redDot):SetActive(node:GetRedDotCount() > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

    self.redDot = node
    RedDotController:AddListener(node.nodePath, self.redDotFunc)
    ;
    ((self.ui).obj_redDot):SetActive(false)
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end

UINNavigationBranchBtn.GetAllSpecialIds = function(self)
  -- function num : 0_7
  if not (self.navigation_subCfg).special then
    return {}
  end
end

UINNavigationBranchBtn.OnDelete = function(self)
  -- function num : 0_8 , upvalues : _ENV, base
  if self.redDot ~= nil then
    RedDotController:RemoveListener((self.redDot).nodePath, self.redDotFunc)
  end
  ;
  (base.OnDelete)(self)
end

return UINNavigationBranchBtn


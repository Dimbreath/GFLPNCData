local UITopStatus = class("UITopStatus", UIBaseWindow)
local base = UIBaseWindow
local UINTopBtnGroup = require("Game.TopStatus.UINTopBtnGroup")
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local JumpManager = require("Game.Jump.JumpManager")
UITopStatus.OnInit = function(self)
  -- function num : 0_0 , upvalues : UINTopBtnGroup, UINResourceGroup, _ENV
  self.__NavigationWin = nil
  self.topGroup = (UINTopBtnGroup.New)()
  ;
  (self.topGroup):Init((self.ui).topButtonGroup)
  self.resGroup = (UINResourceGroup.New)()
  ;
  (self.resGroup):Init((self.ui).gameResourceGroup)
  self.__OnClickNavigationBarBtn = BindCallback(self, self.OnClickNavigationBarBtn)
  self.__HideNavigation = BindCallback(self, self.HideNavigation)
  ;
  (self.topGroup):SetBtnHomeClickAction(function()
    -- function num : 0_0_0 , upvalues : self
    self:OnClickHomeBtn()
  end
)
end

UITopStatus.ChangeResourceItemClass = function(self, newClass)
  -- function num : 0_1
  (self.resGroup):ChangeResourceItemClass(newClass)
end

UITopStatus.RefreshTopStatusUI = function(self, topData)
  -- function num : 0_2
  self:SetTopStatusResIds(topData.resIds)
  self:SetTopStatusResAddFuncs(topData.resIds, topData.resAddCallbackDic)
  if topData.infoAction ~= nil then
    (self.topGroup):SetInfoClickAction(topData.infoAction)
  end
  self:SetTopButtonGroup(not topData.hideTopButton)
  ;
  (self.topGroup):SetBeforeBackCloseNavigation(self.__HideNavigation)
  ;
  (self.topGroup):SetBtnOpenNavigationClickAction(self.__OnClickNavigationBarBtn)
  ;
  (self.topGroup):RefreshTopGroupUI(topData)
  self:__RefreshNewbeeTopstatus()
end

UITopStatus.__RefreshNewbeeTopstatus = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local completeIntro = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_CompleteIntro)
  if not completeIntro then
    (self.topGroup):ShowTopBtnGroupGoHomeBtn(false)
    ;
    (self.topGroup):RefreshouldShowNaviBtn(false)
    self:SetResourceGroupActive(false)
  end
end

UITopStatus.OnClickHomeBtn = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self.__NavigationWin ~= nil and (self.__NavigationWin).active then
    (self.__NavigationWin):CloseNavigationBar()
    ;
    (UIUtil.ReturnHome)()
  else
    ;
    (UIUtil.ReturnHome)()
  end
end

UITopStatus.OnClickNavigationBarBtn = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.__NavigationWin ~= nil then
    if (self.__NavigationWin).active then
      (self.__NavigationWin):CloseNavigationBar()
    else
      ;
      (self.__NavigationWin):Show()
      ;
      (self.__NavigationWin):RefreshAllBranchItem()
    end
  else
    UIManager:ShowWindowAsync(UIWindowTypeID.NavigationBar, function(win)
    -- function num : 0_5_0 , upvalues : self
    if win == nil then
      return 
    end
    ;
    (win.transform):SetParent(((self.ui).go_NavigationParent).transform, false)
    self.__NavigationWin = win
    ;
    (self.__NavigationWin):RefreshAllBranchItem()
  end
)
  end
end

UITopStatus.HideNavigation = function(self)
  -- function num : 0_6
  if self.__NavigationWin ~= nil and (self.__NavigationWin).active then
    (self.__NavigationWin):CloseNavigationBar()
    return true
  end
end

UITopStatus.SetTopButtonGroup = function(self, active)
  -- function num : 0_7
  ((self.topGroup).gameObject):SetActive(active)
end

UITopStatus.SetTopStatusResIds = function(self, Ids)
  -- function num : 0_8
  if Ids ~= nil then
    (self.resGroup):SetResourceIds(Ids)
    self:SetResourceGroupActive(true)
  else
    self:SetResourceGroupActive(false)
  end
end

UITopStatus.SetTopStatusResAddFuncs = function(self, Ids, addCallbackDic)
  -- function num : 0_9 , upvalues : _ENV, JumpManager
  if Ids == nil then
    return 
  end
  for _,itemId in ipairs(Ids) do
    local addCallback = nil
    if addCallbackDic ~= nil then
      addCallback = addCallbackDic[itemId]
    end
    if addCallback == nil and itemId == ConstGlobalItem.SKey then
      local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
      local quickPurchaseWin = UIManager:GetWindow(UIWindowTypeID.QuickBuyKey)
      if (quickPurchaseWin == nil or quickPurchaseWin.active == false or quickPurchaseWin.isSlideOuting) and shopCtrl:GetIsUnlock() then
        addCallback = function()
    -- function num : 0_9_0 , upvalues : JumpManager
    JumpManager:Jump((JumpManager.eJumpTarget).BuyStamina)
  end

      end
    end
    do
      do
        if addCallback ~= nil then
          (self.resGroup):SetResourceAddBtnFunc(itemId, true, addCallback)
        else
          ;
          (self.resGroup):SetResourceAddBtnFunc(itemId, false, addCallback)
        end
        -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
end

UITopStatus.GetTopStatusResItem = function(self, Id)
  -- function num : 0_10
  return (self.resGroup):GetResourceItem(Id)
end

UITopStatus.SetResourceGroupActive = function(self, active)
  -- function num : 0_11
  ((self.resGroup).gameObject):SetActive(active)
end

UITopStatus.GetResItemPos = function(self, id)
  -- function num : 0_12
  return (self.resGroup):GetResItemPos(id)
end

UITopStatus.OnDelete = function(self)
  -- function num : 0_13 , upvalues : base
  (self.topGroup):Delete()
  ;
  (self.resGroup):Delete()
  ;
  (base.OnDelete)(self)
end

return UITopStatus


-- params : ...
-- function num : 0 , upvalues : _ENV
local UINTopBtnGroup = class("UINTopBtnGroup", UIBaseNode)
local base = UIBaseNode
UINTopBtnGroup.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Back, self, self.__OnBtnBackClick)
  if (self.ui).btn_OpenNavigation ~= nil then
    (UIUtil.AddButtonListener)((self.ui).btn_OpenNavigation, self, self.__OnBtnpenNavigationClick)
    self:RefreshouldShowNaviBtn(true)
  end
  if (self.ui).btn_GoHome ~= nil then
    (UIUtil.AddButtonListener)((self.ui).btn_GoHome, self, self.__OnBtnHomeClick)
    ;
    (((self.ui).btn_GoHome).gameObject):SetActive(false)
  end
  self._showGoHomeBtn = true
  if (self.ui).btn_Info ~= nil then
    (UIUtil.AddButtonListener)((self.ui).btn_Info, self, self.__OnBtnInfoClick)
    ;
    (((self.ui).btn_Info).gameObject):SetActive(false)
  end
  self.__ReddotNodeUpdate = BindCallback(self, self.ReddotNodeUpdate)
  ;
  (((self.ui).btn_Back).gameObject):SetActive(false)
  self:__TryInitBtnHomeRedDot()
end

UINTopBtnGroup.RefreshTopGroupUI = function(self, topData)
  -- function num : 0_1 , upvalues : _ENV
  local topData = (UIUtil.PeekBackStack)()
  local active = self.__onBackClick ~= nil or topData.backAction ~= nil
  ;
  (((self.ui).btn_Back).gameObject):SetActive(active)
  if active then
    (((self.ui).btn_GoHome).gameObject):SetActive(self._showGoHomeBtn)
    self._goHomeBtnActive = active
    if active then
      (((self.ui).btn_OpenNavigation).gameObject):SetActive(self._showNaviBtn)
      ;
      (((self.ui).btn_Info).gameObject):SetActive(topData.infoAction ~= nil)
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
end

UINTopBtnGroup.ShowTopBtnGroupGoHomeBtn = function(self, show)
  -- function num : 0_2
  self._showGoHomeBtn = show
  if self._goHomeBtnActive then
    (((self.ui).btn_GoHome).gameObject):SetActive(self._showGoHomeBtn)
  end
end

UINTopBtnGroup.RefreshouldShowNaviBtn = function(self, show)
  -- function num : 0_3 , upvalues : _ENV
  local couldShow = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_QuickJump)
  self._showNaviBtn = not couldShow or show
  if self._goHomeBtnActive then
    (((self.ui).btn_OpenNavigation).gameObject):SetActive(self._showNaviBtn)
  end
end

UINTopBtnGroup.SetBeforeBackCloseNavigation = function(self, closeNavigationAction)
  -- function num : 0_4
  self.__closeNavigationAction = closeNavigationAction
end

UINTopBtnGroup.SetBackClickAction = function(self, onBackClick)
  -- function num : 0_5
  self.__onBackClick = onBackClick
end

UINTopBtnGroup.__OnBtnBackClick = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.__closeNavigationAction ~= nil and (self.__closeNavigationAction)() then
    return 
  end
  if self.__onBackClick ~= nil then
    local backFunc = self.__onBackClick
    backFunc()
    self.__onBackClick = nil
  else
    do
      ;
      (UIUtil.OnClickBack)()
    end
  end
end

UINTopBtnGroup.SetBtnHomeClickAction = function(self, onHomeClick)
  -- function num : 0_7
  self.__onHomeClick = onHomeClick
end

UINTopBtnGroup.__OnBtnHomeClick = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self.__onHomeClick ~= nil then
    (self.__onHomeClick)()
  else
    ;
    (UIUtil.ReturnHome)()
  end
end

UINTopBtnGroup.SetBtnOpenNavigationClickAction = function(self, onNaviClick)
  -- function num : 0_9
  self.__onNaviClick = onNaviClick
end

UINTopBtnGroup.__OnBtnpenNavigationClick = function(self)
  -- function num : 0_10
  if self.__onNaviClick ~= nil then
    (self.__onNaviClick)()
  end
end

UINTopBtnGroup.SetInfoClickAction = function(self, infoClickAction)
  -- function num : 0_11
  self.__onInfoClick = infoClickAction
end

UINTopBtnGroup.__OnBtnInfoClick = function(self)
  -- function num : 0_12
  if self.__onInfoClick ~= nil then
    (self.__onInfoClick)()
  end
end

UINTopBtnGroup.__TryInitBtnHomeRedDot = function(self)
  -- function num : 0_13 , upvalues : _ENV
  self.redDotDic = {}
  if ConfigData.navigation_sub == nil then
    return 
  end
  for index,cfg in ipairs(ConfigData.navigation_sub) do
    local redDotPathList = (string.split)(cfg.red_dot_path, ".")
    if redDotPathList ~= nil and #redDotPathList ~= 0 then
      local ok, node = RedDotController:GetRedDotNode((table.unpack)(redDotPathList))
      if ok then
        RedDotController:AddListener(node.nodePath, self.__ReddotNodeUpdate)
        -- DECOMPILER ERROR at PC43: Confused about usage of register: R9 in 'UnsetPending'

        ;
        (self.redDotDic)[node] = node:GetRedDotCount() > 0
      end
    end
  end
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Oasis, RedDotStaticTypeId.OasisBuildResMax)
  if ok then
    RedDotController:AddListener(node.nodePath, self.__ReddotNodeUpdate)
    -- DECOMPILER ERROR at PC69: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.redDotDic)[node] = node:GetRedDotCount() > 0
  end
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Task)
  if ok then
    RedDotController:AddListener(node.nodePath, self.__ReddotNodeUpdate)
    -- DECOMPILER ERROR at PC91: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self.redDotDic)[node] = node:GetRedDotCount() > 0
  end
  self:RefreshHomeRedDotFx()
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

UINTopBtnGroup.ReddotNodeUpdate = function(self, node)
  -- function num : 0_14
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  (self.redDotDic)[node] = node:GetRedDotCount() > 0
  self:RefreshHomeRedDotFx()
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINTopBtnGroup.RefreshHomeRedDotFx = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local homeFxActive = false
  for node,boolean in pairs(self.redDotDic) do
    if boolean then
      homeFxActive = true
      break
    end
  end
  do
    if UIManager:GetWindow(UIWindowTypeID.NavigationBar) ~= nil and (UIManager:GetWindow(UIWindowTypeID.NavigationBar)).active then
      ((self.ui).fX_TopStatus):SetActive(false)
    else
      ;
      ((self.ui).fX_TopStatus):SetActive(homeFxActive)
    end
  end
end

UINTopBtnGroup.OnDelete = function(self)
  -- function num : 0_16 , upvalues : _ENV, base
  if self.redDotDic ~= nil and (table.count)(self.redDotDic) > 0 then
    for node,_ in pairs(self.redDotDic) do
      RedDotController:RemoveListener(node.nodePath, self.__ReddotNodeUpdate)
    end
  end
  do
    ;
    (base.OnDelete)(self)
  end
end

return UINTopBtnGroup


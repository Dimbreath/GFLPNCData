-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBossResult = class("UIBossResult", UIBaseWindow)
local base = UIBaseWindow
UIBossResult.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_next, self, self.NextSectionExploration)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_continue, self, self.ContinueSectionExploration)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_exit, self, self.ExitSectionExploration)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_complete, self, self.CompleteSectionExploration)
end

UIBossResult.SetBtnNextClickAction = function(self, nextAction)
  -- function num : 0_1
  self.onNextAction = nextAction
end

UIBossResult.SetBtnContinueClickAction = function(self, continueAction)
  -- function num : 0_2
  self.onContinueAction = continueAction
end

UIBossResult.SetBtnExitClickAction = function(self, exitAction)
  -- function num : 0_3
  self.onExitAction = exitAction
end

UIBossResult.SetBtnCompleteClickAction = function(self, completeAction)
  -- function num : 0_4
  self.onCompleteAction = completeAction
end

UIBossResult.ShowBossResult = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.onNextAction == nil and self.onContinueAction == nil and self.onExitAction == nil and self.onCompleteAction == nil then
    self.onNextAction = BindCallback(self, self.__DefaultAction)
  end
  ;
  ((self.ui).tex_tier):SetIndex(0, tostring(ExplorationManager:GetCurLevelIndex() + 1))
  ;
  (((self.ui).btn_next).gameObject):SetActive(self.onNextAction ~= nil and true or false)
  ;
  (((self.ui).btn_continue).gameObject):SetActive(self.onContinueAction ~= nil and true or false)
  ;
  (((self.ui).btn_exit).gameObject):SetActive(self.onExitAction ~= nil and true or false)
  ;
  (((self.ui).btn_complete).gameObject):SetActive(self.onCompleteAction ~= nil and true or false)
end

UIBossResult.NextSectionExploration = function(self)
  -- function num : 0_6
  if self.onNextAction ~= nil then
    (self.onNextAction)()
  end
  self:__AfterClick()
end

UIBossResult.ContinueSectionExploration = function(self)
  -- function num : 0_7
  if self.onContinueAction ~= nil then
    (self.onContinueAction)()
  end
  self:__AfterClick()
end

UIBossResult.ExitSectionExploration = function(self)
  -- function num : 0_8
  if self.onExitAction ~= nil then
    (self.onExitAction)()
  end
  self:__AfterClick()
end

UIBossResult.CompleteSectionExploration = function(self)
  -- function num : 0_9
  if self.onCompleteAction ~= nil then
    (self.onCompleteAction)()
  end
  self:__AfterClick()
end

UIBossResult.__DefaultAction = function(self)
  -- function num : 0_10 , upvalues : _ENV
  ExplorationManager:EnterNextSectionExploration()
  self:__AfterClick()
end

UIBossResult.__AfterClick = function(self)
  -- function num : 0_11
  self.onNextAction = nil
  self.onContinueAction = nil
  self.onExitAction = nil
  self.onCompleteAction = nil
  self:Delete()
end

UIBossResult.OnDelete = function(self)
  -- function num : 0_12 , upvalues : base
  (base.OnDelete)(self)
end

return UIBossResult

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBossResult = class("UIBossResult", UIBaseWindow)
local base = UIBaseWindow
UIBossResult.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.AddButtonListener)((self.ui).btn_next, self,
                               self.NextSectionExploration);
    (UIUtil.AddButtonListener)((self.ui).btn_continue, self,
                               self.ContinueSectionExploration);
    (UIUtil.AddButtonListener)((self.ui).btn_exit, self,
                               self.ExitSectionExploration);
    (UIUtil.AddButtonListener)((self.ui).btn_complete, self,
                               self.CompleteSectionExploration)
end

UIBossResult.SetBtnNextClickAction = function(self, nextAction)
    -- function num : 0_1
    self.onNextAction = nextAction
end

UIBossResult.SetBtnContinueClickAction =
    function(self, continueAction)
        -- function num : 0_2
        self.onContinueAction = continueAction
    end

UIBossResult.SetBtnExitClickAction = function(self, exitAction)
    -- function num : 0_3
    self.onExitAction = exitAction
end

UIBossResult.SetBtnCompleteClickAction =
    function(self, completeAction)
        -- function num : 0_4
        self.onCompleteAction = completeAction
    end

UIBossResult.ShowBossResult = function(self)
    -- function num : 0_5 , upvalues : _ENV
    if self.onNextAction == nil and self.onContinueAction == nil and
        self.onExitAction == nil and self.onCompleteAction == nil then
        self.onNextAction = BindCallback(self, self.__DefaultAction)
    end
    ((self.ui).tex_tier):SetIndex(0, tostring(
                                      ExplorationManager:GetCurLevelIndex() + 1));
    (((self.ui).btn_next).gameObject):SetActive(
        self.onNextAction ~= nil and true or false);
    (((self.ui).btn_continue).gameObject):SetActive(
        self.onContinueAction ~= nil and true or false);
    (((self.ui).btn_exit).gameObject):SetActive(
        self.onExitAction ~= nil and true or false);
    (((self.ui).btn_complete).gameObject):SetActive(
        self.onCompleteAction ~= nil and true or false)
end

UIBossResult.NextSectionExploration = function(self)
    -- function num : 0_6
    if self.onNextAction ~= nil then (self.onNextAction)() end
    self:__AfterClick()
end

UIBossResult.ContinueSectionExploration =
    function(self)
        -- function num : 0_7
        if self.onContinueAction ~= nil then (self.onContinueAction)() end
        self:__AfterClick()
    end

UIBossResult.ExitSectionExploration = function(self)
    -- function num : 0_8
    if self.onExitAction ~= nil then (self.onExitAction)() end
    self:__AfterClick()
end

UIBossResult.CompleteSectionExploration =
    function(self)
        -- function num : 0_9
        if self.onCompleteAction ~= nil then (self.onCompleteAction)() end
        self:__AfterClick()
    end

UIBossResult.__DefaultAction = function(self)
    -- function num : 0_10 , upvalues : _ENV
    ExplorationManager:EnterNextSectionExploration()
    self:__AfterClick()
end

UIBossResult.__AfterClick = function(self)
    -- function num : 0_11
    self.onNextAction = nil
    self.onContinueAction = nil
    self.onExitAction = nil
    self.onCompleteAction = nil
    self:Delete()
end

UIBossResult.OnDelete = function(self)
    -- function num : 0_12 , upvalues : base
    (base.OnDelete)(self)
end

return UIBossResult


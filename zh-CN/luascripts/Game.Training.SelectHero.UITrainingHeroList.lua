-- params : ...
-- function num : 0 , upvalues : _ENV
local UITrainingHeroList = class("UITrainingHeroList", UIBaseWindow)
local base = UIBaseWindow
local UINHeroSortList = require("Game.Hero.SortList.UINHeroSortList")
local HeroUpgradePreviewNode = require("Game.Training.SelectHero.UIHeroUpgradePreviewNode")
local TrainingPlanNode = require("Game.Training.SelectHero.UITrainingPlanNode")
UITrainingHeroList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.OnTrainingHeroEvent = nil
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.__OnClickReturn)
  self.__refreshSelectHeroUI = BindCallback(self, self.__RefreshCureSelectHeroUIData)
end

UITrainingHeroList.InitHeroList = function(self, resloader, efficiencyCfg)
  -- function num : 0_1 , upvalues : HeroUpgradePreviewNode, TrainingPlanNode, _ENV, UINHeroSortList
  self.resloader = resloader
  self.heroPreviewNode = (HeroUpgradePreviewNode.New)()
  ;
  (self.heroPreviewNode):Init((self.ui).attributeNode)
  self.trainingPlanNode = (TrainingPlanNode.New)()
  ;
  (self.trainingPlanNode):Init((self.ui).planNode)
  ;
  (self.trainingPlanNode):InitPlanNode(resloader, efficiencyCfg)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.trainingPlanNode).OnSelectEvent = BindCallback(self, self.__OnSelectPlan)
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.trainingPlanNode).OnConfirmEvent = BindCallback(self, self.__OnConfirmSelectPlan)
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.trainingPlanNode).OnCancelEvent = BindCallback(self, self.__OnCancelSelectPlan)
  self.panelSortList = (UINHeroSortList.New)()
  ;
  (self.panelSortList):Init((self.ui).heroSortListNode)
  ;
  (self.panelSortList):InitHeroSortList(self.resloader, self.__refreshSelectHeroUI)
  ;
  (self.panelSortList):RefreshHeroList()
end

UITrainingHeroList.__RefreshCureSelectHeroUIData = function(self, heroData)
  -- function num : 0_2
  self.selectHero = heroData
  ;
  (self.heroPreviewNode):InitHeroData(heroData)
  ;
  (self.trainingPlanNode):ResetSelect()
end

UITrainingHeroList.__OnSelectPlan = function(self, totalExp)
  -- function num : 0_3
  (self.heroPreviewNode):RefreshNextExp(totalExp)
end

UITrainingHeroList.__OnCancelSelectPlan = function(self)
  -- function num : 0_4
  (self.heroPreviewNode):RefreshNextExp(0)
end

UITrainingHeroList.__OnConfirmSelectPlan = function(self, efficencyId, costExp)
  -- function num : 0_5
  if self.OnTrainingHeroEvent ~= nil then
    (self.OnTrainingHeroEvent)((self.selectHero).dataId, efficencyId, costExp)
  end
end

UITrainingHeroList.__OnClickReturn = function(self)
  -- function num : 0_6
  self:Delete()
end

UITrainingHeroList.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  self.resloader = nil
  if self.panelSortList ~= nil then
    (self.panelSortList):Delete()
    self.panelSortList = nil
  end
  if self.trainingPlanNode ~= nil then
    (self.trainingPlanNode):Delete()
    self.trainingPlanNode = nil
  end
  if self.heroPreviewNode ~= nil then
    (self.heroPreviewNode):Delete()
    self.heroPreviewNode = nil
  end
  ;
  (base.OnDelete)(self)
end

return UITrainingHeroList

-- params : ...
-- function num : 0 , upvalues : _ENV
local UITrainingHeroList = class("UITrainingHeroList", UIBaseWindow)
local base = UIBaseWindow
local UINHeroSortList = require("Game.Hero.SortList.UINHeroSortList")
local HeroUpgradePreviewNode = require(
                                   "Game.Training.SelectHero.UIHeroUpgradePreviewNode")
local TrainingPlanNode = require("Game.Training.SelectHero.UITrainingPlanNode")
UITrainingHeroList.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    self.OnTrainingHeroEvent = nil;
    (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.__OnClickReturn)
    self.__refreshSelectHeroUI = BindCallback(self,
                                              self.__RefreshCureSelectHeroUIData)
end

UITrainingHeroList.InitHeroList = function(self, resloader, efficiencyCfg)
    -- function num : 0_1 , upvalues : HeroUpgradePreviewNode, TrainingPlanNode, _ENV, UINHeroSortList
    self.resloader = resloader
    self.heroPreviewNode = (HeroUpgradePreviewNode.New)();
    (self.heroPreviewNode):Init((self.ui).attributeNode)
    self.trainingPlanNode = (TrainingPlanNode.New)();
    (self.trainingPlanNode):Init((self.ui).planNode);
    (self.trainingPlanNode):InitPlanNode(resloader, efficiencyCfg) -- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.trainingPlanNode).OnSelectEvent =
        BindCallback(self, self.__OnSelectPlan) -- DECOMPILER ERROR at PC33: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.trainingPlanNode).OnConfirmEvent =
        BindCallback(self, self.__OnConfirmSelectPlan) -- DECOMPILER ERROR at PC39: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.trainingPlanNode).OnCancelEvent =
        BindCallback(self, self.__OnCancelSelectPlan)
    self.panelSortList = (UINHeroSortList.New)();
    (self.panelSortList):Init((self.ui).heroSortListNode);
    (self.panelSortList):InitHeroSortList(self.resloader,
                                          self.__refreshSelectHeroUI);
    (self.panelSortList):RefreshHeroList()
end

UITrainingHeroList.__RefreshCureSelectHeroUIData =
    function(self, heroData)
        -- function num : 0_2
        self.selectHero = heroData;
        (self.heroPreviewNode):InitHeroData(heroData);
        (self.trainingPlanNode):ResetSelect()
    end

UITrainingHeroList.__OnSelectPlan = function(self, totalExp)
    -- function num : 0_3
    (self.heroPreviewNode):RefreshNextExp(totalExp)
end

UITrainingHeroList.__OnCancelSelectPlan =
    function(self)
        -- function num : 0_4
        (self.heroPreviewNode):RefreshNextExp(0)
    end

UITrainingHeroList.__OnConfirmSelectPlan =
    function(self, efficencyId, costExp)
        -- function num : 0_5
        if self.OnTrainingHeroEvent ~= nil then
            (self.OnTrainingHeroEvent)((self.selectHero).dataId, efficencyId,
                                       costExp)
        end
    end

UITrainingHeroList.__OnClickReturn = function(self)
    -- function num : 0_6
    self:Delete()
end

UITrainingHeroList.OnDelete = function(self)
    -- function num : 0_7 , upvalues : base
    self.resloader = nil
    if self.panelSortList ~= nil then
        (self.panelSortList):Delete()
        self.panelSortList = nil
    end
    if self.trainingPlanNode ~= nil then
        (self.trainingPlanNode):Delete()
        self.trainingPlanNode = nil
    end
    if self.heroPreviewNode ~= nil then
        (self.heroPreviewNode):Delete()
        self.heroPreviewNode = nil
    end
    (base.OnDelete)(self)
end

return UITrainingHeroList


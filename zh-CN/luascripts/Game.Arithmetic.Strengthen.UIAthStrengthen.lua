-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthStrengthen = class("UIAthStrengthen", UIBaseWindow)
local base = UIBaseWindow
local UINAthOptimal = require("Game.Arithmetic.Strengthen.UINAthOptimal")
local UIAthSortList = require("Game.Arithmetic.SortList.UIAthSortList")
local UIAthInherit = require("Game.Arithmetic.Strengthen.UIAthInherit")
UIAthStrengthen.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.AddValueChangedListener)((self.ui).tog_ATHItem0, self,
                                     self.OnClickOptimalNode);
    (UIUtil.AddValueChangedListener)((self.ui).tog_ATHItem1, self,
                                     self.OnClickInheritNode);
    (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.OnClickReturn)
end

UIAthStrengthen.InitAthStrengthen = function(self, athData)
    -- function num : 0_1
    self.athData = athData
    self:ShowOptimal(athData)
    self:__ShowOtherWindow(false)
end

UIAthStrengthen.__ShowOtherWindow = function(self, show)
    -- function num : 0_2 , upvalues : _ENV
    local heroWindow = UIManager:GetWindow(UIWindowTypeID.HeroList)
    if heroWindow ~= nil then
        if show then
            heroWindow:Show()
        else
            heroWindow:Hide()
        end
    end
    local detailWindow = UIManager:GetWindow(UIWindowTypeID.AthDetail)
    if detailWindow ~= nil then
        if show then
            detailWindow:Show()
        else
            detailWindow:Hide()
        end
    end
end

UIAthStrengthen.ShowOptimal = function(self, athData)
    -- function num : 0_3 , upvalues : UINAthOptimal
    if self.optimalNode == nil then
        self.optimalNode = (UINAthOptimal.New)();
        (self.optimalNode):Init((self.ui).optimalNode)
    end
    (self.optimalNode):Show();
    (self.optimalNode):InitAthOptimal(athData)
end

UIAthStrengthen.HideOptimal = function(self)
    -- function num : 0_4
    if self.optimalNode ~= nil then (self.optimalNode):Hide() end
end

UIAthStrengthen.OnClickOptimalNode = function(self, isOn)
    -- function num : 0_5
    if not isOn then return end
    self:HideInherit()
    self:ShowOptimal(self.athData)
end

UIAthStrengthen.OnClickInheritNode = function(self, isOn)
    -- function num : 0_6 , upvalues : UIAthInherit
    if not isOn then return end
    self:HideOptimal()
    if self.uiAthInheritNode == nil then
        self.uiAthInheritNode = (UIAthInherit.New)();
        (self.uiAthInheritNode):Init((self.ui).inheritNode)
    end
    (self.uiAthInheritNode):OnInitData(self.athData);
    (self.uiAthInheritNode):Show()
end

UIAthStrengthen.HideInherit = function(self)
    -- function num : 0_7
    if self.uiAthInheritNode ~= nil then (self.uiAthInheritNode):Hide() end
end

UIAthStrengthen.OnClickReturn = function(self)
    -- function num : 0_8
    self:Delete()
end

UIAthStrengthen.OnDelete = function(self)
    -- function num : 0_9 , upvalues : base
    if self.optimalNode ~= nil then (self.optimalNode):Delete() end
    if self.uiAthInheritNode ~= nil then (self.uiAthInheritNode):Delete() end
    self:__ShowOtherWindow(true);
    (base.OnDelete)(self)
end

return UIAthStrengthen


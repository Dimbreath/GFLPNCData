-- params : ...
-- function num : 0 , upvalues : _ENV
local UIFloatText = class("UIFloatText", UIBaseWindow)
local base = UIBaseWindow
local UIFloatTextItem = require("Game.CommonUI.FloatText.UIFloatTextItem")
local MinIntervalShowText = 30
UIFloatText.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UIFloatTextItem
    self.__update_handle = BindCallback(self, self.Update)
    UpdateManager:AddUpdate(self.__update_handle)
    self.floatTextItemPool = (UIItemPool.New)(UIFloatTextItem,
                                              (self.ui).floatTextItem)
    self.textDataQue = {}
    self.lastShowTextFrame = 0
end

UIFloatText.Update = function(self)
    -- function num : 0_1 , upvalues : _ENV, MinIntervalShowText
    self.lastShowTextFrame = (math.max)(0, self.lastShowTextFrame - 1)
    if self.lastShowTextFrame == 0 and #self.textDataQue > 0 then
        local textData = (table.remove)(self.textDataQue, 1)
        self:__ShowTextInternal(textData)
        self.lastShowTextFrame = MinIntervalShowText
    end
end

UIFloatText.ShowFloatText = function(self, position, textContent, color)
    -- function num : 0_2 , upvalues : _ENV
    local data = {position = position, textContent = textContent, color = color};
    (table.insert)(self.textDataQue, data)
end

UIFloatText.__ShowTextInternal = function(self, textData)
    -- function num : 0_3 , upvalues : _ENV
    local item = (self.floatTextItemPool):GetOne()
    item:InitFloatTextItem(textData.position, textData.textContent,
                           textData.color,
                           BindCallback(self, self.RecoveryFloatText))
end

UIFloatText.RecoveryFloatText = function(self, floatTextItem)
    -- function num : 0_4
    (self.floatTextItemPool):HideOne(floatTextItem)
end

UIFloatText.OnDelete = function(self)
    -- function num : 0_5 , upvalues : _ENV, base
    UpdateManager:RemoveUpdate(self.__update_handle);
    (self.floatTextItemPool):DeleteAll();
    (base.OnDelete)(self)
end

return UIFloatText


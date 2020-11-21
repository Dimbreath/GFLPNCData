-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAchivTypeToggle = class("UIAchivTypeToggle", UIBaseNode)
local base = UIBaseNode
UIAchivTypeToggle.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddValueChangedListener)((self.ui).toggle, self, self.OnPageChanged)
end

UIAchivTypeToggle.InitAchivTypeToggle = function(self, id, name, isOn,
                                                 onChangedEvent)
    -- function num : 0_1 , upvalues : _ENV
    self.id = id -- DECOMPILER ERROR at PC7: Confused about usage of register: R5 in 'UnsetPending'
    ;
    ((self.ui).tex_TypeName).text = (LanguageUtil.GetLocaleText)(name) -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'
    ;
    ((self.ui).toggle).isOn = isOn
    self.onChangedEvent = onChangedEvent
end

UIAchivTypeToggle.OnPageChanged = function(self, value)
    -- function num : 0_2
    if self.onChangedEvent ~= nil and value then
        (self.onChangedEvent)(self.id)
    end
end

UIAchivTypeToggle.ShowAchivTypeToggleRedDot =
    function(self, show)
        -- function num : 0_3
        ((self.ui).img_RedDot):SetActive(show)
    end

UIAchivTypeToggle.OnDelete = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnDelete)(self)
end

return UIAchivTypeToggle


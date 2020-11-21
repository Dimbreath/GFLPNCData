-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthEfficiencyUpSuccess = class("UIAthEfficiencyUpSuccess", UIBaseWindow)
local base = UIBaseWindow
UIAthEfficiencyUpSuccess.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.__OnClickClose)
end

UIAthEfficiencyUpSuccess.InitAthEffiUpSuccess =
    function(self, fromValue, toValue)
        -- function num : 0_1
        -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

        ((self.ui).tex_CurNum).text = fromValue -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).tex_NewNum).text = toValue
    end

UIAthEfficiencyUpSuccess.__OnClickClose =
    function(self)
        -- function num : 0_2
        self:Delete()
    end

UIAthEfficiencyUpSuccess.OnDelete = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnDelete)(self)
end

return UIAthEfficiencyUpSuccess


-- params : ...
-- function num : 0 , upvalues : _ENV
local UINEventRoomRandomOptionButton = class("UINEventRoomRandomOptionButton",
                                             UIBaseNode)
local base = UIBaseNode
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
UINEventRoomRandomOptionButton.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).optionButton, self, self.OnClick)
end

UINEventRoomRandomOptionButton.InitNormalButton =
    function(self, cfg, idx, clickCallback)
        -- function num : 0_1 , upvalues : _ENV
        -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

        ((self.ui).btnText).text = tostring(cfg.id) -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'
        ;
        ((self.ui).tipText).text = "普通选项"
        self.cfg = cfg
        self.idx = idx
        self.clickCallback = clickCallback
    end

UINEventRoomRandomOptionButton.InitRandomButton =
    function(self, cfg, idx, clickCallback)
        -- function num : 0_2 , upvalues : _ENV
        -- DECOMPILER ERROR at PC6: Confused about usage of register: R4 in 'UnsetPending'

        ((self.ui).btnText).text = (LanguageUtil.GetLocaleText)(cfg.name) -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'
        ;
        ((self.ui).tipText).text = "判定" ..
                                       (LanguageUtil.GetLocaleText)(
                                           ((ConfigData.career)[cfg.judge_profession]).name)
        self.cfg = cfg
        self.idx = idx
        self.clickCallback = clickCallback
    end

UINEventRoomRandomOptionButton.OnClick =
    function(self)
        -- function num : 0_3
        if self.clickCallback ~= nil then
            (self.clickCallback)(self.cfg, self.idx)
        end
    end

UINEventRoomRandomOptionButton.OnDelete =
    function(self)
        -- function num : 0_4 , upvalues : base
        (base.OnDelete)(self)
    end

return UINEventRoomRandomOptionButton


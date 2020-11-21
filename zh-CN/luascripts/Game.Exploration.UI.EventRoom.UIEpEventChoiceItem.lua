-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEpEventChoiceItem = class("UIEpEventChoiceItem", UIBaseNode)
local base = UIBaseNode
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
UIEpEventChoiceItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_choiceItem, self,
                               self.OnChoiceItemClick)
end

UIEpEventChoiceItem.InitEventChoiceItem =
    function(self, choiceData, clickAction)
        -- function num : 0_1
        self.idx = choiceData.idx
        self.choiceId = choiceData.choiceId
        self.onClickAction = clickAction
        self.catId = choiceData.catId
        self:RefreshChoiceUI(choiceData)
    end

UIEpEventChoiceItem.RefreshChoiceUI = function(self, choiceData)
    -- function num : 0_2 , upvalues : ExplorationEnum, _ENV
    if choiceData.catId == (ExplorationEnum.eEventRoomChoiceType).Normal then
        self.cfg = (ConfigData.event_choice)[choiceData.choiceId]
        if self.cfg == nil then
            error("Can`t find choiceCfg id:" .. tostring(choiceData.choiceId))
            return
        end
    else
        if choiceData.catId == (ExplorationEnum.eEventRoomChoiceType).Upgrade then
            self.cfg = (ConfigData.event_upgrade)[choiceData.choiceId]
        end
    end -- DECOMPILER ERROR at PC39: Confused about usage of register: R2 in 'UnsetPending'
    
    ((self.ui).tex_Describe).text = (LanguageUtil.GetLocaleText)(
                                        (self.cfg).describe) -- DECOMPILER ERROR at PC49: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).img_Icon).sprite = CRH:GetSprite((self.cfg).icon,
                                                CommonAtlasType.ExplorationIcon)
    -- DECOMPILER ERROR at PC62: Confused about usage of register: R2 in 'UnsetPending'

    if not (self.cfg).choice_color or not Color.white then
        ((self.ui).tex_Describe).color = Color.black
        -- DECOMPILER ERROR at PC85: Confused about usage of register: R2 in 'UnsetPending'

        if not (self.cfg).choice_color or not (Color.New)(1, 1, 1, 0.3) then
            ((self.ui).img_IconBg).color = (Color.New)(0, 0, 0, 0.7);
            ((self.ui).img_Buttom):SetIndex((self.cfg).choice_color and 1 or 0)
            if choiceData.isAble ~= nil then
                self:SetItemCanClick(choiceData.isAble)
            end
        end
    end
end

UIEpEventChoiceItem.SetItemCanClick = function(self, isAble)
    -- function num : 0_3 , upvalues : _ENV
    self.isAble = isAble
    if not isAble or not Color.white then
        local color = (self.ui).col_CantSelect
    end -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'
    
    (((self.ui).img_Buttom).image).color = color -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.ui).img_Icon).color = color;
    ((self.ui).ani_Select):SetActive(isAble)
end

UIEpEventChoiceItem.OnChoiceItemClick = function(self)
    -- function num : 0_4
    if self.onClickAction ~= nil then
        (self.onClickAction)(self.cfg, self.idx, self.isAble, self.catId)
    end
end

return UIEpEventChoiceItem


-- params : ...
-- function num : 0 , upvalues : _ENV
local UINTaskPeroidNodeItem = class("UINTaskPeroidNodeItem", UIBaseWindow)
local base = UIBaseWindow
local TaskEnum = require("Game.Task.TaskEnum")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
UINTaskPeroidNodeItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINBaseItem
    self.ctrl = ControllerManager:GetController(ControllerTypeId.Task);
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self.closeViewState = BindCallback(self, self.SetViewState, false)
    self.baseItem = (UINBaseItem.New)();
    (self.baseItem):Init((self.ui).uINBaseItem)
    self._OnClick = BindCallback(self, self.OnClick)
end

UINTaskPeroidNodeItem.InitPeroidItem = function(self, index, eTaskState, point,
                                                itemCfg, num, viewReward, data)
    -- function num : 0_1 , upvalues : _ENV, TaskEnum
    self.data = data
    self.index = index
    self.eTaskState = eTaskState;
    (self.baseItem):InitBaseItem(itemCfg, self._OnClick) -- DECOMPILER ERROR at PC13: Confused about usage of register: R8 in 'UnsetPending'
    ;
    ((self.ui).tex_Point).text = tostring(point) -- DECOMPILER ERROR at PC19: Confused about usage of register: R8 in 'UnsetPending'
    ;
    ((self.ui).tex_Count).text = tostring(num)
    self.viewReward = viewReward
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R8 in 'UnsetPending'

    if eTaskState == (TaskEnum.eTaskState).Completed then
        ((self.ui).img_trangle).color = (self.ui).color_oragnge;
        ((self.ui).obj_canPick):SetActive(true)
        self:SetRedDotActive(true)
    else
        -- DECOMPILER ERROR at PC47: Confused about usage of register: R8 in 'UnsetPending'

        if eTaskState == (TaskEnum.eTaskState).Picked then
            ((self.ui).img_trangle).color = (self.ui).color_oragnge;
            ((self.ui).obj_isPicked):SetActive(true);
            ((self.ui).obj_canPick):SetActive(false)
            self:SetRedDotActive(false)
        else
            -- DECOMPILER ERROR at PC70: Confused about usage of register: R8 in 'UnsetPending'

            if eTaskState == (TaskEnum.eTaskState).InProgress then
                ((self.ui).img_trangle).color = (self.ui).color_black;
                ((self.ui).obj_isPicked):SetActive(false);
                ((self.ui).obj_canPick):SetActive(false)
                self:SetRedDotActive(false)
            end
        end
    end
end

UINTaskPeroidNodeItem.OnClick = function(self)
    -- function num : 0_2 , upvalues : TaskEnum, HAType, VAType
    if self.eTaskState == (TaskEnum.eTaskState).Completed then
        (self.ctrl):SendCommitTaskPeriod(self.index)
    else

        (self.viewReward):Show();
        (self.viewReward):FloatTo(self.transform, HAType.autoCenter, VAType.up);
        (self.viewReward):RefreshItems(((self.data).stcData).rewardIds,
                                       ((self.data).stcData).rewardNums,
                                       self.closeViewState)
        self:SetViewState(true)
    end
end

UINTaskPeroidNodeItem.SetViewState = function(self, bool)
    -- function num : 0_3
    ((self.ui).obj_viewState):SetActive(bool)
end

UINTaskPeroidNodeItem.SetRedDotActive = function(self, bool)
    -- function num : 0_4
    ((self.ui).obj_RedDot):SetActive(bool)
end

UINTaskPeroidNodeItem.OnDelete = function(self)
    -- function num : 0_5 , upvalues : base
    (base.OnDelete)(self)
end

return UINTaskPeroidNodeItem


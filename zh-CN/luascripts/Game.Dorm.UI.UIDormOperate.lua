-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDormOperate = class("UIDormOperate", UIBaseWindow)
local base = UIBaseWindow
UIDormOperate.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.AddButtonListener)((self.ui).btn_Recycle, self,
                               self.OnRecycleClicked);
    (UIUtil.AddButtonListener)((self.ui).btn_Decompose, self,
                               self.OnDecomposeClicked);
    (UIUtil.AddButtonListener)((self.ui).btn_RecycleFnt, self,
                               self.OnRecycleFntClicked);
    (UIUtil.AddButtonListener)((self.ui).btn_Rote, self, self.OnRotateFntClicked)
    self.dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
end

UIDormOperate.InitDormHouseOperate = function(self, position, isBpRoom)
    -- function num : 0_1 , upvalues : _ENV
    ((self.ui).panel_House):SetActive(true);
    ((self.ui).panel_Room):SetActive(false)
    local uiPosition = UIManager:World2UIPosition(position) -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'
    ;
    (((self.ui).panel_House).transform).localPosition =
        (Vector3.New)(uiPosition.x, uiPosition.y, 0);
    (((self.ui).btn_Decompose).gameObject):SetActive(not isBpRoom)
end

UIDormOperate.ShowFntOperate = function(self, show, rotEnable)
    -- function num : 0_2
    ((self.ui).panel_House):SetActive(false);
    ((self.ui).panel_Room):SetActive(show);
    (((self.ui).btn_Rote).gameObject):SetActive(rotEnable)
end

UIDormOperate.UpdateFntOpPos = function(self, position)
    -- function num : 0_3 , upvalues : _ENV
    if ((self.ui).panel_Room).activeSelf then
        local uiPosition = UIManager:World2UIPosition(position) -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'
        ;
        (((self.ui).panel_Room).transform).localPosition =
            (Vector3.New)(uiPosition.x, uiPosition.y, 0)
    end
end

UIDormOperate.OnRecycleClicked = function(self)
    -- function num : 0_4
    ((self.dormCtrl).houseCtrl):RecycleHouseRoom()
end

UIDormOperate.OnDecomposeClicked = function(self)
    -- function num : 0_5 , upvalues : _ENV
    ((CS.MessageCommon).ShowMessageBox)(ConfigData:GetTipContent(
                                            TipContent.dorm_ConfirmDecomposeRoom),
                                        function()
        -- function num : 0_5_0 , upvalues : self
        ((self.dormCtrl).houseCtrl):DecomposeHouseRoom()
    end, nil)
end

UIDormOperate.OnRecycleFntClicked = function(self)
    -- function num : 0_6
    ((self.dormCtrl).roomCtrl):RecycleFntSelect()
end

UIDormOperate.OnRotateFntClicked = function(self)
    -- function num : 0_7
    ((self.dormCtrl).roomCtrl):RotateFnt()
end

UIDormOperate.OnDelete = function(self)
    -- function num : 0_8 , upvalues : base
    (base.OnDelete)(self)
end

return UIDormOperate


-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthEfficiencyOneKeyFiltrate = class("UINAthEfficiencyOneKeyFiltrate",
                                             UIBaseNode)
local base = UIBaseNode
local UINAthEfccOneKeyFiltItem = require(
                                     "Game.Arithmetic.AthEfficiency.UINAthEfccOneKeyFiltItem")
local eAthEfccAutoSelectType = require(
                                   "Game.Arithmetic.Enum.eAthEfccAutoSelectType")
UINAthEfficiencyOneKeyFiltrate.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINAthEfccOneKeyFiltItem
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self,
                               self.__OnConfirmClick);
    (UIUtil.AddButtonListener)((self.ui).btn_Reset, self, self.__OnResetClick);
    (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.__OnClickClose)
    self.__OnSelectFilt = BindCallback(self, self.OnSelectFilt);
    ((self.ui).obj_kindItem):SetActive(false)
    self.filtItemPool = (UIItemPool.New)(UINAthEfccOneKeyFiltItem,
                                         (self.ui).obj_kindItem)
    self.filtItemDic = {}
    self.selectDic = {}
end

UINAthEfficiencyOneKeyFiltrate.InitAthEfccOneKeyFilt =
    function(self, confirmFunc)
        -- function num : 0_1 , upvalues : _ENV, eAthEfccAutoSelectType
        self.confirmFunc = confirmFunc;
        (self.filtItemPool):HideAll()
        for k, v in ipairs(eAthEfccAutoSelectType) do
            local filteItem = (self.filtItemPool):GetOne()
            filteItem:InitAthEfccOneKeyFiltItem(v, self.__OnSelectFilt,
                                                (self.selectDic)[v]) -- DECOMPILER ERROR at PC18: Confused about usage of register: R8 in 'UnsetPending'
            ;
            (self.filtItemDic)[v] = filteItem
        end
        self:Show()
    end

UINAthEfficiencyOneKeyFiltrate.OnSelectFilt =
    function(self, index, select)
        -- function num : 0_2
        -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

        (self.selectDic)[index] = select
    end

UINAthEfficiencyOneKeyFiltrate.__OnConfirmClick =
    function(self)
        -- function num : 0_3
        if self.confirmFunc ~= nil then
            (self.confirmFunc)(self.selectDic)
            self:Hide()
        end
    end

UINAthEfficiencyOneKeyFiltrate.__OnResetClick =
    function(self)
        -- function num : 0_4 , upvalues : _ENV
        self.selectDic = {}
        for k, v in pairs(self.filtItemDic) do
            v:InitAthEfccOneKeyFiltItem(k, self.__OnSelectFilt,
                                        (self.selectDic)[k])
        end
    end

UINAthEfficiencyOneKeyFiltrate.__OnClickClose =
    function(self)
        -- function num : 0_5
        self:Hide()
    end

UINAthEfficiencyOneKeyFiltrate.OnDelete =
    function(self)
        -- function num : 0_6 , upvalues : base
        (self.filtItemPool):DeleteAll();
        (base.OnDelete)(self)
    end

return UINAthEfficiencyOneKeyFiltrate


-- params : ...
-- function num : 0 , upvalues : _ENV
local New_UIMail = class("New_UIMail", UIBaseWindow)
local base = UIBaseWindow
local JumpManager = require("Game.Jump.JumpManager")
local MailEnum = require("Game.Mail.MailEnum")
local UINMailListItem = require("Game.Mail.UI.UINMailListItem")
local UINMailContent = require("Game.Mail.UI.UINMailContent")
New_UIMail.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINMailContent
    self.mailDataList = {}
    self.mailItemDic = {}
    self.ctrl = ControllerManager:GetController(ControllerTypeId.Mail, true);
    (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.Delete);
    (UIUtil.AddButtonListener)((self.ui).btn_GetAll, self, self.GetAllRewards);
    (UIUtil.AddButtonListener)((self.ui).btn_Delete, self,
                               self.DeletAllReadedMail)
    self._OnClickMailItem = BindCallback(self, self.OnClickMailItem) -- DECOMPILER ERROR at PC43: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).loopList_mails).onInstantiateItem =
        BindCallback(self, self.m_OnNewItem) -- DECOMPILER ERROR at PC50: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).loopList_mails).onChangeItem =
        BindCallback(self, self.m_OnChangeItem)
    self.mailContent = (UINMailContent.New)();
    (self.mailContent):Init((self.ui).detail)
    self._m_MailDiff = BindCallback(self, self.m_MailDiff)
    MsgCenter:AddListener(eMsgEventId.OnMailDiff, self._m_MailDiff)
    self._m_MailDelete = BindCallback(self, self.m_MailDelete)
    MsgCenter:AddListener(eMsgEventId.OnMailDelete, self._m_MailDelete)
end

New_UIMail.OnShow = function(self)
    -- function num : 0_1 , upvalues : base
    (base.OnShow)(self);
    (self.ctrl):OnMailUIShow(function()
        -- function num : 0_1_0 , upvalues : self
        self:RefreshMailList((self.ctrl):GetMailDataList())
        self:OpenFirstMail()
    end)
end

New_UIMail.RefreshMailList = function(self, dataList)
    -- function num : 0_2 , upvalues : _ENV
    local num = #dataList
    self.mailDataList = dataList
    if num > 0 then
        ((self.ui).empty):SetActive(false);
        ((self.ui).layoutGroup):SetActive(true);
        ((self.ui).btnGroup):SetActive(true) -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).loopList_mails).totalCount = num;
        ((self.ui).loopList_mails):RefillCells()
    else

        ((self.ui).empty):SetActive(true);
        ((self.ui).layoutGroup):SetActive(false);
        ((self.ui).btnGroup):SetActive(false)
    end
    local numLimit = (ConfigData.game_config).MailNumLimit;
    ((self.ui).tex_Count):SetIndex(0, tostring(num), tostring(numLimit))
    if num == 0 then (self.mailContent):UpdateContent() end
end

New_UIMail.m_OnNewItem = function(self, go)
    -- function num : 0_3 , upvalues : UINMailListItem
    local mailItem = (UINMailListItem.New)()
    mailItem:Init(go)
    mailItem:SetCallback(self._OnClickMailItem) -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.mailItemDic)[go] = mailItem
end

New_UIMail.m_OnChangeItem = function(self, go, index)
    -- function num : 0_4 , upvalues : _ENV
    local mailItem = (self.mailItemDic)[go]
    if mailItem == nil then
        error("Can\'t find mailItem by gameObject")
        return
    end
    local mailData = (self.mailDataList)[index + 1]
    if mailData == nil then
        error("Can\'t find mailData by index, index = " .. tonumber(index))
    end
    mailItem:InitMailItem(mailData)
end

New_UIMail.m_GetItemByData = function(self, data)
    -- function num : 0_5 , upvalues : _ENV
    for k, v in ipairs(self.mailDataList) do
        if v == data then
            local index = k - 1
            return self:m_GetItemGoByIndex(index)
        end
    end
end

New_UIMail.m_GetItemGoByIndex = function(self, index)
    -- function num : 0_6
    local go = ((self.ui).loopList_mails):GetCellByIndex(index)
    if go ~= nil then return (self.mailItemDic)[go] end
    return nil
end

New_UIMail.m_MailDiff = function(self, diffDatas, hasNew)
    -- function num : 0_7 , upvalues : _ENV
    if hasNew then
        self:RefreshMailList((self.ctrl):GetMailDataList())
        return
    end
    for _, mailData in ipairs(diffDatas) do
        local mailItem = self:m_GetItemByData(mailData)
        if mailItem ~= nil then
            mailItem:InitMailItem(mailData)
            if self.lastSelectMailData == mailData then
                mailItem:OnCkilck()
            end
        end
    end
end

New_UIMail.m_MailDelete = function(self, delete)
    -- function num : 0_8 , upvalues : _ENV
    if (table.count)(delete) > 0 then
        self:RefreshMailList((self.ctrl):GetMailDataList())
        if self.lastSelectMailData ~= nil and
            (self.lastSelectMailData).isDeleted then self:OpenFirstMail() end
    end
end

New_UIMail.OpenFirstMail = function(self)
    -- function num : 0_9
    if #self.mailDataList > 0 then
        local firstMailData = (self.mailDataList)[1]
        if self.lastSelectMailData == firstMailData then return end
        local mailItem = self:m_GetItemByData(firstMailData)
        mailItem:OnCkilck()
    end
end

New_UIMail.OnClickMailItem = function(self, mailData)
    -- function num : 0_10
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

    if self.lastSelectMailData ~= nil and mailData ~= self.lastSelectMailData then
        (self.lastSelectMailData).isSelected = false
        local lastSelectedItem = self:m_GetItemByData(self.lastSelectMailData)
        if lastSelectedItem ~= nil then lastSelectedItem:SetSelect(false) end
    end
    do
        self.lastSelectMailData = mailData
        self:OpenMail(mailData)
    end
end

New_UIMail.OpenMail = function(self, mailData)
    -- function num : 0_11
    (self.ctrl):ReqMailRead(mailData.uid, function()
        -- function num : 0_11_0
    end);
    (self.mailContent):UpdateContent(mailData)
end

New_UIMail.GetAllRewards = function(self)
    -- function num : 0_12
    (self.ctrl):ReqOneClickPickUp()
end

New_UIMail.DeletAllReadedMail = function(self)
    -- function num : 0_13
    (self.ctrl):ReqOneClickDelete()
end

New_UIMail.OnHide = function(self)
    -- function num : 0_14 , upvalues : _ENV, base
    local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
    if homeWin ~= nil then homeWin:BackFromOtherWin() end
    (base.OnHide)(self)
end

New_UIMail.OnDelete = function(self)
    -- function num : 0_15 , upvalues : _ENV, base
    MsgCenter:RemoveListener(eMsgEventId.OnMailDiff, self._m_MailDiff)
    MsgCenter:RemoveListener(eMsgEventId.OnMailDelete, self._m_MailDelete)
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

    if self.lastSelectMailData ~= nil then
        (self.lastSelectMailData).isSelected = false
    end
    (self.mailContent):Delete();
    (self.ctrl):OnMailUIHide();
    (base.OnDelete)(self)
end

return New_UIMail


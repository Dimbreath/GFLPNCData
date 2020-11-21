-- params : ...
-- function num : 0 , upvalues : _ENV
local UINMailListItem = class("UINMailListItem", UIBaseNode)
local base = UIBaseNode
local MailEnum = require("Game.Mail.MailEnum")
UINMailListItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    self.onClickCallback = nil;
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_mailItem, self, self.OnCkilck)
end

UINMailListItem.SetCallback = function(self, onClickCallback)
    -- function num : 0_1
    self.onClickCallback = onClickCallback
end

UINMailListItem.InitMailItem = function(self, mailData)
    -- function num : 0_2 , upvalues : _ENV, MailEnum
    self.mailData = mailData
    self:SetSelect(mailData.isSelected) -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).tex_Tile).text = mailData:GetTitle()
    local time = mailData:GetTimeBeforeExpired()
    if time > 86400 then
        local num = (math.ceil)(time // 86400);
        ((self.ui).tex_Time):SetIndex(0, tostring(num))
    else
        do

            ((self.ui).tex_Time):SetIndex(1)
            local mailState = mailData:GetState()
            if mailState == (MailEnum.eMailDetailType).None then
                ((self.ui).img_IsRead):SetIndex(0) -- DECOMPILER ERROR at PC44: Confused about usage of register: R4 in 'UnsetPending'
                ;
                ((self.ui).canvasGroup).alpha = 1
            else

                ((self.ui).img_IsRead):SetIndex(1) -- DECOMPILER ERROR at PC61: Confused about usage of register: R4 in 'UnsetPending'
                ;
                ((self.ui).canvasGroup).alpha =
                    (self.mailData).isSelected and 1 or 0.35
            end
            local isHaveAtt, attDic, isPicked = mailData:IsHaveAtt();
            (((self.ui).img_HasReward).gameObject):SetActive(isHaveAtt)
            if isHaveAtt then
                if isPicked then
                    ((self.ui).img_HasReward):SetIndex(1)
                else

                    ((self.ui).img_HasReward):SetIndex(0)
                end
            end
        end
    end
end

UINMailListItem.OnCkilck = function(self)
    -- function num : 0_3
    if self.onClickCallback ~= nil then (self.onClickCallback)(self.mailData) end -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'
    
    (self.mailData).isSelected = true
    self:SetSelect(true)
end

UINMailListItem.SetSelect = function(self, bool)
    -- function num : 0_4
    if bool then
        ((self.ui).img_Select):SetIndex(1) -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).tex_Tile).color = (self.ui).color_balck -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).canvasGroup).alpha = 1
    else

        ((self.ui).img_Select):SetIndex(0) -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).tex_Tile).color = (self.ui).color_white -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).canvasGroup).alpha = 0.35
    end
end

UINMailListItem.OnDelete = function(self)
    -- function num : 0_5 , upvalues : base
    (base.OnDelete)(self)
end

return UINMailListItem


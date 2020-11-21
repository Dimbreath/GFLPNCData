-- params : ...
-- function num : 0 , upvalues : _ENV
local UINDormListItem = class("UINDormListItem", UIBaseNode)
UINDormListItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).roomItem, self, self.OnListItemClicked)
end

UINDormListItem.InitDormListItem = function(self, id, name, unlock, isSelf,
                                            action)
    -- function num : 0_1 , upvalues : _ENV
    self.unlock = unlock or false
    if not isSelf then isSelf = false end
    self.id = id;
    ((self.ui).img_UnLock):SetActive(self.unlock);
    ((self.ui).img_Lock):SetActive(not self.unlock)
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R6 in 'UnsetPending'

    if self.unlock then
        (((self.ui).tex_RoomName).text).color = Color.white;
        ((self.ui).tex_RoomName):SetIndex(0, name)
    else
        -- DECOMPILER ERROR at PC40: Confused about usage of register: R6 in 'UnsetPending'


        (((self.ui).tex_RoomName).text).color = (self.ui).color_roomLock;
        ((self.ui).tex_RoomName):SetIndex(1)
    end
    ((self.ui).img_Glow):SetActive(isSelf)
    self.clickAction = action
end

UINDormListItem.OnListItemClicked = function(self)
    -- function num : 0_2
    if self.clickAction ~= nil then (self.clickAction)(self) end
end

UINDormListItem.OnDelete = function(self)
    -- function num : 0_3
end

return UINDormListItem


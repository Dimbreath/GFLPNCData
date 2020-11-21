-- params : ...
-- function num : 0 , upvalues : _ENV
local UICIDJumpInfoItem = class("UICommonItemDetailWinNew", UIBaseNode)
local base = UIBaseNode
local UICIDJumpDescrItem =
    require("Game.CommonUI.ItemDetail.UICIDJumpDescrItem")
UICIDJumpInfoItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UICIDJumpDescrItem
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self.PoolDescrItem = (UIItemPool.New)(UICIDJumpDescrItem,
                                          (self.ui).obj_jumpDescrItem);
    ((self.ui).obj_jumpDescrItem):SetActive(false)
end

UICIDJumpInfoItem.InitCIDJumpInfoItem = function(self, jumpData, jumpCallback)
    -- function num : 0_1 , upvalues : _ENV
    self.id = jumpData.jumpId -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.ui).tex_tile).text = tostring(
                                    (LanguageUtil.GetLocaleText)(
                                        (jumpData.cfg).title));
    (self.PoolDescrItem):HideAll()
    local item = (self.PoolDescrItem):GetOne()
    item:InitCIDJumpDescrItem(jumpData)
    item:SetJumpCallback(jumpCallback)
end

return UICIDJumpInfoItem


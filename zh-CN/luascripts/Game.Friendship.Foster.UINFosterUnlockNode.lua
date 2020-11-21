-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFosterUnlockNode = class("UINFosterUnlockNode", UIBaseNode)
local base = UIBaseNode
local UINFosterUnlockRewardItem = require(
                                      "Game.Friendship.Foster.UINFosterUnlockRewardItem")
UINFosterUnlockNode.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINFosterUnlockRewardItem
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friendship)
    self.unlockRewardItemPool = (UIItemPool.New)(UINFosterUnlockRewardItem,
                                                 (self.ui).obj_materialItem);
    ((self.ui).obj_materialItem):SetActive(false)
end

UINFosterUnlockNode.InitUnlockNode = function(self, heroId, heroLevel,
                                              friendShipLevel)
    -- function num : 0_1
    self.heroId = heroId
    self.friendShipLevel = friendShipLevel or 1
    self.heroLevel = heroLevel or 1
end

UINFosterUnlockNode.RefreshAndShowLockedInfo =
    function(self, fosterCfg)
        -- function num : 0_2 , upvalues : _ENV
        local requireFlevel = (fosterCfg[1]).friendship_level
        local requireHlevel = (fosterCfg[1]).hero_level;
        ((self.ui).tex_Condition1):SetIndex(0, tostring(requireFlevel))
        -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

        if requireFlevel <= self.friendShipLevel then
            ((self.ui).img_conditionItem1).color = (self.ui).color_fullfill
        else
            -- DECOMPILER ERROR at PC25: Confused about usage of register: R4 in 'UnsetPending'


            ((self.ui).img_conditionItem1).color = (self.ui).color_notFullfill
        end
        ((self.ui).tex_Condition2):SetIndex(1, tostring(requireHlevel))
        -- DECOMPILER ERROR at PC41: Confused about usage of register: R4 in 'UnsetPending'

        if requireHlevel <= self.heroLevel then
            ((self.ui).img_conditionItem2).color = (self.ui).color_fullfill
        else
            -- DECOMPILER ERROR at PC47: Confused about usage of register: R4 in 'UnsetPending'


            ((self.ui).img_conditionItem2).color = (self.ui).color_notFullfill
        end
        (self.unlockRewardItemPool):HideAll()
        for index, itemId in ipairs((fosterCfg[1]).unlockIds) do
            local itemNum = ((fosterCfg[1]).unlockNums)[index]
            local item = (self.unlockRewardItemPool):GetOne(true)
            item:InitItem(R13_PC66, itemNum)
        end
        (((self.ui).btn_Unlock).onClick):RemoveAllListeners();
        (UIUtil.AddButtonListener)((self.ui).btn_Unlock, self, function()
            -- function num : 0_2_0 , upvalues : self, requireFlevel, requireHlevel, fosterCfg, _ENV
            if requireFlevel <= self.friendShipLevel and requireHlevel <=
                self.heroLevel then
                (self.networkCtrl):CS_INTIMACY_UpgradeLine(self.heroId,
                                                           (fosterCfg[1]).id)
            else
                print("条件不满足")
            end
        end)
        -- DECOMPILER ERROR at PC91: Confused about usage of register: R4 in 'UnsetPending'

        if requireFlevel <= self.friendShipLevel and requireHlevel <=
            self.heroLevel then
            ((self.ui).img_btn_Unlock).color = (self.ui).color_canClick
        else
            -- DECOMPILER ERROR at PC97: Confused about usage of register: R4 in 'UnsetPending'


            ((self.ui).img_btn_Unlock).color = (self.ui).color_canNotClick
        end
    end

UINFosterUnlockNode.OnDelete = function(self)
    -- function num : 0_3 , upvalues : base
    (self.unlockRewardItemPool):DeleteAll();
    (base.OnDelete)(self)
end

return UINFosterUnlockNode


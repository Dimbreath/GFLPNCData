-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCSTDetail_Overload = class("UINCSTDetail_Overload", UIBaseNode)
local base = UIBaseNode
local OverloadItem = require("Game.CommanderSkill.UI.TreeDetail.UINCSTDetail_OverloadItem")
UINCSTDetail_Overload.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, OverloadItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.OverloadItemPool = (UIItemPool.New)(OverloadItem, (self.ui).obj_skilllItem)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_close, self, self.Close)
end

UINCSTDetail_Overload.InitOverload = function(self, resloader, CloseAllOverLoad)
  -- function num : 0_1
  self.resloader = resloader
  self.CloseAllOverLoad = CloseAllOverLoad
end

UINCSTDetail_Overload.ShowOverload = function(self, curId, index, treeData)
  -- function num : 0_2 , upvalues : _ENV
  (((self.ui).btn_close).gameObject):SetActive(true)
  ;
  (self.OverloadItemPool):HideAll()
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).toggroup_overloadList).allowSwitchOff = true
  for index,skillId in ipairs((treeData.slotSkillOverloadList)[index]) do
    local item = (self.OverloadItemPool):GetOne()
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (item.gameObject).name = "overloadSkill" .. tostring(index)
    local skillData = (treeData.commanderSkillDataDic)[skillId]
    item:InitOverladItem(skillData, self.resloader, treeData)
    if skillId ~= curId then
      do
        item:SetSelected(curId == 0)
        -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).toggroup_overloadList).allowSwitchOff = false
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINCSTDetail_Overload.Close = function(self)
  -- function num : 0_3
  (((self.ui).btn_close).gameObject):SetActive(false)
  if self.CloseAllOverLoad ~= nil then
    (self.CloseAllOverLoad)()
  end
end

UINCSTDetail_Overload.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINCSTDetail_Overload

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCSTDetail_Overload = class("UINCSTDetail_Overload", UIBaseNode)
local base = UIBaseNode
local OverloadItem = require(
                         "Game.CommanderSkill.UI.TreeDetail.UINCSTDetail_OverloadItem")
UINCSTDetail_Overload.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, OverloadItem
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self.OverloadItemPool = (UIItemPool.New)(OverloadItem,
                                             (self.ui).obj_skilllItem);
    (UIUtil.AddButtonListener)((self.ui).btn_close, self, self.Close)
end

UINCSTDetail_Overload.InitOverload = function(self, resloader, CloseAllOverLoad)
    -- function num : 0_1
    self.resloader = resloader
    self.CloseAllOverLoad = CloseAllOverLoad
end

UINCSTDetail_Overload.ShowOverload = function(self, curId, index, treeData)
    -- function num : 0_2 , upvalues : _ENV
    (((self.ui).btn_close).gameObject):SetActive(true);
    (self.OverloadItemPool):HideAll() -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'
    ;
    ((self.ui).toggroup_overloadList).allowSwitchOff = true
    for index, skillId in ipairs((treeData.slotSkillOverloadList)[index]) do
        local item = (self.OverloadItemPool):GetOne() -- DECOMPILER ERROR at PC26: Confused about usage of register: R10 in 'UnsetPending'
        ;
        (item.gameObject).name = "overloadSkill" .. tostring(index)
        local skillData = (treeData.commanderSkillDataDic)[skillId]
        item:InitOverladItem(skillData, self.resloader, treeData)
        if skillId ~= curId then
            do
                item:SetSelected(curId == 0)
                -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_STMT

            end
        end
    end -- DECOMPILER ERROR at PC46: Confused about usage of register: R4 in 'UnsetPending'
    
    ((self.ui).toggroup_overloadList).allowSwitchOff = false
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINCSTDetail_Overload.Close = function(self)
    -- function num : 0_3
    (((self.ui).btn_close).gameObject):SetActive(false)
    if self.CloseAllOverLoad ~= nil then (self.CloseAllOverLoad)() end
end

UINCSTDetail_Overload.OnDelete = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnDelete)(self)
end

return UINCSTDetail_Overload


-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCSTDetail_SkillNode = class("UINCSTDetail_SkillNode", UIBaseNode)
local base = UIBaseNode
local SkillNodeItem = require("Game.CommanderSkill.UI.TreeDetail.UINCSTDetail_SkillNodeItem")
local ActiveSkillItem = require("Game.CommanderSkill.UI.TreeDetail.UINCSTDetail_ActiveSkillItem")
local Overload = require("Game.CommanderSkill.UI.TreeDetail.UINCSTDetail_Overload")
local CommanderSkillData = require("Game.CommanderSkill.CommanderSkillData")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local sortFunc = function(a, b)
  -- function num : 0_0
  local aUnlockLevel = a.unlockLevel
  local bUnlockLevel = b.unlockLevel
  if aUnlockLevel >= bUnlockLevel then
    do return aUnlockLevel == bUnlockLevel end
    local aPlace = a.place
    local bPlace = b.place
    if aPlace >= bPlace then
      do
        do return aPlace == bPlace end
        do return a.dataId < b.dataId end
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
      end
    end
  end
end

UINCSTDetail_SkillNode.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, SkillNodeItem, Overload, ActiveSkillItem
  self.ActiveSkillItemList = {}
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.SkillNodeItemPool = (UIItemPool.New)(SkillNodeItem, (self.ui).obj_SkillItem)
  self.OverloadNode = (Overload.New)()
  ;
  (self.OverloadNode):Init((self.ui).obj_overloadList)
  self.__ShowSkillDescription = BindCallback(self, self.ShowSkillDescription)
  self.__HideSkillDetail = BindCallback(self, self.HideSkillDetail)
  self.__ShowActiveSkillOverLoad = BindCallback(self, self.ShowActiveSkillOverLoad)
  self.__HideActiveSkillOverLoad = BindCallback(self, self.HideActiveSkillOverLoad)
  self.__SelectOverload = BindCallback(self, self.SelectOverload)
  self.__CloseAllOverLoad = BindCallback(self, self.CloseAllOverLoad)
  MsgCenter:AddListener(eMsgEventId.OnCommanderSkillOverLoad, self.__SelectOverload)
  for index,go in ipairs((self.ui).obj_useSkillItems) do
    -- DECOMPILER ERROR at PC66: Confused about usage of register: R6 in 'UnsetPending'

    (self.ActiveSkillItemList)[index] = (ActiveSkillItem.New)()
    ;
    ((self.ActiveSkillItemList)[index]):Init(go)
  end
end

UINCSTDetail_SkillNode.InitSkillNode = function(self, resloader)
  -- function num : 0_2 , upvalues : _ENV
  self.resloader = resloader
  ;
  (self.OverloadNode):InitOverload(self.resloader, self.__CloseAllOverLoad)
  for index,go in ipairs((self.ui).obj_useSkillItems) do
    ((self.ActiveSkillItemList)[index]):InitActiveSkill(index, self.__ShowActiveSkillOverLoad, self.__HideActiveSkillOverLoad, self.resloader)
  end
end

UINCSTDetail_SkillNode.ShowSkillNode = function(self, treeData)
  -- function num : 0_3 , upvalues : _ENV
  self.treeData = treeData
  local skillList = {}
  self:__GetAllSkillAndSort(skillList)
  ;
  (self.SkillNodeItemPool):HideAll()
  for _,skillData in ipairs(skillList) do
    local item = (self.SkillNodeItemPool):GetOne()
    item:InitItem(skillData, self.resloader)
    item:SetFloatCallback(self.__ShowSkillDescription, self.__HideSkillDetail)
  end
  for index,activeSkillItem in pairs(self.ActiveSkillItemList) do
    if (treeData.slotSkillList)[index] ~= nil and (treeData.slotSkillList)[index] ~= 0 then
      local skillId = (treeData.slotSkillList)[index]
      local skillData = (treeData.commanderSkillDataDic)[skillId]
      local totalNum, unlockNum = treeData:GetUnlockNum(index)
      ;
      ((self.ActiveSkillItemList)[index]):ShowActiveSkill(skillData, index, totalNum, unlockNum)
      ;
      ((self.ActiveSkillItemList)[index]):SetTog(false)
    else
      do
        do
          local totalNum, unlockNum = treeData:GetUnlockNum(index)
          activeSkillItem:ShowActiveSkill(nil, index, totalNum, unlockNum)
          -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

UINCSTDetail_SkillNode.__GetAllSkillAndSort = function(self, list)
  -- function num : 0_4 , upvalues : _ENV, CommanderSkillData, sortFunc
  for skillId,skillData in pairs((self.treeData).commanderSkillDataDic) do
    if skillData.type ~= (CommanderSkillData.skillType).master and (skillData.type ~= (CommanderSkillData.skillType).active or skillData.unlockLevel ~= 1) then
      (table.insert)(list, skillData)
    end
  end
  ;
  (table.sort)(list, sortFunc)
end

UINCSTDetail_SkillNode.ShowSkillDescription = function(self, item, skillData)
  -- function num : 0_5 , upvalues : _ENV, HAType, VAType
  UIManager:ShowWindowAsync(UIWindowTypeID.FloatingFrame, function(win)
    -- function num : 0_5_0 , upvalues : skillData, item, HAType, VAType
    win:SetTitleAndContext(skillData:GetName(), skillData:GetDescribe())
    win:FloatTo(item.transform, HAType.autoCenter, VAType.up, nil, 0.5)
  end
)
end

UINCSTDetail_SkillNode.HideSkillDetail = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
  end
end

UINCSTDetail_SkillNode.ShowActiveSkillOverLoad = function(self, curId, index)
  -- function num : 0_7
  (self.OverloadNode):Show()
  ;
  (self.OverloadNode):ShowOverload(curId, index, self.treeData)
end

UINCSTDetail_SkillNode.HideActiveSkillOverLoad = function(self)
  -- function num : 0_8
  (self.OverloadNode):Hide()
end

UINCSTDetail_SkillNode.SelectOverload = function(self, index, skillData)
  -- function num : 0_9
  ((self.ActiveSkillItemList)[index]):ShowActiveSkill(skillData, index)
end

UINCSTDetail_SkillNode.CloseAllOverLoad = function(self)
  -- function num : 0_10 , upvalues : _ENV
  for index,item in ipairs(self.ActiveSkillItemList) do
    item:SetTog(false)
  end
end

UINCSTDetail_SkillNode.OnDelete = function(self)
  -- function num : 0_11 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnCommanderSkillOverLoad, self.__SelectOverload)
  ;
  (base.OnDelete)(self)
end

return UINCSTDetail_SkillNode


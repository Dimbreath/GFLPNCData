-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCSTLvUpSkillUnlockList = class("UINCSTLvUpSkillUnlockList", UIBaseNode)
local base = UIBaseNode
local UINCSTLvUpSkillItem = require("Game.CommanderSkill.UI.LevelUpNode.UINCSTLvUpSkillItem")
UINCSTLvUpSkillUnlockList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.skillItemDic = {}
end

UINCSTLvUpSkillUnlockList.InitCSTLvUpSkillUnlockList = function(self, resLoader, unlockSkillDataList, newTreeLevel, treeData, refill)
  -- function num : 0_1
  self.resLoader = resLoader
  self.newTreeLevel = newTreeLevel
  self.treeData = treeData
  self.unlockSkillDataList = unlockSkillDataList
  self:_RefillScrollRect(refill)
end

UINCSTLvUpSkillUnlockList._RefillScrollRect = function(self, refill)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).scrollRect).totalCount = #self.unlockSkillDataList
  if refill then
    ((self.ui).scrollRect):RefillCells()
  else
    ;
    ((self.ui).scrollRect):RefreshCells()
  end
end

UINCSTLvUpSkillUnlockList.__OnNewItem = function(self, go)
  -- function num : 0_3 , upvalues : UINCSTLvUpSkillItem
  local item = (UINCSTLvUpSkillItem.New)()
  item:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.skillItemDic)[go] = item
end

UINCSTLvUpSkillUnlockList.__OnChangeItem = function(self, go, index)
  -- function num : 0_4 , upvalues : _ENV
  local item = (self.skillItemDic)[go]
  if item == nil then
    error("Can\'t find item by gameObject")
    return 
  end
  local unlockSkillData = (self.unlockSkillDataList)[index + 1]
  if unlockSkillData == nil then
    error("Can\'t find unlockSkillData by index, index = " .. tonumber(index))
  end
  local cmdSkillData = ((self.treeData).commanderSkillDataDic)[unlockSkillData.skillId]
  item:InitCSTLvUpSkillItem(self.resLoader, cmdSkillData, self.newTreeLevel, unlockSkillData.skillLevel)
end

UINCSTLvUpSkillUnlockList.OnDelete = function(self)
  -- function num : 0_5 , upvalues : _ENV, base
  for k,v in pairs(self.skillItemDic) do
    v:Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UINCSTLvUpSkillUnlockList


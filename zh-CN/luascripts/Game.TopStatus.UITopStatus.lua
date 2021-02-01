-- params : ...
-- function num : 0 , upvalues : _ENV
local UITopStatus = class("UITopStatus", UIBaseWindow)
local base = UIBaseWindow
local UINTopBtnGroup = require("Game.Common.UINTopBtnGroup")
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
UITopStatus.OnInit = function(self)
  -- function num : 0_0 , upvalues : UINTopBtnGroup, UINResourceGroup
  self.topGroup = (UINTopBtnGroup.New)()
  ;
  (self.topGroup):Init((self.ui).topButtonGroup)
  self.resGroup = (UINResourceGroup.New)()
  ;
  (self.resGroup):Init((self.ui).gameResourceGroup)
end

UITopStatus.ChangeResourceItemClass = function(self, newClass)
  -- function num : 0_1
  (self.resGroup):ChangeResourceItemClass(newClass)
end

UITopStatus.RefreshTopStatusUI = function(self, topData)
  -- function num : 0_2
  self:SetTopStatusResIds(topData.resIds)
  if topData.resAddCallbackDic ~= nil then
    self:SetTopStatusResAddFuncs(topData.resIds, topData.resAddCallbackDic)
  end
  if topData.infoAction ~= nil then
    (self.topGroup):SetInfoClickAction(topData.infoAction)
  end
  ;
  (self.topGroup):RefreshTopGroupUI(topData)
end

UITopStatus.SetTopStatusResIds = function(self, Ids)
  -- function num : 0_3
  self:SetResourceGroupActive(false)
  if Ids ~= nil then
    (self.resGroup):SetResourceIds(Ids)
    self:SetResourceGroupActive(true)
  end
end

UITopStatus.SetTopStatusResAddFuncs = function(self, Ids, addCallbackDic)
  -- function num : 0_4 , upvalues : _ENV
  for _,itemId in ipairs(Ids) do
    local addCallback = addCallbackDic[itemId]
    if addCallback ~= nil then
      (self.resGroup):SetResourceAddBtnFunc(itemId, true, addCallback)
    else
      ;
      (self.resGroup):SetResourceAddBtnFunc(itemId, false, addCallback)
    end
  end
end

UITopStatus.GetTopStatusResItem = function(self, Id)
  -- function num : 0_5
  return (self.resGroup):GetResourceItem(Id)
end

UITopStatus.SetResourceGroupActive = function(self, active)
  -- function num : 0_6
  ((self.resGroup).gameObject):SetActive(active)
end

UITopStatus.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (self.topGroup):Delete()
  ;
  (self.resGroup):Delete()
  ;
  (base.OnDelete)(self)
end

return UITopStatus


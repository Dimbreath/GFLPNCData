-- params : ...
-- function num : 0 , upvalues : _ENV
local UISector = class("UISector", UIBaseWindow)
local base = UIBaseWindow
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UISctBuildResItem = require("Game.Sector.UISector.UISctBuildResItem")
UISector.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UISctBuildResItem
  (UIUtil.CreateTopBtnGroup)((self.ui).topButtonGroup, self, self.OnClickBackBtn)
  self.onClickGetRes = BindCallback(self, self.OnClickGetRes)
  self:SetResGroup({1007})
  ;
  ((self.ui).resItem):SetActive(false)
  self.resItemPool = (UIItemPool.New)(UISctBuildResItem, (self.ui).resItem)
  ;
  ((self.ui).outputInfo):SetActive(false)
  self.CollectResWin = UIManager:ShowWindow(UIWindowTypeID.CommonCollectRes)
  ;
  ((self.CollectResWin).transform):SetParent((self.ui).Tran_CommonResNode)
  ;
  (self.CollectResWin):SetCommonCollectRes(self.onClickGetRes)
  ;
  (self.CollectResWin):Hide()
end

UISector.InitUISector = function(self, sctCtrl)
  -- function num : 0_1
  self.sctCtrl = sctCtrl
end

UISector.OnlyShowSctUITop = function(self, onlyShow)
  -- function num : 0_2
  self.__onlyShowTop = onlyShow
  if onlyShow then
    (self.CollectResWin):Hide()
  else
    self:__ShowOutputInfo(self.__showOutputInfo)
  end
end

UISector.OnClickGetRes = function(self)
  -- function num : 0_3
  (self.sctCtrl):CollectAllSctBuildRes()
end

UISector.OnClickBackBtn = function(self)
  -- function num : 0_4
  if self.sctCtrl ~= nil then
    (self.sctCtrl):OnBtnHomeClicked()
  end
end

UISector.UpdateUIAllSctBuildRes = function(self, allResDic, hasRes)
  -- function num : 0_5 , upvalues : _ENV
  self.__showOutputInfo = hasRes
  if self.__onlyShowTop then
    return 
  end
  self:__ShowOutputInfo(self.__showOutputInfo)
  if not self.__showOutputInfo then
    return 
  end
  local allResList = {}
  for k,v in pairs(allResDic) do
    (table.insert)(allResList, v)
  end
  ;
  (table.sort)(allResList, function(a, b)
    -- function num : 0_5_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for k,allResData in ipairs(allResList) do
    if (self.ui).resShowCount < k then
      return 
    end
    local resList = {}
    ;
    (table.insert)(resList, allResData)
    ;
    (self.CollectResWin):UpdateProduction(k, resList)
  end
end

UISector.__ShowOutputInfo = function(self, showOutputInfo)
  -- function num : 0_6
  if self.CollectResWin == nil then
    return 
  end
  if showOutputInfo then
    (self.CollectResWin):Show()
  else
    ;
    (self.CollectResWin):Hide()
  end
end

UISector.SetResGroup = function(self, itemIds)
  -- function num : 0_7 , upvalues : UINResourceGroup
  if self.resourceGroup == nil then
    self.resourceGroup = (UINResourceGroup.New)()
    ;
    (self.resourceGroup):Init((self.ui).gameResourceGroup)
  end
  ;
  (self.resourceGroup):SetResourceIds(itemIds)
end

UISector.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  (self.resourceGroup):Delete()
  if self.CollectResWin ~= nil then
    (self.CollectResWin):Delete()
    self.CollectResWin = nil
  end
  ;
  (self.resItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UISector


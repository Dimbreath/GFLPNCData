local UIEpRewardPreview = class("UIEpRewardPreview", UIBaseWindow)
local base = UIBaseWindow
local UINEpRewardPreviewItem = require("Game.Exploration.UI.EpRewardPreview.UINEpRewardPreviewItem")
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local EpRewardBagUtil = require("Game.Exploration.UI.EpRewardBag.EpRewardBagUtil")
UIEpRewardPreview.OnInit = function(self)
  -- function num : 0_0 , upvalues : UINResourceGroup, _ENV, UINEpRewardPreviewItem
  self.resourceGroup = (UINResourceGroup.New)()
  ;
  (self.resourceGroup):Init((self.ui).gameResourceGroup)
  ;
  (self.resourceGroup):SetResourceIds({ConstGlobalItem.SKey})
  ;
  ((self.ui).obj_PreviewItem):SetActive(false)
  self.previewItemPool = (UIItemPool.New)(UINEpRewardPreviewItem, (self.ui).obj_PreviewItem)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self._OnCloseClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).background, self, self._OnCloseClick)
end

UIEpRewardPreview.InitEpRewardPreview = function(self, stageCfg, itemList)
  -- function num : 0_1
  local totalPrice, previewDataList = self:_InitData(stageCfg, itemList)
  self:_RefreshUI(totalPrice, previewDataList)
end

UIEpRewardPreview._InitData = function(self, stageCfg, itemList)
  -- function num : 0_2 , upvalues : _ENV, EpRewardBagUtil
  local epModuleId = ExplorationManager:GetEpModuleId()
  local totalPrice = 0
  local stageId = ExplorationManager:GetEpDungeonId()
  local previewDataList = {}
  for index,v in ipairs(itemList) do
    local itemCfg = (ConfigData.item)[v.itemId]
    if itemCfg == nil then
      error("Cant get item cfg, id = " .. tostring(v.itemId))
    else
      local price = (EpRewardBagUtil.GetEpRewardItemPrice)(v.itemId, epModuleId, stageId, v.num)
      totalPrice = totalPrice + price
      local previewData = {itemId = v.itemId, itemCfg = itemCfg, itemNum = v.num, moneyIcon = nil, priceStr = EpRewardBagUtil:GetEpRewardItemPriceStr(price)}
      ;
      (table.insert)(previewDataList, previewData)
    end
  end
  return totalPrice, previewDataList
end

UIEpRewardPreview._RefreshUI = function(self, totalPrice, previewDataList)
  -- function num : 0_3 , upvalues : _ENV
  local isDataEmpty = #previewDataList <= 0
  local isEmpty = false
  local setColor = Color.white
  if totalPrice == 0 and isDataEmpty then
    isEmpty = true
    setColor = (self.ui).col_TPriceEmptyCol
  end
  local totalPriceStr = tostring((math.ceil)(totalPrice / (ConfigData.game_config).staminaDividend))
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_TotalPrice).text = totalPriceStr
  ;
  ((self.ui).obj_Empty):SetActive(isEmpty)
  ;
  ((self.ui).obj_PreviewList):SetActive(not isEmpty)
  self:_SetTotalPriceEmptyUIColor(setColor)
  self:_RefreshPreviewItem(previewDataList)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIEpRewardPreview._SetTotalPriceEmptyUIColor = function(self, color)
  -- function num : 0_4 , upvalues : _ENV
  for _,compoment in ipairs((self.ui).totalPriceColArr) do
    compoment.color = color
  end
end

UIEpRewardPreview._RefreshPreviewItem = function(self, previewDataList)
  -- function num : 0_5 , upvalues : _ENV
  (self.previewItemPool):HideAll()
  for index,previewData in ipairs(previewDataList) do
    local item = (self.previewItemPool):GetOne()
    item:InitEpRewardPreviewItem(index, previewData)
  end
end

UIEpRewardPreview._OnCloseClick = function(self)
  -- function num : 0_6
  self:Delete()
end

UIEpRewardPreview.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (self.resourceGroup):Delete()
  self.resourceGroup = nil
  ;
  (self.previewItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UIEpRewardPreview


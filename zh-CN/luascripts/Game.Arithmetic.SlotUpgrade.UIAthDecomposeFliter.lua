-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthDecomposeFliter = class("UIAthDecomposeFliter", UIBaseNode)
local base = UIBaseNode
local UIFliterItem = require("Game.Arithmetic.SlotUpgrade.UIAthFliterItem")
local eFliterKindType, eFliterKindTypeName, eFliterKindTypeOptionName, eFliterKindColorName = (table.unpack)(require("Game.Arithmetic.SlotUpgrade.UIAthFliterHelper"))
UIAthDecomposeFliter.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIFliterItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).fliterItem):SetActive(false)
  self.fliterItemPool = (UIItemPool.New)(UIFliterItem, (self.ui).fliterItem)
  self.itemList = {}
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.ConfirmBtn)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Reset, self, self.ResetBtn)
end

UIAthDecomposeFliter.InitFliter = function(self, fliterList)
  -- function num : 0_1 , upvalues : _ENV, eFliterKindTypeName, eFliterKindType
  if fliterList == nil then
    return 
  end
  for _,options in ipairs(fliterList) do
    local e = (self.fliterItemPool):GetOne(true)
    e:InitName(options.name)
    if options.name == eFliterKindTypeName[eFliterKindType.MainAttr] then
      self.mainAttrItem = e
    end
    e:InitKindOptions(options)
    ;
    (table.insert)(self.itemList, e)
  end
  self.allKindItem = {}
  for _,item in pairs(self.itemList) do
    for __,kindItem in ipairs(item.kindItemList) do
      -- DECOMPILER ERROR at PC42: Confused about usage of register: R12 in 'UnsetPending'

      (self.allKindItem)[kindItem.name] = kindItem
    end
  end
end

UIAthDecomposeFliter.SetResetCallback = function(self, callback)
  -- function num : 0_2
  self.resetCallback = callback
end

UIAthDecomposeFliter.SetConfirmCallback = function(self, callback)
  -- function num : 0_3
  self.confirmCallback = callback
end

UIAthDecomposeFliter.ResetBtn = function(self)
  -- function num : 0_4
  if self.resetCallback ~= nil then
    (self.resetCallback)()
  end
  self:Hide()
end

UIAthDecomposeFliter.ConfirmBtn = function(self)
  -- function num : 0_5
  if self.confirmCallback ~= nil then
    (self.confirmCallback)()
  end
end

UIAthDecomposeFliter.CleanSelect = function(self)
  -- function num : 0_6 , upvalues : _ENV
  for index,value in ipairs(self.itemList) do
    value:CleanSelect()
  end
end

UIAthDecomposeFliter.OrangeAddOrRemoveSwitch = function(self, isAdd)
  -- function num : 0_7 , upvalues : eFliterKindColorName, _ENV, eFliterKindTypeOptionName, eFliterKindType
  if isAdd then
    ((self.allKindItem)[eFliterKindColorName[eItemQualityType.Orange] .. eFliterKindTypeOptionName[eFliterKindType.Quality]]):AddOrangeEvent(function(isSelect)
    -- function num : 0_7_0 , upvalues : self
    if isSelect then
      (self.mainAttrItem):Show()
    else
      ;
      (self.mainAttrItem):Hide()
    end
  end
)
  else
    ;
    (self.mainAttrItem):Show()
    ;
    ((self.allKindItem)[eFliterKindColorName[eItemQualityType.Orange] .. eFliterKindTypeOptionName[eFliterKindType.Quality]]):RemoveOrangeEvent()
  end
end

UIAthDecomposeFliter.AutoDecoSelect = function(self, autoDeco)
  -- function num : 0_8 , upvalues : _ENV, eFliterKindTypeName, eFliterKindType, eFliterKindColorName, eFliterKindTypeOptionName
  local lastData = nil
  if autoDeco.data == nil then
    print("无配置")
    return 
  end
  for index,value in pairs(autoDeco.data) do
    ((self.allKindItem)[eFliterKindTypeName[eFliterKindType.Area] .. index]):onClick()
    lastData = value
  end
  if lastData == nil then
    (self.mainAttrItem):Hide()
    return 
  end
  if lastData.blue then
    ((self.allKindItem)[eFliterKindColorName[eItemQualityType.Blue] .. eFliterKindTypeOptionName[eFliterKindType.Quality]]):onClick()
  end
  if lastData.purple then
    ((self.allKindItem)[eFliterKindColorName[eItemQualityType.Purple] .. eFliterKindTypeOptionName[eFliterKindType.Quality]]):onClick()
  end
  if (table.count)(lastData.orange) > 0 then
    ((self.allKindItem)[eFliterKindColorName[eItemQualityType.Orange] .. eFliterKindTypeOptionName[eFliterKindType.Quality]]):onClick()
    for key,_ in pairs(lastData.orange) do
      ((self.allKindItem)[eFliterKindTypeOptionName[eFliterKindType.MainAttr] .. (LanguageUtil.GetLocaleText)(((ConfigData.attribute)[key]).name) .. key]):onClick()
    end
  else
    do
      ;
      (self.mainAttrItem):Hide()
    end
  end
end

return UIAthDecomposeFliter


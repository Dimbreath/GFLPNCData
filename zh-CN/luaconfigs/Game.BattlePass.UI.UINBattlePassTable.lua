-- params : ...
-- function num : 0 , upvalues : _ENV
local UINBattlePassTable = class("UINBattlePassTable", UIBaseNode)
local base = UIBaseNode
local UINBattlePassItem = require("Game.BattlePass.UI.UINBattlePassItem")
local UINBattlePassLimitItem = require("Game.BattlePass.UI.UINBattlePassLimitItem")
local UINBattlePassTagItem = require("Game.BattlePass.UI.UINBattlePassTagItem")
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")
UINBattlePassTable.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBattlePassLimitItem, UINBattlePassTagItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).scroll, self, self.OnScrollValueChanged)
  ;
  ((self.ui).baseItem):SetActive(false)
  ;
  ((self.ui).battlePassItem):SetActive(false)
  self.passLimitItem = (UINBattlePassLimitItem.New)()
  ;
  (self.passLimitItem):Init((self.ui).spBattlePassItem)
  self.passTagItem = (UINBattlePassTagItem.New)()
  ;
  (self.passTagItem):Init((self.ui).tagBattlePassItem)
  self.__onLimitsItemClicked = BindCallback(self, self.OnBattlePassLimitItemClicked)
end

UINBattlePassTable.InitBattlePassTable = function(self, passInfo)
  -- function num : 0_1 , upvalues : _ENV, UINBattlePassItem
  self.passInfo = passInfo
  self.passItemList = {}
  local baseItemClicked = BindCallback(self, self.OnBattlePassItemClicked)
  for level = 1, passInfo.maxlevel do
    local passLevelCfg = ((ConfigData.battlepass)[passInfo.id])[level]
    if passLevelCfg == nil then
      error((string.format)("battle pass cfg is null,id:%d level:%d", passInfo.id, level))
    end
    local passItemObj = ((self.ui).battlePassItem):Instantiate()
    passItemObj:SetActive(true)
    local passItem = (UINBattlePassItem.New)()
    passItem:Init(passItemObj)
    passItem:InitPassItemUI((self.ui).baseItem, passLevelCfg, passInfo, baseItemClicked)
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.passItemList)[level] = passItem
  end
  ;
  (self.passLimitItem):UpdatePassLimitItemUI(passInfo, self.__onLimitsItemClicked)
  ;
  ((self.passLimitItem).transform):SetAsLastSibling()
  local baseItemWidth = ((((self.ui).battlePassItem).transform).sizeDelta).x + ((self.ui).layout_rect).spacing
  local spItemWidth = ((((self.ui).spBattlePassItem).transform).sizeDelta).x
  local baseItemTotalWidth = baseItemWidth * passInfo.maxlevel
  local totalWidth = baseItemTotalWidth + spItemWidth
  local scrollWidth = ((((self.ui).scroll).transform).sizeDelta).x
  self.baseScrollRatio = baseItemTotalWidth / (totalWidth - scrollWidth)
  self.baseScrollRatioUint = self.baseScrollRatio / passInfo.maxlevel
  self:__OnPassTableValueChanged(0)
  local defaultLevel = (self.passInfo):GetPassDefaultShowLevel()
  self:LocationPassItemByLevel(defaultLevel)
end

UINBattlePassTable.UpdateBattlePassTable = function(self, passInfo)
  -- function num : 0_2 , upvalues : _ENV
  for level,passItem in pairs(self.passItemList) do
    passItem:UpdatePassItemUI(passInfo)
  end
  ;
  (self.passLimitItem):UpdatePassLimitItemUI(passInfo, self.__onLimitsItemClicked)
  ;
  (self.passTagItem):UpdatePassItemUI(passInfo)
end

UINBattlePassTable.OnScrollValueChanged = function(self, vec2)
  -- function num : 0_3 , upvalues : _ENV
  local x = vec2.x
  if (math.abs)(self.__lastX - x) < 0.01 then
    return 
  end
  self:__OnPassTableValueChanged(x)
end

UINBattlePassTable.__OnPassTableValueChanged = function(self, x)
  -- function num : 0_4 , upvalues : _ENV
  self.__lastX = x
  local tag_level = ((ConfigData.battlepass).tag_levels)[(self.passInfo).id]
  local useLevel = tag_level[#tag_level]
  local offset = 5.7 * self.baseScrollRatioUint
  local level = (math.floor)((x + offset) / self.baseScrollRatioUint)
  for i = 1, #tag_level do
    local cur_level = tag_level[i]
    if level < cur_level then
      useLevel = cur_level
      break
    end
  end
  do
    if self.__lastTagLevel ~= useLevel then
      self:UpdatePassTagItem(useLevel)
    end
  end
end

UINBattlePassTable.UpdatePassTagItem = function(self, level)
  -- function num : 0_5 , upvalues : _ENV
  self.__lastTagLevel = level
  local passLevelCfg = ((ConfigData.battlepass)[(self.passInfo).id])[level]
  if passLevelCfg == nil then
    error((string.format)("battle pass cfg is null,id:%d level:%d", (self.passInfo).id, level))
  end
  ;
  (self.passTagItem):InitPassItemUI((self.ui).baseItem, passLevelCfg, self.passInfo)
end

UINBattlePassTable.LocationPassItemByLevel = function(self, level)
  -- function num : 0_6 , upvalues : _ENV
  local index = level - 2
  local pos = index / (self.passInfo).maxlevel * self.baseScrollRatio
  pos = (math.clamp)(pos, 0, 1)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).scroll).horizontalNormalizedPosition = pos
end

UINBattlePassTable.OnBattlePassItemClicked = function(self, level, isSenior)
  -- function num : 0_7 , upvalues : _ENV, BattlePassEnum
  local battlepassCtrl = ControllerManager:GetController(ControllerTypeId.BattlePass, true)
  local takeway = (BattlePassEnum.TakeWay).Base
  if isSenior then
    takeway = (BattlePassEnum.TakeWay).Senior
  end
  battlepassCtrl:TakeBattlePassReward((self.passInfo).id, level, takeway)
end

UINBattlePassTable.OnBattlePassLimitItemClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV, BattlePassEnum
  local battlepassCtrl = ControllerManager:GetController(ControllerTypeId.BattlePass, true)
  battlepassCtrl:TakeBattlePassReward((self.passInfo).id, 0, (BattlePassEnum.TakeWay).Overflow)
end

UINBattlePassTable.OnDelete = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnDelete)(self)
end

return UINBattlePassTable


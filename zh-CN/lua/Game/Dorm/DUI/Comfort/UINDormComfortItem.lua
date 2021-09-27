local UINDormComfortItem = class("UINDormComfortItem", UIBaseNode)
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local CommonLogicUtil = require("Game.Common.CommonLogicUtil.CommonLogicUtil")
UINDormComfortItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithReceived
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Pick, self, self.OnComforPickClicked)
  ;
  ((self.ui).rewardItem):SetActive(false)
  self.rewardItemPool = (UIItemPool.New)(UINBaseItemWithReceived, (self.ui).rewardItem)
end

UINDormComfortItem.InitDormComfortItem = function(self, comfortLevelCfg, dormBriefData, pickAction)
  -- function num : 0_1
  self.comfortLevelCfg = comfortLevelCfg
  self.comfortLevel = comfortLevelCfg.level
  self.__pickAction = pickAction
  self:RefreshDormComfortItem(dormBriefData)
end

UINDormComfortItem.OnComforPickClicked = function(self)
  -- function num : 0_2
  if self.__pickAction ~= nil then
    (self.__pickAction)(self.comfortLevelCfg, self)
  end
end

UINDormComfortItem.RefreshDormComfortItem = function(self, dormBriefData)
  -- function num : 0_3 , upvalues : _ENV, CommonLogicUtil
  local curLevel = dormBriefData:GetDormComfortLevel()
  local isPicked = dormBriefData:IsDormComfortPicked(self.comfortLevel)
  local isReach = false
  if self.comfortLevel <= curLevel then
    isReach = true
  end
  if isReach then
    ((self.ui).isComplete):SetActive(isPicked)
    ;
    (((self.ui).btn_Pick).gameObject):SetActive(not isPicked)
  else
    ;
    ((self.ui).isComplete):SetActive(false)
    ;
    (((self.ui).btn_Pick).gameObject):SetActive(false)
  end
  ;
  (self.rewardItemPool):HideAll()
  for index,itemId in pairs((self.comfortLevelCfg).rewardIds) do
    local itemCount = ((self.comfortLevelCfg).rewardNums)[index]
    local rewardItem = (self.rewardItemPool):GetOne()
    local itemCfg = (ConfigData.item)[itemId]
    rewardItem:InitItemWithCount(itemCfg, itemCount)
    rewardItem:SetPickedUIActive()
  end
  -- DECOMPILER ERROR at PC70: Confused about usage of register: R5 in 'UnsetPending'

  if self.comfortLevel < 10 then
    ((self.ui).tex_Level).text = "LV.0" .. tostring(self.comfortLevel)
  else
    -- DECOMPILER ERROR at PC79: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).tex_Level).text = "LV." .. tostring(self.comfortLevel)
  end
  if #(self.comfortLevelCfg).logic > 0 then
    local front_cfg = (ConfigData.dorm_comfort)[self.comfortLevel - 1]
    local logic, para1, para2, para3 = (CommonLogicUtil.MinLogicCfg)(self.comfortLevelCfg, front_cfg)
    local des = (CommonLogicUtil.GetLogicDesStrMultiLine)(logic, para1, para2, para3)
    -- DECOMPILER ERROR at PC102: Confused about usage of register: R11 in 'UnsetPending'

    ;
    ((self.ui).tex_Addition).text = des
    ;
    ((self.ui).isAddition):SetActive(true)
    local isEffectOn = self.comfortLevel <= curLevel
    ;
    ((self.ui).isEffectOn):SetActive(isEffectOn)
    if not isEffectOn or not (self.ui).color_effect then
      local showColor = Color.white
    end
    -- DECOMPILER ERROR at PC128: Confused about usage of register: R13 in 'UnsetPending'

    ;
    ((self.ui).img_Addition).color = showColor
    -- DECOMPILER ERROR at PC131: Confused about usage of register: R13 in 'UnsetPending'

    ;
    ((self.ui).tex_Addition).color = showColor
  else
    ((self.ui).isEffectOn):SetActive(false)
    ;
    ((self.ui).isAddition):SetActive(false)
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

UINDormComfortItem.OnDelete = function(self)
  -- function num : 0_4
end

return UINDormComfortItem


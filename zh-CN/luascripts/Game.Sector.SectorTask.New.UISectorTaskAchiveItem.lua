-- params : ...
-- function num : 0 , upvalues : _ENV
local UISectorTaskAchiveItem = class("UISectorTaskAchiveItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
local SectorEnum = require("Game.Sector.SectorEnum")
UISectorTaskAchiveItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.baseItem = (UINBaseItem.New)()
  ;
  (self.baseItem):Init((self.ui).obj_BaseItem)
  self.onBtnClick = BindCallback(self, self.__onBtnClick)
end

UISectorTaskAchiveItem.InitSectorTaskAchiveItem = function(self, achiveCfg, clickAction)
  -- function num : 0_1 , upvalues : _ENV
  self.achivCfg = achiveCfg
  self.id = achiveCfg.id
  self.__onClickAction = clickAction
  self.starCount = (achiveCfg.conditionNums)[1]
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Point).text = tostring(self.starCount)
  local itemId = (achiveCfg.conditionIds)[1]
  local itemCfg = (ConfigData.item)[itemId]
  if itemCfg == nil then
    error("Can`t find ItemCfg:ID = " .. tostring(itemId))
    return 
  end
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite(itemCfg.icon)
  local rewardId = (achiveCfg.achivRewardIds)[1]
  local rewardCfg = (ConfigData.item)[rewardId]
  if rewardCfg == nil then
    error("Can`t find rewardCfg:ID = " .. tostring(rewardId))
    return 
  end
  ;
  (self.baseItem):InitBaseItem(rewardCfg, self.onBtnClick)
end

UISectorTaskAchiveItem.GetStarCount = function(self)
  -- function num : 0_2
  return self.starCount
end

UISectorTaskAchiveItem.UpdateSectorAchivItem = function(self, state)
  -- function num : 0_3 , upvalues : SectorEnum
  self.state = state
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).ItemFade).alpha = 1
  if state == (SectorEnum.eSectorAchivState).Normal then
    ((self.ui).obj_State):SetActive(false)
  else
    ;
    ((self.ui).obj_State):SetActive(true)
    if state == (SectorEnum.eSectorAchivState).Completed then
      ((self.ui).obj_Completed):SetActive(true)
      ;
      ((self.ui).obj_Accomplish):SetActive(false)
    else
      ;
      ((self.ui).obj_Completed):SetActive(false)
      ;
      ((self.ui).obj_Accomplish):SetActive(true)
      -- DECOMPILER ERROR at PC46: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).ItemFade).alpha = 0.6
    end
  end
end

UISectorTaskAchiveItem.__onBtnClick = function(self)
  -- function num : 0_4
  if self.__onClickAction ~= nil then
    (self.__onClickAction)(self.id)
  end
end

UISectorTaskAchiveItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UISectorTaskAchiveItem


-- params : ...
-- function num : 0 , upvalues : _ENV
local UINSectorTaskAchiveItem = class("UINSectorTaskAchiveItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local SectorEnum = require("Game.Sector.SectorEnum")
UINSectorTaskAchiveItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithReceived
  self.isPicking = false
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.baseItem = (UINBaseItemWithReceived.New)()
  ;
  (self.baseItem):Init((self.ui).obj_BaseItem)
  self.__onBtnClick = BindCallback(self, self.__OnBtnClick)
end

UINSectorTaskAchiveItem.InitSectorTaskAchiveItem = function(self, sectorId, achivData, showRewardCallback)
  -- function num : 0_1
  self.sectorId = sectorId
  self.achivData = achivData
  self.showRewardCallback = showRewardCallback
  self:__RefreshItemNotmalUI()
  self:__RefreshItemStateUI()
end

UINSectorTaskAchiveItem.__RefreshItemNotmalUI = function(self)
  -- function num : 0_2 , upvalues : _ENV, SectorEnum
  local starCount = (((self.achivData).achiveCfg).conditionNums)[1]
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Point).text = tostring(starCount)
  local rewardId = (((self.achivData).achiveCfg).achivRewardIds)[1]
  local count = (((self.achivData).achiveCfg).achivRewardNums)[1]
  local rewardCfg = (ConfigData.item)[rewardId]
  if rewardCfg == nil then
    error("Can`t find rewardCfg:ID = " .. tostring(rewardId))
    return 
  end
  ;
  (self.baseItem):InitItemWithCount(rewardCfg, count, self.__onBtnClick, (self.achivData).state == (SectorEnum.eSectorAchivState).Picked)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINSectorTaskAchiveItem.__RefreshItemStateUI = function(self)
  -- function num : 0_3 , upvalues : SectorEnum
  if (self.achivData).state == (SectorEnum.eSectorAchivState).Normal then
    (self.baseItem):SetPickedUIActive(false)
    ;
    ((self.ui).obgj_img_GetReward):SetActive(false)
  else
    if (self.achivData).state == (SectorEnum.eSectorAchivState).Completed then
      (self.baseItem):SetPickedUIActive(false)
      ;
      ((self.ui).obgj_img_GetReward):SetActive(true)
    else
      if (self.achivData).state == (SectorEnum.eSectorAchivState).Picked then
        (self.baseItem):SetPickedUIActive(true)
        ;
        ((self.ui).obgj_img_GetReward):SetActive(false)
      end
    end
  end
end

UINSectorTaskAchiveItem.UpdateSectorAchivItem = function(self)
  -- function num : 0_4 , upvalues : SectorEnum
  local state = (self.achivData).isComplete
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

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
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).ItemFade).alpha = 0.6
    end
  end
end

UINSectorTaskAchiveItem.__OnBtnClick = function(self)
  -- function num : 0_5 , upvalues : SectorEnum, _ENV
  if self.isPicking then
    return 
  end
  if (self.achivData).state == (SectorEnum.eSectorAchivState).Completed then
    self.isPicking = true
    self._heroIdSnapShoot = PlayerDataCenter:GetHeroIdSnapShoot()
    ;
    (NetworkManager:GetNetwork(NetworkTypeID.Sector)):SendPickReward(self.sectorId, ((self.achivData).achiveCfg).id, function()
    -- function num : 0_5_0 , upvalues : self, _ENV
    self.isPicking = false
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      -- function num : 0_5_0_0 , upvalues : self
      if window == nil then
        return 
      end
      local rewardIds = ((self.achivData).achiveCfg).achivRewardIds
      local rewardNums = ((self.achivData).achiveCfg).achivRewardNums
      window:InitRewardsItem(rewardIds, rewardNums, self._heroIdSnapShoot)
    end
)
  end
)
  else
    if self.showRewardCallback ~= nil then
      (self.showRewardCallback)(self, ((self.achivData).achiveCfg).achivRewardIds, ((self.achivData).achiveCfg).achivRewardNums)
    end
  end
end

UINSectorTaskAchiveItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UINSectorTaskAchiveItem


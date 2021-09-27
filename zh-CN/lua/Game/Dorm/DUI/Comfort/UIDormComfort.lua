local UIDormComfort = class("UIDormComfort", UIBaseWindow)
local base = UIBaseWindow
local UINDormComfortItem = require("Game.Dorm.DUI.Comfort.UINDormComfortItem")
local CommonLogicUtil = require("Game.Common.CommonLogicUtil.CommonLogicUtil")
UIDormComfort.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINDormComfortItem
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnCloseClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_background, self, self.OnCloseClicked)
  ;
  ((self.ui).comfortLvItem):SetActive(false)
  self.comfortItemPool = (UIItemPool.New)(UINDormComfortItem, (self.ui).comfortLvItem)
  self.__ReqComfortRewardPick = BindCallback(self, self.ReqComfortRewardPick)
  ;
  (UIUtil.SetTopStatus)(nil, nil, nil, nil, nil, true)
end

UIDormComfort.InitDormComfortUI = function(self, dormRoomData)
  -- function num : 0_1 , upvalues : _ENV
  local dormBriefData = PlayerDataCenter.dormBriefData
  if dormBriefData == nil then
    return 
  end
  self:RefreshComfortBaseInfo(dormBriefData, dormRoomData)
  self:InitDormComfortList(dormBriefData)
  self:RefreshComfortTotalLogic(dormBriefData)
end

UIDormComfort.RefreshComfortBaseInfo = function(self, dormBriefData, dormRoomData)
  -- function num : 0_2 , upvalues : _ENV
  local curLevel, maxLevel = dormBriefData:GetDormComfortLevel()
  if curLevel <= 10 then
    ((self.ui).tex_Level):SetIndex(0, tostring(curLevel))
  else
    ;
    ((self.ui).tex_Level):SetIndex(1, tostring(curLevel))
  end
  if dormRoomData == nil then
    ((self.ui).currRoomComfort):SetActive(false)
  else
    ;
    ((self.ui).currRoomComfort):SetActive(true)
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).tex_CurrRoomComfort).text = tostring(dormRoomData:GetComfort())
  end
  local hisComfort = dormBriefData:HistoryMaxComfort()
  local nextComfort = 0
  if maxLevel <= curLevel then
    local maxLevelCfg = (ConfigData.dorm_comfort)[maxLevel]
    nextComfort = maxLevelCfg.comfort
    hisComfort = nextComfort
  else
    do
      do
        local nextLevelCfg = (ConfigData.dorm_comfort)[curLevel + 1]
        nextComfort = nextLevelCfg.comfort
        local dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
        local curComfort = (dormCtrl.allDormData):GetTotalComfort()
        -- DECOMPILER ERROR at PC68: Confused about usage of register: R9 in 'UnsetPending'

        ;
        ((self.ui).img_ComfortBar).value = curComfort / nextComfort
        ;
        ((self.ui).tex_TotalComfort):SetIndex(0, tostring(curComfort), tostring(nextComfort))
      end
    end
  end
end

UIDormComfort.InitDormComfortList = function(self, dormBriefData)
  -- function num : 0_3 , upvalues : _ENV
  (self.comfortItemPool):HideAll()
  for _,level in pairs((ConfigData.dorm_comfort).level_sort) do
    local comfortLevelCfg = (ConfigData.dorm_comfort)[level]
    local isPicked = dormBriefData:IsDormComfortPicked(comfortLevelCfg.level)
    if #comfortLevelCfg.rewardIds > 0 and not isPicked then
      local comfortItem = (self.comfortItemPool):GetOne()
      comfortItem:InitDormComfortItem(comfortLevelCfg, dormBriefData, self.__ReqComfortRewardPick)
    end
  end
  for _,level in pairs((ConfigData.dorm_comfort).level_sort) do
    local comfortLevelCfg = (ConfigData.dorm_comfort)[level]
    local isPicked = dormBriefData:IsDormComfortPicked(comfortLevelCfg.level)
    if #comfortLevelCfg.rewardIds > 0 and isPicked then
      local comfortItem = (self.comfortItemPool):GetOne()
      comfortItem:InitDormComfortItem(comfortLevelCfg, dormBriefData, self.__ReqComfortRewardPick)
    end
  end
end

UIDormComfort.RefreshComfortTotalLogic = function(self, dormBriefData)
  -- function num : 0_4 , upvalues : _ENV, CommonLogicUtil
  local curLevel, maxLevel = dormBriefData:GetDormComfortLevel()
  local cfg = (ConfigData.dorm_comfort)[curLevel]
  local des = ""
  for index,logic in ipairs(cfg.logic) do
    if (string.IsNullOrEmpty)(des) then
      des = (CommonLogicUtil.GetDesString)(logic, (cfg.para1)[index], (cfg.para2)[index], (cfg.para3)[index])
    else
      des = des .. "\n" .. (CommonLogicUtil.GetDesString)(logic, (cfg.para1)[index], (cfg.para2)[index], (cfg.para3)[index])
    end
  end
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_TotalAddition).text = des
end

UIDormComfort.ReqComfortRewardPick = function(self, comfortLevelCfg, comfortItem)
  -- function num : 0_5 , upvalues : _ENV
  local dormNetwork = NetworkManager:GetNetwork(NetworkTypeID.Dorm)
  dormNetwork:CS_DORM_PickConfortRewards(comfortLevelCfg.level, function()
    -- function num : 0_5_0 , upvalues : comfortItem, _ENV, comfortLevelCfg
    comfortItem:RefreshDormComfortItem(PlayerDataCenter.dormBriefData)
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      -- function num : 0_5_0_0 , upvalues : comfortLevelCfg
      if window == nil then
        return 
      end
      window:InitRewardsItem(comfortLevelCfg.rewardIds, comfortLevelCfg.rewardNums)
    end
)
  end
)
end

UIDormComfort.OnCloseClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  self:Delete()
  ;
  (UIUtil.OnClickBack)()
end

UIDormComfort.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnDelete)(self)
end

return UIDormComfort


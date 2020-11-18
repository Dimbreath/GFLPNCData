-- params : ...
-- function num : 0 , upvalues : _ENV
local UIN3DFormation = class("UIN3DFormation", UIBaseNode)
local base = UIBaseNode
local UINFmtPlatform = require("Game.Formation.UI.3DFormation.UINFmtPlatform")
local UINCampBond3DItem = require("Game.Formation.UI.3DFormation.UINCampBond3DItem")
UIN3DFormation.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINFmtPlatform
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).start, self, self.OnClickStartBattle)
  ;
  ((self.ui).campItem):SetActive(false)
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
  self.platformDic = {}
  for fmtIndex,go in ipairs((self.ui).platform) do
    local isBench = (ConfigData.game_config).max_stage_hero < fmtIndex
    local unlock, lockStr = nil, nil
    do
      if isBench then
        local benchId = fmtIndex - (ConfigData.game_config).max_stage_hero
        unlock = (fmtCtrl.BenchUnlock)(benchId, true)
      end
      do
        local plat = (UINFmtPlatform.New)()
        plat:Init(go)
        plat:InitFmtPlatform(fmtIndex, isBench, lockStr)
        -- DECOMPILER ERROR at PC60: Confused about usage of register: R11 in 'UnsetPending'

        ;
        (self.platformDic)[fmtIndex] = plat
        -- DECOMPILER ERROR at PC61: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  self.isOpenOverClock = false
  self.isOpenCampInfluence = false
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UIN3DFormation.OpenCampInfluence = function(self, isOpen)
  -- function num : 0_1 , upvalues : _ENV, UINCampBond3DItem
  self.isOpenCampInfluence = isOpen
  if isOpen then
    (((self.ui).campList).gameObject):SetActive(false)
    ;
    (UIUtil.AddButtonListener)((self.ui).campList, self, self.ShowFmtCampFetter)
    self.campBondPool = (UIItemPool.New)(UINCampBond3DItem, (self.ui).campItem)
  else
    ;
    (((self.ui).campList).gameObject):SetActive(false)
  end
end

UIN3DFormation.OpenOverClock = function(self, isOpen)
  -- function num : 0_2 , upvalues : _ENV
  self.isOpenOverClock = isOpen
  if isOpen then
    ((self.ui).overLock):SetActive(true)
    ;
    (UIUtil.AddButtonListener)((self.ui).btn_overLock, self, self.OnOverClockClick)
    self.OverclockCtrl = ControllerManager:GetController(ControllerTypeId.Overclock, true)
    ;
    (self.OverclockCtrl):RefreshData(function()
    -- function num : 0_2_0 , upvalues : self
    ((self.ui).obj_countItem):SetActive(false)
    self.countItemList = {}
    self:RefreshOverClockUI()
  end
)
  else
    ;
    ((self.ui).overLock):SetActive(false)
  end
end

UIN3DFormation.Init3DFormation = function(self, startBattleFunc, sectorStageId, fromModule)
  -- function num : 0_3
  self.startBattleFunc = startBattleFunc
  if self.isOpenOverClock then
    (self.OverclockCtrl):SetStageId(sectorStageId, fromModule)
    ;
    (self.OverclockCtrl):CleanData()
  end
end

UIN3DFormation.Refresh3DFmt = function(self, formationData)
  -- function num : 0_4 , upvalues : _ENV
  self.formationData = formationData
  local totalFtPower = 0
  local campCountDic = (table.GetDefaulValueTable)(0)
  for index,platItem in pairs(self.platformDic) do
    local heroId = (formationData.data)[index]
    local heroData = nil
    if heroId ~= nil then
      heroData = PlayerDataCenter:GetHeroData(heroId)
      if heroData ~= nil then
        local campId = heroData.camp
        campCountDic[campId] = campCountDic[campId] + 1
      end
    end
    do
      do
        totalFtPower = platItem:RefreshUIFmtPlatform(heroData) + totalFtPower
        -- DECOMPILER ERROR at PC30: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_TotalPower).text = tostring(totalFtPower)
  if self.isOpenCampInfluence then
    self:__RefreshCampBond(campCountDic)
  end
end

UIN3DFormation.__RefreshCampBond = function(self, campCountDic)
  -- function num : 0_5 , upvalues : _ENV
  self.campCountDic = campCountDic
  local campCountList = {}
  for k,v in pairs(campCountDic) do
    local campCount = {campId = k, count = v}
    ;
    (table.insert)(campCountList, campCount)
  end
  ;
  (table.sort)(campCountList, function(a, b)
    -- function num : 0_5_0
    if b.count >= a.count then
      do return a.count == b.count end
      do return a.campId < b.campId end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  if self.campBondPool ~= nil then
    (self.campBondPool):HideAll()
  end
  for k,v in pairs(campCountList) do
    local bondItem = (self.campBondPool):GetOne()
    bondItem:InitCampBond3DItem(v.campId, v.count)
  end
end

UIN3DFormation.ShowFmtCampFetter = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.campCountDic == nil or (table.count)(self.campCountDic) == 0 or not self.isOpenCampInfluence then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CampBond, function(window)
    -- function num : 0_6_0 , upvalues : self
    window:InitCampBond(self.campCountDic)
  end
)
end

UIN3DFormation.GetFmtPlatformUI = function(self, fmtIndex)
  -- function num : 0_7 , upvalues : _ENV
  local platform = (self.platformDic)[fmtIndex]
  if platform == nil then
    warn("Can\'t get FmtPlatformUI, fmtIndex = " .. tostring(fmtIndex))
  end
  return platform
end

UIN3DFormation.RefreshFmtPlatformUI = function(self, fmtIndex)
  -- function num : 0_8 , upvalues : _ENV
  local platform = self:GetFmtPlatformUI(fmtIndex)
  if platform == nil then
    return 
  end
  local heroId = ((self.formationData).data)[fmtIndex]
  local heroData = nil
  if heroId ~= nil then
    heroData = PlayerDataCenter:GetHeroData(heroId)
  end
  platform:RefreshUIFmtPlatform(heroData)
end

UIN3DFormation.OnClickStartBattle = function(self)
  -- function num : 0_9
  if self.startBattleFunc ~= nil then
    (self.startBattleFunc)()
  end
end

UIN3DFormation.OnOverClockClick = function(self)
  -- function num : 0_10 , upvalues : _ENV
  if not self.isOpenOverClock then
    return 
  end
  ;
  (self.OverclockCtrl):ShowOverclockUI()
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.OverclockCtrl).selectChangEvent = BindCallback(self, self.RefreshOverClockUI)
end

UIN3DFormation.RefreshOverClockUI = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if not self.isOpenOverClock then
    return 
  end
  local curAssembleNum, maxAssembleNum = (self.OverclockCtrl):GetAssembleNum()
  if curAssembleNum > 0 then
    ((self.ui).img_overLock):SetIndex(1)
  else
    ;
    ((self.ui).img_overLock):SetIndex(0)
  end
  for _,obj in ipairs(self.countItemList) do
    obj:SetActive(false)
  end
  for i = 1, curAssembleNum do
    if (self.countItemList)[i] ~= nil then
      ((self.countItemList)[i]):SetActive(true)
    else
      local go = ((self.ui).obj_countItem):Instantiate()
      go:SetActive(true)
      ;
      (table.insert)(self.countItemList, go)
    end
  end
  if (self.OverclockCtrl):GetIsHaveFree() then
    ((self.ui).overclock_free):SetActive(true)
  else
    ;
    ((self.ui).overclock_free):SetActive(false)
  end
end

UIN3DFormation.OnDelete = function(self)
  -- function num : 0_12 , upvalues : base
  (base.OnDelete)(self)
end

return UIN3DFormation


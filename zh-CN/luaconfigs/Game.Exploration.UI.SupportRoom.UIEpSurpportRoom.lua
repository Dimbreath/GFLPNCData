-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEpSurpportRoom = class("UIEpSurpportRoom", UIBaseWindow)
local base = UIBaseWindow
local UINEpSptRoomHeroItem = require("Game.Exploration.UI.SupportRoom.UINEpSptRoomHeroItem")
local UINEpSptRoomHeroDetail = require("Game.Exploration.UI.SupportRoom.UINEpSptRoomHeroDetail")
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
UIEpSurpportRoom.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINEpSptRoomHeroItem, UINEpSptRoomHeroDetail, cs_ResLoader
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self._OnClickConfirm)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Cancel, self, self._OnClickCancel)
  self._confirmBtnColor = ((self.ui).img_Confirm).color
  ;
  ((self.ui).heroItem):SetActive(false)
  self.heroItemPool = (UIItemPool.New)(UINEpSptRoomHeroItem, (self.ui).heroItem)
  self.heroDetailNode = (UINEpSptRoomHeroDetail.New)()
  ;
  (self.heroDetailNode):Init((self.ui).heroDetail)
  ;
  (self.heroDetailNode):Hide()
  self.resLoader = (cs_ResLoader.Create)()
  self._clickHeroFunc = BindCallback(self, self._OnClickHeroItem)
end

UIEpSurpportRoom.InitEpSurpportRoom = function(self, dynPlayer, supportHeroList, epSptCtrl)
  -- function num : 0_1 , upvalues : _ENV
  self.epSptCtrl = epSptCtrl
  MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, false)
  self.inFormationDic = {}
  self.currentHeroList = dynPlayer.heroList
  self.supportHeroList = supportHeroList
  self.selectedSptHeroDic = {}
  self.currentHeroDic = {}
  self.maxHeroCount = (ConfigData.game_config).max_stage_hero
  for i = 1, (ConfigData.game_config).max_bench_hero do
    local unlock = (FunctionUnlockMgr.BenchUnlock)(i)
    if unlock then
      self.maxHeroCount = self.maxHeroCount + 1
    end
  end
  local repeatHeroItemDic = {}
  local tempHeroItemDic = {}
  local tryAddRepeatHeroItem = function(heroId, heroItem)
    -- function num : 0_1_0 , upvalues : tempHeroItemDic, repeatHeroItemDic, _ENV
    if tempHeroItemDic[heroId] ~= nil then
      local heroItemList = repeatHeroItemDic[heroId]
      if heroItemList == nil then
        heroItemList = {tempHeroItemDic[heroId]}
        repeatHeroItemDic[heroId] = heroItemList
      end
      ;
      (table.insert)(heroItemList, heroItem)
      return true
    else
      do
        tempHeroItemDic[heroId] = heroItem
        do return false end
      end
    end
  end

  self.repeatHeroItemDic = repeatHeroItemDic
  for k,dynHero in ipairs(dynPlayer.heroList) do
    local heroItem = (self.heroItemPool):GetOne()
    heroItem:InitEpSptRoomHeroItem(dynHero, self.resLoader, self._clickHeroFunc)
    heroItem:SetEpSptRoomHeroItemSelect(true)
    ;
    (heroItem.transform):SetParent((self.ui).currentList)
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (heroItem.gameObject).name = tostring(k)
    -- DECOMPILER ERROR at PC67: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (self.inFormationDic)[dynHero.dataId] = true
    -- DECOMPILER ERROR at PC69: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (self.currentHeroDic)[dynHero] = true
    tryAddRepeatHeroItem(dynHero.dataId, heroItem)
  end
  for k,dynHero in ipairs(supportHeroList) do
    local heroItem = (self.heroItemPool):GetOne()
    heroItem:InitEpSptRoomHeroItem(dynHero, self.resLoader, self._clickHeroFunc)
    ;
    (heroItem.transform):SetParent((self.ui).supportList)
    -- DECOMPILER ERROR at PC97: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (heroItem.gameObject).name = tostring(k)
    if tryAddRepeatHeroItem(dynHero.dataId, heroItem) then
      heroItem:SetEpSptRoomHeroItemHas(true)
    end
  end
  self:_UpdateHeroNum()
end

UIEpSurpportRoom._UpdateHeroNum = function(self)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).tex_Limit).text = tostring((table.count)(self.inFormationDic)) .. "/" .. tostring(self.maxHeroCount)
end

UIEpSurpportRoom._SetRepeatHeroHas = function(self, heroId, heroItem, has)
  -- function num : 0_3 , upvalues : _ENV
  local repeatHeroItemList = (self.repeatHeroItemDic)[heroId]
  if repeatHeroItemList ~= nil then
    for k,item in ipairs(repeatHeroItemList) do
      if item ~= heroItem then
        item:SetEpSptRoomHeroItemHas(has)
      end
    end
  end
end

UIEpSurpportRoom._OnClickHeroItem = function(self, heroItem, dynHeroData, fightPower)
  -- function num : 0_4 , upvalues : _ENV, cs_MessageCommon
  if (self.inFormationDic)[dynHeroData.dataId] == nil then
    if self.maxHeroCount <= (table.count)(self.inFormationDic) then
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Formation_MaxHeroCount))
      return 
    end
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R4 in 'UnsetPending'

    if (self.currentHeroDic)[dynHeroData] ~= nil then
      (self.inFormationDic)[dynHeroData.dataId] = true
    else
      local limitNum = (ConfigData.game_config).supportHeroMaxNum
      if limitNum <= (table.count)(self.selectedSptHeroDic) then
        (cs_MessageCommon.ShowMessageTipsWithErrorSound)((string.format)(ConfigData:GetTipContent(168), limitNum))
        return 
      end
      -- DECOMPILER ERROR at PC50: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self.inFormationDic)[dynHeroData.dataId] = false
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self.selectedSptHeroDic)[dynHeroData] = true
    end
    do
      heroItem:SetEpSptRoomHeroItemSelect(true)
      self:_SetRepeatHeroHas(dynHeroData.dataId, heroItem, true)
      ;
      (self.heroDetailNode):Show()
      ;
      (self.heroDetailNode):InitEpSptRoomHeroDetail(dynHeroData, self.resLoader, fightPower)
      heroItem:SetEpSptRoomHeroItemSelect(false)
      -- DECOMPILER ERROR at PC76: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (self.inFormationDic)[dynHeroData.dataId] = nil
      -- DECOMPILER ERROR at PC78: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (self.selectedSptHeroDic)[dynHeroData] = nil
      self:_SetRepeatHeroHas(dynHeroData.dataId, heroItem, false)
      ;
      (self.heroDetailNode):Hide()
      local canConfirm = #self.currentHeroList <= (table.count)(self.inFormationDic)
      -- DECOMPILER ERROR at PC106: Confused about usage of register: R5 in 'UnsetPending'

      if not canConfirm or not self._confirmBtnColor then
        ((self.ui).img_Confirm).color = Color.gray
        self:_UpdateHeroNum()
        -- DECOMPILER ERROR: 3 unprocessed JMP targets
      end
    end
  end
end

UIEpSurpportRoom._OnClickConfirm = function(self)
  -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon
  if (table.count)(self.inFormationDic) < #self.currentHeroList then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(169))
    return 
  end
  local quitHeroUidList = {}
  local enterIdList = {}
  for k,dynHero in ipairs(self.supportHeroList) do
    if (self.inFormationDic)[dynHero.dataId] == false then
      (table.insert)(enterIdList, k - 1)
    end
  end
  for k,dynHero in pairs(self.currentHeroList) do
    if (self.inFormationDic)[dynHero.dataId] ~= true then
      (table.insert)(quitHeroUidList, dynHero.uid)
    end
  end
  ;
  (self.epSptCtrl):ReqChangeSupportHero(quitHeroUidList, enterIdList)
end

UIEpSurpportRoom._OnClickCancel = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (self.epSptCtrl):ReqChangeSupportHero(table.emptytable, table.emptytable)
end

UIEpSurpportRoom.OnDelete = function(self)
  -- function num : 0_7 , upvalues : _ENV, base
  (self.heroItemPool):DeleteAll()
  ;
  (self.heroDetailNode):Delete()
  ;
  (self.resLoader):Put2Pool()
  self.resLoader = nil
  MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, true)
  ;
  (base.OnDelete)(self)
end

return UIEpSurpportRoom


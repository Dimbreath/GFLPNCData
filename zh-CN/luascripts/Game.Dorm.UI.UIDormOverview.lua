-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDormOverview = class("UIDormOverview", UIBaseWindow)
local UINDormOverviewHouse = require("Game.Dorm.UI.UINDormOverviewHouse")
local base = UIBaseWindow
UIDormOverview.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINDormOverviewHouse
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.OnReturnClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CheckIn, self, self.OnEnterHosueClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Buy, self, self.OnHouseBuyClicked)
  ;
  ((self.ui).dormInfoItem):SetActive(false)
  self.poolDorm = (UIItemPool.New)(UINDormOverviewHouse, (self.ui).dormInfoItem)
  ;
  ((self.ui).heroIconItem):SetActive(false)
  self.__onRefreshSelectHosue = BindCallback(self, self.__OnRefreshSelectHosue)
  self.selectHouse = nil
  self.dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
end

UIDormOverview.InitDormOverview = function(self, allDormData)
  -- function num : 0_1
  self.allDormData = allDormData
  self:RefreshDormOverview()
end

UIDormOverview.RefreshDormOverview = function(self)
  -- function num : 0_2
  self:__InitComfortLevel()
  self:__InitDormList()
end

UIDormOverview.__InitComfortLevel = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local comfortCfg = (self.allDormData):GetHistoryComfortCfg()
  if comfortCfg == nil then
    ((self.ui).tex_Level):SetIndex(0, "1")
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_Progress).fillAmount = 0
    ;
    ((self.ui).tex_ComfortNum):SetIndex(0, "0", "0")
  else
    ;
    ((self.ui).tex_Level):SetIndex(0, tostring(comfortCfg.level))
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

    if comfortCfg.level == (ConfigData.dorm_comfort).max_level then
      ((self.ui).img_Progress).fillAmount = 0
      ;
      ((self.ui).tex_ComfortNum):SetIndex(0, "0", "0")
    else
      local nextComfort = (ConfigData.dorm_comfort)[comfortCfg.level + 1]
      if nextComfort == nil then
        error("dorm comfort cfg is null,id:" .. tostring(comfortCfg.level + 1))
        return 
      end
      local curComfort = (self.allDormData):GetTotalComfort()
      local nextComfort = nextComfort.comfort
      -- DECOMPILER ERROR at PC70: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).img_Progress).fillAmount = curComfort / nextComfort
      ;
      ((self.ui).tex_ComfortNum):SetIndex(0, tostring(curComfort), tostring(nextComfort))
    end
  end
end

UIDormOverview.__InitDormList = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (self.poolDorm):HideAll()
  local defaultHouse = nil
  if self.selectHouse == nil or not (self.selectHouse).id then
    local selectHouseId = ((self.dormCtrl):GetCurHouse()).id
  end
  self.selectHouse = nil
  for _,houseId in ipairs((ConfigData.dorm_house).id_sort_list) do
    local houseCfg = (ConfigData.dorm_house)[houseId]
    local houseData = ((self.allDormData).houseDic)[houseId]
    local overviewHouse = (self.poolDorm):GetOne()
    overviewHouse:InitDormHouseInfo(houseCfg, houseData, self.__onRefreshSelectHosue)
    if defaultHouse == nil then
      defaultHouse = overviewHouse
    else
      if selectHouseId == houseId then
        defaultHouse = overviewHouse
      end
    end
  end
  if defaultHouse ~= nil then
    self:__OnRefreshSelectHosue(defaultHouse)
  end
end

UIDormOverview.__OnRefreshSelectHosue = function(self, houseItem)
  -- function num : 0_5 , upvalues : _ENV
  if houseItem == nil or self.selectHouse == houseItem then
    return 
  end
  if self.selectHouse ~= nil then
    (self.selectHouse):SetSelectActive(false)
  end
  self.selectHouse = houseItem
  ;
  (self.selectHouse):SetSelectActive(true)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Description).text = (LanguageUtil.GetLocaleText)(((self.selectHouse).houseCfg).intro)
  ;
  ((self.ui).lockNode):SetActive(not (self.selectHouse).unlock)
  ;
  ((self.ui).unlockNode):SetActive((self.selectHouse).unlock)
  if not (self.selectHouse).unlock then
    if ((self.selectHouse).houseCfg).unlock_logic == 2 then
      (((self.ui).btn_Buy).gameObject):SetActive(true)
    else
      ;
      (((self.ui).btn_Buy).gameObject):SetActive(false)
    end
    return 
  end
  ;
  ((self.ui).tex_RoomNum):SetIndex(0, tostring(((self.selectHouse).houseData):GetRoomCount()), tostring(((self.selectHouse).houseData):GetRoomLimit()))
end

UIDormOverview.OnHouseBuyClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.selectHouse == nil or (self.selectHouse).houseCfg == nil or ((self.selectHouse).houseCfg).unlock_logic ~= 2 then
    return 
  end
  local haveCount = PlayerDataCenter:GetItemCount(((self.selectHouse).houseCfg).unlock_item_id)
  if haveCount < ((self.selectHouse).houseCfg).unlock_item_num then
    ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(TipContent.dorm_BuyItemInsufficient))
    return 
  end
  ;
  ((self.dormCtrl).dormNetwork):CS_DORM_DormPurchase(((self.selectHouse).houseCfg).id)
end

UIDormOverview.OnEnterHosueClicked = function(self)
  -- function num : 0_7
  if self.selectHouse == nil or (self.selectHouse).houseData == nil then
    return 
  end
  ;
  ((self.dormCtrl).houseCtrl):EnterDormHouse((self.selectHouse).id)
  self:Delete()
end

UIDormOverview.OnReturnClicked = function(self)
  -- function num : 0_8
  self:Delete()
end

UIDormOverview.OnDelete = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnDelete)(self)
end

return UIDormOverview

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDormOverview = class("UIDormOverview", UIBaseWindow)
local UINDormOverviewHouse = require("Game.Dorm.UI.UINDormOverviewHouse")
local base = UIBaseWindow
UIDormOverview.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINDormOverviewHouse
    (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.OnReturnClicked);
    (UIUtil.AddButtonListener)((self.ui).btn_CheckIn, self,
                               self.OnEnterHosueClicked);
    (UIUtil.AddButtonListener)((self.ui).btn_Buy, self, self.OnHouseBuyClicked);
    ((self.ui).dormInfoItem):SetActive(false)
    self.poolDorm = (UIItemPool.New)(UINDormOverviewHouse,
                                     (self.ui).dormInfoItem);
    ((self.ui).heroIconItem):SetActive(false)
    self.__onRefreshSelectHosue =
        BindCallback(self, self.__OnRefreshSelectHosue)
    self.selectHouse = nil
    self.dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
end

UIDormOverview.InitDormOverview = function(self, allDormData)
    -- function num : 0_1
    self.allDormData = allDormData
    self:RefreshDormOverview()
end

UIDormOverview.RefreshDormOverview = function(self)
    -- function num : 0_2
    self:__InitComfortLevel()
    self:__InitDormList()
end

UIDormOverview.__InitComfortLevel = function(self)
    -- function num : 0_3 , upvalues : _ENV
    local comfortCfg = (self.allDormData):GetHistoryComfortCfg()
    if comfortCfg == nil then
        ((self.ui).tex_Level):SetIndex(0, "1") -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).img_Progress).fillAmount = 0;
        ((self.ui).tex_ComfortNum):SetIndex(0, "0", "0")
    else

        ((self.ui).tex_Level):SetIndex(0, tostring(comfortCfg.level))
        -- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

        if comfortCfg.level == (ConfigData.dorm_comfort).max_level then
            ((self.ui).img_Progress).fillAmount = 0;
            ((self.ui).tex_ComfortNum):SetIndex(0, "0", "0")
        else
            local nextComfort = (ConfigData.dorm_comfort)[comfortCfg.level + 1]
            if nextComfort == nil then
                error("dorm comfort cfg is null,id:" ..
                          tostring(comfortCfg.level + 1))
                return
            end
            local curComfort = (self.allDormData):GetTotalComfort()
            local nextComfort = nextComfort.comfort -- DECOMPILER ERROR at PC70: Confused about usage of register: R5 in 'UnsetPending'
            ;
            ((self.ui).img_Progress).fillAmount = curComfort / nextComfort;
            ((self.ui).tex_ComfortNum):SetIndex(0, tostring(curComfort),
                                                tostring(nextComfort))
        end
    end
end

UIDormOverview.__InitDormList = function(self)
    -- function num : 0_4 , upvalues : _ENV
    (self.poolDorm):HideAll()
    local defaultHouse = nil
    if self.selectHouse == nil or not (self.selectHouse).id then
        local selectHouseId = ((self.dormCtrl):GetCurHouse()).id
    end
    self.selectHouse = nil
    for _, houseId in ipairs((ConfigData.dorm_house).id_sort_list) do
        local houseCfg = (ConfigData.dorm_house)[houseId]
        local houseData = ((self.allDormData).houseDic)[houseId]
        local overviewHouse = (self.poolDorm):GetOne()
        overviewHouse:InitDormHouseInfo(houseCfg, houseData,
                                        self.__onRefreshSelectHosue)
        if defaultHouse == nil then
            defaultHouse = overviewHouse
        else
            if selectHouseId == houseId then
                defaultHouse = overviewHouse
            end
        end
    end
    if defaultHouse ~= nil then self:__OnRefreshSelectHosue(defaultHouse) end
end

UIDormOverview.__OnRefreshSelectHosue = function(self, houseItem)
    -- function num : 0_5 , upvalues : _ENV
    if houseItem == nil or self.selectHouse == houseItem then return end
    if self.selectHouse ~= nil then (self.selectHouse):SetSelectActive(false) end
    self.selectHouse = houseItem;
    (self.selectHouse):SetSelectActive(true) -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).tex_Description).text = (LanguageUtil.GetLocaleText)(
                                           ((self.selectHouse).houseCfg).intro);
    ((self.ui).lockNode):SetActive(not (self.selectHouse).unlock);
    ((self.ui).unlockNode):SetActive((self.selectHouse).unlock)
    if not (self.selectHouse).unlock then
        if ((self.selectHouse).houseCfg).unlock_logic == 2 then
            (((self.ui).btn_Buy).gameObject):SetActive(true)
        else

            (((self.ui).btn_Buy).gameObject):SetActive(false)
        end
        return
    end
    ((self.ui).tex_RoomNum):SetIndex(0, tostring(
                                         ((self.selectHouse).houseData):GetRoomCount()),
                                     tostring(
                                         ((self.selectHouse).houseData):GetRoomLimit()))
end

UIDormOverview.OnHouseBuyClicked = function(self)
    -- function num : 0_6 , upvalues : _ENV
    if self.selectHouse == nil or (self.selectHouse).houseCfg == nil or
        ((self.selectHouse).houseCfg).unlock_logic ~= 2 then return end
    local haveCount = PlayerDataCenter:GetItemCount(
                          ((self.selectHouse).houseCfg).unlock_item_id)
    if haveCount < ((self.selectHouse).houseCfg).unlock_item_num then
        ((CS.MessageCommon).ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.dorm_BuyItemInsufficient))
        return
    end
    ((self.dormCtrl).dormNetwork):CS_DORM_DormPurchase(
        ((self.selectHouse).houseCfg).id)
end

UIDormOverview.OnEnterHosueClicked = function(self)
    -- function num : 0_7
    if self.selectHouse == nil or (self.selectHouse).houseData == nil then
        return
    end
    ((self.dormCtrl).houseCtrl):EnterDormHouse((self.selectHouse).id)
    self:Delete()
end

UIDormOverview.OnReturnClicked = function(self)
    -- function num : 0_8
    self:Delete()
end

UIDormOverview.OnDelete = function(self)
    -- function num : 0_9 , upvalues : base
    (base.OnDelete)(self)
end

return UIDormOverview

